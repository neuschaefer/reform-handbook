#!/bin/sh

set -e
set -x

# generate content tex files from individual rst sources

cat _tex/pre.tex >reform-handbook.tex

for section in \
  preface \
  safety \
  quickstart \
  input \
  linux \
  desktops \
  software \
  development \
  parts \
  advanced \
  schematics \
  online \
  credits
do
  pandoc -o _$section.tex -frst+smart --verbose -V fontsize=10pt --top-level-division=chapter $section.rst
  cat _tex/section.tex >>reform-handbook.tex
  sed 's/-callouts\.png/x\.eps/g' _$section.tex >>reform-handbook.tex
done

cat _tex/post.tex >>reform-handbook.tex

# generate reform-handbook.pdf
xelatex reform-handbook.tex
# thrice to get the TOC right
xelatex reform-handbook.tex
xelatex reform-handbook.tex

# clean up
mv reform-handbook.pdf ../build/
rm -- _*.tex
rm -- *.out
rm -- *.log
rm -- *.aux
rm -- *.toc

echo ">>> generated ../build/reform-handbook.pdf <<<"
