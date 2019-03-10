--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on a sprite sheet.
function updateRoom(camera, room, layer, spriteSheet, spriteBatch)

    spriteBatch:clear()

    local topLeftMapX = math.floor(camera.x / spriteSheet.width)
    local topLeftMapY = math.floor(camera.y / spriteSheet.height)
    local topLeftScreenX = (16 - camera.x % 16) - 16
    local topLeftScreenY = (16 - camera.y % 16) - 16

    local mapX = topLeftMapX
    local mapY = topLeftMapY
    local screenX = topLeftScreenX
    local screenY = topLeftScreenY

    for y = 0, 13 do
        mapX = topLeftMapX
        screenX = topLeftScreenX
        for x = 0, 20 do

            if mapX >= 0 and mapX < room.x and
               mapY >= 0 and mapY < room.y then
                local tileIndex = bit.band(room.layout[layer][room.x * mapY + mapX + 1], 0xff)

                local quad = love.graphics.newQuad(
                    spriteSheet.width * tileIndex, 0,
                    spriteSheet.width, spriteSheet.height,
                    spriteSheet.width * spriteSheet.frameCount, spriteSheet.height)
                spriteBatch:add(quad, screenX, screenY)
            end

            mapX = mapX + 1
            screenX = screenX + spriteSheet.width
        end
        mapY = mapY + 1
        screenY = screenY + spriteSheet.height
    end

    spriteBatch:flush()

end
