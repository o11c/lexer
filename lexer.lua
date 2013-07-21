#!/usr/bin/env lua
local file = {}
file.file = assert(io.open(arg[1]), "[ERROR]: File not found.") -- Attempts to load a file
file.txt = file.file:read("*all")
file.file:close()

file.len = file.txt:len()

--print(string.find(file.txt, " "))
--print(file.txt:len())

function find(ta, s)
  --foo.txt:1:1: note: there is a space here
  local t = {}
  for i=1, file.len do
    table.insert(t, string.sub(ta, i, i))
  end

  local line = 1
  local column = 1
  local ss = {}
  for i,v in ipairs(t) do

    if v == s then
      --[[
          This is where different messages are generated that is given to the user if what they are looking for exists.
      ]]--
      if s == " " then
        msg = "note: there is a space here"
      elseif s == "\t" then
        msg = "error: there is a tab here"
      else
        msg = "note: there is a " .. s .. " here"
      end
      print(arg[1] .. ":" .. line .. ":" .. column .. ": " .. msg)
    end

    if v == "\n" then
      line = line + 1
      column = 1
    else
      column = column + 1
    end

  end
end

find(file.txt, " ") -- The string you are going through goes in the first argument, the second is the thing you are looking for.
