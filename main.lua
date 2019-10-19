gui = require('libraries.gspot.Gspot')

local earth = {}

love.load = function()
	earth.image = love.graphics.newImage("resources/earth1.png")
end

love.update = function(dt)
	gui:update(dt)
end

love.draw = function()
	gui:draw()

	love.graphics.draw(earth.image, 0, 0, 0, 0.5, 0.5)
end


love.keypressed = function(key, code, isrepeat)
	gui:keypress(key)
end

love.textinput = function(key)
	gui:textinput(key)
end

love.mousepressed = function(x, y, button)
	gui:mousepress(x, y, button)
end

love.mousereleased = function(x, y, button)
	gui:mouserelease(x, y, button)
end

love.wheelmoved = function(x, y)
	gui:mousewheel(x, y)
end