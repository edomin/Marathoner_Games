local M = {};

local mod          = require "mod";
local tex          = require "tex";
local spr          = require "spr";
local snd          = require "snd";
local mus          = require "mus";
local font         = require "font";
local utils        = require "Utils";
local SceneManager = require "SceneManager";

local quit;
local fps;

local mouse;

local function SelectCompany(company);
    local k;
    local v;
    
    for k, v in pairs(cl) do
        if k ~= company then
            guiCompanySelected[k] = false;
        else
            companySelected = k;
        end;
    end;
end;

local function Init()
    local k;
    local v;
    
    mouse = {};
    mouse.x = 0;
    mouse.y = 0;
    mouse.xt = 0;
    mouse.yt = 0;
    
    AudioMusicStop();
end;

local function Input()
    mouse.x, mouse.y = MouseGetXY();
    mouse.xt = math.floor(mouse.x / 32);
	mouse.yt = math.floor(mouse.y / 32);
    
    if KeyboardPress(KEY_ESCAPE) then
        SceneManager.Next(nil);
        quit = true;
    end;
end;

local function Step()
    GuiProcessEvents();
end;

local function Draw()
    PrimitiveFill_c(0x000000);
    
    GuiRender();
end;

local function Gui()
    local k;
    local v;
    local centerX = mod.screenWidth / 2;
    local centerY = mod.screenHeight / 2;
    local labelFlags = bit32.bor(GUI_TEXT_ALIGN_MIDDLE,  GUI_TEXT_ALIGN_LEFT);
    if GuiBegin("Main Menu", centerX - 128, centerY - 40, 256, 80, 
     GUI_WINDOW_BORDER + GUI_WINDOW_NO_SCROLLBAR) then
        GuiLayoutRowDynamic(32, 1);
        if GuiButtonLabel("Новая игра") then
            SceneManager.Next("Game");
            quit = true;
        end;
        if GuiButtonLabel("Выход") then
            SceneManager.Next(nil);
            quit = true;
        end;
    end;
    GuiEnd();
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
        GameControllerRefresh();
        
        Input();
        Step();
        Draw();
        
        Gui();
        
        ScreenFlip();
        fps = TimerDelayForFPS(30);
    end;
    Quit();
end;

M.Run = Run;
return M;