rm *.jpg *.png
rm aa.*
wget -U 'SomeUserAgent/1.0' -O- 'http://backend.deviantart.com/rss.xml?q=special:dd' 2> /dev/null |
grep -oP "(?<=<media:content)[^<]+" |sed s/'url="'//g |cut -d " " -f2 |sed s/'"'//g|
sed -r 's/.+-([0-9]+)/http:\/\/www.deviantart.com\/download\/\1\/aa/' |
wget -U 'SomeUserAgent/1.0' -i-
FILES=~/deviant/*
count=0
one=1
for f in $FILES
do
file -b $f
echo "Checking file number $count"
count=$(($count + $one))
if [ "$(file $f|grep JPEG)" ]; then
mv ${f} ${count%.*}.jpg
elif [ "$(file $f|grep PNG)" ]; then
mv ${f} ${count%.*}.png
elif [ "$(file $f|grep ASCII)" ]; then
echo ”Skip Script file”
else
rm ${f}
fi
done

bash /home/pi/deviant/slideshow.sh