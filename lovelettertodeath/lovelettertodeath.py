import os
import urllib2
import cookielib
import re
import htmlentitydefs
import codecs
import time
from os.path import basename, splitext
from BeautifulSoup import BeautifulSoup

import sys
#streamWriter = codecs.lookup('utf-8')[-1]
#sys.stdout = streamWriter(sys.stdout)

savepath = '/tmp'
TXDATA = None
TXHEADERS = {'User-agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36'}

numberofdead = 0
deadname = []
deadcontent = []
deadphoto = []

def request_url(url, txdata, txheaders):
    """Gets a webpage's HTML."""
    req = Request(url, txdata, txheaders)
    handle = urlopen(req)
    html = handle.read()
    return html
    
def download_photo(img_url, filename):
		print "downloading image: " + img_url
		file_path = "%s%s" % (savepath, filename)
		downloaded_image = file(file_path, "wb")
		image_on_web = urlopen(img_url)
		while True:
			buf = image_on_web.read(65536)
			if len(buf) == 0:
				break
			downloaded_image.write(buf)
		downloaded_image.close()
		image_on_web.close()
		return file_path
		
urlopen = urllib2.urlopen
Request = urllib2.Request

# Install cookie jar in opener for fetching URL
cookiejar = cookielib.LWPCookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookiejar))
urllib2.install_opener(opener)


try:
	import pyext
except:
	print "ERROR: This script must be loaded by the PD pyext external"
	sys.exit()

class fetch(pyext._class):
	"""Love"""

	# number of inlets and outlets
	_inlets=5
	_outlets=4
	
	def __init__(self,*args):
		pass
		
	def finddeadpets_1(self, a, b):
		global numberofdead
		print "------------------------"
		print "Looking for dead "+str(b)
		
		html = request_url('http://www.fondpetmemories.com/category/'+str(b)+'/page/'+str(a)+'/', TXDATA, TXHEADERS)
		soup = BeautifulSoup(html)
		
		# extract links
		deathlink = []
		
		for pets in soup.findAll('div', {"class":"hfeed"}):
			for link in pets.findAll('a'):
				if link['href'].startswith('http://www.fondpetmemories.com/category'):
					pass
				else:
					deathlink.append(link['href'])
			
		# unique
		deathlink = [i for i in set(deathlink)]
		
		for deaths in deathlink:
			deathinfo = request_url(deaths, TXDATA, TXHEADERS)
			deathsoup = BeautifulSoup(deathinfo, fromEncoding="utf-8", convertEntities="html")
			
			letter = deathsoup.find('div', {"class":"format_text entry-content"})	
			letter = str(letter).replace("\n", " ")
			letter = str(letter).replace("Tagged as:", "")
			letter = re.sub('<[^<]+?>', '', str(letter))
				
			for image in deathsoup.findAll('img', attrs={'src': re.compile("^/images/")}):
				if not "Facebook" in str(image):
					numberofdead = numberofdead + 1
					deadcontent.append(str(letter))
					print str(image.get('alt', ''))
					deadname.append(str(image.get('alt', '')))
					deadphoto.append(str(image['src']))	
		self._outlet(4, numberofdead)


	def deadpetsinformation_2(self, a):
		self._outlet(1, str(deadname[int(a)]).replace(',', ' '))
		self._outlet(2, str(deadcontent[int(a)]).replace(',', ' '))
		download_photo("http://www.fondpetmemories.com"+str(deadphoto[int(a)]), '/inmemoriam.jpg')
		self._outlet(3, "inmemoriam.jpg")
		
	def finddeadpeople_3(self, a):
		global numberofdead
		print "------------------------"
		print "Looking for dead people..."

		html = request_url('http://www.inmemoriam.ca/resultats-de-recherche/?page='+str(a)+'&search_for=&first_name=&last_name=&deceased_gender=&born_in=0&died_in=0&country_birth=&birth_province=&death_country=&death_province=&specific_newspaper=', TXDATA, TXHEADERS)
		soup = BeautifulSoup(html)

		# extract links
		deathlink = []
		
		for people in soup.findAll('div', {"class":"box_listing"}):
			for link in people.findAll('a'):
				if link['href'].startswith('/voir'):
					deathlink.append(link['href'])

		# unique
		deathlink = [i for i in set(deathlink)]
		
		for deaths in deathlink:
			deathinfo = request_url("http://www.inmemoriam.ca/"+deaths, TXDATA, TXHEADERS)
			deathsoup = BeautifulSoup(deathinfo, fromEncoding="utf-8")
			
			
			for image in deathsoup.findAll('a', attrs={'href': re.compile("^/images/photo_original")}):
									
					for deathlove in deathsoup.findAll('p', {"class":"event"}):

						if(len(str(deathlove.contents[0])) > 6):
							
							numberofdead = numberofdead + 1
							deadcontent.append(str(deathlove.contents[0]))
							
							for deathname in deathsoup.findAll('h1', {"id":"announcement_name"}):
								deadname.append(str(deathname.contents[0]))
								print str(deathname.contents[0])
							
							deadphoto.append(str(image['href']))
								
		self._outlet(4, numberofdead)
	
	
	def deadpeopleinformation_4(self, a):
		self._outlet(1, str(deadname[int(a)]).replace(',', ' '))
		self._outlet(2, str(deadcontent[int(a)]).replace(',', ' '))
		download_photo("http://www.inmemoriam.ca/"+str(deadphoto[int(a)]), '/inmemoriam.jpg')
		self._outlet(3, "inmemoriam.jpg")
		
	def switchdeath_5(self, a):
		global numberofdead
		numberofdead = 0
		deadname[:] = []
		deadcontent[:] = []
		deadphoto[:] = []
		deathlink[:] = []
