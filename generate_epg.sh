#!/bin/bash
set -e

# Clone the EPG grabber repo
git clone https://github.com/iptv-org/epg.git epg
cd epg

# Install node dependencies
npm install

# Grab EPG only for channels in your playlist
npm run grab -- --channels=../verified_usa_can_mex.m3u --output=../guide.xml
