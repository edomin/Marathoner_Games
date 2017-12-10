local M = {};

local mod  = require "mod";
local tex  = require "tex";
local font = require "font";
local spr = require "spr";
local mus = require "mus";
local snd = require "snd";

local function LoadAll()
    spr.font_00 = SpriteLoad(mod.dir .. "textures/mbf_big_00.png", 10, 12, 16, 
     16, 256, 0, 0);
    spr.font_04 = SpriteLoad(mod.dir .. "textures/mbf_big_04.png", 10, 12, 16, 
     16, 256, 0, 0);
    font.main = FontCreate("Main", 5);
    FontAddAtlas(font.main, spr.font_00, 0);
    FontAddAtlas(font.main, spr.font_04, 4);
    
    tex.arena = TextureLoad(mod.dir .. "textures/arena.png");
    tex.people1 = TextureLoad(mod.dir .. "textures/people1.png");
    tex.people2 = TextureLoad(mod.dir .. "textures/people2.png");
    tex.people3 = TextureLoad(mod.dir .. "textures/people3.png");
    tex.people4 = TextureLoad(mod.dir .. "textures/people4.png");
    tex.bg = TextureLoad(mod.dir .. "textures/background.png");
    
    spr.blue_cube = {};
    spr.red_cube = {};
    spr.green_cube = {};
    spr.bottle = {};
    
    spr.object = {};
    spr.object[0] = {};
    spr.object[0][0] = SpriteLoadSimple(mod.dir .. "textures/blue_cube.png", 0, 16);
    spr.object[0][1] = SpriteLoadSimple(mod.dir .. "textures/blue_cube.png", 16, 16);
    spr.object[1] = {};
    spr.object[1][0] = SpriteLoadSimple(mod.dir .. "textures/red_cube.png", 0, 16);
    spr.object[1][1] = SpriteLoadSimple(mod.dir .. "textures/red_cube.png", 16, 16);
    spr.object[2] = {};
    spr.object[2][0] = SpriteLoadSimple(mod.dir .. "textures/green_cube.png", 0, 16);
    spr.object[2][1] = SpriteLoadSimple(mod.dir .. "textures/green_cube.png", 16, 16);
    spr.object[3] = {};
    spr.object[3][0] = SpriteLoadSimple(mod.dir .. "textures/bottle.png", 0, 16);
    spr.object[3][1] = SpriteLoadSimple(mod.dir .. "textures/bottle.png", 16, 16);
    spr.object[4] = {};
    spr.object[4][0] = SpriteLoadSimple(mod.dir .. "textures/jar.png", 0, 16);
    spr.object[4][1] = SpriteLoadSimple(mod.dir .. "textures/jar.png", 16, 16);
    spr.object[5] = {};
    spr.object[5][0] = SpriteLoadSimple(mod.dir .. "textures/goblet.png", 0, 16);
    spr.object[5][1] = SpriteLoadSimple(mod.dir .. "textures/goblet.png", 16, 16);
    spr.object[6] = {};
    spr.object[6][0] = SpriteLoadSimple(mod.dir .. "textures/container.png", 0, 16);
    spr.object[6][1] = SpriteLoadSimple(mod.dir .. "textures/container.png", 16, 16);
    spr.object[7] = {};
    spr.object[7][0] = SpriteLoadSimple(mod.dir .. "textures/box.png", 0, 16);
    spr.object[7][1] = SpriteLoadSimple(mod.dir .. "textures/box.png", 16, 16);
    spr.object[8] = {};
    spr.object[8][0] = SpriteLoadSimple(mod.dir .. "textures/box2.png", 0, 16);
    spr.object[8][1] = SpriteLoadSimple(mod.dir .. "textures/box2.png", 16, 16);
    
    spr.hero = SpriteLoad(mod.dir .. "textures/hero.png", 64, 64, 1, 2, 2, 32, 
     64);
 
    mus.main = AudioMusicLoad(mod.dir .. "music/bu-the-absurd-puppy.ogg");
 
    snd.set = AudioSoundLoad(mod.dir .. "sounds/set.wav");
    snd.fall = AudioSoundLoad(mod.dir .. "sounds/fall.wav");
end;

M.LoadAll = LoadAll;
return M;