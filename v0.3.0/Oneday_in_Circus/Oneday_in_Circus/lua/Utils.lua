local M = {};
-- ver 1.0

local function Sign(x)
    if x > 0 then
        return 1;
    elseif x < 0 then
        return -1;
    else
        return 0;
    end;
end;

-- длина массива, начиная с 0 индекса
local function Length(array)
	local length = 0;
	while array[length] ~= nil do
		length = length + 1;
	end;
	return length;
end;

-- длина массива, начиная с 1 индекса
local function Length1(array)
	local length = 0;
	while array[length + 1] ~= nil do
		length = length + 1;
	end;
	return length;
end;

-- объединение двух массивов
local function Unif(array1, array2)
	local i;
	local start = Length(array1);
	if Length(array2) > 0 then
		for i = 0, Length(array2) - 1, 1 do
			array1[start + i] = array2[i];
		end;
	end;
end;

-- удаление элемента из массива
local function ArrayDeleteElement(array, element)
	local i;
	if element == Length(array) - 1 then
		array[element] = nil;
		return;
	end;
	for i = element, Length(array) - 2, 1 do
		array[i] = array[i + 1];
	end;
	array[Length(array) - 1] = nil;
end;

-- переместить элемент массива в новую позицию, элементы между новой и старой позициями сдвигаются в сторону старой позиции
local function ArrayMoveElement(array, oldPos, newPos)
	local temp = array[oldPos];
	local i;
	if newPos ~= oldPos then
		for i = oldPos, newPos - Sign(newPos - oldPos), Sign(newPos - oldPos) do
			array[i] = array[i + Sign(newPos - oldPos)];
		end;
		array[newPos] = temp;
	end;
end;

-- развернуть порядок элементов массива задом наперед. Индексация должна начинаться с 0
local function ArrayReverse(array)
	local newArray = {};
	local i;
	if array == nil then
		return nil;
	end;
	for i = 0, Length(array) - 1, 1 do
		newArray[i] = array[Length(array) - 1 - i];
	end;
	return newArray;
end;

-- проверить существование элемента двумерного массива
local function Array2DHaveElement(array, m, n)
	if array ~= nil then
		if array[m] ~= nil then
			if array[m][n] ~= nil then
				return true;
			else
				return false;
			end;
		else
			return false;
		end;
	else
		return false;
	end;
end;

-- проверить существование элемента двумерного массива
local function Array2DElement(array, m, n)
	if array ~= nil then
		if array[m] ~= nil then
			if array[m][n] ~= nil then
				return array[m][n];
			else
				return nil;
			end;
		else
			return nil;
		end;
	else
		return nil;
	end;
end;

-- возведение в степень
local function Power(num, power)
	local i;
	local result = 1;
	for i = 0, power - 1, 1 do
		result = result * num;
	end;
end;

-- конструктор точки
local function Point(x, y)
	local point = {};
	point.x = x;
	point.y = y;
	return point;
end;

-- конструктор двумерного массива. Заполняет все ячейки значением value (например можно все заполнить нулями)
local function Array2D(width, height, value)
	local i;
	local j;
	local array;
	array = {};
	for i = 1, width, 1 do
		array[i] = {};
		for j = 1, height, 1 do
			array[i][j] = value;
		end;
	end;
	return array;
end;

local function RecordDelete(record)
    local k, v;
    if type(record) == "table" then
        for k, v in pairs(record) do
            RecordDelete(record[k]);
        end;
    end;
    record = nil;
end;

local function RecordCopy(RecordFrom)
    local k, v;
    if type(RecordFrom) == "table" then
        local temp = {};
        for k, v in pairs(RecordFrom) do
            temp[k] = RecordCopy(RecordFrom[k]);
        end;
        return temp;
    else
        return RecordFrom;
    end;
end;

local function VectorLength(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2));
end;

local function VectorDirection(x1, y1, x2, y2)
    local dir = math.acos((x2 - x1) / math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2)));
    if (y2 > y1) then
        dir = math.pi * 2 - dir;
    end;
    -- было в радианах. Стало в градусах
    dir = dir * 180 / math.pi - 90;
    return dir;
end;

-- Возвращает x, y
local function VectorXY(length, dir)
    local dir2;
    dir2 = (dir + 90) / 180 * math.pi;
    return (-(length * math.cos(math.pi - dir2))), (-(length * math.sin(math.pi - dir2)));
end;

M.Sign = Sign;
M.Length = Length;
M.Length1 = Length1;
M.Unif = Unif;
M.ArrayDeleteElement = ArrayDeleteElement;
M.ArrayMoveElement = ArrayMoveElement;
M.ArrayReverse = ArrayReverse;
M.Array2DHaveElement = Array2DHaveElement;
M.Array2DElement = Array2DHaveElement;
M.Power = Power;
M.Point = Point;
M.Array2D = Array2D;
M.RecordDelete = RecordDelete;
M.RecordCopy = RecordCopy;
M.VectorLength = VectorLength;
M.VectorDirection = VectorDirection;
M.VectorXY = VectorXY;
return M;