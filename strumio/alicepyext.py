
try:
	import pyext
except:
	print "ERROR: This script must be loaded by the PD pyext external"
	sys.exit()
import aiml
import sys
import os
import glob

os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
class alice(pyext._class):
    """Alice binding"""
    _inlets=1
    _outlets=1
    global k
    
    def __init__(self,*args):
        self.k = aiml.Kernel()
        for files in glob.glob("*.aiml"):
            self.k.learn(os.path.dirname(os.path.abspath(__file__))+"/"+files)

    def ask_1(self,a):
		print str(a)
		self._outlet(1, str(self.k.respond(str(a))))
