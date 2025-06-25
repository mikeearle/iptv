#!/bin/bash
set -e

# Clone EPG grabber repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Run grabber for known working sources
npm run grab -- --site=plutotv.com,xumo.tv --output=guide.xml

# Move EPG to repo root if it exists
if [ -f guide.xml ]; then
  echo "✅ guide.xml generated successfully, moving to root..."
  mv guide.xml ../guide.xml
else
  echo "❌ guide.xml was NOT generated"
  exit 1
fi
