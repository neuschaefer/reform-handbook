#!/bin/bash

for i in *.svg
do
	target="${i/refman-//}"
	target="../_static/illustrations/${target/\.svg/-callouts.png}"
	echo "$i -> $target"
	inkscape -o $target --export-area-page -w 1280 $i
done

