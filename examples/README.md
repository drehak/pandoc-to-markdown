# Example documents

### Markdown

- `panda.md` - A short tale of a panda. Attempts to cover all elements available in Pandoc's flavor of Markdown.
    - [raw file][panda.md-raw], [TeX input][panda.md-input], [TeX output][panda.md-output], [PDF output][panda.md-pdf]

 [panda.md-raw]: files/panda.md?plain=1
 [panda.md-input]: markdown-panda.tex
 [panda.md-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/markdown-panda.pandoc.tex
 [panda.md-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/markdown-panda.pdf

### HTML

- `browsers.html` - *Every Web Browser Absolutely Sucks.* by Luke Smith. I have stripped elements for navigation and tags, resulting in a nice version for "print".
    - [raw file][browsers.html-raw], [TeX input][browsers.html-input], [TeX output][browsers.html-output], [PDF output][browsers.html-pdf], [source][browsers.html-source]
- `gdp.html` - *Why It's Bad to Have High GDP* by Luke Smith. Similar to `browsers.html`, but contains an image. Not stripped.
    - [raw file][gdp.html-raw], [TeX input][gdp.html-input], [TeX output][gdp.html-output], [PDF output][gdp.html-pdf], [source][gdp.html-source]
- ~~`pandoc.html` - (incomplete) Hackage documentation of Pandoc's AST elements. Lots of divs and tables. More of a stress test than a document you would actually like to typeset.~~ Currently disabled in Makefile and automation.
    - ~~[raw file][pandoc.html-raw], [TeX input][pandoc.html-input], [source][pandoc.html-source]~~

 [browsers.html-source]: https://lukesmith.xyz/articles/every-web-browser-absolutely-sucks/
 [browsers.html-raw]: files/browsers.html?plain=1
 [browsers.html-input]: html-browsers.tex
 [browsers.html-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/html-browsers.pandoc.tex
 [browsers.html-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/html-browsers.pdf

 [gdp.html-source]: https://lukesmith.xyz/articles/why-its-bad-to-have-high-gdp/
 [gdp.html-raw]: files/gdp.html?plain=1
 [gdp.html-input]: html-gdp.tex
 [gdp.html-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/html-gdp.pandoc.tex
 [gdp.html-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/html-gdp.pdf

 [pandoc.html-source]: https://hackage.haskell.org/package/pandoc-types-1.22/docs/Text-Pandoc-Definition.html
 [pandoc.html-raw]: files/pandoc.html?plain=1
 [pandoc.html-input]: html-pandoc.tex

### Manual pages

- `leapp.1` - Example of a real-world manual page. 4 pages, basic structural elements.
    - [raw file][leapp.1-raw], [TeX input][leapp.1-input], [TeX output][leapp.1-output], [PDF output][leapp.1-pdf], [source][leapp.1-source]
- `pandoc.1` - (incomplete) Pandoc's manual page. 100+ pages, tables and other complex structural elements.
    - [raw file][pandoc.1-raw], [TeX input][pandoc.1-input], [TeX output][pandoc.1-output], [PDF output][pandoc.1-pdf], [source][pandoc.1-source]
- `wolf.1` - Demonstrates how to change the styling of resulting macros.
    - [raw file][wolf.1-raw], [TeX input][wolf.1-input], [TeX output][wolf.1-output], [PDF output][wolf.1-pdf]

 [leapp.1-source]: https://github.com/oamg/leapp/blob/master/man/leapp.1
 [leapp.1-raw]: files/leapp.1
 [leapp.1-input]: man-leapp.tex
 [leapp.1-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-leapp.pandoc.tex
 [leapp.1-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-leapp.pdf

 [pandoc.1-source]: https://github.com/jgm/pandoc/blob/master/man/pandoc.1
 [pandoc.1-raw]: files/pandoc.1
 [pandoc.1-input]: man-pandoc.tex
 [pandoc.1-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-pandoc.pandoc.tex
 [pandoc.1-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-pandoc.pdf

 [wolf.1-raw]: files/wolf.1
 [wolf.1-input]: man-wolf.tex
 [wolf.1-output]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-wolf.pandoc.tex
 [wolf.1-pdf]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/man-wolf.pdf

All included documents except `panda.md` and `wolf.1` belong to their respective authors and are only included for the purpose of demonstrating the functionality of this software.
