#!/bin/bash
# Author:	Khaschuluu
# Contact:	http://twitter.com/khaschuluu

tmp=/tmp/tmp$$

curl http://vimcasts.org/episodes/archive/ | grep -E '\/episodes' | grep '\"archive\"' | sed -r  's#(^.*"\/)(episodes.*)(" class="archive)(".*)#http:\/\/vimcasts\.org/\2#g' > $tmp-pages 

cat $tmp-pages	|\
while read page_uri
do
	curl $page_uri		|\
	grep -E "ogg:"		|\
	sed -r "s#(^.*')(.*)('.*)#\2#g" > $tmp-episodes

	cat $tmp-episodes |\
	while read episode_uri
	do
		axel -an 10 -o . $episode_uri
	done
done

rm $tmp-*
exit 0
