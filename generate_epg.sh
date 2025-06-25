#!/bin/bash
set -e

# Clone EPG repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install dependencies
npm install

# Generate EPG into working directory
npm run grab -- --channels=../verified_usa_can_mex.m3u --output=../guide.xml

# Move guide.xml up to repo root
mv guide.xml ../guide.xml
