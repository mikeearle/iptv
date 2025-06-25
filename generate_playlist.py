import requests
import re
from datetime import datetime

# Google Freeplay-aligned FAST channels
GOOGLE_VERIFIED_CHANNELS = [
    "NBC News Now", "TODAY All Day", "Tastemade", "FailArmy",
    "Court TV", "Law & Crime", "REELZ Famous & Infamous",
    "Filmrise: Free Movies", "Dry Bar Comedy", "Mystery Science Theater 3000"
]

COUNTRIES = ["us", "ca", "mx"]
BASE_URL = "https://iptv-org.github.io/iptv/countries"

def extract_channels(m3u_data):
    pattern = r'#EXTINF:-1\s+(.*?)\n(https?://[^\n]+)'
    return re.findall(pattern, m3u_data)

def download_playlist(country):
    url = f"{BASE_URL}/{country}.m3u"
    response = requests.get(url)
    response.raise_for_status()
    return response.text

def filter_verified_us(channels):
    verified = []
    for meta, url in channels:
        for name in GOOGLE_VERIFIED_CHANNELS:
            if name.lower() in meta.lower():
                verified.append((meta.strip(), url.strip()))
                break
    return verified

def main():
    all_channels = []

    for country in COUNTRIES:
        print(f"Processing {country.upper()}...")
        m3u_data = download_playlist(country)
        parsed = extract_channels(m3u_data)
        if country == "us":
            parsed = filter_verified_us(parsed)
        all_channels.extend(parsed)

    now = datetime.utcnow().strftime("%Y-%m-%d %H:%M UTC")
    output = "#EXTM3U\n"
    output += f"# Generated on {now}\n"
    for meta, url in all_channels:
        output += f"#EXTINF:-1 {meta}\n{url}\n"

    with open("verified_usa_can_mex.m3u", "w", encoding="utf-8") as f:
        f.write(output)
    print("✅ Playlist generated: verified_usa_can_mex.m3u")

if __name__ == "__main__":
    main()
