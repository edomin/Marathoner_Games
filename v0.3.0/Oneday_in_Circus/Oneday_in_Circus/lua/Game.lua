local M = {};

local mod          = require "mod";
local tex          = require "tex";
local spr          = require "spr";
local font         = require "font";
local mus          = require "mus";
local snd          = require "snd";
local utils        = require "Utils";
local SceneManager = require "SceneManager";

local quit;
local fps;

local mouse;
local playerx;
local peopleTimer1;
local peopleTimer2;
local peopleTimer3;
local peopleTimer4;

local heroStep;

local column;
local columnHeight;
local columnAngle;
local columnTopX;
local columnTopY;

local columnX, columnY;

local gameOver;
local win;

local fallingFigure;
local fallingFigureX;
local fallingFigureY;
local fallingFigureAngle;
local fallingFigureAngleSpeed;
local fallingFigureActualX;

local function columnAddFigure(sprite)
    column[columnHeight] = sprite;
    columnHeight = columnHeight + 1;
end;

local function RandomFigure()
    local figure;
    
    figure = RandRange(0, 8);
    return spr.object[figure];
end;

local function AddRandomFigure()
    columnAddFigure(RandomFigure());
end;

local function ColumnShift(direction, power, step)
    local columnAnglePower = Abs_f(90 - columnAngle) / 35 * columnHeight;
    
    if step then
        if direction == "right" then
            columnAngle = columnAngle - power;
        else
            columnAngle = columnAngle + power;
        end;
    else
        if direction == "right" then
            if columnAnglePower ~= 0 then
                columnAngle = columnAngle - power * columnAnglePower;
            else
                columnAngle = columnAngle - power;
            end;
        else
            if columnAnglePower ~= 0 then
                columnAngle = columnAngle + power * columnAnglePower;
            else
                columnAngle = columnAngle + power;
            end;
        end;
    end;
end;

local function AddFallingFigure()
    fallingFigure = RandomFigure();
    fallingFigureX = playerx - 64 + RandRange(1, 128);
    fallingFigureY = 0;
    fallingFigureAngle = 90;
    fallingFigureAngleSpeed = -4 + RandRange(0, 8);
end;

local function Init()
    mouse = {};
    mouse.x = 0;
    mouse.y = 0;
    
    playerx = 0;
    peopleTimer1 = 0;
    peopleTimer2 = 7;
    peopleTimer3 = 14;
    peopleTimer4 = 21;
    
    heroStep = 0;
    
    column = {};
    columnHeight = 0;
    columnAngle = 90;
    columnX = 320;
    columnY = 376;
    
    gameOver = false;
    win = false;
    
    AddRandomFigure();
    AddFallingFigure();
    
    AudioMusicPlay(mus.main);
end;

local function Input()
    mouse.x, mouse.y = MouseGetXY();
    
    if KeyboardPress(KEY_ESCAPE) then
        SceneManager.Next(nil);
        quit = true;
    end;
    
    if KeyboardPress(KEY_R) then
        Init();
    end;
    
    if gameOver then
        return;
    end;
    
    if KeyboardPress(KEY_LEFT) then
        playerx = playerx - 8;
        heroStep = 7;
        if columnHeight ~= 1 then
            ColumnShift("right", 5, true);
        end;
    end;
    if KeyboardPress(KEY_RIGHT) then
        playerx = playerx + 8;
        heroStep = 7;
        if columnHeight ~= 1 then
            ColumnShift("left", 5, true);
        end;
    end;
    
--    if KeyboardPress(KEY_SPACE) then
--        AddRandomFigure();
--    end;
end;

