PANDOC = time /usr/local/bin/pandoc
OUTPUT = build

FLAGS = \
	--filter=`which pandoc-include` \
	-F `which pandoc-crossref` \
	-f markdown \
	--pdf-engine=`which pdflatex` \
	--filter table-filter.py \
	--filter=`which pandoc-citeproc` \
	--bibliography=bibliography.bib \
	--csl=bibliography.csl \
	-s

FLAGS_TEX = \
	--bibliography=bibliography.bib \
	--csl=bibliography.csl \
	-s \
	-F /usr/local/bin/pandoc-crossref

FLAGS_PDF = --template=template.latex

all: paper.pdf  # test1.pdf test2.pdf

mkdir:
	@if [ ! -e build ]; then mkdir build; fi

%.pdf : contents/paper.md | mkdir
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS) $(FLAGS_PDF) metadata.yaml $<

%.tex : contents/%.md | mkdir
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS_TEX) $(FLAGS_PDF) metadata.yaml $<

test:
	make all
	make test1.tex test2.tex

watch:
	fswatch -o *.md *.png *.bib *.csl *.yaml *.py *.latex makefile | xargs -n1 -I{} make all

clean:
	rm -f build/*
