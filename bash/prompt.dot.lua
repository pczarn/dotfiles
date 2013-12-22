#!/usr/bin/env lua

require"lfs"

local LUA_DIRSEP = string.sub(package.config, 1, 1)

local basename = function(string_, suffix)
    string_ = string_ or ''
    return string.gsub(string_, '[^'.. LUA_DIRSEP ..']*'.. LUA_DIRSEP ..'', '')
end

local prompt = "\\[\27[1;34m\\]\\w"

local branch = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null"):read()
if branch then
    local repo = basename(io.popen("git rev-parse --show-toplevel"):read())
    local rel_path = io.popen("git rev-parse --show-prefix"):read()

    prompt = "\\[\27[1m\\]" .. repo

    if branch ~= "master" then
        prompt = prompt .. "\\[\27[m\\]:\\[\27[31m\\]" .. branch
    end

    local staged_lines  = (io.popen("git diff --shortstat --staged"):read() or ''):match("%d+")
    local changed_lines = (io.popen("git diff --shortstat"):read() or ''):match("%d+")

    if staged_lines then
        prompt = prompt .. "\\[\27[31m\\]+" .. staged_lines
    elseif changed_lines then
        prompt = prompt .. "\\[\27[31m\\]*" .. changed_lines
    end

    if rel_path ~= '' then
        prompt = prompt .. "\\[\27[1;34m\\]/" .. rel_path
    end
end

if lfs.currentdir() == os.getenv("HOME") then
    prompt = prompt .. " \\[\27[0m\\]"
else
    prompt = prompt .. " \\[\27[0m\\]$ "
end

io.write(prompt)
