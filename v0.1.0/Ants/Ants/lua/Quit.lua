local M = {};

local tex = require "tex";
local snd = require "snd";
local mus = require "mus";

local function DestroyAll()
	TextureFree(tex.number);
	TextureFree(tex.font);
    
	TextureFree(tex.grass);
	TextureFree(tex.ground);
	TextureFree(tex.palm);
	TextureFree(tex.bush);
	TextureFree(tex.bg);
	TextureFree(tex.sky);
	TextureFree(tex.bamboo);
	TextureFree(tex.gliderRun);
	TextureFree(tex.gliderFlying);
    
    AudioSoundFree(snd.glide);
    AudioSoundFree(snd.crash);
    AudioMusicFree(mus.main);
    
    GameControllerQuit();
    AudioQuit();
    TtfQuit();
    ScreenQuit();
end;

M.DestroyAll = DestroyAll;
return M;