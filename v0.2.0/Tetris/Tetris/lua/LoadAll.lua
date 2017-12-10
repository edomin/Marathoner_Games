local M = {};

local mod  = require "mod";
local tex  = require "tex";
local font = require "font";

local function LoadAll()
    tex.mbf_big_00 = TextureLoad(mod.dir .. "textures/mbf_big_00.png");
    tex.mbf_big_04 = TextureLoad(mod.dir .. "textures/mbf_big_04.png");
    
    font.mbf_big = FontCreateMbf("mbf_big", 5, 10, 12);
    FontAddMbfTextureTable(font.mbf_big, tex.mbf_big_00, 0x00);
    FontAddMbfTextureTable(font.mbf_big, tex.mbf_big_04, 0x04);
end;

M.LoadAll = LoadAll;
return M;