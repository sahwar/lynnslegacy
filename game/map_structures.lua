require("game/image_structures")
require("game/sequence_structures")

-- Type _LL_MiniMapRoomDoorType
function create_LL_MiniMapRoomDoorType()
  local roomdoor = {}
--
--   As vector_Integer location
  roomdoor.location = create_vector()
--
--   As Integer id '' Enum LLMINI_DOORTYPES
  roomdoor.id = 0
--
--   As Integer codes
  roomdoor.codes = 0
--   As Integer Ptr code
  roomdoor.code = {}
--
  return roomdoor
-- End Type
end
-- Type LL_MiniMapRoomDoorType As _LL_MiniMapRoomDoorType
--

--
-- Type _LL_MiniMapRoomType
function create_LL_MiniMapRoomType()
--
  local room = {}
--   As vector_Integer location
  room.location = create_vector()
--
--   As Integer floor
  room.floor = 0
--
--   As Integer doors
  room.doors = 0
--   door As LL_MiniMapRoomDoorType Ptr
  room.door = {}
--
--   As Byte hasVisited
  room.hasVisited = 0
--
  return room
-- End Type
end

-- Type _LL_MiniMapType
function create_LL_MiniMapType()
  local minimap = {}
--
--   rooms As Integer
  minimap.rooms = 0
--   room As LL_MiniMapRoomType Ptr
  minimap.room = {}
--
--   As vector_Integer camera, location
  minimap.camera = create_vector()
  minimap.location = create_vector()

--
  return minimap
-- End Type
-- Type LL_MiniMapType As _LL_MiniMapType
end

-- Type teleport_type
function create_teleport_type()
--
  local teleport_type = {}
--   x As Integer
  teleport_type.x = 0
--   y As Integer
  teleport_type.y = 0
--   w As Integer
  teleport_type.w = 0
--   h As Integer
  teleport_type.h = 0
--   to_room As Integer
  teleport_type.to_room = 0
--   to_map As String
  teleport_type.to_map = ""
--
--   dx As Integer
  teleport_type.dx = 0
--   dy As Integer
  teleport_type.dy = 0
--   dd As Integer
  teleport_type.dd = 0
--
--   to_song As Integer
  teleport_type.to_song = 0
--
--   reserved( 19 ) As Integer
  teleport_type.reserved = {[0]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
--
--
  return teleport_type
-- End Type
end

-- Type room_type
function create_room_type()
--
  local room_type = {}
--   x As Integer
  room_type.x = 0
--   y As Integer
  room_type.y = 0
--   parallax As Integer
  room_type.parallax = 0
-- '  para_img As image_header
--   para_img As LLSystem_ImageHeader Ptr
  room_type.para_img = create_LLSystem_ImageHeader()
--
--   teleports As Integer
  room_type.teleports = 0
--   teleport As teleport_type Ptr
  room_type.teleport = {}
--
--   enemies As Integer
  room_type.enemies = 0
--   enemy As _char_type Ptr
  room_type.enemy = {}
--
--   temp_enemies As Integer
  room_type.temp_enemies = 0
--   temp_enemy( MAX_TEMP_ENEMIES - 1 ) As _char_type
  room_type.temp_enemy = {}
--
--   seq_here As Integer
  room_type.seq_here = 0
--   seq As sequence_type Ptr
  room_type.seq = nil
  --NOTE: We introduce seqi because seq was basically a pointer
  --to the current sequence in an allocated array of sequences. We
  --can't operate that way with Lua, so we need to have this index
  --alongside seq.
  room_type.seqi = 0
--
--   #IfDef list_type
--     manage_mem As list_type Ptr
--
--   #EndIf
--
--   dark As Integer
  room_type.dark = 0
--   now_dark As Integer
--
--   song As Integer
  room_type.song = 0
--
--   layout As Integer Ptr Ptr
  room_type.layout = {}
--
--   song_changes As Integer
  room_type.song_changes = 0
--   changes_to As Integer
  room_type.changes_to = 0
--
--
--   reserved( 17 ) As Integer
  room_type.reserved = {[0]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
--
-- End Type
  return room_type
end

-- Type map_entry_type
function create_map_entry_type()
--
  local map_entry_type = {}
--   x As Integer
  map_entry_type.x = 0
--   y As Integer
  map_entry_type.y = 0
--   room As Integer
  map_entry_type.room = 0
--
--   direction As Byte
  map_entry_type.direction = 0
--
--   seq_here As Integer
  map_entry_type.seq_here = 0
--   seq As sequence_type Ptr
  map_entry_type.seq = nil
  --NOTE: We introduce seqi because seq was basically a pointer
  --to the current sequence in an allocated array of sequences. We
  --can't operate that way with Lua, so we need to have this index
  --alongside seq.
  map_entry_type.seqi = 0
--
--   reserved( 20 ) As Integer
  map_entry_type.reserved = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
--
--
  return map_entry_type
-- End Type
end

-- Type map_type
function create_map_type()
--
  local map_type = {}
--   filename As String
  map_type.filename = ""
--
--   entries As Integer
  map_type.entries = 0
--   entry As map_entry_type Ptr
  map_type.entry = {}
--
--   rooms As Integer
  map_type.rooms = 0
--   room As room_type Ptr
  map_type.room = {}
--
--   ref As Integer
  map_type.ref = 0
--
--
--   #IfDef list_type
--     manage_mem As list_type Ptr
--
--   #EndIf
--
--   tileset As LLSystem_ImageHeader Ptr
  map_type.tileset = create_LLSystem_ImageHeader()
--   song As Integer
  map_type.song = 0
--
--   isDungeon As Byte
  map_type.isDungeon = 0
--
--
  return map_type
-- End Type
end
