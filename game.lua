require("player");

game = {};

local map = {
	{ id = "p1", x = 0, y = 411 },
	{ id = "p2", x = 126, y = 411 },
	{ id = "p3", x = 243, y = 532 },
	{ id = "p4", x = 839, y = 532 },
	{ id = "p5", x = 908, y = 482 },
	{ id = "p6", x = 1001, y = 482 }
};
local hero = nil;

game.load = function()
	hero = player(100, 100, 30, 40, map);
end;

game.update = function(dt)
	hero.update(dt);
end;

game.draw = function()
	hero.draw();
	
	for i = 1, #map do
		local j = ((i + 1) <= #map) and (i + 1) or i;
		
		if i ~= j then
			local p1 = map[i];
			local p2 = map[j];
			
			love.graphics.line(p1.x, p1.y, p2.x, p2.y);
			love.graphics.circle("line", p1.x, p1.y, 5);
		end
		
		love.graphics.setColor({ 255, 0, 0, 255 });
		if i == #map then
			love.graphics.circle("line", map[i].x, map[i].y, 5);
		end
		love.graphics.setColor({ 255, 255, 255, 255 });
	end
end;