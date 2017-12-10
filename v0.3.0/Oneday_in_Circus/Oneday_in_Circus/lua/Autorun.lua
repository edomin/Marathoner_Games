package.path = "./Oneday_in_Circus/lua/?.lua";

local Init         = require "Init";
local LoadAll      = require "LoadAll";
local Quit         = require "Quit";
local SceneManager = require "SceneManager";
local font         = require "font";

Init.InitAll();
LoadAll.LoadAll();
SceneManager.Init();
SceneManager.Next("Game");
SceneManager.Run();
Quit.DestroyAll();
