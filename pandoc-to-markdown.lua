function Doc(body, metadata, variables)
  return "\\pandocDocumentBegin\n"
      .. body .. "\n"
      .. "\\pandocDocumentEnd"
end

-- The following code will produce runtime warnings when you haven't defined
-- all of the functions you need for the custom writer, so it's useful
-- to include when you're working on a writer.
local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined function '%s'\n",key))
    return function() return "" end
  end
setmetatable(_G, meta)

function escape(s)
  return s  -- TODO: Add some proper escaping.
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
-- TODO CodeBlock
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
  -- TODO very suboptimal for the users, ideally turn it into a single macro with a level parameter
  if (lev == 1) then
    return "\\pandocHeaderOne{" .. s .. "}"
  elseif (lev == 2) then
    return "\\pandocHeaderTwo{" .. s .. "}"
  elseif (lev == 3) then
    return "\\pandocHeaderThree{" .. s .. "}"
  elseif (lev == 4) then
    return "\\pandocHeaderFour{" .. s .. "}"
  elseif (lev == 5) then
    return "\\pandocHeaderFive{" .. s .. "}"
  elseif (lev == 6) then
    return "\\pandocHeaderSix{" .. s .. "}"
  end
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
-- TODO Code

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
