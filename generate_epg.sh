#!/bin/bash
set -e

# Clone EPG grabber repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Use all known channels (will filter based on grabber source support)
npm run grab -- --channels=channels/channels.xml --output=../guide.xml

# Move if it exists
if [ -f ../guide.xml ]; then
  echo "✅ guide.xml created successfully."
else
  echo "❌ guide.xml was not generated. Check if channels.xml has valid entries."
  exit 1
fi
