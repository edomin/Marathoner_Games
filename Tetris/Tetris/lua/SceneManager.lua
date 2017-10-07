local M = {};

local scene;
local nextScene;

function Init()
    scene = {};
    scene.MainMenu = require "MainMenu";
    scene.Game = require "Game";
    nextScene = nil;
end;

function Next(nScene)
    nextScene = nScene;
end;

function Run()
    while nextScene ~= nil do
        scene[nextScene].Run();
    end;
end;

M.Init = Init;
M.Run = Run;
M.Next = Next;
return M;