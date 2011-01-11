#!/bin/python
# conding: utf-8

import re
import urllib2

url = urllib2.urlopen("http://www.mongolbank.mn/web/guest/137")
html = url.read()

for tables in re.findall('<table[^>]*>(.+?)</table>', html):
	for trs in re.findall('<tr[^>]*>(.+?)</tr>', tables):
		for tds in re.findall('<td[^>]*>(.+?)</td><td[^>]*>(.+?)</td><td[^>]*>(.+?)</td>', trs):
			print tds[0] + " " + tds[1] + " " + tds[2]
