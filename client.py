import requests

url = 'http://127.0.0.1:8001'
headers = {'iws': 'adasd___321_asda'}

r = requests.get(url, headers=headers)
print(r.headers["Accept"])
