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

local grid;

local block;
local score;
local deleted;
local speed;
local stepCounter;
local gameOver;

local GRID_WIDTH = 10;
local GRID_HEIGHT = 15;

local function Init()
    local i;
    local j;
    
    RandSeedByTime();
    
    mouse = {};
    mouse.x = 0;
    mouse.y = 0;
    
    grid = {};
    for i = 1, GRID_WIDTH, 1 do
        grid[i] = {};
        for j = 1, GRID_HEIGHT, 1 do
            grid[i][j] = 0;
        end;
    end;
    
    block = {
        -- #
        -- ##
        --  #
        {
            {1, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 1, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 1, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        --  #
        -- ##
        -- #
        {
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        -- #
        -- ##
        -- #
        {
            {1, 0, 0, 0},
            {1, 1, 0, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        -- #
        -- #
        -- ##
        {
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 1, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        --  #
        --  #
        -- ##
        {
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 0, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        -- ##
        -- ##
        {
            {1, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        -- #
        -- #
        -- #
        -- #
        {
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {1, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {1, 0, 0, 0},
            {1, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        
    };
    
    currentFigure = {};
    currentFigure.angle = 0;
    currentFigure.type = RandRange(1, 7) * 4 - 3;
    currentFigure.x32 = 5;
    currentFigure.y32 = 1;
    
    score = 0;
    speed = 1;
    deleted = 0;
    stepCounter = 0;
    gameOver = false;
end;

local function DeleteLine(line)
    local i;
    local j;
    
    for i = 1, GRID_WIDTH, 1 do
        for j = line, 2, -1 do
            grid[i][j] = grid[i][j - 1];
        end;
    end;
end;

local function AppendFigure(x32, y32)
    local i;
    local j;
    local figure = block[currentFigure.type + currentFigure.angle];
    local lineCombo = 0;
    
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            if i + x32 - 1 <= GRID_WIDTH and i + x32 - 1 >= 1 and j + y32 <= GRID_HEIGHT then
                grid[i + x32 - 1][j + y32] = bit32.bor(grid[i + x32 - 1][j + y32], figure[i][j]);
            end;
        end;
    end;
    
    for j = 1, GRID_HEIGHT, 1 do
        local line = true;
        for i = 1, GRID_WIDTH, 1 do
            if grid[i][j] == 0 then
                line = false;
            else
                line = line and true;
            end;
        end;
        if line then
            lineCombo = lineCombo + 1;
            DeleteLine(j);
        end;
    end;
    if lineCombo > 0 then
        score = score + Pow_f(2, lineCombo - 1);
        deleted = deleted + 1;
        if deleted % 10 == 0 then
            speed = speed + 1;
        end;
    end;
end;

local function NewFigure()
    currentFigure.angle = 0;
    currentFigure.type = RandRange(1, 7) * 4 - 3;
    currentFigure.x32 = 5;
    currentFigure.y32 = 1;
    
    local i;
    local j;
    local figure = block[currentFigure.type + currentFigure.angle];
    
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            if figure[i][j] == 1 then
                if grid[i + currentFigure.x32 - 1][j + currentFigure.y32] == 1 then
                    gameOver = true;
                end;
                
                if currentFigure.y32 - 1 + j == GRID_HEIGHT then
                    gameOver = true;
                end;
            end;
        end;
    end;
    if not gameOver then
        currentFigure.y32 = 1;
    end;
end;

local function StepDown()
    local i;
    local j;
    local figure = block[currentFigure.type + currentFigure.angle];
    
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            if figure[i][j] == 1 then
                if grid[i + currentFigure.x32 - 1][j + currentFigure.y32] == 1 then
                    AppendFigure(currentFigure.x32, currentFigure.y32 - 1);
                    NewFigure();
                    return true;
                end;
                
                if currentFigure.y32 - 1 + j == GRID_HEIGHT then
                    AppendFigure(currentFigure.x32, currentFigure.y32 - 1);
                    NewFigure();
                    return true;
                end;
            end;
        end;
    end;
    
    currentFigure.y32 = currentFigure.y32 + 1;
    return false;
end;

local function Input()
    local i;
    local j;
    local figure = block[currentFigure.type + currentFigure.angle];
    
    mouse.x, mouse.y = MouseGetXY();
    
    if KeyboardPress(KEY_ESCAPE) then
        SceneManager.Next("MainMenu");
        quit = true;
    end;
    
    if not gameOver then
        if KeyboardPress(KEY_DOWN) then
            StepDown();
        end;
        
        if KeyboardPress(KEY_SPACE) then
            stopped = false;
            repeat
                stopped = StepDown();
            until stopped;
        end;
        
        if KeyboardPress(KEY_LEFT) then
            local ok = true;
            for i = 1, 4, 1 do
                for j = 1, 4, 1 do
                    if figure[i][j] == 1 and ok then
                        local array = grid;
                        local m = i + currentFigure.x32 - 2;
                        local n = j + currentFigure.y32 - 1;
                        if utils.Array2DElement(grid, m, n) then
                            if grid[m ][n] ~= 1 then
                                ok = true;
                            else
                                ok = false;
                            end;
                        else
                            ok = false;
                        end;
                    end;
                end;
            end;
            if ok then
                currentFigure.x32 = currentFigure.x32 - 1;
            end;
        end;
        if KeyboardPress(KEY_RIGHT) then
            local ok = true;
            for i = 1, 4, 1 do
                for j = 1, 4, 1 do
                    if figure[i][j] == 1 and ok then
                        local array = grid;
                        local m = i + currentFigure.x32;
                        local n = j + currentFigure.y32 - 1;
                        if utils.Array2DElement(grid, m, n) then
                            if grid[m ][n] ~= 1 then
                                ok = true;
                            else
                                ok = false;
                            end;
                        else
                            ok = false;
                        end;
                    end;
                end;
            end;
            if ok then
                currentFigure.x32 = currentFigure.x32 + 1;
            end;
        end;
        if KeyboardPress(KEY_UP) then
            local ok = true;
            local oldAngle = currentFigure.angle;
            local tryToShift = 0;
            local oldX32 = currentFigure.x32;
            
            currentFigure.angle = currentFigure.angle + 1;
            currentFigure.angle = currentFigure.angle % 4;
            figure = block[currentFigure.type + currentFigure.angle];
            
            ::again::
            for i = 1, 4, 1 do
                for j = 1, 4, 1 do
                    if figure[i][j] == 1 and ok then
                        local array = grid;
                        local m = i + currentFigure.x32 - 1;
                        local n = j + currentFigure.y32 - 1;
                        if utils.Array2DElement(grid, m, n) then
                            if grid[m][n] ~= 1 then
                                ok = true;
                            else
                                ok = false;
                            end;
                        else
                            if m > GRID_WIDTH then
                                if tryToShift > -2 then
                                    currentFigure.x32 = currentFigure.x32 - 1;
                                    tryToShift = tryToShift - 1;
                                    goto again;
                                else
                                    ok = false;
                                end;
                            end;
                            if m < 1 then
                                if tryToShift < 2 then
                                    currentFigure.x32 = currentFigure.x32 + 1;
                                    tryToShift = tryToShift + 1;
                                    goto again;
                                else
                                    ok = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            if not ok then
                currentFigure.angle = oldAngle;
                currentFigure.x32 = currentFigure.x32 + tryToShift;
                figure = block[currentFigure.type + currentFigure.angle];
            end;
        end;
    end;
end;

local function Step()
    if not gameOver then
        stepCounter = stepCounter + 1;
        if stepCounter % (30 - speed) == 0 then
            stepCounter = 0;
            StepDown();
        end;
    end;
end;

local function Draw()
    local i;
    local j;
    local figure = block[currentFigure.type + currentFigure.angle];
    local figureX;
    local figureY;
    
    PrimitiveFill_c(0x000000);
    
    for i = 1, GRID_WIDTH, 1 do
        for j = 1, GRID_HEIGHT, 1 do
            if grid[i][j] == 0 then
                PrimitiveRectangleFilled_c_f(i * 32 + 1 - 32, j * 32 + 1 - 32, 
                 i * 32 + 30 - 32, j * 32 + 30 - 32, 0x444444);
            else
                PrimitiveRectangleFilled_c_f(i * 32 + 1 - 32, j * 32 + 1 - 32, 
                 i * 32 + 30 - 32, j * 32 + 30 - 32, 0x888800);
            end;
        end;
    end;
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            if figure[i][j] == 1 then
                figureX = ((i - 1) + currentFigure.x32) * 32;
                figureY = ((j - 1) + currentFigure.y32) * 32
                PrimitiveRectangleFilled_c_f(figureX + 1 - 32, figureY + 1 - 32, 
                 figureX + 30 - 32, figureY + 30 - 32, 0x008800);
            end;
        end;
    end;
    
    FontDrawMbfString_f(font.mbf_big, 352, 32, "Score: " .. score);
    FontDrawMbfString_f(font.mbf_big, 352, 64, "Speed: " .. speed);
    if gameOver then
        FontDrawMbfString_f(font.mbf_big, 352, 96, "Game Over");
    end;
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