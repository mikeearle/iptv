#!/bin/bash
set -e

# Clone EPG repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Run grabber for North American sites only (US + CA + MX)
npm run grab -- --site=us,ca,mx --output=../guide.xml
