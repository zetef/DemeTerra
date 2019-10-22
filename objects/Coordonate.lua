Object = require "libraries.classic.classic"
-- gspot = require "libraries.gspot.Gspot"
vec2d = require "libraries.hump.vector"

local gui = gspot()
local font = love.graphics.newFont(20)

local Coordonate = Object:extend()

function Coordonate:new(sndwch, pos1, pos2)
	local x = (pos1.lon + 180) * (earth.image:getWidth() / 360) * game.ratio.x
	local y = ((pos1.lat * -1) + 90) * (earth.image:getHeight() / 180) * game.ratio.y
	self.posGame1 = {}
	self.posGame1 = vec2d(x, y)

	x = (pos2.lon + 180) * (earth.image:getWidth() / 360) * game.ratio.x
	y = ((pos2.lat * -1) + 90) * (earth.image:getHeight() / 180) * game.ratio.y
	self.posGame2 = {}
	self.posGame2 = vec2d(x, y)

	--print(self.posGame1.x .. " " .. self.posGame1.y)
	--print(self.posGame2.x .. " " .. self.posGame2.y)

	gui.style.font = font

	self.png = {
		[1] = {
			img = love.graphics.newImage("resources/sandwiches/" .. tostring(sndwch) .. "/top.png"),
			show = false,
			x = nil,
			y = nil
		},

		[2] = {
			img = love.graphics.newImage("resources/sandwiches/" .. tostring(sndwch) .. "/bot.png"),
			show = false,
			x = nil,
			y = nil
		}

	}

	-- nu e foarte eficient, foarte mult refactoring ramane de facut :c
	local padding = 0
	local w = self.png[1].img:getWidth()
	local h = self.png[1].img:getHeight()
	local x = {}
	local y = {}
	local tmpx = self.posGame1.x - w / 2
	local tmpy = self.posGame1.y + padding
	if (tmpx < 10) then
		x[1] = padding
	elseif (tmpx > (game.window.width - w)) then
		x[1] = game.window.width - w - padding
	else
		x[1] = tmpx
	end

	if (tmpy + h >= game.window.height) then
		y[1] = self.posGame1.y - padding - h
	else
		y[1] = tmpy
	end

	self.png[1].x = x[1]
	self.png[1].y = y[1]

	tmpx = self.posGame2.x - w / 2
	tmpy = self.posGame2.y + padding
	if (tmpx < 10) then
		x[2] = padding
	elseif (tmpx > (game.window.width - w)) then
		x[2] = game.window.width - w - padding
	else
		x[2] = tmpx
	end

	if (tmpy + h >= game.window.height) then
		y[2] = self.posGame2.y - padding - h
	else
		y[2] = tmpy
	end

	self.png[2].x = x[2]
	self.png[2].y = y[2]


	self.button1 = gspot:button(nil, {self.posGame1.x, self.posGame1.y, nil, nil, 15},
		nil, true
	)

	self.button2 = gspot:button(nil, {self.posGame2.x, self.posGame2.y, nil, nil, 15},
		nil, true
	)

	self.button1.click = function(this)
		self.png[1].show = not self.png[1].show
	end

	self.button2.click = function(this)
		self.png[2].show = not self.png[2].show
	end

	gui.style.default = {1, 0, 0, 1}
	self.button1.style = gui.style
	self.button2.style = gui.style

	self.button1:hide()
	self.button2:hide()
end

function Coordonate:update(dt)
	gui:update(dt)
end

function Coordonate:draw()
	if (self.png[2].show) then
		love.graphics.draw(self.png[2].img, self.png[2].x, self.png[2].y)
	end

	if (self.png[1].show) then
		love.graphics.draw(self.png[1].img, self.png[1].x, self.png[1].y)
	end

	gui:draw()



	-- love.graphics.setColor({256, 0, 0, 256})
	-- love.graphics.circle("fill", self.posGame1.x, self.posGame1.y, 7)
	-- love.graphics.circle("fill", self.posGame2.x, self.posGame2.y, 7)
	-- love.graphics.setColor({256, 256, 256, 256})
end

return Coordonate