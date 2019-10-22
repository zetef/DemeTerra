gspot = require "libraries.gspot.Gspot"
Coord = require "objects.Coordonate"

game = {}
earth = {}

love.load = function()
	love.math.getRandomSeed(os.time())

	game.window = {}
	game.window.width, game.window.height = love.graphics.getDimensions()
	game.font = love.graphics.newFont(30)

	earth.image = love.graphics.newImage("resources/earth.png")
	earth.transform = love.math.newTransform(0, 0, 0,
		game.window.width / earth.image:getWidth(),
		game.window.height / earth.image:getHeight()
	)

	game.ratio = {}
	game.ratio.x = game.window.width / earth.image:getWidth()
	game.ratio.y = game.window.height / earth.image:getHeight()

	print("ratio x " .. game.ratio.x .. '\n' .. "ratio y " .. game.ratio.y)

	button = gspot:button("make a sandwich!", {
		10,
		game.window.height - game.window.height / 5,
		300, 30
		}, nil, true
	)

	local already = {}
	local cnt = 0
	button.click = function(this)
		if (current_coord) then
			current_coord.button1:hide()
			current_coord.button2:hide()
		end
		local n = love.math.random(1, #coords)
		if(already[n]) then
			while(already[n] and (#already ~= #coords)) do
				n = love.math.random(1, #coords)
			end
		end
		already[n] = n

		current_coord = coords[n]
		current_coord.button1:show()
		current_coord.button2:show()

		-- current_coord.png[1].show = true
		-- current_coord.png[2].show = true
	end


	gspot.style.font = game.font
	gspot.style.fg = {0, 0, 0, 1}
	gspot.style.default = {0, 100/256, 0, 1}
	button.style = gspot.style

	coords = {
		Coord( -- australia, ocean pacific
			1,
			{lon = 135, lat = -33},
			{lon = -145, lat = 33}
		),
		Coord( -- liberia, ocean sanatos
			2,
			{lon = 171, lat = -6},
			{lon = -9, lat = 6}
		),
		Coord( -- argentina, china
			3,
			{lon = 115, lat = 33},
			{lon = -70, lat = -33}
		),
		Coord( -- alaska, antarctida
			4,
			{lon = -152, lat = 70},
			{lon = 28, lat = -70}
		),
		Coord( -- spania, noua zeelanda
			5,
			{lon = 170, lat = -40},
			{lon = -10, lat = 40}
		)
	}
	current_coord = nil
end

love.update = function(dt)
	gspot:update(dt)

	if (current_coord) then
		current_coord:update(dt)
		if current_coord.png[1].show == true and current_coord.png[2].show == true then
			-- facem sandwichul
			current_coord.png[1].x = game.window.width / 2 - current_coord.png[1].img:getWidth() / 2
			current_coord.png[1].y = game.window.height / 2 - current_coord.png[1].img:getHeight() / 2

			current_coord.png[2].x = game.window.width / 2 - current_coord.png[2].img:getWidth() / 2
			current_coord.png[2].y = game.window.height / 2
		end
	end
end

function love.draw()
	love.graphics.draw(earth.image, earth.transform)

	gspot:draw()

	if (current_coord) then
		current_coord:draw()
	end
end

function love.keypressed(key, code, isrepeat)
	gspot:keypress(key)
end

love.textinput = function(key)
	gspot:textinput(key)
end

love.mousepressed = function(x, y, button)
	gspot:mousepress(x, y, button)
end

love.mousereleased = function(x, y, button)
	gspot:mouserelease(x, y, button)
end

love.wheelmoved = function(x, y)
	gspot:mousewheel(x, y)
end