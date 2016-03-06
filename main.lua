require("game");

function love.load()
	game.load();
end

function love.update(dt)
	game.update(dt);
end

function love.draw()
	game.draw();
	
	-- draw FPS
	local fColor = { 255, 255, 0, 255 };
	local bColor = { 34, 34, 34, 255 };
	local fps = tostring(love.timer.getFPS());
	printWithBackground("FPS: " .. fps, 0, 0, fColor, bColor);
end

local font = love.graphics.getFont();
function printWithBackground(text, x, y, fc, bgc)
	love.graphics.setColor(bgc or { 64, 64, 64, 255 });
	love.graphics.rectangle("fill", x, y, font:getWidth(text), font:getHeight());

	-- draw text
	love.graphics.setColor(fc or { 255, 0, 0, 255 });
	love.graphics.print(text, x, y);
	love.graphics.setColor({ 255, 255, 255, 255 });
end