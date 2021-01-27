#!/bin/bash

mogrify -flatten -background white *.png
mogrify -set colorspace Gray -separate -average *.png

