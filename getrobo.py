import sys
import requests

url = 'https://' + sys.argv[1] + '/robots.txt'

r = requests.get(url)

with open(sys.argv[1], 'w') as f:
    f.write(r.text)
