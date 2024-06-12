import requests
from pprint import pprint
url = "https://alchmate.com/api//summary/osrs"

response = requests.request("GET", url)

items = []
for item in response.json()['data']:
    if item["members_only"] == "1":
        continue
    if "necklace" in item['name'].lower():
        if "diamond" in item['name'].lower() or "ruby" in item['name'].lower():
            pprint(item)

