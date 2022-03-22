function Doc(body, metadata, variables)
  return "\\pandocDocumentBegin\n"
      .. body .. "\n"
      .. "\\pandocDocumentEnd"
end

local meta = PANDOC_DOCUMENT.meta
-- The following code will produce runtime warnings when you haven't defined
-- all of the functions you need for the custom writer, so it's useful
-- to include when you're working on a writer.
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined function '%s'\n",key))
    return function() return "" end
  end
setmetatable(_G, meta)

function escape(s)
  -- TODO handle all special characters, deduplicate code
  s = string.gsub(s, "\\", "\\\\")
  -- TODO avoid the dummy
  s = string.gsub(s, "{", "!!DUMMY!!")
  s = string.gsub(s, "}", "\\textbraceright{}")
  s = string.gsub(s, "!!DUMMY!!", "\\textbraceleft{}")
  s = string.gsub(s, "%[", "\\lbrack{}")
  s = string.gsub(s, "]", "\\rbrack{}")
  s = string.gsub(s, "%<", "\\textless{}")
  s = string.gsub(s, "%>", "\\textgreater{}")
  s = string.gsub(s, "%|", "\\textbar{}")
  s = string.gsub(s, "_", "\\_")
  s = string.gsub(s, "#", "\\#")
  s = string.gsub(s, "&", "\\&")
  s = string.gsub(s, "~", "\\~{}")
  s = string.gsub(s, "`", "\\`{}")
  s = string.gsub(s, "%^", "\\^{}")
  s = string.gsub(s, "%%", "\\%%")
  s = string.gsub(s, "%$", "\\$")
  return s
end

function Blocksep()
  return "\\pandocBlocksep\n"
end

-- Block elements.

function Plain(s)
  return s
end

function Para(s)
  return s
end

-- TODO LineBlock

-- counter for filenames
local codeBlocks = 1

function CodeBlock(s, attr)  -- attributes are discarded - no support in Markdown
  local filename = meta.auxDir .. "/CodeBlock." .. codeBlocks
  local file = assert(io.open(filename, "w"))
  file:write(s)
  file:close()
  codeBlocks = codeBlocks + 1
  return "\\pandocCodeBlock{" .. filename .. "}{" .. attr.class .. "}"
end

-- TODO RawBlock

function BlockQuote(s)
  return s  -- TODO
end

-- TODO OrderedList

function BulletList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "\\pandocBulletListItemBegin\n" .. item .. "\n\\pandocBulletListItemEnd")
  end
  return "\\pandocBulletListBegin\n" .. table.concat(buffer, '\n') .. "\n\\pandocBulletListEnd"
end

-- TODO DefinitionList

function Header(lev, s, attr)
  return "\\pandocHeader{" .. lev .. "}{" .. s .. "}"
end

function HorizontalRule()
  return "\\pandocHorizontalRule"
end

-- TODO Table
-- TODO Div
-- TODO Null

-- Inline elements.

function Str(s)
  return escape(s)
end

function Emph(s)
  return "\\pandocEmph{" .. s .. "}"
end

function Underline(s)
  return "\\pandocUnderline{" .. s .. "}"
end

function Strong(s)
  return "\\pandocStrong{" .. s .. "}"
end

function Strikeout(s)
  return "\\pandocStrikeout{" .. s .. "}"
end

function Subscript(s)
  return "\\pandocSubscript{" .. s .. "}"
end

function Superscript(s)
  return "\\pandocSuperscript{" .. s .. "}"
end

-- TODO SmallCaps

function SingleQuoted(s)
  return "\\pandocSingleQuoted{" .. s .. "}"
end

function DoubleQuoted(s)
  return "\\pandocDoubleQuoted{" .. s .. "}"
end

-- TODO Cite

function Code(s, attr)  -- attributes are discarded - no support in Markdown
  return "\\pandocCode{" .. escape(s) .. "}"
end

function Space()
  return "\\pandocSpace{}"
end

-- TODO SoftBreak
-- TODO LineBreak
-- TODO Math
-- TODO RawInline
-- TODO Link
-- TODO Image
-- TODO Note
-- TODO Span
