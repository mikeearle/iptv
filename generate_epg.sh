#!/bin/bash
set -e

# Clone EPG repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Generate EPG into working directory
npm run grab -- --site=us,ca,mx --output=guide.xml

# Move guide.xml up to repo root
mv guide.xml ../guide.xml
