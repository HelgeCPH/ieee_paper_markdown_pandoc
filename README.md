# ieee_paper_markdown_pandoc

Example project of an academic paper using the IEEE template. I did my
work on MacOS. Your OS may need other requirements. This includes a
workaround for the latex package `longtable` (required by the IEEE
template) not supporting 2 column output.

# TeX Environment
0. Install homebrew (https://brew.sh/)

## Install MacTeX and Additional Dependencies:
1. `brew cask install mactex`
2. `brew install pandoc pandoc-crossref pandoc-citeproc`
3. `brew install ghc cabal-install`

The last dependency is needed to install `pandoc-include` as there is no homebrew formula for it.

```bash
brew install ghc cabal-install
cabal update
cabal install pandoc-include
```

Find the documentation of `pandoc-include` [here](https://github.com/steindani/pandoc-include).


# Python Environment

I used python 3.6. I did not try 2.7. Here are instructions on setting
up your environment based on miniconda:

0. Install miniconda: `brew cask install miniconda`
1. `conda create --name pandoc python=3.6 -y`
2. `conda activate pandoc`
3. `pip install -r requirements.txt`

# Development Environment

If you haven't installed the Apple developer tools, you may need to do
that (for make). Or you can try installing it via homebrew (`brew
install make`). You'll want to ensure the following are in
/usr/local/bin (or otherwise modify the makefile accordingly):

* `pandoc`
* `pdflatex`
* `pandoc-crossref`
* `pandoc-citeproc`

# Ready, set, go
Executing `make` will create 2 pdf files in the `build` directory.

Those pdfs are also in the `pdf-sample` directory for your convenience.

# Autobuild Your Documents
0. `brew install fswatch`

Run `make watch` in a different terminal window to have `fswatch` watch
your files and automatically build them as you edit them.  If you use
the [Skim app](https://skim-app.sourceforge.io) as your PDF reader, it
will pick up the changes to the PDF automatically. If you use Preview,
you'll have to switch to another app and then switch back to see the
changes.

# Thanks
To Daniel Graziotin whose repo I forked:
https://github.com/dgraziotin/acm_sig_paper_markdown_pandoc

Context:
https://ineed.coffee/4008/how-to-write-an-acm-styled-conference-paper-using-markdownpandoc/
