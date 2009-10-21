#!/bin/bash
#*****************************************************************************#
# Description:  RailsCast Video Downloader. Useful for offline learners.      #
# Author:       Battur Sanchin: { mail: batturjapan@gmail.com,                #
#                                 blog: http://battur.blogspot.com }          #
# Date:         2009.10.20                                                    #
# License:      Free Software.                                                #  
#                                                                             #
#*****************************************************************************#

# constants & tunings here...
tmp=/tmp/tmp$$
rchost="http://railscasts.com" # railscast host
dl_dir=$(dirname $0)/movies    # directory where movies saved
dl_bandwidth=60                # download limit/s in kilobytes
dl_interval=2                  # delay interval between downloads

# strip html line to tag uri
function strip(){
  cat - | sed -r 's#(^.*"\/)(tags.*)(".*)#'$rchost'/\2#g'
}


# pull tag categories
curl $rchost | grep -E "\/tag" | grep "<li>" | strip > $tmp-pages

# create directory for downloading movies
mkdir -p $dl_dir


while [ -s $tmp-pages ]
do

  # pull uri's to: download || turn to next page
  dl_uri=$(head -1 $tmp-pages)
  curl $dl_uri                    |\
  grep -E "Download|Next Page"    |\
  tee $tmp-html                   |\
  grep "Download"                 |\
  sed -r 's#(^.*")(.*)(".*)#\2#g' > $tmp-movies


  # download operation is here...
  cat $tmp-movies   |\
  while read movie_uri
  do
    # let's use continue mode. operation would be cheaper if movie is downloaded before.
    wget -c --limit-rate=${dl_bandwidth}k -O $dl_dir/$(basename $movie_uri) $movie_uri 
    sleep $dl_interval
  done


  # remove downloaded uri 
  sed '1d' $tmp-pages > $tmp-tmp
  mv $tmp-tmp $tmp-pages

  # add onto $tmp-pages if "Next Page" was shown.
  grep "Next Page" $tmp-html | strip >> $tmp-pages

done
# Happy ride on Rails ;)

rm $tmp-*
exit 0
