local M = {};

local mod = require "mod";

mod.name = "Oneday_in_Circus";
mod.dir = "Oneday_in_Circus/";

mod.screenWidth = 640;
mod.screenHeight = 480;
mod.fullscreen = true;
mod.title = "Oneday_in_Circus";

local function InitAll()
    ScreenInit(mod.screenWidth, mod.screenHeight, mod.fullscreen, mod.title);
    PrimitiveInit();
    TextureInit(IKDM_SMALL, 32);
    TtfInit(IKDM_SMALL, 32)
    FontInit(IKDM_SMALL, 32);
    SpriteInit(IKDM_SMALL, 32);
    KeyboardInit();
    MouseInit();
    TimerInit();
    RandSeedByTime();
    AudioInit(IKDM_SMALL, 32, IKDM_SMALL, 32, 44100, 2, 4096);
end;

M.InitAll = InitAll;
return M;