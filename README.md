# Pandoc to Markdown Bridge

This repository contains a proof of concept for an upcoming package for TeX
that will enable the use of [Pandoc][1] together with the [Markdown package][2]
for TeX. For more information, see [the article in the CSTUG Bulletin 31:1–4][3]
(in Slovak, [here is a machine translation to English][4]).

 [1]: https://github.com/jgm/pandoc
 [2]: https://github.com/witiko/markdown
 [3]: https://www.cstug.cz/bulletin/pdf/2021-1-4.pdf#page=85
 [4]: https://translate.google.com/translate?sl=auto&tl=en&u=https://www.fi.muni.cz/~xnovot32/bulletin/2021-1-4/06-rehak-pandoc/&client=webapp

*__Important:__ Pandoc currently supports two styles of [custom writers][5]. The new style was introduced only in 2.17.2. The classic style, which this project uses, is currently [deprecated][6] and should be removed in version 3.0.0. Therefore, this project (in its current state) will not eventually work with newest versions of Pandoc.*

 [5]: https://pandoc.org/custom-writers.html
 [6]: https://github.com/jgm/pandoc/commit/921d7dd2711828d188fe4af2ba6d2765571cde2d

To typeset the example documents, execute the following commands on a system with
an up-to-date installation of TeX Live and Pandoc:

    $ cd examples
    $ make examples

Alternatively, you can use [the witiko/markdown Docker image][7], which includes
both TeX Live and Pandoc:

    $ docker run --rm -it -v "$PWD":/workdir -w /workdir witiko/markdown \
    > latexmk -shell-escape -pdf examples/example-man-pandoc.tex

 [7]: https://hub.docker.com/r/witiko/markdown/tags

See `examples/` for the example documents.

The development of this package has been funded by the research project
[MUNI/33/1784/2020 (Extension of the input formats of the Markdown tool)][8]
funded by the Faculty of Informatics, Masaryk University.

 [8]: https://www.fi.muni.cz/app/projects?project=58488

All included documents except `panda.md` and `wolf.1` belong to their respective authors and are only included for the purpose of demonstrating the functionality of this software.
