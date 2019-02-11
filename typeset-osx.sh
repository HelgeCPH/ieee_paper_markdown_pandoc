#!/bin/bash
/usr/local/bin/pandoc \
	-f markdown \
	--pdf-engine=/usr/local/bin/pdflatex \
	--variable documentclass=sig-alternate-05-2015 \
	--filter table-filter.py \
	--filter=/usr/local/bin/pandoc-citeproc \
	--bibliography=sigproc.bib \
	--csl=acm-sig-proceedings-long-author-list.csl \
	metadata.yml sig-alternate-sample.md \
	-o sig-alternate-sample.pdf
