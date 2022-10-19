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

local function escape(s)
  s = string.gsub(s, "[\\{}%|_#&~%^%%%$]", function(c)
    local s
    if     c == "&"  then s = "\\pandocAmpersand{}"
    elseif c == "\\" then s = "\\pandocBackslash{}"
    elseif c == "^"  then s = "\\pandocCircumflex{}"
    elseif c == "$"  then s = "\\pandocDollarSign{}"
    elseif c == "#"  then s = "\\pandocHash{}"
    elseif c == "{"  then s = "\\pandocLeftBrace{}"
    elseif c == "%"  then s = "\\pandocPercentSign{}"
    elseif c == "|"  then s = "\\pandocPipe{}"
    elseif c == "}"  then s = "\\pandocRightBrace{}"
    elseif c == "~"  then s = "\\pandocTilde{}"
    elseif c == "_"  then s = "\\pandocUnderscore{}"
    else                  s = c
    end
    return s
  end)
  return s
end

local function attributes(attr)
  -- TODO figure out how to parse
  return "heh"
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

function LineBlock(ls)
  return table.concat(ls, "\\pandocLineBreak{}\\n")
end

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

function RawBlock(format, str)
  return "\\pandocRawBlock{" .. format .. "}{" .. str .. "}"
end

function BlockQuote(s)
  return "\\pandocBlockQuoteBegin\n" .. s .. "\n\\pandocBlockQuoteEnd"
end

function OrderedList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "\\pandocOrderedListItemBegin\n" .. item .. "\n\\pandocOrderedListItemEnd")
  end
  return "\\pandocOrderedListBegin\n" .. table.concat(buffer, '\n') .. "\n\\pandocOrderedListEnd"
end

function BulletList(items, num, sty, delim) -- TODO handle num, sty, delim
  if #items == 0 then
    return ""
  end

  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "\\pandocBulletListItemBegin\n" .. item .. "\n\\pandocBulletListItemEnd")
  end
  return "\\pandocBulletListBegin\n" .. table.concat(buffer, '\n') .. "\n\\pandocBulletListEnd"
end

function DefinitionList(items)
  local buffer = {}
  for _,item in pairs(items) do
    local term, defs = next(item)
    table.insert(buffer, "\\pandocDefinitionListItemBegin{" .. term .. "}")
    for _,def in pairs(defs) do
        table.insert(buffer, "\\pandocDefinitionListDefinitionBegin\n" .. def ..
                       "\n\\pandocDefinitionListDefinitionEnd{}")
    end
    table.insert(buffer, "\\pandocDefinitionListItemEnd{}")
  end
  return "\\pandocDefinitionListBegin\n" .. table.concat(buffer) .. "\n\\pandocDefinitionListEnd{}"
end

function Header(lev, s, attr)
  return "\\pandocHeader{" .. lev .. "}{" .. s .. "}"
end

function HorizontalRule()
  return "\\pandocHorizontalRule"
end

function Table(caption, aligns, widths, headers, rows)
  local coldef = ""
  for col,def in pairs(aligns) do
    if     def == "AlignLeft"    then coldef = coldef .. "l"
    elseif def == "AlignRight"   then coldef = coldef .. "r"
    elseif def == "AlignDefault" then coldef = coldef .. "c"
    elseif def == "AlignCenter"  then coldef = coldef .. "d"
    end
  end

  local buffer = {"\\pandocTable{"}
  if caption ~= nil then table.insert(buffer, caption) end
  table.insert(buffer, "}{" .. #rows .. "}{" .. #aligns .. "}{" .. coldef .. "}")

  for i,row in ipairs(rows) do
    local row_buffer = {"{"}
    for j,cell in ipairs(row) do
      table.insert(row_buffer, "{" .. cell .. "}")
    end
    table.insert(row_buffer, "}")
    table.insert(buffer, table.concat(row_buffer))
  end

  return table.concat(buffer)
end

function Div(s, attr)  -- attributes are discarded for now
  return "\\pandocDivBegin\n" .. s .. "\n\\pandocDivEnd{}"
end

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

function SmallCaps(s)
  return "\\pandocSmallCaps{" .. s .. "}"
end

function SingleQuoted(s)
  return "\\pandocSingleQuoted{" .. s .. "}"
end

function DoubleQuoted(s)
  return "\\pandocDoubleQuoted{" .. s .. "}"
end

function Cite(s, cs)
  local buffer = {"\\pandocCite{" .. #cs .. "}"}
  for _, citation in pairs(cs) do
    if (citation.citationMode == "SuppressAuthor") then
      table.insert(buffer, "{-}")
    else
      table.insert(buffer, "{+}")
    end
    table.insert(buffer, "{" .. citation.citationPrefix .. "}")
    table.insert(buffer, "{" .. citation.citationSuffix .. "}")
    table.insert(buffer, "{" .. citation.citationId .. "}")
  end
  return table.concat(buffer)
end

function Code(s, attr)  -- attributes are discarded - no support in Markdown
  return "\\pandocCode{" .. escape(s) .. "}"
end

function Space()
  return "\\pandocSpace{}"
end

function SoftBreak()
  return "\\pandocSoftBreak{}"
end

function LineBreak()
  return "\\pandocLineBreak{}\\n"
end

function InlineMath(s)
  return "\\pandocInlineMath{" .. s .. "}"
end

function DisplayMath(s)
  return "\\pandocDisplayMath{" .. s .. "}"
end

function RawInline(format, str)
  return "\\pandocRawInline{" .. format .. "}{" .. str .. "}"
end

function Link(s, tgt, tit, attr)   -- attributes are discarded for now
  return "\\pandocLink{" .. s .. "}{" .. escape(tgt) .. "}{" .. tgt .. "}{" .. escape(tit) .. "}"
end

function Image(s, src, tit, attr)
  return "\\pandocImage{" .. s .. "}{" .. escape(src) .. "}{" .. src .. "}{" .. escape(tit) .. "}"
end

function CaptionedImage(src, tit, s, attr)  -- s = caption
  return "\\pandocCaptionedImage{" .. s .. "}{" .. escape(src) .. "}{" .. src .. "}{" .. escape(string.sub(tit, 5)) .. "}"
end

function Note(s)
  return "\\pandocNote{" .. s .. "}"
end

function Span(s, attr)
  return "\\pandocSpan{" .. s .. "}"
end
