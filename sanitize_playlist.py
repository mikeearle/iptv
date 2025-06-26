import os
import re

# Config
M3U_INPUT = "verified_curated_full.m3u"
M3U_OUTPUT = "verified_curated_full.m3u"
EPG_SITES_DIR = "epg/sites"
LOG_FILE = "invalid_tvg_ids.log"

# Load valid EPG site slugs
valid_ids = set(os.listdir(EPG_SITES_DIR))

# Read and process playlist
with open(M3U_INPUT, "r", encoding="utf-8") as infile, \
     open(M3U_OUTPUT, "w", encoding="utf-8") as outfile, \
     open(LOG_FILE, "w", encoding="utf-8") as log:
    
    for line in infile:
        if line.startswith("#EXTINF"):
            match = re.search(r'tvg-id="([^"]+)"', line)
            if match:
                tvg_id = match.group(1).lower()
                if tvg_id in valid_ids:
                    outfile.write(line)
                else:
                    clean_line = re.sub(r'tvg-id="[^"]+"\s*', '', line)
                    outfile.write(clean_line)
                    log.write(f"{tvg_id}\n")
            else:
                outfile.write(line)
        else:
            outfile.write(line)
