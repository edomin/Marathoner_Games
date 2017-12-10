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

local BUGS_COUNT = 40;
local BLOCKS_COUNT = 20;
local ANTS_COUNT = 5;

local function Init()
    local i;
    
    math.randomseed(os.clock());
    
    mouse = {};
    mouse.x = 0;
    mouse.y = 0;
    mouse.xt = 0;
    mouse.yt = 0;
    
    player = {};
    player.x = 320;
    player.y = 240;
    player.direction = 0;
    player.anim = 0;
    player.speed = 0;
    
    controller = {};
    controller.x = 0;
    controller.y = 0;
    
    block = {};
    for i = 0, BLOCKS_COUNT - 1, 1 do
        block[i] = {};
        ::again::
        block[i].x = math.random(0, 19) * 32;
        block[i].y = math.random(0, 14) * 32;
        if (block[i].x == 320 or block[i].x == 352) and (block[i].y == 224 or block[i].y == 256) then
            goto again;
        end;
        if math.random(1, 2) == 1 then
            block[i].sprite = spr.stone;
        else
            block[i].sprite = spr.leaf;
        end;
    end;
    
    ant = {};
    for i = 0, ANTS_COUNT - 1, 1 do
        ant[i] = {};
        ant[i].x = math.random(0, 19) * 32;
        ant[i].y = math.random(0, 14) * 32;
        ant[i].hspeed = math.random(1, 4);
        ant[i].vspeed = math.random(1, 4);
        if math.random(1, 2) == 1 then
            ant[i].hspeed = -ant[i].hspeed;
        end;
        if math.random(1, 2) == 1 then
            ant[i].vspeed = -ant[i].vspeed;
        end;
        ant[i].anim = 0;
        ant[i].saved = false;
    end;
    
    bug = {};
    for i = 0, BUGS_COUNT - 1, 1 do
        local type = math.random(1, 3);
        bug[i] = {};
        bug[i].x = math.random(0, 19) * 32;
        bug[i].y = math.random(0, 14) * 32;
        bug[i].hspeed = math.random(1, 2);
        bug[i].vspeed = math.random(1, 2);
        if math.random(1, 2) == 1 then
            bug[i].hspeed = -bug[i].hspeed;
        end;
        if math.random(1, 2) == 1 then
            bug[i].vspeed = -bug[i].vspeed;
        end;
        if type == 1 then
            bug[i].sprite = spr.beetle;
            bug[i].corpseSprite = spr.beetle_corpse;
        elseif type == 2 then
            bug[i].sprite = spr.beetle2;
            bug[i].corpseSprite = spr.beetle2_corpse;
        else
            bug[i].sprite = spr.spider;
            bug[i].corpseSprite = spr.spider_corpse;
        end;
        bug[i].alive = true;
    end;
    
    lens = {};
    lens.x = 32;
    lens.y = 32;
    lens.direction = math.random(1, 360);
    lens.speed = math.random(1, 4);
    if math.random(1, 2) == 1 then
        lens.speed = -lens.speed;
    end;
    
    savedAnts = 0;
    
    TextureBeginTarget(tex.bg);
    for i = 0, 19, 1 do
        for j = 0, 14, 1 do
            SpriteDraw_f(spr.ground, 0, i * 32, j * 32);
        end;
    end;
    TextureEndTarget(void);
    
    savedText = {};
    savedText.x = 0;
    savedText.y = 0;
    savedText.frame = 0;
    savedText.active = false;
    
    AudioMusicPlay(mus.main);
    
    touched = false;
    
    gameOver = false;
    victory = false;
    
    gameOverTime = 0;
end;

local function Input()
    local i;
    local povHat;
    
    mouse.x, mouse.y = MouseGetXY();
    mouse.xt = math.floor(mouse.x / 32);
	mouse.yt = math.floor(mouse.y / 32);
    
    if KeyboardPress(KEY_ESCAPE) then
        SceneManager.Next("MainMenu");
        quit = true;
    end;
    
    for i = 0, 11, 1 do
        if GameControllerButtonPress(1, i) then
            if gameOver and gameOverTime <= 0 then
                SceneManager.Next("Game");
                quit = true;
            else
                player.speed = 8;
                AudioSoundPlay(snd.step);
                touched = true;
            end;
        end;
    end;
    
    controller.x = GameControllerGetAxis(1, 0);
    controller.y = GameControllerGetAxis(1, 1);
    
