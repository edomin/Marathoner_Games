local M = {};

local mod  = require "mod";
local tex  = require "tex";
local spr  = require "spr";
local snd  = require "snd";
local mus  = require "mus";
local font = require "font";

local function LoadAll()
    tex.mbf_big_00 = TextureLoad(mod.dir .. "textures/mbf_big_00.png");
    tex.mbf_big_04 = TextureLoad(mod.dir .. "textures/mbf_big_04.png");
    
    font.mbf_big = FontCreateMbf("mbf_big", 5, 10, 12);
    FontAddMbfTextureTable(font.mbf_big, tex.mbf_big_00, 0x00);
    FontAddMbfTextureTable(font.mbf_big, tex.mbf_big_04, 0x04);
    
    spr.ant = SpriteLoad(mod.dir .. "textures/ant_strip4.png", 16, 16, 1, 4, 
     4, 8, 8);
    spr.ground = SpriteLoad(mod.dir .. "textures/ground.png", 32, 32, 1, 1, 
     1, 0, 0);
    spr.leaf = SpriteLoad(mod.dir .. "textures/leaf.png", 32, 32, 1, 1, 
     1, 0, 0);
    spr.stone = SpriteLoad(mod.dir .. "textures/stone.png", 32, 32, 1, 1, 
     1, 0, 0);
    spr.beetle = SpriteLoad(mod.dir .. "textures/beetle.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.beetle2 = SpriteLoad(mod.dir .. "textures/beetle2.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.spider = SpriteLoad(mod.dir .. "textures/spider.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.beetle_corpse = SpriteLoad(mod.dir .. "textures/beetle_corpse.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.beetle2_corpse = SpriteLoad(mod.dir .. "textures/beetle2_corpse.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.spider_corpse = SpriteLoad(mod.dir .. "textures/spider_corpse.png", 32, 32, 1, 1, 
     1, 16, 16);
    spr.lens = SpriteLoad(mod.dir .. "textures/lens.png", 160, 160, 1, 1, 
     1, 0, 0);
 
    spr.tail = SpriteLoad(mod.dir .. "textures/tail.png", 16, 16, 1, 1, 
     1, 8, 8);
 
    spr.savedText = SpriteLoad(mod.dir .. "textures/savedText_strip16.png", 200, 64, 1, 1, 
     1, 100, 64);
    spr.note = SpriteLoad(mod.dir .. "textures/note.png", 279, 105, 1, 1, 
     1, 0, 0);
 
    tex.bg = TextureCreate("Background", 640, 480);
    
    snd.saved = AudioSoundLoad(mod.dir .. "sounds/saved.wav");
    snd.step = AudioSoundLoad(mod.dir .. "sounds/step.wav");
    snd.bugDeath = AudioSoundLoad(mod.dir .. "sounds/bugDeath.wav");
    AudioSoundSetVolume_f(snd.saved, 1);
    AudioSoundSetVolume_f(snd.step, 0.3);
    AudioSoundSetVolume_f(snd.bugDeath, 0.3);
    mus.main = AudioMusicLoad(mod.dir .. "music/main.mp3");
    AudioMusicSetVolume_f(0.05);
end;

M.LoadAll = LoadAll;
return M;