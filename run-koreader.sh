#!/bin/bash

rm -rf output/frontend &&
cp -r frontend output/frontend &&
rm -rf output/plugins/calibre.koplugin &&
cp -r plugins/calibre.koplugin output/plugins/calibre.koplugin &&
cd output &&
./reader.lua