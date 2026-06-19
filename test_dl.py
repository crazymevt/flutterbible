import requests
session = requests.Session()
session.headers.update({'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
# Visit main page to get cookies
session.get('https://www.ph4.org/b4_1.php?l=en')
# Download the file
r = session.get('https://www.ph4.org/_dl.php?back=bbl&a=KJV1611&b=mybible&c', allow_redirects=True)
print(f'Status: {r.status_code}')
print(f'Content length: {len(r.content)}')
print(f'Headers: {r.headers}')
