local M = {};

local mod = require "mod";

mod.name = "Tetris";
mod.dir = "Tetris/";

mod.screenWidth = 640;
mod.screenHeight = 480;
mod.fullscreen = false;
mod.title = "Tetris";

local function InitAll()
    ScreenInit(mod.screenWidth, mod.screenHeight, mod.fullscreen, mod.title);
    PrimitiveInit();
    TextureInit(IKDM_SMALL, 32);
    TtfInit(IKDM_SMALL, 32)
    FontInit(IKDM_SMALL, 32);
    KeyboardInit();
    MouseInit();
end;

M.InitAll = InitAll;
return M;