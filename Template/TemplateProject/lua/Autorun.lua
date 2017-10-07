package.path = "./TemplateProject/lua/?.lua";

local Init         = require "Init";
local LoadAll      = require "LoadAll";
local Quit         = require "Quit";
local SceneManager = require "SceneManager";
local font         = require "font";

Init.InitAll();
LoadAll.LoadAll();
GuiInit(IKDM_SMALL, 32, IKDM_MEDIUM, 256, font.mbf_big);
SceneManager.Init();
SceneManager.Next("MainMenu");
SceneManager.Run();
GuiQuit();
Quit.DestroyAll();
