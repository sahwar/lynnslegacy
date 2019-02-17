function love.load()
    --love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)

    paletteData = love.filesystem.read("ll.pal")

    spriteData = love.filesystem.read("lynn24.spr")

    offset = 0
    spriteOffset = 0
end

function love.update(dt)

    if love.keyboard.isDown("up") then
        offset = offset + 1
    end

    if love.keyboard.isDown("down") then
        offset = offset - 1
    end

    if love.keyboard.isDown("right") then
        spriteOffset = spriteOffset + 16
    end

    if love.keyboard.isDown("left") then
        spriteOffset = spriteOffset - 16
    end

end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    -- Render stuff in the game here
    love.graphics.setLineStyle("rough")
    love.graphics.rectangle("line",50,50,100,100)
    love.graphics.points(110,110)

    --The following code attempts to plot each color from
    --ll.pal on the screen as a pixel. It does not work, everything
    --comes up black.
    --[
    print("****")
    local i = 1
    for y=1,16 do
        for x = 1,16 do
            local r,g,b = string.byte(paletteData, i),
                          string.byte(paletteData, i+1),
                          string.byte(paletteData, i+2)
            print("red: "..r.." green: "..g.." blue: " ..b)
            love.graphics.setColor(r/255,g/255,b/255)
            love.graphics.points(x*2+200, y*2+100)
            i = i + 3
        end
    end

    i = 1
    for y=1,128 do
        for x = 1,16 do
            local bt = (string.byte(spriteData, i + spriteOffset) + (offset / 20)) * 3

            if bt and bt >= 1 then
                local r,g,b = string.byte(paletteData, bt),
                              string.byte(paletteData, bt+1),
                              string.byte(paletteData, bt+2)
                love.graphics.setColor(r/255,g/255,b/255)
                love.graphics.points(x+100, y+100)
            end

            i = i + 1
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas()

    love.graphics.push() -- Push transformation state, The translate and scale will affect everything bellow until love.graphics.pop()
    love.graphics.translate( math.floor((screenWidth - canvasWidth * scale)/2) , math.floor((screenHeight - canvasHeight * scale)/2)) -- Move to the appropiate top left corner
    love.graphics.scale(scale,scale) -- Scale
    love.graphics.draw(canvas) -- Draw the canvas
    love.graphics.pop() -- pop transformation state
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end