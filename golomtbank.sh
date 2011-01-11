#!/bin/bash

curl "http://www.golomtbank.com/whansh.aspx?lang=1"	|\
	grep "<table[^>]*>.*</table>" 					|\
	sed -re "s|<tr[^>]*>|\n|g"						\
	-e "s|<td[^>]*><img[^>]*></td><td[^>]*>||g"		\
	-e "s|</td><td[^>]*>| |g"						\ 
	-e "s|</td></tr>||g" 							\
	-e "s|<td.*||g"									\
