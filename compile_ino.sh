python /usr/bin/ino2cpp *.ino -o output
cd output
cp ../platformio.ini .
platformio run -t upload