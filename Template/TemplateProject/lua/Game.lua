local M = {};

local mod          = require "mod";
local tex          = require "tex";
local spr          = require "spr";
local font         = require "font";
local utils        = require "Utils";
local SceneManager = require "SceneManager";

local quit;
local fps;

local mouse;

local function Init()
    mouse = {};
    mouse.x = 0;
    mouse.y = 0;
end;

local function Input()
    local i;
    local povHat;
    
    mouse.x, mouse.y = MouseGetXY();
    
    if KeyboardPress(KEY_ESCAPE) then
        SceneManager.Next("MainMenu");
        quit = true;
    end;
end;

local function Step()
    
end;

local function Draw()
    PrimitiveFill_c(0x000000);
end;

local function Quit()
    utils.RecordDelete(mouse);
end;

local function Run()
    Init();
    quit = false;
    
    fps = 0;
    
    while not quit do
        TimerStart();
        KeyboardRefresh();
        MouseRefresh();
        
        Input();
        Step();
        Draw();
        
        ScreenFlip();
        fps = TimerDelayForFPS(30);
    end;
    Quit();
end;

M.Run = Run;
return M;