local function Step()
    if gameOver then
        return;
    end;
    
    peopleTimer1 = peopleTimer1 + 1;
    peopleTimer2 = peopleTimer2 + 1;
    peopleTimer3 = peopleTimer3 + 1;
    peopleTimer4 = peopleTimer4 + 1;
    if peopleTimer1 == 30 then
        peopleTimer1 = 0;
    end;
    if peopleTimer2 == 30 then
        peopleTimer2 = 0;
    end;
    if peopleTimer3 == 30 then
        peopleTimer3 = 0;
    end;
    if peopleTimer4 == 30 then
        peopleTimer4 = 0;
    end;
    
    if heroStep > 0 then
        heroStep = heroStep - 1;
    end;
    
    if columnHeight ~= 1 then
        if columnAngle <= 90 then
            ColumnShift("right", 0.2, false);
        else
            ColumnShift("left", 0.2, false);
        end;
    end;
    
    if columnAngle <= 0 or columnAngle >= 180 then
        gameOver = true;
        AudioSoundPlay(snd.fall);
    end;
    
    fallingFigureY = fallingFigureY + 1;
    fallingFigureAngle = fallingFigureAngle + fallingFigureAngleSpeed;
    
    fallingFigureActualX = 320 + fallingFigureX - playerx;
    
    columnTopX = columnX + Vecx_f(32 * columnHeight, columnAngle);
    columnTopY = columnY + Vecy_f(32 * columnHeight, columnAngle);
    
    if fallingFigureY < columnTopY then
        if Abs_f(fallingFigureActualX - columnTopX) <= 32  and columnTopY - fallingFigureY <= 16 then
            columnAddFigure(fallingFigure);
            AddFallingFigure();
            AudioSoundPlay(snd.set);
        end;
    end;
    
    if fallingFigureY >= 480 then
        gameOver = true;
        AudioSoundPlay(snd.fall);
    end;
    
    if columnHeight == 9 then
        gameOver = true;
        win = true;
    end;
end;

local function Draw()
    local i;
    local columnCurrentX = columnX;
    local columnCurrentY = columnY;
    PrimitiveFill_c(0x000000);
    
    for i = 0, 2, 1 do
        TextureBlitScaled_f(tex.bg, i * 512 - (playerx % 512), 0, 2.0, 2.0);
    end;
    
    for i = -1, 5, 1 do
        if peopleTimer4 < 15 then
            TextureBlitScaled_f(tex.people4, i * 128 - (playerx % 128) + 32, 208, 2.0, 2.0);
        else
            TextureBlitScaled_f(tex.people4, i * 128 - (playerx % 128) + 32, 208 + 2, 2.0, 2.0);
        end;
        if peopleTimer3 < 15 then
            TextureBlitScaled_f(tex.people3, i * 128 - (playerx % 128) + 24, 224, 2.0, 2.0);
        else
            TextureBlitScaled_f(tex.people3, i * 128 - (playerx % 128) + 24, 224 + 2, 2.0, 2.0);
        end;
        if peopleTimer2 < 15 then
            TextureBlitScaled_f(tex.people2, i * 128 - (playerx % 128) + 16, 240, 2.0, 2.0);
        else
            TextureBlitScaled_f(tex.people2, i * 128 - (playerx % 128) + 16, 240 + 2, 2.0, 2.0);
        end;
        if peopleTimer1 < 15 then
            TextureBlitScaled_f(tex.people1, i * 128 - (playerx % 128) + 8, 256, 2.0, 2.0);
        else
            TextureBlitScaled_f(tex.people1, i * 128 - (playerx % 128) + 8, 256 + 2, 2.0, 2.0);
        end;
        TextureBlitScaled_f(tex.arena, i * 128 - (playerx % 128), 288, 2.0, 2.0);
    end;
    
    if heroStep == 0 then
        SpriteDrawScaled_f(spr.hero, 0, 320, 448, 2.0, 2.0);
    else
        SpriteDrawScaled_f(spr.hero, 1, 320, 448, 2.0, 2.0);
    end;
    
    for i = 0, columnHeight - 1, 1 do
        if i ~= 0 then
            columnCurrentX = columnCurrentX + Vecx_f(32, columnAngle);
            columnCurrentY = columnCurrentY + Vecy_f(32, columnAngle);
        end;
        SpriteDrawGeneral_f(column[i][0], 0, columnCurrentX, columnCurrentY, 2, 2, columnAngle, FLIP_NONE);
    end;

    SpriteDrawGeneral_f(fallingFigure[1], 0, fallingFigureActualX, fallingFigureY, 2, 2, fallingFigureAngle, FLIP_NONE);

    if gameOver then
        PrimitiveRectangleFilled_ca_f(120, 200, 520, 280, 0xFF000088);
        if win then
            FontDrawString_f(font.main, 160, 230, "Успех");
        else
            FontDrawString_f(font.main, 160, 230, "Неудача");
        end;
        FontDrawString_f(font.main, 160, 250, "Нажмите 'R' для перезапуска игры");
    end;

    FontDrawString_f(font.main, 0, 0, "FPS: " .. fps);
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
        fps = TimerDelayForFPS_f(60);
    end;
    Quit();
end;

M.Run = Run;
return M;