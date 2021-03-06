function setup()
	fishes = {}
	
	for i = 1, 64 do
		-- fishes[i] = Sprites.new(320 + (math.random() > .5 and 0 or 16), 112)
		fishes[i] = Sprites.new(math.random() > .5 and 244 or 245)
		fishes[i].z = math.random() > .75 and -4 or -1 
		-- fishes[i] = Sprites.new(math.floor(math.random() * 256))
		if math.random() > .5 then fishes[i]:toggleAttribute(Sprites.Attributes.FlipH) end
		if math.random() > .5 then fishes[i]:toggleAttribute(Sprites.Attributes.FlipV) end
		if math.random() > .5 then fishes[i]:toggleAttribute(Sprites.Attributes.Rot90) end
		if math.random() > .5 then fishes[i]:toggleAttribute(Sprites.Attributes.Rot180) end
		fishes[i]:toggleAttribute(Sprites.Attributes.Additive)
		fishes[i]:offset(
			24 +           (i % 12) * 32,
			08 + math.floor(i / 12) * 32
		)
		fishes[i]:home(8, 8)
		fishes[i]:rotation(i * 8)
		fishes[i].variables[1] = 0--i * 3
		fishes[i].variables[2] = (window.screen.width / 8) + (i * 2)
		fishes[i].variables[3] = (window.screen.height / 8) + (i * 2)
		fishes[i].variables[4] = i * 2
		fishes[i]:addCallback(becomeFunky)
	end
	
	local thing = Backgrounds.fromV360Map("maps/map1.v360map")
	
	for i = 1, #thing do
		thing[i]:addCallback(alsoProbablyFunky)
		thing[i].variables[1] = i - 1
	end
	
	thing[1].z = 0
	thing[2].z = 1
	thing[3].z = -1
	
	for i = 1, #thing do
		table.insert(fishes, table.remove(thing, 1))
	end
	
	t = Text.new(25, 15)
	t.z = -8
	t:print("Hello, world!")
	t:color(0, 4)
	t:locate(3, 3)
	t:print("Hello, world!")
	table.insert(fishes, t)
end

function update()
	-- add code before
	
	for i = 1, #fishes do
		fishes[i]:update()
	end
end

function draw()
	love.graphics.clear(0, 0, 0)
	
	ZSort.clear()
	for i = 1, #fishes do
		ZSort.add(fishes[i])
	end
	ZSort.flush()
end

function becomeFunky(sprite)
	sprite:offset(
		sine(window.frames + sprite.variables[1], 120 + sprite.variables[4], sprite.variables[2], true) + (window.screen.width / 2),
		cosine(window.frames + sprite.variables[1], 90 + sprite.variables[4], sprite.variables[3], true) + (window.screen.height / 2),
		sine(window.frames + sprite.variables[1], 120 + sprite.variables[4], 5, true)
	)
	sprite:rotation(
		sprite:rotation() + 2
	)
	sprite:color(
		sine(window.frames + sprite.variables[1], 120 + sprite.variables[4], .5, true) + 1,
		sine(window.frames + sprite.variables[1], 180 + sprite.variables[4], .5, true) + 1,
		sine(window.frames + sprite.variables[1], 240 + sprite.variables[4], .5, true) + 1
	)
	sprite:scale(
		sine(window.frames + sprite.variables[1], 90 + sprite.variables[4], 2, true) + 3,
		sine(window.frames + sprite.variables[1], 90 + sprite.variables[4], 2, true) + 3
	)
	
	-- if window.frames % 60 ==  0 then sprite:toggleAttribute(Sprites.Attributes.FlipH) end
	-- if window.frames % 60 == 15 then sprite:toggleAttribute(Sprites.Attributes.FlipV) end
	-- if window.frames % 60 == 30 then sprite:toggleAttribute(Sprites.Attributes.Rot90) end
	-- if window.frames % 60 == 45 then sprite:toggleAttribute(Sprites.Attributes.Rot180) end
end

function alsoProbablyFunky(bg)
	bg:offset(
		sine(window.frames + (bg.variables[1] * 8), 120, 32, true), 0
	)
	
	-- local i, j
	
	-- for j = 0, bg.height - 1 do
	-- 	for i = 0, bg.width - 1 do
	-- 		if window.frames % 60 ==  0 then bg.map[j][i] = bit.bxor(bg.map[j][i], Backgrounds.Attributes.FlipH) end
	-- 		if window.frames % 60 == 15 then bg.map[j][i] = bit.bxor(bg.map[j][i], Backgrounds.Attributes.FlipV) end
	-- 		if window.frames % 60 == 30 then bg.map[j][i] = bit.bxor(bg.map[j][i], Backgrounds.Attributes.Rot90) end
	-- 		if window.frames % 60 == 45 then bg.map[j][i] = bit.bxor(bg.map[j][i], Backgrounds.Attributes.Rot180) end
	-- 	end
	-- end
end
