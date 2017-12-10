local M = {};

local mod = require "mod";

mod.name = "Ants";
mod.dir = "Ants/";

mod.screenWidth = 640;
mod.screenHeight = 480;

local function InitAll()
    ScreenInit(mod.screenWidth, mod.screenHeight);
    PrimitiveInit();
    TextureInit(IKDM_MEDIUM, 256);
    SpriteInit(IKDM_MEDIUM, 256);
    TtfInit(IKDM_SMALL, 32);
    FontInit(IKDM_SMALL, 32);
    AudioInit(IKDM_MEDIUM, 32, IKDM_SMALL, 32, AU_FREQ_DEFAULT, 
     AU_CHANNELS_DEFAULT, 1024);
    KeyboardInit();
    MouseInit();
    GameControllerInit();
end;

M.InitAll = InitAll;
return M;