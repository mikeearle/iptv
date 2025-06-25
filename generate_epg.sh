#!/bin/bash
set -e

# Clone EPG grabber repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Run grabber (pulls all site configs and merges into one guide.xml)
npm run grab -- --channels=../verified_usa_can_mex.m3u --output=../guide.xml
