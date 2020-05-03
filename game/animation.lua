function newAnimation(image, width, height, frames, duration)
    local animation = {}
    animation.image = image;
    animation.quads = {};

    local x = 0
    for i = 1, frames do
        table.insert(animation.quads, love.graphics.newQuad(x, 0, width, height, image:getDimensions()))
        x = x + width
    end

    animation.frameLength = 10
    animation.frameCounter = animation.frameLength
    animation.frame = 1

    return animation
end

function updateAnimation(animation)
  animation.frameCounter = animation.frameCounter - 1
  if animation.frameCounter == 0 then
    animation.frameCounter = animation.frameLength
    animation.frame = animation.frame + 1
    if animation.frame > #animation.quads then
      animation.frame = 1
    end
  end
end

function drawAnimation(animation, screenX, screenY)
  if animation.frame >= 1 and animation.frame <= #animation.quads then
    love.graphics.draw(animation.image, animation.quads[animation.frame], screenX, screenY)
  end
end
