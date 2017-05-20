Zubax document templates
========================

This repository contains templates for documents (LaTeX and such).
It is mostly inteneded for use as a submodule.

## Compiling LaTeX on Ubuntu

```bash
sudo apt-get install texlive-full lyx python-pygments
sudo apt-get install texmaker   # GUI IDE, optional
```

Then use the following helper script (which will probably require some modifications) to automate compilation:

```bash
#!/bin/bash

SRC=main

#rm -rf out &> /dev/null
mkdir out &> /dev/null
cp -fP *.bib out/ &> /dev/null

rm out/$SRC.pdf

pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
cd out
bibtex $SRC
#biber $SRC
cd ..
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex

rm *.pdf*
```

Alternatively, use the Texmaker IDE.
In this case you will have to modify the compilation command so that `pdflatex` (or other LaTeX compiler)
is invoked with the option `-shell-escape`, otherwise the syntax coloring feature will not work.

## Editing notes

Avoid inclusion of complex graphics in EPS format, because it tends to be rendered poorly by `pdflatex`.
Prefer PDF instead.

When exporting graphics from Wolfram Mathematica, avoid PDF, and export to EPS instead.
Afterwards convert EPS into PDF using Inkscape or other vector graphics software.
Yes it's complicated, I wish software had less bugs...
