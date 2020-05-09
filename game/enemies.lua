require("game/load/loadxml")
require("game/animation")
require("game/cache")

-- Loads enemy xml and sprite image files from the current map.
function loadEnemies()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = {}

    -- Initialize enemy propertes not defined in xml here.
    enemy.pause = 0

    -- Load enemy properties defined in room xml here.
    log.debug("Enemy id: "..roomEnemy.id)
    enemy.id = roomEnemy.id
    log.debug("Enemy x: "..map.rooms[curRoom].enemies[i].xOrigin)
    enemy.mapX = map.rooms[curRoom].enemies[i].xOrigin
    log.debug("Enemy y: "..map.rooms[curRoom].enemies[i].yOrigin)
    enemy.mapY = map.rooms[curRoom].enemies[i].yOrigin

    -- Load enemy properties defined in enemy's object xml.
    log.debug("Loading enemy xml.")
    local enemyXml = getObjectXml(roomEnemy.id)
    log.debug("Loading enemy sprite sheets.")
    local spriteXml = ensureTable(enemyXml.sprite)
    enemy.spriteObjects = {}
    for spriteKey, spriteValue in pairs(spriteXml) do
      if spriteValue.filename then
        log.debug(" spriteValue.filename: "..spriteValue.filename)
        local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
        log.debug(" fixedFileName: "..fixedFileName)
        local spriteObject = getSpriteObject(fixedFileName)
        if spriteValue.rate then
          log.debug(" spriteValue.rate: "..spriteValue.rate)
          spriteObject.rate = tonumber(spriteValue.rate)
        end
        if spriteValue.dir_frames then
          log.debug(" spriteValue.dir_frames: "..spriteValue.dir_frames)
          spriteObject.dirFrames = tonumber(spriteValue.dir_frames)
        end
        table.insert(enemy.spriteObjects, spriteObject)
      end
    end
    if enemyXml.fp then
      enemy.fpIndex = 1
      enemy.funcIndex = 1
      enemy.fp = {}
      local fp = {}
      fp.func = {}
      local fpXml = ensureTable(enemyXml.fp)
      for fpKey, fpValue in pairs(fpXml) do
        if fpValue.proc_id then
          local procIdXml = ensureTable(fpValue.proc_id)
          log.debug("  fpValue.proc_id: "..procIdXml[1])
          fp.procId = procIdXml[1]
        end
        if fpValue.func then
          local funcXml = ensureTable(fpValue.func)
          for funcKey, funcValue in pairs(funcXml) do
            log.debug("  funcValue: "..funcValue)
            if funcValue == "second_pause" then
              log.debug( "  Installing secondPause function.")
              table.insert(fp.func, secondPause)
            end
          end
        end
        table.insert(enemy.fp, fp)
      end
    end
    table.insert(enemies, enemy)
  end
end

function updateEnemies()
  for i, enemy in pairs(enemies) do
    if enemy.fp then
      local fp = enemy.fp[enemy.fpIndex]
      if fp.func then
        local func = fp.func
        if func[enemy.funcIndex] then
          if func[enemy.funcIndex](enemy) == 1 then
            --advance to next func of the current fp state
            enemy.funcIndex = enemy.funcIndex + 1
          end
        end
      end
    end
  end
end

-- Creates enemy animations from the sprite objects for each enemy. Should
-- be called after loadEnemies.
function createEnemyAnimations()
  for i, enemy in pairs(enemies) do
    enemy.animations = {}
    for j, spriteObject in pairs(enemy.spriteObjects) do
      if spriteObject.rate and spriteObject.dirFrames then
        local spriteSheet = spriteObject.spriteSheet
        local animation = newAnimation(spriteObject.image, spriteSheet.width,
          spriteSheet.height, spriteObject.dirFrames, 1)
        table.insert(enemy.animations, animation)
      end
    end
  end
end

function updateEnemyAnimations()
  for i, enemy in pairs(enemies) do
    if #enemy.animations >=1 then
      updateAnimation(enemy.animations[1])
    end
  end
end

function drawEnemies()
  for i, enemy in pairs(enemies) do
    local screenX, screenY = enemy.mapX - camera.x, enemy.mapY - camera.y
    if #enemy.animations >= 1 then
      drawAnimation(enemy.animations[1], screenX, screenY)
    end
  end
end

function secondPause(this)
  local timer = love.timer.getTime()

  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    log.debug("secondPause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end
