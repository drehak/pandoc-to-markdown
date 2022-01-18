function Doc(body, metadata, variables)
  return "\\pandocDocumentBegin\n"
      .. body .. "\n"
      .. "\\pandocDocumentEnd"
end

function escape(s)
  return s  -- TODO: Add some proper escaping.
end

function Str(s)
  return escape(s)
end

function Space()
  return "\\pandocSpace{}"
end

function Blocksep()
  return "\\pandocBlocksep{}"
end

function Emph(s)
  return "\\pandocEmph{" .. s .. "}"
end

function Para(s)
  return s
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
