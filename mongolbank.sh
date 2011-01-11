#!/bin/bash

curl "http://www.mongolbank.mn/web/guest/137" 	|\
	grep -E "<table[^>]*>.*</table>"			|\
	sed -re "s#^<table[^>]*>##g"				\
	-e "s#<th.*>.*</th>##g" 					\
	-e "s#</table>.*##g" 						\
	-e "s#<tr[^>]*>#\n#g" 						\
	-e "s#</?t[d|r][^>]*># #g" 							
