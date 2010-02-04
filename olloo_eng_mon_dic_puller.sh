#!/bin/bash
#------------------------------------------------
# olloo_eng_mon_dic_puller.sh
# by Battur (batturjapan@gmail.com) 2010.02.04
#------------------------------------------------

tmp=/tmp/tmp$$

echo > db
ruby -e "('a'..'z').each {|c| puts c}" |\
while read c
do 
  reached=false; 
  range=30; 
  while [ "$reached" = "false" ]
  do 
    echo "++ $c : $range ++"
    curl "http://www.olloo.mn/modules.php?name=Dictionary&dicSearch=${c}&searchType=starts_with&min=${range}" 2> /dev/null |\
    grep -E "play_word"                                   |\
    iconv -f cp1251 -t utf8                               |\
    sed -r -e "s#<br>#\n#g" -e "s#<[^>]*>##g"             |\
    sed -r -e "s#\[[^]]*\] ?##" -e "/^\s*$/d"             > $tmp-result
    grep "Таны хайсан vг олдсонгvй" $tmp-result           > /dev/null

    if [ $? -ne 0 ]; then
      cat $tmp-result | tee -a db
      let range=$range+30
    else
      reached=true; 
    fi

  done 
  sleep 1
done


cat db |\
sort -u

rm $tmp-*
exit 0

Result:
==============================================

aback - be taken aback балмагдах, хирдхийх, цочирдох, сандрах, сочих. 
abacus - сампин. 
abandoned - 1. ёс суртахуунгvй, задгай, танхай. 2. хаягдсан, орхигдмол. 
abandon - чєлєєтэй байх, хэв журамд vл баригдах. 1. бvрмєсєн хаяад/ орхиод явах. 2. (хийж буй юмаа) зогсоох. 
abasement - басамжлал, доромжлол. 
abase - басамжлах, доромжлох. 
abashed - ичиж зовсон, нvvр улайсан. 
abate - 1. (салхи, шуурга, vерийн ус, євчин г.м) намжих, буурах. 2. эцэс болгох. 
abatement - бууралт, намдалт. 
abattoir - бой, нядалгааны газар. 
abbey - католик шашны хийд. 
abbot - хийдийн хамба. 
abbreviate - товчлох, хураангуйлах. 
abbreviation - хураангуйлал, товчлол, їг хураах ёс. 
abdicate - (хаан ширээ, єндєр тушаал гэх мэтээс) болих, татгалзах, єгєх. 
abdication - хаан ширээнээсээ татгалзах. 
abdomen - 1. хэвлий, хэвлийн хєндийн, гэдэс. 2. хорхой, шавжны бєгс. 
abdominal - хэвлийн, хэвлийн хєндийн, гэдэсний. 
abduction - хvн хулгайлах. 
abductor - хулгайч. 
abduct - хvн хулгайлах, хvчээр буюу хуурч авч явах. 
aberration - хазайлт, гажилт, гажиг. 
abetter, abettor - єєхшvvлэгч, тухирагч. 
abet - (-tt-) хэрэгтнийг єєхшvvлэх/ тухирах. 
abeyance - тvр зогсоосон/ хойшлуулсан буюу тvтгэлзvvлсэн байдал. 
abhorrence - жигшил, зэвvvцэл, vзэн ядах. 
abhorrent - зэвvv хvрэгсэн, жигшмээр, vзэн ядах сэтгэл тєрvvлсэн. 
abhor - (-rr-) жигших, зэвvvцэх, эгдvvцэх, vзэн ядах. 
abide - 1. (abode or abided) сахих, дагах, мєрдєх. 2. vнэнч байх. 3. хэлсэндээ хvрэх. 
abiding - 1. олон жилийн, удаан vргэлжилсэн. 2. тогтвортой, байнгын. 

