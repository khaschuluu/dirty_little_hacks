#!/bin/bash
# Quantum magazine downloader for lazy learner.
# Author:  Battur (batturjapan@gmail.com). 2010/02/07
# License: Free software

tmp=/tmp/tmp-$$

host_url="http://kvant.mirror1.mccme.ru"
page_url="${host_url}/oblozhka_djvu"
dnld_dir="$(dirname $0)/quantum"

:> $tmp-urls_with_html

for i in "" 2 3 4 5 6 
do 
  echo "Collecting djvu files on ${page_url}${i}.htm..."
  curl "${page_url}${i}.htm" >> $tmp-urls_with_html 2> /dev/null
done

mkdir -p $dnld_dir

cat $tmp-urls_with_html         |\
iconv -f cp1251 -t utf-8        |\
grep -E "\.djvu"                |\
sed -r 's#(<a[^>]+>).*#\1===#g' |\
grep "==="                      |\
sed -r 's#(.*)"([^"]+)".*#\2#g' |\
while read djvu_file
do
  wget -c "${host_url}/${djvu_file}" -O $dnld_dir/$(basename $djvu_file)
done

ruby -e "puts '=' * 80"
ls -l $dnld_dir | sed '1d' | nl
echo "DOWNLOAD COMPLETE."


rm $tmp-*
exit 0
