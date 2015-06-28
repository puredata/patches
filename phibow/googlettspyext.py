try:
	import pyext
except:
	print "ERROR: This script must be loaded by the PD pyext external"
	sys.exit()

import sys
import os
import re
import urllib, urllib2
import time
from urllib import FancyURLopener

# Start FancyURLopener with defined version 
class MyOpener(FancyURLopener): 
    version = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19'
myopener = MyOpener()


class gtts(pyext._class):
    _inlets=1
    _outlets=1
    lg = 'en'
    
    def __init__(self,*args):
        pass
       
       
    def language_1(self,a):
		self.lg = str(a)
		
    def tts_1(self,a):
        text = str(a)
        text = text.replace('\n','')
        text = text.replace('.','')
        text = text.replace(',','')
        text = text.replace('\\','')
        text = text[:100]
        text_list = re.split('(\,|\.)', text)
        
        combined_text = []
        for idx, val in enumerate(text_list):
            if idx % 2 == 0:
                combined_text.append(val)
            else:
                joined_text = ''.join((combined_text.pop(),val))
                if len(joined_text) < 100:
                    combined_text.append(joined_text)
                else:
                    subparts = re.split('( )', joined_text)
                    temp_string = ""
                    temp_array = []
                    for part in subparts:
                        temp_string = temp_string + part
                        if len(temp_string) > 80:
                            temp_array.append(temp_string)
                            temp_string = ""
                    #append final part
                    temp_array.append(temp_string)
                    combined_text.extend(temp_array)
        #download chunks and write them to the output file
        for idx, val in enumerate(combined_text):
            mp3url = "http://translate.google.com/translate_tts?tl=%s&q=%s&total=%s&idx=%s" % (self.lg, urllib.quote(val), len(combined_text), idx)
            headers = {"Host":"translate.google.com", "Referer":"http://www.gstatic.com/translate/sound_player2.swf", "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19"}
            req = urllib2.Request(mp3url, '', headers)
            #sys.stdout.write('.')
            #sys.stdout.flush()
            myopener.retrieve(mp3url,str(os.path.dirname(os.path.abspath(__file__)))+'/tts.mp3')
            '''
            if len(val) > 0:
                try:
                    response = urllib2.urlopen(req)
                    args.output.write(response.read())
                    time.sleep(.5)
                except urllib2.HTTPError as e:
                    print ('%s' % e)
            '''
        #args.output.close()
        self._outlet(1, str("tts.mp3"))
