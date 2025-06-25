#!/bin/bash
set -e

# Clone EPG grabber repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Run grabber (pulls all site configs and merges into one guide.xml)
npm run grab -- --site=us,ca,mx --output=../guide.xml
