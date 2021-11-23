python /usr/bin/ino2cpp *.ino -o output
cd output
mkdir src/
cp ../platformio.ini .
mv *.cpp *.h src/
platformio run -t upload