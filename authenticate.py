from bs4 import BeautifulSoup
import urllib2, re

for uni in unis:
	response = urllib2.urlopen('http://search.columbia.edu/search?proxystylesheet=columbia2&client=columbia&site=Columbia&output=xml_no_dtd&q=' + uni)
	html = response.read()
	soup = BeautifulSoup(html)
	authenticate = soup.find_all(text=uni) 
	print authenticate 
	print "ithis is uni " + uni