--    controller.x = GameControllerGetAxis(1, 3);
--    controller.y = GameControllerGetAxis(1, 2);
    
    povHat = GameControllerGetPovHat(1, 0);
    if povHat == POVHAT_UP then
        controller.x = 0;
        controller.y = -1;
    end;
    if povHat == POVHAT_DOWN then
        controller.x = 0;
        controller.y = 1;
    end;
    if povHat == POVHAT_LEFT then
        controller.x = -1;
        controller.y = 0;
    end;
    if povHat == POVHAT_RIGHT then
        controller.x = 1;
        controller.y = 0;
    end;
    if povHat == POVHAT_UP_LEFT then
        controller.x = -1;
        controller.y = -1;
    end;
    if povHat == POVHAT_UP_RIGHT then
        controller.x = 1;
        controller.y = -1;
    end;
    if povHat == POVHAT_DOWN_LEFT then
        controller.x = -1;
        controller.y = 1;
    end;
    if povHat == POVHAT_DOWN_RIGHT then
        controller.x = 1;
        controller.y = 1;
    end;
end;

local function Step()
    local canMove = true;
    
    if gameOver then 
        gameOverTime = gameOverTime - 1;
        return;
    end;
    
    if controller.x ~= 0 or controller.y ~= 0 then
        player.direction = utils.VectorDirection(0, 0, controller.x, 
         controller.y);
    end;
    
    if player.speed > 0 then
        player.speed = player.speed - 1;
    end;
    
    hSpeed, vSpeed = utils.VectorXY(player.speed, player.direction);
    
    for i = 0, BUGS_COUNT - 1, 1 do
        if utils.VectorLength(player.x + hSpeed, player.y + vSpeed, bug[i].x, 
         bug[i].y) < 32 then
            if player.speed >= 4 then
                player.speed = player.speed - 4;
            end;
        end;
        if utils.VectorLength(lens.x, lens.y, bug[i].x, bug[i].y) < 16 then
            if bug[i].alive then
                bug[i].alive = false;
                AudioSoundStop(snd.bugDeath);
                AudioSoundPlay(snd.bugDeath);
            end;
        end;
    end;
    
    for i = 0, BLOCKS_COUNT - 1, 1 do
        if utils.VectorLength(player.x + hSpeed, player.y + vSpeed, 
         block[i].x + 16, block[i].y + 16) < 32 then
            if player.speed >= 4 then
                player.speed = player.speed - 4;
            end;
        end;
    end;
    
    for i = 0, ANTS_COUNT - 1, 1 do
        if utils.VectorLength(player.x + hSpeed, player.y + vSpeed, 
         ant[i].x + 16, ant[i].y + 16) < 32 then
            if not ant[i].saved then
                ant[i].saved = true;
                savedAnts = savedAnts + 1;
                AudioSoundPlay(snd.saved);
                
                savedText.x = ant[i].x;
                savedText.y = ant[i].y;
                savedText.frame = 0;
                savedText.active = true;
                
                if savedAnts == ANTS_COUNT then
                    gameOver = true;
                    victory = true;
                    gameOverTime = 15;
                end;
            end;
        end;
    end;
    
    if utils.VectorLength(player.x, player.y, lens.x, 
     lens.y) < 16 then
        gameOver = true;
        gameOverTime = 15;
    end;
    
    if player.x + hSpeed <= 0 then
        canMove = false;
    end;
    if player.x + hSpeed >= 640 then
        canMove = false;
    end;
    if player.y + vSpeed <= 0 then
        canMove = false;
    end;
    if player.y + vSpeed >= 480 then
        canMove = false;
    end;
    
    if canMove then
        player.x = player.x + hSpeed;
        player.y = player.y + vSpeed;
    end;
    
    if player.speed > 0 then 
        if player.anim == 15 then
            player.anim = 0;
        else
            player.anim = player.anim + 1;
        end;
    end;
    
    for i = 0, ANTS_COUNT - 1, 1 do
        ant[i].x = ant[i].x + ant[i].hspeed;
        ant[i].y = ant[i].y + ant[i].vspeed;
        
        if ant[i].x <= 0 then
            ant[i].x = ant[i].x - ant[i].hspeed;
            ant[i].hspeed = -ant[i].hspeed;
        end;
        if ant[i].x >= 640 then
            ant[i].x = ant[i].x - ant[i].hspeed;
            ant[i].hspeed = -ant[i].hspeed;
        end;
        if ant[i].y <= 0 then
            ant[i].y = ant[i].y - ant[i].vspeed;
            ant[i].vspeed = -ant[i].vspeed;
        end;
        if ant[i].y >= 480 then
            ant[i].y = ant[i].y - ant[i].vspeed;
            ant[i].vspeed = -ant[i].vspeed;
        end;
        
        ant[i].direction = utils.VectorDirection(0, 0, ant[i].hspeed, 
         ant[i].vspeed);
        
        if ant[i].anim == 15 then
            ant[i].anim = 0;
        else
            ant[i].anim = ant[i].anim + 1;
        end;
    end;
    
    for i = 0, BUGS_COUNT - 1, 1 do
        if bug[i].alive then
            bug[i].x = bug[i].x + bug[i].hspeed;
            bug[i].y = bug[i].y + bug[i].vspeed;
            
            if bug[i].x <= 0 then
                bug[i].x = bug[i].x - bug[i].hspeed;
                bug[i].hspeed = -bug[i].hspeed;
            end;
            if bug[i].x >= 640 then
                bug[i].x = bug[i].x - bug[i].hspeed;
                bug[i].hspeed = -bug[i].hspeed;
            end;
            if bug[i].y <= 0 then
                bug[i].y = bug[i].y - bug[i].vspeed;
                bug[i].vspeed = -bug[i].vspeed;
            end;
            if bug[i].y >= 480 then
                bug[i].y = bug[i].y - bug[i].vspeed;
                bug[i].vspeed = -bug[i].vspeed;
            end;
            
            bug[i].direction = utils.VectorDirection(0, 0, bug[i].hspeed, bug[i].vspeed);
        end;
    end;
    
    if math.random(1, 30) == 1 then
        lens.direction = utils.VectorDirection(lens.x, lens.y, player.x, player.y);
        lens.speed = 4;
    end;
    
    hSpeed, vSpeed = utils.VectorXY(lens.speed, lens.direction);
    
    if lens.x + hSpeed < 0 then
        lens.x = lens.x + 4;
        lens.direction = utils.VectorDirection(lens.x, lens.y, player.x, player.y);
        lens.speed = 4;
    end;
    if lens.x + hSpeed > 640 then
        lens.x = lens.x - 4;
        lens.direction = utils.VectorDirection(lens.x, lens.y, player.x, player.y);
        lens.speed = 4;
    end;
    if lens.y + vSpeed < 0 then
        lens.y = lens.y + 4;
        lens.direction = utils.VectorDirection(lens.x, lens.y, player.x, player.y);
        lens.speed = 4;
    end;
    if lens.y + vSpeed > 480 then
        lens.y = lens.y - 4;
        lens.direction = utils.VectorDirection(lens.x, lens.y, player.x, player.y);
        lens.speed = 4;
    end;
    
    lens.x = lens.x + hSpeed;
    lens.y = lens.y + vSpeed;
    
    if savedText.active then
        if  savedText.frame == 16 then
            savedText.active = false;
        end;
        savedText.y = savedText.y - 8;
        savedText.frame = savedText.frame + 1;
    end;
