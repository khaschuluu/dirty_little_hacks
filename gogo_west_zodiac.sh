#!/bin/bash

# West zodiac from gogo.mn for lazy learner.
# Author:  Khaschuluu (khaschuluu.m@gmail.com). 2011/01/16
# License: Opensource sowtware

curl "http://news.gogo.mn/horoscope/content/west.htm" |\
	grep -E "formatted_date" |\
		sed -re "s|^.*<td><br><span class='formatted_date'>[^<]*</span><table style='border-bottom: 1px solid #d8d8d8' width='100%'><tr><td align='center' style='padding: 5px; padding-left:0px;'><a onclick = 'showOneZodiac\([0-9]*,'[a-z]*\.png'\);'><img class='zodiac_list_img' src='http://stat\.gogo\.mn/images/zodiac/oneZodiac/w70/[a-z]*\.png'></a><br><center class='zodiac_date_desc'>([^<]*)<br/>\([0-9/-]*\)</center></td><td valign='top'><br><p>([^<]*)(</p><div align='right'>)?|\1 -> \2|g"
