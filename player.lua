player = function(x, y, w, h, map)
	local self = {};
	
	self.x = x or 0;
	self.y = y or 0;
	
	self.w = w or 20;
	self.h = h or 20;
	
	self.speed = 100;
	
	self.map = map or nil;
	
	-- jump functions ///////////////////////////////////////////////////////////////
	local vel = 0;
	local gravity = 20; -- 20
	local maxJump = 10; -- 10
	local stateJump = "falling"; -- falling, jumping, solid
	
	-- jump player
	local jump = function()
		vel = -maxJump;
		stateJump = "jumping";
	end;
	
	local getPointsDist = function()
		for i = 1, #self.map do
			local j = ((i + 1) <= #self.map) and (i + 1) or i;
			
			if i ~= j then
				local p1 = self.map[i];
				local p2 = self.map[j];
				
				if self.x >= p1.x and self.x <= p2.x then return { p1, p2 }; end
			end
		end
		
		return nil;
	end;
	
	local mathf_lerp = function(value1, value2, amount) return value1 + (value2 - value1) * amount; end;
	
	self.update = function(dt)
		if stateJump == "falling" then vel = vel + gravity * dt; end
		if vel <= 0 then stateJump = "falling"; end
		self.y = self.y + vel;
		
		if love.keyboard.isDown("up") then
			self.y = self.y - self.speed * dt;
		elseif love.keyboard.isDown("down") then
			self.y = self.y + self.speed * dt;
		end
		
		if love.keyboard.isDown("left") then
			self.x = self.x - self.speed * dt;
		elseif love.keyboard.isDown("right") then
			self.x = self.x + self.speed * dt;
		end
		
		local points = getPointsDist();
		if points ~= nil then
			local amount = (self.x - points[1].x) / (points[2].x - points[1].x);
			local y_interpolate = mathf_lerp(points[1].y, points[2].y, amount);
			
			-- self.y = y_interpolate;
			--if self.y > y_interpolate then self.y = y_interpolate; end
			
			local isJumpimg = vel > (-maxJump) and vel < 0;
			local isFalling = stateJump == "falling" and isJumpimg == false;
			
			if self.y >= (y_interpolate - 5) and self.y <= (y_interpolate + 10) and isFalling then
				vel = 0;
				stateJump = "solid";
				self.y = y_interpolate;
			end
		end
		
		-- jump player
		if love.keyboard.isDown("x") and stateJump == "solid" then jump(); end
	end;
	
	self.draw = function()
		love.graphics.setColor({ 255, 100, 100, 255 });
		love.graphics.rectangle("fill", self.x-(self.w/2), self.y-self.h, self.w, self.h);
		love.graphics.setColor({ 255, 255, 255, 255 });
		
		love.graphics.circle("line", self.x, self.y, 5);
		
		local points = getPointsDist();
		
		love.graphics.setColor({ 255, 100, 100, 255 });
		if points ~= nil then
			love.graphics.line(self.x, self.y, points[1].x, points[1].y);
			love.graphics.line(self.x, self.y, points[2].x, points[2].y);
			
			love.graphics.circle("fill", points[1].x, points[1].y, 5);
			love.graphics.circle("fill", points[2].x, points[2].y, 5);
		end
		love.graphics.setColor({ 255, 255, 255, 255 });
	end;
	
	return setmetatable(self, self);
end;