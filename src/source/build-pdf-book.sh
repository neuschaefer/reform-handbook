#!/bin/sh

set -e
set -x

# generate content tex files from individual rst sources

cat _tex/pre.tex >reform-handbook.tex

# concat _referenceelec subsections
# because pandoc can't work with toctree
echo >_referenceelec.rst
for subsection in \
    referenceelec \
    motherboard \
    keyboard \
    trackball \
    trackpad \
    power \
    debug
do
  cat $subsection.rst >>_referenceelec.rst
  echo >>_referenceelec.rst
done

for section in \
  preface \
  safety \
  quickstart \
  tutorial \
  _referenceelec \
  referencemech \
  credits
do
  pandoc -o _$section.tex -frst+smart --verbose --top-level-division=chapter $section.rst
  cat _tex/section.tex >>reform-handbook.tex
  cat _$section.tex >>reform-handbook.tex
done

cat _tex/post.tex >>reform-handbook.tex

# generate reform-handbook.pdf
xelatex reform-handbook.tex
# twice to get the TOC built
xelatex reform-handbook.tex

# clean up
mv reform-handbook.pdf ../build/
rm _*.tex
rm _*.rst
rm *.out
rm *.log
rm *.aux
rm *.toc

echo ">>> generated ../build/reform-handbook.pdf <<<"

