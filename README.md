# Pandoc to Markdown Bridge

This repository contains a proof of concept for an upcoming package for TeX
that will enable the use of [Pandoc][1] together with the [Markdown package][2]
for TeX. For more information, see [the article in the CSTUG Bulletin 31:1–4][3]
(in Slovak, [here is a machine translation to English][7]).

 [1]: https://github.com/jgm/pandoc
 [2]: https://github.com/witiko/markdown
 [3]: https://www.cstug.cz/bulletin/pdf/2021-1-4.pdf#page=85
 [7]: https://translate.google.com/translate?sl=auto&tl=en&u=https://www.fi.muni.cz/~xnovot32/bulletin/2021-1-4/06-rehak-pandoc/&client=webapp

To typeset the example document, execute the following command on a system with
an up-to-date installation of TeX Live and Pandoc:

    $ latexmk -shell-escape -pdf example.tex

Alternatively, you can use [the witiko/markdown Docker image][4], which includes
both TeX Live and Pandoc:

    $ docker run --rm -it -v "$PWD":/workdir -w /workdir witiko/markdown \
    > latexmk -shell-escape -pdf example.tex

 [4]: https://hub.docker.com/r/witiko/markdown/tags

Here are the expected results:

- [`example.pandoc.tex`][5] – the generic TeX output of Pandoc's conversion
- [`example.pdf`][6] – the result of typesetting `example.pandoc.tex` using the Markdown package for TeX

 [5]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/example.pandoc.tex
 [6]: https://github.com/drehak/pandoc-to-markdown/releases/download/latest/example.pdf
