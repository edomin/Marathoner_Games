local M = {};

local tex = require "tex";
local snd = require "snd";
local mus = require "mus";

local function DestroyAll()
	  TextureFree(tex.mbf_big_00);
	  TextureFree(tex.mbf_big_04);
    
    TtfQuit();
end;

M.DestroyAll = DestroyAll;
return M;