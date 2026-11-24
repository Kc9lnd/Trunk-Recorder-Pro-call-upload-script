sudo tee /usr/local/bin/upload_call.sh > /dev/null << 'SCRIPT'
#!/bin/bash
AUDIO_FILE="$1"
JSON_FILE="$2"
REMOTE="USER@SSH-SERVER-ip-ADDRESS"
REMOTE_DIR="/var/www/html/calls"

[ -f "$AUDIO_FILE" ] && [ -f "$JSON_FILE" ] || exit 0

scp -q "$AUDIO_FILE" "$JSON_FILE" "${REMOTE}:${REMOTE_DIR}/"

ssh -q "$REMOTE" "python3 - << 'EOF'
import glob, json, os, time

call_dir = '${REMOTE_DIR}'
cutoff = time.time() - 86400  # 24 hours in seconds

# 1. Delete any audio or JSON files older than 24 hours
for fp in glob.glob(os.path.join(call_dir, '*')):
    if os.path.basename(fp) == 'calls.json':
        continue
    try:
        if os.path.getmtime(fp) < cutoff:
            os.remove(fp)
    except OSError:
        pass

# 2. Rebuild calls.json from remaining calls (newest first, up to 200)
files = sorted(glob.glob(os.path.join(call_dir, '*.json')), key=os.path.getmtime, reverse=True)
files = [f for f in files if os.path.basename(f) != 'calls.json']

manifest = []
for jf in files[:200]:
    try:
        with open(jf) as fp:
            d = json.load(fp)
        stem = os.path.basename(jf).rpartition('.').__getitem__(0)
        for ext in ('.m4a', '.mp3', '.wav'):
            if os.path.exists(os.path.join(call_dir, stem + ext)):
                d['audio_url'] = '/calls/' + stem + ext
                break
        if 'audio_url' in d:
            manifest.append(d)
    except Exception:
        pass

tmp = os.path.join(call_dir, 'calls.json.tmp')
with open(tmp, 'w') as out:
    json.dump(manifest, out)
os.replace(tmp, os.path.join(call_dir, 'calls.json'))
EOF"
SCRIPT
sudo chmod +x /usr/local/bin/upload_call.sh
