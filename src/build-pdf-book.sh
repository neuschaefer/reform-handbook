#!/bin/sh

set -e
set -x

cd source

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
  cat $section.rst | grep -v '`KiCAD: ' | grep -v '`PDF: ' | pandoc -o _$section.tex -frst+smart --verbose -V fontsize=10pt --top-level-division=chapter
  cat _tex/section.tex >>reform-handbook.tex
  sed 's/\(-callouts\|-icon\)\.png/x\.eps/g' _$section.tex >>reform-handbook.tex
done

cat _tex/post.tex >>reform-handbook.tex

# generate reform-handbook.pdf
xelatex --interaction=nonstopmode reform-handbook.tex
# thrice to get the TOC right
xelatex --interaction=nonstopmode reform-handbook.tex
xelatex --interaction=nonstopmode reform-handbook.tex

# clean up
mv reform-handbook.pdf ../build/
rm -- _*.tex
rm -- *.out
rm -- *.log
rm -- *.aux
rm -- *.toc

cd ..

echo ">>> generated ./build/reform-handbook.pdf <<<"

