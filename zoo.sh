#! /bin/bash
ls > zlist

for  i in `cat zlist`
 do
  cd  $i
  ls > zlist
  for y in `cat zlist`
   do
    f=""
    t="${y/.avi/$f}"
    mkdir $t
    ffmpeg -i "$y" -q:v 1 "$t"/%06d.jpg;
    
  done
 cd ../
done
