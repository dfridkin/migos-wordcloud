import urllib.request
from bs4 import BeautifulSoup as soup
import re
import pylyrics3
import json

# For some reason, pylyrics3 refuses to get_artist_lyrics Migos, so we'll do it ourselves

url = 'http://lyrics.wikia.com/wiki/Migos'

f = urllib.request.urlopen(url)
tracklist = soup(f, 'html.parser')
songs = tracklist.find('div', attrs = {'id': 'mw-content-text'}).find_all('li')
songs = [re.search('(?<=:)\S+(?=")', str(s))[0] for s in songs]

# Now we have their tracks, we'll let pylyrics do the hard part
song_dict = {}
for s in songs:
    song_dict[s] = pylyrics3.get_lyrics_from_url(url + ':' + s)

with open('lyrics.json', 'w') as fp:
    json.dump(song_dict, fp, sort_keys=False, indent=2)
