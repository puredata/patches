"""This is an example script for the py/pyext object's threading functionality.
For threading support pyext exposes several function and variables

- _detach([0/1]): by enabling thread detaching, threads will run in their own threads
- _priority(prio+-): you can raise or lower the priority of the current thread
- _stop({wait time in ms}): stop all running threads (you can additionally specify a wait time in ms)
- _shouldexit: this is a flag which indicates that the running thread should terminate
"""
try:
	import pyext
except:
	print "ERROR: This script must be loaded by the PD pyext external"
	sys.exit()
import os
import sys
import time
from urllib import FancyURLopener
import urllib2
import simplejson
import urlparse
import urllib
import imghdr


# Start FancyURLopener with defined version 
class MyOpener(FancyURLopener): 
    version = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11'
myopener = MyOpener()


class gi(pyext._class):
    """Connect to Google image and fetch 1 jpeg"""

    # number of inlets and outlets
    _inlets=1
    _outlets=2
    imgsz = 'small'
    
    def __init__(self,*args):
        pass

    def imgsz_1(self,a):
		self.imgsz = str(a)
		
    def search_1(self,a):
		#print "\nSearching Google for: " + str(a)
		url = ('https://ajax.googleapis.com/ajax/services/search/images?' + 'v=1.0&rsz=8&safe=off&imgsz='+str(self.imgsz)+'&as_filetype=jpg&q='+urllib.quote(str(a), '')+'&start=0&userip=MyIP')
		#print url
		request = urllib2.Request(url, None, {'Referer': 'testing'})
		response = urllib2.urlopen(request)

		# Get results using JSON
		results = simplejson.load(response)
		data = results['responseData']
		dataInfo = data['results']

		# Iterate for each result and get unescaped url
		for myUrl in dataInfo:
			#print myUrl['unescapedUrl']
			path = urlparse.urlparse(myUrl['unescapedUrl']).path
			ext = os.path.splitext(path)[1]
			myopener.retrieve(myUrl['unescapedUrl'],str(os.path.dirname(os.path.abspath(__file__)))+'/sing2text.jpg')
			if(str(imghdr.what(str(os.path.dirname(os.path.abspath(__file__)))+'/sing2text.jpg')) == "jpeg"):
				self._outlet(1, str("sing2text"+ext))
				self._outlet(2, str("bang"))
				break
		self._outlet(2, str("sing2text"))