end;

local function Draw()
    local i;
    local j;
    PrimitiveFill_c(0x000000);
    
    TextureBlit_f(tex.bg, 0, 0);
    
    for i = 0, BLOCKS_COUNT - 1, 1 do
        SpriteDraw_f(block[i].sprite, 0, block[i].x, block[i].y);
    end;
 
    for i = 0, ANTS_COUNT - 1, 1 do
        if not ant[i].saved then
            SpriteDrawAngled_f(spr.ant, math.floor(ant[i].anim / 4), ant[i].x, 
             ant[i].y, ant[i].direction);
        end;
    end;
    for i = 0, BUGS_COUNT - 1, 1 do
        if bug[i].alive then
            SpriteDrawAngled_f(bug[i].sprite, 0, bug[i].x, bug[i].y, bug[i].direction);
        else
            SpriteDrawAngled_f(bug[i].corpseSprite, 0, bug[i].x, bug[i].y, bug[i].direction);
        end;
    end;
    
    SpriteDrawAngled_f(spr.ant, math.floor(player.anim / 4), player.x, 
     player.y, player.direction);
    
    SpriteDraw_f(spr.lens, 0, lens.x, lens.y);
    
    TextureBeginTarget(tex.bg);
    SpriteDraw_f(spr.tail, 0, lens.x, lens.y);
    TextureEndTarget(void);
    
    if savedText.active then
        SpriteDraw_f(spr.savedText, 0, savedText.x, savedText.y);
    end;
    
    if not touched then
        SpriteDraw_f(spr.note, 0, player.x + 8, player.y + 8);
    end;
 
    FontDrawMbfString_f(font.mbf_big, 0, 0, "Спасено муравьёв: " .. savedAnts);
    
    if gameOver then
        PrimitiveRectangleFilled_ca_f(100, 220, 540, 260, 0xFF000080);
        if victory then
            FontDrawMbfString_f(font.mbf_big, 120, 235, "Все спасены. Нажмите любую кнопку.");
        else
            FontDrawMbfString_f(font.mbf_big, 120, 235, "Ваш муравей сгорел. Нажмите любую кнопку.");
        end;
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
        GameControllerRefresh();
        
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