#!/usr/bin/env lua

local posix = require"posix"
require"lfs"

local prompt = "\\[\27[1;34m\\]\\w"

local pwd = lfs.currentdir()
local repo = pwd
local branch
while repo:len() > 1 do
    local attr = lfs.attributes(repo.."/.git")
    if attr then
        if attr.mode == "directory" then
            branch = io.open(repo.."/.git/HEAD"):read()
        elseif attr.mode == "file" then
            -- submodule
            repo = repo .. "/" .. io.open(repo.."/.git"):read():match("gitdir: (.+)")
            branch = "master"
        end
        break
    end
    repo = posix.dirname(repo)
end

if branch then
    if branch:sub(1, 4) == "ref:" then
        branch = branch:sub(17)
    end

    prompt = "\\[\27[1m\\]" .. posix.basename(repo)

    if branch ~= "master" then
        prompt = prompt .. "\\[\27[m\\]:\\[\27[31m\\]" .. branch
    end

    local staged_lines  = io.popen("git diff --shortstat --staged"):read()
    if staged_lines then
        prompt = prompt .. "\\[\27[31m\\]+" .. staged_lines:match("%d+")
    else
        local changed_lines = io.popen("git diff --shortstat"):read()
        if changed_lines then
            prompt = prompt .. "\\[\27[31m\\]*" .. changed_lines:match("%d+")
        end
    end

    if repo ~= pwd then
        prompt = prompt .. "\\[\27[1;34m\\]" .. pwd:sub(repo:len() + 1)
    end
end

local rvm = os.getenv("RUBY_VERSION")
if rvm then
    prompt = prompt .. " \\[\27[0;37m\\]" .. rvm
end

if pwd == os.getenv("HOME") then
    prompt = prompt .. " \\[\27[0m\\]"
else
    prompt = prompt .. " \\[\27[0m\\]$ "
end

io.write(prompt)
