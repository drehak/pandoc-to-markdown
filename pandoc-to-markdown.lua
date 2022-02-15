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

-- TODO Plain

function Para(s)
  return s
end

-- TODO LineBlock
-- TODO CodeBlock
-- TODO RawBlock
-- TODO BlockQuote
-- TODO OrderedList
-- TODO BulletList
-- TODO DefinitionList
-- TODO Header
-- TODO HorizontalRule
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

-- TODO Underline

function Strong(s)
  return "\\pandocStrong{" .. s .. "}"
end

-- TODO Strikeout
-- TODO Superscript
-- TODO Subscript
-- TODO SmallCaps
-- TODO Quoted
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
