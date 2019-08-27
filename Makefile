PANDOC = time /usr/local/bin/pandoc
OUTPUT = build

FLAGS = \
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
	# For some reason piping to pandoc does not work. Only therefore I write to 
	# the intermediate file
	./md_include.py $<
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS) $(FLAGS_PDF) metadata.yaml contents/_complete_paper.md
	rm contents/_complete_paper.md

%.tex : contents/%.md | mkdir
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS_TEX) $(FLAGS_PDF) metadata.yaml $<

test:
	make all
	make test1.tex test2.tex

watch:
	fswatch -o *.md *.png *.bib *.csl *.yaml *.py *.latex makefile | xargs -n1 -I{} make all

clean:
	rm -f build/*



# perl -ne 's/^#\\((.+)\\).*/cat \"\\$1\"/e;print' ${file_base_name}.md > result.md