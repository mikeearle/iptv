#!/bin/bash
set -e

# Clone EPG repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Grab EPG from NA region
npm run grab -- --site=us,ca,mx --output=guide.xml

# Move it to root for commit
mv guide.xml ../guide.xml
