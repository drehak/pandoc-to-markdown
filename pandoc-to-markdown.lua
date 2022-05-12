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
    if     c == "&"  then s = "\\pandocRendererAmpersand{}"
    elseif c == "\\" then s = "\\pandocRendererBackslash{}"
    elseif c == "^"  then s = "\\pandocRendererCircumflex{}"
    elseif c == "$"  then s = "\\pandocRendererDollarSign{}"
    elseif c == "#"  then s = "\\pandocRendererHash{}"
    elseif c == "{"  then s = "\\pandocRendererLeftBrace{}"
    elseif c == "%"  then s = "\\pandocRendererPercentSign{}"
    elseif c == "|"  then s = "\\pandocRendererPipe{}"
    elseif c == "}"  then s = "\\pandocRendererRightBrace{}"
    elseif c == "~"  then s = "\\pandocRendererTilde{}"
    elseif c == "_"  then s = "\\pandocRendererUnderscore{}"
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

-- TODO Table

function Div(s, attr)  -- attributes are discarded for now
  return "\\pandocDivBegin\n" .. s .. "\n\\pandocDivEnd{}"
end

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

function SmallCaps(s)
  return "\\pandocSmallCaps{" .. s .. "}"
end

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

function SoftBreak()
  return "\\pandocSoftBreak{}"
end

function LineBreak()
  return "\\pandocLineBreak{}"
end


function InlineMath(s)
  return "\\pandocInlineMath{" .. s .. "}"
end

function DisplayMath(s)
  return "\\pandocDisplayMath{" .. s .. "}"
end

-- TODO RawInline

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
