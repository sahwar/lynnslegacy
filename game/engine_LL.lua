require("lib/blob")
require("game/audio")
require("game/binary_objects")
require("game/constants")
require("game/engine_object")
require("game/engine_object_damage")
require("game/macros")
require("game/object_boss")
require("game/object_control")
require("game/utils")
require("game/utility")

-- Sub ll_main_entry()
function ll_main_entry()
--
--
--   enter_map( Varptr( llg( hero ) ), llg( map ), llg( start_map ), llg( start_entry ) )
  enter_map(ll_global.hero, ll_global, ll_global.start_map, ll_global.start_entry)
  --Load map data
  ll_global.this_room.i = 0
--
--   With llg( map )->room[llg( this_room.i )]
--
--     set_up_room_enemies( .enemies, .enemy )
--
--   End With
  set_up_room_enemies(now_room().enemies, now_room().enemy)
--   llg( seq ) = llg( hero ).seq
  ll_global.seq = ll_global.hero.seq
  ll_global.seqi = ll_global.hero.seqi
--   llg( hero ).seq = 0
  ll_global.hero.seq = nil
  ll_global.hero.seqi = 0
--   llg( song ) = llg( map )->room[llg( this_room.i )].song
  ll_global.song = ll_global.map.room[ll_global.this_room.i].song
--
--
--   If llg( map )->isDungeon <> 0 Then
  if ll_global.map.isDungeon ~= 0 then
--     llg( minimap ).room[llg( this_room ).i].hasVisited = -1
    ll_global.miniMap.room[ll_global.this_room.i].hasVisited = -1
--
--   End If
  end
--
  ll_global.current_cam = ll_global.hero

--
--   LLMusic_Start( *music_strings( llg( song ) ) )
  LLMusic_Start(music_strings[ll_global.song])
--
--                                                                                                                                               antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--                                                                                                                                               antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
--                                                                                                                                               antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--                                                                                                                                               antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
--                                                                                                                                               antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
--                                                                                                                                               antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
--
-- End Sub
end

-- Sub engine_init()
function engine_init()
--
--   fb_StartGlobal()
--
--   echo_print( "setting keys to values in ""data\controls.xml""" )
--
--   Kill "roomchange.txt"
--   Kill "set_up_room_enemies.txt"
--
--   Dim As xml_type Ptr last_controls
--   last_controls = xml_Load( "data\controls.xml" )
--
--
--   Dim As Integer control_check
--
--   If last_controls <> 0 Then
--
--     control_check = -1
--
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->attack"     ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->item"       ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->action"     ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_up"    ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_right" ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_down"  ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_left"  ) ) ) <> 0
--
--   End If
--
--   If control_check = 0 Then
--     ? "Run Controls.exe to set the game controls."
--     Sleep 5000
--     End
--
--   End If
--
--
--
--
--   llg( atk_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->attack" ) ), ProcPtr( atk_key_in_sub    ), ProcPtr( atk_key_out_sub    ) )
--   llg( act_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->item"   ) ), ProcPtr( act_key_in_sub    ), ProcPtr( act_key_out_sub    ) )
--   llg( conf_key )        = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->action" ) ), ProcPtr( conf_key_in_sub   ), ProcPtr( conf_key_out_sub   ) )
--   llg( item_l_key )      = init_bin_obj( sc_comma                                               , ProcPtr( item_l_key_in_sub ), ProcPtr( item_l_key_out_sub ) )
--   llg( item_r_key )      = init_bin_obj( sc_period                                              , ProcPtr( item_r_key_in_sub ), ProcPtr( item_r_key_out_sub ) )
--
--   llg( u_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_up"    ) )
--   llg( r_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_right" ) )
--   llg( d_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_down"  ) )
--   llg( l_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_left"  ) )
--
--
--   xml_Destroy( last_controls )
--
--
--   echo_print( "setting up directional ""hints""." )
--
--   llg( dir_hint ) = CAllocate( Len( uByte ) * 4 )
--
--     llg( dir_hint[0] ) = llg( u_key.code )
--     llg( dir_hint[1] ) = llg( r_key.code )
--     llg( dir_hint[2] ) = llg( d_key.code )
--     llg( dir_hint[3] ) = llg( l_key.code )
--
--
--
--   echo_print( "setting up event table" )
--   llg( now ) = CAllocate( Len( uByte ) * LL_EVENTS_MAX )
  --NOTE: Probably don't need to allocate this. It is just a
  --big table of values used throughout the game with hard-coded
  --indices, no need to pre-allocate since we just use Lua tables.
  ll_global.now = {}
  for i = 0, LL_EVENTS_MAX - 1 do
    ll_global.now[i] = 0
  end
--
--
--   echo_print( "setting screen pages" )
--   llg( a_page ) = 0
--   llg( v_page ) = 1
--
--
--
--
--   echo_print( "determining entry point" )
--   load_entrypoint()
  load_entrypoint()
--
--
--   echo_print( "map: " & llg( start_map ) )
--
--
--   echo_print( "constructing main object" )
--   ctor_hero( Varptr( llg( hero ) ) )
  ctor_hero(ll_global.hero)
--
--   llg( do_hud ) = -1
  ll_global.do_hud = -1
--
--   llg( current_cam ) = Varptr( llg( hero ) )
  ll_global.current_cam = hero
--
--
--   echo_print( "loading menu and HUD gfx" )
--   load_status_images( Varptr( llg( savImages ) ) )
  load_status_images(ll_global.savImages)
--   load_hud( Varptr( llg( hud ) ) )
  load_hud(ll_global.hud)
--
--   load_menu()
  load_menu()
--   menu_StringInit()
--
--
--   '' 15, 241
  --NOTE: We deviated from how font recolorization works in
  --the original code. fontBG is never used, only fontFG is.
  --These values are colors. 15 is white (I recall this from DOS VGA
  --palette actually). 92 is yellow in the Lynn's Legacy palette.
  --The original code recolors the font pixel by pixel on the fly.
  --It is the only usage of font recolorization in the entire game.
  --I didn't feel like fully porting the pixel by pixel recolorization
  --code, so instead I made a small change to how we load images allowing
  --specification of an original and a replacement color. Then we can build
  --a white font and a yellow font and assign as needed.
--   llg( font ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\llfont.spr" ) )
--   llg( fontFG ) = 15
--   llg( fontBG ) = 241
  ll_global.fontWhite = LLSystem_ImageLoad("data/pictures/llfont.spr", 15, 255)
  ll_global.fontYellow = LLSystem_ImageLoad("data/pictures/llfont.spr", 15, 92)
  ll_global.font = ll_global.fontWhite
--
--
--
--
--   echo_print( "retrieving screen information" )
--   ScreenInfo llg( sx ), llg( sy )
--
--
--   llg( menu_ScreenSave ) = ImageCreate( 320, 200 )
--
--   llg( scrn_ptr ) = ScreenPtr
--
--   llg( hero_only ).specialSequence = callocate( len( sequence_type ) )
  ll_global.hero_only.specialSequence = {[0] = create_sequence_type()}
--
--   llg( hero_only ).specialSequence[0].commands = 1
  ll_global.hero_only.specialSequence[0].commands = 1
--
--   llg( hero_only ).specialSequence[0].command = callocate( len( command_type ) )
  ll_global.hero_only.specialSequence[0].Command = {[0] = create_command_type()}
--
--   llg( hero_only ).specialSequence[0].command[0].ents = 1
  ll_global.hero_only.specialSequence[0].Command[0].ents = 1
--
--   llg( hero_only ).specialSequence[0].command[0].ent = callocate( len( command_data ) )
  ll_global.hero_only.specialSequence[0].Command[0].ent = {[0] = create_command_data()}
--
--   llg( hero_only ).specialSequence[0].command[0].ent[0].active_ent = SF_BOX
  ll_global.hero_only.specialSequence[0].Command[0].ent[0].active_ent = SF_BOX
--   llg( hero_only ).specialSequence[0].command[0].ent[0].text = "Lynn: I can't use this here."
  ll_global.hero_only.specialSequence[0].Command[0].ent[0].text = "Lynn: I can't use this here."
--
--   llg( hero_only ).healingImage = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\heal.spr"  ) )
  ll_global.hero_only.healingImage = getImageHeader("data/pictures/char/heal.spr")
--
--
--
-- End Sub
end

-- #macro hUniSound(__CHAR__,__ANIM__,__FRAME__,__SOUND__)
function hUniSound(__CHAR__, __ANIM__, __FRAME__, __SOUND__)
--
--   scope
--
--     dim as integer frameCrawl, frameIter
  local frameCrawl, frameIter = 0, 0
--     frameCrawl = __FRAME__
  frameCrawl = __FRAME__
--
--     for frameIter = 0 to 3
  for frameIter = 0, 3 do
--
--       __CHAR__##.anim[__ANIM__]->frame[frameCrawl].sound = __SOUND__
    __CHAR__.anim[__ANIM__].frame[frameCrawl].sound = __SOUND__
--
--       frameCrawl += __CHAR__##.animControl[__ANIM__].dir_frames
    frameCrawl = frameCrawl + __CHAR__.animControl[__ANIM__].dir_frames
--
--     next
  end
--
--   end scope
--
-- #endmacro
end
--
-- #macro hUniVol(__CHAR__,__ANIM__,__FRAME__,__VOL__)
function hUniVol(__CHAR__, __ANIM__, __FRAME__, __VOL__)
--
--   scope
--
--     dim as integer frameCrawl, frameIter
  local frameCrawl, frameIter = 0, 0
--     frameCrawl = __FRAME__
  frameCrawl = __FRAME__
--
--     for frameIter = 0 to 3
  for frameIter = 0, 3 do
--
--       __CHAR__##.anim[__ANIM__]->frame[frameCrawl].vol = __VOL__
    __CHAR__.anim[__ANIM__].frame[frameCrawl].vol = __VOL__
--
--       frameCrawl += __CHAR__##.animControl[__ANIM__].dir_frames
    frameCrawl = frameCrawl + __CHAR__.animControl[__ANIM__].dir_frames
--
--     next
  end
--
--   end scope
--
-- #endmacro
end

-- Private Sub set_regular()
function set_regular()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/lynn24.spr"         )
  ll_global.hero.animControl[0].rate = .08
  ll_global.hero.anim[3] = getImageHeader( "data/pictures/char/lynnattack_new.spr" )
  ll_global.hero.animControl[3].rate = .07
  ll_global.hero.anim[4] = getImageHeader( "data/pictures/char/lynnattack_2.spr"   )
  ll_global.hero.animControl[4].rate = .1
  ll_global.hero.anim[5] = getImageHeader( "data/pictures/char/lynnattack_3.spr"   )
  ll_global.hero.animControl[5].rate = .13
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/lynn_flare.spr"     )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/lynn_ice.spr"       )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/lynnfall.spr"       )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/lynngetup.spr"       )
  ll_global.hero.animControl[12].rate = .18

end
--
-- Private Sub set_cougar()
function set_cougar()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/outfits/cougar/walk.spr"   )
  ll_global.hero.animControl[0].rate = .05
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/outfits/cougar/flare.spr"  )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/outfits/cougar/ice.spr"    )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/outfits/cougar/die.spr"    )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/outfits/cougar/getup.spr" )
  ll_global.hero.animControl[12].rate = .18

  hUniSound( ll_global.hero, 6, 0, sound_flare )
  hUniSound( ll_global.hero, 7, 0, sound_ice )
-- End Sub
end
--
-- Private Sub set_lynnity()
function set_lynnity()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/outfits/lynnity/walk.spr"     )
  ll_global.hero.animControl[0].rate = .08
  ll_global.hero.anim[3] = getImageHeader( "data/pictures/char/outfits/lynnity/attack_1.spr" )
  ll_global.hero.animControl[3].rate = .07
  ll_global.hero.anim[4] = getImageHeader( "data/pictures/char/outfits/lynnity/attack_2.spr" )
  ll_global.hero.animControl[4].rate = .1
  ll_global.hero.anim[5] = getImageHeader( "data/pictures/char/outfits/lynnity/attack_3.spr" )
  ll_global.hero.animControl[5].rate = .13
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/outfits/lynnity/flare.spr"    )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/outfits/lynnity/ice.spr"      )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/outfits/lynnity/die.spr"      )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/outfits/lynnity/getup.spr"   )
  ll_global.hero.animControl[12].rate = .18


  hUniSound( ll_global.hero, 3, 0, sound_mace_0 )
  hUniSound( ll_global.hero, 4, 0, sound_mace_1 )
  hUniSound( ll_global.hero, 5, 0, sound_mace_2 )
  hUniSound( ll_global.hero, 6, 0, sound_flare  )
  hUniSound( ll_global.hero, 7, 0, sound_ice    )

  hUniVol( ll_global.hero, 3, 0, 50 )
  hUniVol( ll_global.hero, 4, 0, 50 )
  hUniVol( ll_global.hero, 5, 0, 50 )


-- End Sub
end
--
-- Private Sub set_ninja()
function set_ninja()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/outfits/ninja/walk.spr"     )
  ll_global.hero.animControl[0].rate = .08
  ll_global.hero.anim[3] = getImageHeader( "data/pictures/char/outfits/ninja/attack_1.spr" )
  ll_global.hero.animControl[3].rate = .04
  ll_global.hero.anim[4] = getImageHeader( "data/pictures/char/outfits/ninja/attack_2.spr" )
  ll_global.hero.animControl[4].rate = .07
  ll_global.hero.anim[5] = getImageHeader( "data/pictures/char/outfits/ninja/attack_3.spr" )
  ll_global.hero.animControl[5].rate = .1
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/outfits/ninja/flare.spr"    )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/outfits/ninja/ice.spr"      )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/outfits/ninja/die.spr"      )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/outfits/ninja/getup.spr"   )
  ll_global.hero.animControl[12].rate = .18

  hUniSound( ll_global.hero, 3, 0, sound_mace_0 )
  hUniSound( ll_global.hero, 4, 0, sound_mace_1 )
  hUniSound( ll_global.hero, 5, 0, sound_mace_2 )
  hUniSound( ll_global.hero, 6, 0, sound_flare  )
  hUniSound( ll_global.hero, 7, 0, sound_ice    )

  hUniVol( ll_global.hero, 3, 0, 50 )
  hUniVol( ll_global.hero, 4, 0, 50 )
  hUniVol( ll_global.hero, 5, 0, 50 )


-- End Sub
end
--
-- Private Sub set_bikini()
function set_bikini()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/outfits/swimsuit/walk.spr"     )
  ll_global.hero.animControl[0].rate = .08
  ll_global.hero.anim[3] = getImageHeader( "data/pictures/char/outfits/swimsuit/attack_1.spr" )
  ll_global.hero.animControl[3].rate = .07
  ll_global.hero.anim[4] = getImageHeader( "data/pictures/char/outfits/swimsuit/attack_2.spr" )
  ll_global.hero.animControl[4].rate = .1
  ll_global.hero.anim[5] = getImageHeader( "data/pictures/char/outfits/swimsuit/attack_3.spr" )
  ll_global.hero.animControl[5].rate = .13
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/outfits/swimsuit/flare.spr"    )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/outfits/swimsuit/ice.spr"      )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/outfits/swimsuit/die.spr"      )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/outfits/swimsuit/getup.spr"   )
  ll_global.hero.animControl[12].rate = .18

  hUniSound( ll_global.hero, 3, 0, sound_mace_0 )
  hUniSound( ll_global.hero, 4, 0, sound_mace_1 )
  hUniSound( ll_global.hero, 5, 0, sound_mace_2 )
  hUniSound( ll_global.hero, 6, 0, sound_flare  )
  hUniSound( ll_global.hero, 7, 0, sound_ice    )

  hUniVol( ll_global.hero, 3, 0, 50 )
  hUniVol( ll_global.hero, 4, 0, 50 )
  hUniVol( ll_global.hero, 5, 0, 50 )


-- End Sub
end

--Private Sub set_rknight()
function set_rknight()

  ll_global.hero.anim[0] = getImageHeader( "data/pictures/char/outfits/redknight/walk.spr"     )
  ll_global.hero.animControl[0].rate = .12
  ll_global.hero.anim[6] = getImageHeader( "data/pictures/char/outfits/redknight/flare.spr"    )
  ll_global.hero.animControl[6].rate = .07
  ll_global.hero.anim[7] = getImageHeader( "data/pictures/char/outfits/redknight/ice.spr"      )
  ll_global.hero.animControl[7].rate = .07
  ll_global.hero.anim[8] = getImageHeader( "data/pictures/char/outfits/redknight/die.spr"      )
  ll_global.hero.animControl[8].rate = .18
  ll_global.hero.anim[12] = getImageHeader( "data/pictures/char/outfits/redknight/getup.spr"   )
  ll_global.hero.animControl[12].rate = .18

  hUniSound( ll_global.hero, 6, 0, sound_flare  )
  hUniSound( ll_global.hero, 7, 0, sound_ice    )

  hUniVol( ll_global.hero, 3, 0, 50 )
  hUniVol( ll_global.hero, 4, 0, 50 )
  hUniVol( ll_global.hero, 5, 0, 50 )


-- End Sub
end

-- Loops over the enemies of the current room and spawns them
function set_up_room_enemies(enemies, enemy)
    -- Dim As Integer setup
    --
    --
    -- For setup = 0 To enemies - 1
  for setup = 0, enemies - 1 do
    --   '' cycle thru these enemies
    --
    --   With enemy[setup]
    local with0 = enemy[setup]
    --
    --     If .spawn_cond <> 0 Then
    if with0.spawn_cond ~= 0 then
    --
    --       If .spawn_info->wait_n > 0 Then
      if with0.spawn_info.wait_n > 0 then
    --
    --         If LLObject_SpawnWait( Varptr( enemy[setup] ) ) <> 0 Then
        if LLObject_SpawnWait(enemy[setup]) ~= 0 then
    --
    --           '' done waiting
    --
    --           LLSystem_CopyNewObject( enemy[setup] )
          LLSystem_CopyNewObject(with0)
    --
    --         Else
        else
    --           Dim As String oldid
    --
    --           oldid = enemy[setup].id
          local oldid = enemy[setup].id
    --
    --           LLSystem_ObjectDeepCopy( enemy[setup], *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( "data\object\null.xml" ) ) )
          enemy[setup].id = "data/object/null.xml"
          LLSystem_CopyNewObject(enemy[setup])
    --           enemy[setup].id = oldid
          enemy[setup].id = oldid
    --
    --         End If
        end
    --
    --       Else
      else
    --
    --         LLSystem_CopyNewObject( enemy[setup] )
        LLSystem_CopyNewObject(enemy[setup])
    --
    --       End If
      end
    --
    --     Else
    else
    --
    --     '' if regular then spawn
    --       LLSystem_CopyNewObject( enemy[setup] )
      LLSystem_CopyNewObject(enemy[setup])
    --
    --     End If
    end
    --
    --     '' setting a couple last vars
    --     .num = setup
    with0.num = setup
    --
    --     If .spawn_cond <> 0 Then
    if with0.spawn_cond ~= 0 then
    --
    --       If LLObject_SpawnKill( Varptr( enemy[setup] ) ) <> 0 Then
      if LLObject_SpawnKill(enemy[setup]) ~= 0 then
    --         '' all conditions met to kill
    --
    --         __make_dead  ( Varptr( enemy[setup] ) )
        __make_dead(enemy[setup])
    --         __cripple  ( Varptr( enemy[setup] ) )
        __cripple(enemy[setup])
    --
    --         If(                                     _
        if(
    --             ( .unique_id = u_chest         ) Or _
          (with0.unique_id == u_chest) or
    --             ( .unique_id = u_bluechest     ) Or _
          (with0.unique_id == u_bluechest) or
    --             ( .unique_id = u_bluechestitem ) Or _
          (with0.unique_id == u_bluechestitem) or
    --             ( .unique_id = u_ghut          ) Or _
          (with0.unique_id == u_ghut) or
    --             ( .unique_id = u_button        ) Or _
          (with0.unique_id == u_button) or
    --             ( .unique_id = u_gbutton       )    _
          (with0.unique_id == u_gbutton)
    --           ) Then
          ) then
    --           .current_anim = 1
          with0.current_anim = 1
    --
    --         End If
        end
    --
    --
    --         .seq_release = 0
        with0.seq_release = 0
    --
    --         .spawn_kill_trig = -1
        with0.spawn_kill_trig = -1
    --
    --
    --         if .unique_id = u_biglarva then
        if with0.unique_id == u_biglarva then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
          LLObject_ShiftState(enemy[setup], 3)
    --
    --         end if
        end
    --
    --         if .unique_id = u_ghut then
        if with0.unique_id == u_ghut then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
          LLObject_ShiftState(enemy[setup], 3)
    --
    --         end if
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --   End With
    --
    --   #IfDef LL_--logRoomEnemySetup
    --     LLSystem_--log( "Initialized room["& llg( this_room ).i &"] enemy " & setup, "set_up_room_enemies.txt" )
    --
    --   #EndIf
    --
    -- Next
  end
end

-- Private Function check_teleports( _char As _char_type, _tele As teleport_type Ptr, num_tele As Integer ) As Integer
function check_teleports(_char, _tele, num_tele)
--
--
--   Dim As Integer tele_check
  local tele_check = 0
--   For tele_check = 0 To num_tele - 1
  for tele_check = 0, num_tele - 1 do
--
--     Dim As vector_pair origin, target
    local origin, target = get_next_vector_pair(), get_next_vector_pair()
--
--     origin.u = _char.coords
    origin.u.x = _char.coords.x
    origin.u.y = _char.coords.y
--     origin.v = _char.perimeter
    origin.v.x = _char.perimeter.x
    origin.v.y = _char.perimeter.y
--
--     target.u.x = _tele[tele_check].x
    target.u.x = _tele[tele_check].x
--     target.u.y = _tele[tele_check].y
    target.u.y = _tele[tele_check].y
--     target.v.x = _tele[tele_check].w
    target.v.x = _tele[tele_check].w
--     target.v.y = _tele[tele_check].h
    target.v.y = _tele[tele_check].h

--
--     If check_bounds( origin, target ) = 0 Then
    if check_bounds(origin, target) == 0 then
--
--       Return tele_check
      return tele_check
--
--     End If
    end
--
--   Next
  end
--
--   Return -1
  return -1
--
-- End Function
end

-- Private Function check_against_teles( o As _char_type )
function check_against_teles(o)
--
--   Function = -1
  local result = -1
--
--   Dim As Integer o_returned_tele
  local o_returned_tele = 0
--
--   '' returns the teleport lynn is standing on (-1 = no collision detected)
--   o_returned_tele = check_teleports( o, now_room().teleport, now_room().teleports )
  o_returned_tele = check_teleports(o, now_room().teleport, now_room().teleports)
--
--   If o_returned_tele <> -1 Then
  if o_returned_tele ~= -1 then
--     '' touched a teleport
--
--     If now_room().teleport[o_returned_tele].to_map = "" Then
    if now_room().teleport[o_returned_tele].to_map == "" then
--
--       '' this is a room teleport
--       change_room( 0, -1, 0 ) '' change_room() is a static FSM, initialize it
      change_room(0, -1, 0)
--       Function = o_returned_tele
      result = o_returned_tele
--
--     Else
    else
--       '' this teleport changed the map
--       With now_room()
      local with0 = now_room()
--
--         With .teleport[o_returned_tele]
      local with1 = with0.teleport[o_returned_tele]
--           o.to_map   = .to_map
      o.to_map = with1.to_map
--           o.to_entry = .to_room
      o.to_entry = with1.to_room
--
--         End With
--
--       End With
--
--       change_room( 0, -1, 1 ) '' change_room() is a static FSM, initialize it
      change_room(0, -1, 1)
--       Function = o_returned_tele
      result = o_returned_tele
--
--     End If
    end
--
--     o.fade_time = .003
    o.fade_time = .003
--
--   End If
  end
--
--
  return result
-- End Function
end

-- Sub hero_main()
function hero_main()
--
--
--   if llg( hero_only ).selected_item = 0 then
  if ll_global.hero_only.selected_item == 0 then
--     if llg( hero_only ).hasItem( 0 ) then
    if ll_global.hero_only.hasItem[0] ~= 0 then
--       llg( hero_only ).selected_item = 1
      ll_global.hero_only.selected_item = 1
--
--     end if
    end
--
--   end if
  end
--
--   If ( llg( hero_only ).isWearing = 1 ) Then
  if ll_global.hero_only.isWearing == 1 then
--     llg( hero ).walk_speed = .003
    ll_global.hero.walk_speed = .003
--
--   elseIf ( llg( hero_only ).isWearing = 5 ) Then
  elseif ll_global.hero_only.isWearing == 5 then
--     llg( hero ).walk_speed = .02
    ll_global.hero.walk_speed = .02
--
--   Else
  else
--     llg( hero ).walk_speed = .009
    ll_global.hero.walk_speed = .009
--
--   End If
  end
--
--   llg( hero_only ).action  = 0
  ll_global.hero_only.action = 0
--
--   If ( llg( hero_only ).isWearing = 5 ) Then
  if ll_global.hero_only.isWearing == 5 then
--
--     if llg( hero_only ).healTimer = 0 then
    if ll_global.hero_only.healTimer == 0 then
--       llg( hero_only ).healTimer = timer + 6
      ll_global.hero_only.healTimer = timer + 6
--
--     end if
    end
--
--     if timer > llg( hero_only ).healTimer then
    if timer > ll_global.hero_only.healTimer then
--       if llg( hero ).hp < llg( hero ).maxhp then
      if ll_global.hero.hp < ll_global.hero.maxhp then
--         llg( hero ).hp += 1
        ll_global.hero.hp = ll_global.hero.hp + 1
--         antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--         play_sample( sound_healthgrab )
        ll_global.snd[sound_healthgrab]:play()
--       end if
      end
--       llg( hero_only ).healTimer = 0
      ll_global.hero_only.healTimer = 0
--
--     end if
    end
--
--   else
  else
--     llg( hero_only ).healTimer = 0
    ll_global.hero_only.healTimer = 0
--
--   end if
  end
--
--
--   static as integer adrenalineState
  if adrenalineState == nil then adrenalineState = 0 end
--   if llg( hero_only ).adrenaline <> NULL then
  if ll_global.hero_only.adrenaline ~= 0.0 then
--
--     select case as const adrenalineState
--
--       case 0
    if adrenalineState == 0 then
--         adrenalineState += __flash( @llg( hero ) )
      adrenalineState = adrenalineState + __flash(ll_global.hero)
--
--       case 1
    elseif adrenalineState == 1 then
--         adrenalineState += __flash_down( @llg( hero ) )
      adrenalineState = adrenalineState + __flash_down(ll_global.hero)
--
--     end select
    end
--
--     if timer > llg( hero_only ).adrenaline then
    if timer > ll_global.hero_only.adrenaline then
--       llg( hero_only ).adrenaline = NULL
      ll_global.hero_only.adrenaline = NULL
--       adrenalineState = 0
      adrenalineState = 0
--       llg( hero_only ).crazy_points = 0
      ll_global.hero_only.crazy_points = 0
--
      ll_global.snd[sound_heart]:stop()
--     end if
    end
--
--   end if
  end
--
--
  --NOTE: I do not know what this healing code does. Prior to porting it,
  --the red regeneration suit was already working via logic elsewhere in
  --the codebase. Everything else seems to be working with Lynn, too, is
  --it possible this is a feature that was removed and never comes in to
  --play?
--   static as double healingTimer
  if healingTimer == nil then healingTimer = 0.0 end
--   if llg( hero_only ).healing <> NULL then
  if ll_global.hero_only.healing ~= NULL then
--
--     if healingTimer = 0 then
    if healingTimer == 0 then
--       healingTimer = timer + .1
      healingTimer = timer + .1
--
--     end if
    end
--
--     if timer > healingTimer then
    if timer > healingTimer then
--
--       llg( hero_only ).healingFrame += 1
      ll_global.hero_only.healingFrame = ll_global.hero_only.healingFrame + 1
--       healingTimer = 0
      healingTimer = 0
--
--     end if
    end
--
--     if llg( hero_only ).healingFrame = 5 then
    if ll_global.hero_only.healingFrame == 5 then
--
--       llg( hero_only ).healingFrame = 0
      ll_global.hero_only.healingFrame = 0
--       llg( hero_only ).healing = 0
      ll_global.hero_only.healing = 0
--
--       healingTimer = 0
      healingTimer = 0
--
--     end if
    end
--
--   end if
  end
--
--
--
--
--   With llg( conf_key )
--     bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--   End With
  if input:pressed("action") then
    conf_key_in_sub()
  end
--
--   If llg( hero ).vol_fade_trig <> 0 Then
  if ll_global.hero.vol_fade_trig ~= 0 then
--     '' projectile triggered
--
--     __do_vol_fade ( VarPtr( llg( hero ) ) )
    __do_vol_fade(ll_global.hero)
--
--   End If
  end
--
--
--
--   With llg( hero )
  local with0 = ll_global.hero
--
--
--     .last_cycle_ice = .on_ice
  with0.last_cycle_ice = with0.on_ice
--     .on_ice = 0
  with0.on_ice = 0
--     check_ice( llg( hero ) )
  check_ice(ll_global.hero)
--
--     If .on_ice = 0 Then
  if with0.on_ice == 0 then
-- --       .coords.x = Int( .coords.x )
     ll_global.hero.coords.x = math.floor(ll_global.hero.coords.x)
-- --       .coords.y = Int( .coords.y )
     ll_global.hero.coords.y = math.floor(ll_global.hero.coords.y)
-- --
--     End If
  end
--
--
--     If ( .on_ice <> 0 ) And .last_cycle_ice = 0 Then
  if (with0.on_ice ~= 0) and with0.last_cycle_ice == 0 then
--
--       Dim As Integer all_momentum
--       For all_momentum = 0 To 3
    for all_momentum = 0, 3 do
--         .momentum.i( all_momentum ) = .momentum_history.i( all_momentum )
      with0.momentum.i[all_momentum] = with0.momentum_history.i[all_momentum]
--
--       Next
    end
--
--     End If
  end
--
--     '' reset lynn move flag
--     .moving = 0
  with0.moving = 0
--
--
--     If llg( hero_only ).action_lock = 0 Then
  if ll_global.hero_only.action_lock == 0 then
--       '' lynn can do actions
--
--       If llg( hero_only ).attacking = 0 Then
    if ll_global.hero_only.attacking == 0 then
--         '' lynn is not attacking
--
--         If (.fly_count = 0) Then
      if with0.fly_count == 0 then
--           '' lynn is not flying back
--
--           If .dead = 0 Then
        if with0.dead == 0 then
--             '' lynn is not dead
--
--             If .switch_room = -1 Then
          if with0.switch_room == -1 then
--               '' lynn isnt doing a room switch fade thing
--
--               With llg( act_key )
--                 bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--               End With
            --NOTE: We are wiring up hard-coded keys directly to their callbacks, here,
            --completely ignoring the key configuration system or porting it. We will
            --add our own key configuration system much later on in development.
            if input:pressed("item") then
              act_key_in_sub()
            end
            if not input:down("item") then
              act_key_out_sub()
            end
--
--               With llg( atk_key )
--                 bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--               End With
            if input:pressed("attack") then
              atk_key_in_sub()
            end
            if not input:down("attack") then
              atk_key_out_sub()
            end
--
--               dir_keys()
            dir_keys()
--
--             End If
          end
--
--           End If
        end
--
--         End If
      end
--
--       End If
    end
--
--
--       If .on_ice = 0 Then
    if with0.on_ice == 0 then
--         '' traction
--         If .unique_id <> u_steelstrider Then
      if with0.unique_id ~= u_steelstrider then
--           __go_grip( Varptr( llg( hero ) ) )
        __go_grip(ll_global.hero)
--
--         End If
      end
--
--       End If
    end
--
--       If .walk_hold = 0 Then
    if with0.walk_hold == 0 then
--
--         '' walk_hold timer is initialized
--         If .dead = 0 Then
      if with0.dead == 0 then
--
--           If llg( hero_only ).attacking <> 0 Then
        if ll_global.hero_only.attacking ~= 0 then
--
--             If .on_ice <> 0 Then
          if with0.on_ice ~= 0 then
--               __momentum_move( VarPtr( llg( hero ) ) )
            __momentum_move(ll_global.hero)

--
--             End If
          end
--
--           Else
        else
-- '            llg( hero ).momentum.i( llg( hero ).direction ) *= 2
--             __momentum_move( VarPtr( llg( hero ) ) )
          __momentum_move(ll_global.hero)
--
--           End If
        end
--
--         End If
      end
--
--       End If
    end
--
--
--       hero_continue_movement( VarPtr( llg( hero ) ) )
    hero_continue_movement(ll_global.hero)
--
--       If ( .on_ice <> 0 ) Then
    if with0.on_ice ~= 0 then
--
--         __calc_slide( VarPtr( llg( hero ) ) )
      __calc_slide(ll_global.hero)
--
--
--       Else
    else
--         __stop_grip( VarPtr( llg( hero ) ) )
      __stop_grip(ll_global.hero)
--
--       End If
    end
--
--
--       .moving Or = ( .is_psfing <> 0 )
    if with0.is_psfing ~= 0 then
      with0.moving = 1
    end
--       .moving Or = ( .is_pushing <> 0 )
    if with0.is_pushing ~= 0 then
      with0.moving = 1
    end
--
--
--       If .moving <> 0 Then
    if with0.moving ~= 0 then
--         '' lynn's moving
--
--         If LLObject_IncrementFrame( varptr( llg( hero ) ) ) <> 0 Then
      if LLObject_IncrementFrame(ll_global.hero) ~= 0 then
--           llg( hero ).frame = 0
        ll_global.hero.frame = 0
--           llg( hero ).frame_hold = Timer + llg( hero ).animControl[llg( hero ).current_anim].rate
        ll_global.hero.frame_hold = timer + ll_global.hero.animControl[ll_global.hero.current_anim].rate
--
--         End If
      end
--
--       Else
    else
--         '' lynn isn't moving
--
--         If .dead = 0 Then
      if with0.dead == 0 then
--           '' lynn's alive
--
--           If llg( hero_only ).attacking  = 0 Then
        if ll_global.hero_only.attacking == 0 then
--
--             If .frame <> 0 Then
          if with0.frame ~= 0 then
--               '' lynn frame not zero, reset
--
--               __reset_frame( VarPtr( llg( hero ) ) )
            __reset_frame(ll_global.hero)
--
--
--             End If
          end
--
--           End If
        end
--
--         End If
      end
--
--       End If
    end
--
--
--       If llg( hero ).switch_room = -1 Then
    if ll_global.hero.switch_room == -1 then
--         llg( hero ).switch_room = check_against_teles( llg( hero ) )
      ll_global.hero.switch_room = check_against_teles(ll_global.hero)
--
--       End If
    end
--
--
--     End If
  end
--
--     With llg( item_l_key )
--       bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--     End With
--     With llg( item_r_key )
--       bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--     End With
--
--
--     If llg( hero_only ).attacking <> 0 Then
  if ll_global.hero_only.attacking ~= 0 then
--       '' lynn is attacking
--       hero_attack( VarPtr( llg( hero ) ) )
    hero_attack(ll_global.hero)
--
--     End If
  end
--
--
--     If Timer > .walk_hold Then
  if timer > with0.walk_hold then
--       '' walkhold timer expired
--
--       .walk_hold = 0
    with0.walk_hold = 0
--       .is_psfing = 0
    with0.is_psfing = 0
--
--     End If
  end
--
--
--     If .switch_room <> -1 Then
  if with0.switch_room ~= -1 then
--       change_room( VarPtr( llg( hero ) ) )
    change_room(ll_global.hero)
--
--     End If
  end
--
--
--     If .dead = FALSE Then
  if with0.dead == 0 then
--       '' lynn's alive,
--
--       LLObject_MAINDamage( VarPtr( llg( hero ) ) )
    LLObject_MAINDamage(ll_global.hero)
--
--       If ( .dmg.id <> 0 ) Then
    if with0.dmg.id ~= 0 then
--         '' lynn is damaged by something
--         __flashy( VarPtr( llg( hero ) ) )
      __flashy(ll_global.hero)
--
--
--       End If
    end
--
--     End If
  end
--
--
--     If .hurt Then
  if with0.hurt ~= 0 then
--       '' lynn's hurt
--
--       .funcs.current_func[.hit_state] += .funcs.func[.hit_state][.funcs.current_func[.hit_state]]( VarPtr( llg( hero ) ) )
    with0.funcs.current_func[with0.hit_state] = with0.funcs.current_func[with0.hit_state] + with0.funcs.func[with0.hit_state][with0.funcs.current_func[with0.hit_state]](ll_global.hero)
--
--
--       If .funcs.current_func[.hit_state] = .funcs.func_count[.hit_state] Then
    if with0.funcs.current_func[with0.hit_state] == with0.funcs.func_count[with0.hit_state] then
--         '' lynn called back
--
--         .funcs.current_func[.hit_state] = 0
      with0.funcs.current_func[with0.hit_state] = 0
--
--         .hurt = 0
      with0.hurt = 0
--         .dmg.index = 0
      with0.dmg.index = 0
--         .dmg.specific = 0
      with0.dmg.specific = 0
--
--       End If
    end
--
--     End If
  end
--
--
--     If .dead Then
  if with0.dead ~= 0 then
--       '' lynn is dead
--
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--       llg( hero ).fade_time = .003
    ll_global.hero.fade_time = .003
--
--       .funcs.current_func[.death_state] += .funcs.func[.death_state][.funcs.current_func[.death_state]]( VarPtr( llg( hero ) ) )
    local func = with0.funcs.func[with0.death_state][with0.funcs.current_func[with0.death_state]]
    with0.funcs.current_func[with0.death_state] = with0.funcs.current_func[with0.death_state] + func(ll_global.hero)
  --
  --       If ( .funcs.current_func[.death_state] = .funcs.func_count[.death_state] ) Then
    if (with0.funcs.current_func[with0.death_state] == with0.funcs.func_count[with0.death_state]) then
  --         '' lynn called back
  --         jump_to_title()
      jump_to_title()
  --
  --       End If
    end
--
--     End If
  end
--
--   End With
--
--   If llg( hero.hp ) > llg( hero.maxhp ) Then
  if ll_global.hero.hp > ll_global.hero.maxhp then
--     llg( hero.hp ) = llg( hero.maxhp )
    ll_global.hero.hp = ll_global.hero.maxhp
--     antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--   end if
  end
--
--   #IfDef ll_audio
--     check_env_sounds()
  check_env_sounds()
--
--   #EndIf
--
--   cache_crazy()
  cache_crazy()
--   decay_crazy()
  decay_crazy()
--
--   If llg( hero_only ).songFade <> NULL Then
  if ll_global.hero_only.songFade ~= nil then
--     LLMusic_Fade()
    LLMusic_Fade()
--
--   End If
  end
--
--
-- End Sub
end

-- Private Sub cache_crazy()
function cache_crazy()
--
--   Static As Double cache_delay = .01, cache_wait
  if cache_delay == nil then cache_delay = .01 end
  if cache_wait == nil then cache_wait = 0 end
--
--   If cache_wait = 0 Then
  if cache_wait == 0 then
--
--     If llg( hero_only ).crazy_cache > 0 Then
    if ll_global.hero_only.crazy_cache > 0 then
--       llg( hero_only ).crazy_points += 1
      ll_global.hero_only.crazy_points = ll_global.hero_only.crazy_points + 1
--       llg( hero_only ).crazy_cache -= 1
      ll_global.hero_only.crazy_cache = ll_global.hero_only.crazy_cache - 1
--
--     End If
    end
--
--     If llg( hero_only ).crazy_dcache > 0 Then
    if ll_global.hero_only.crazy_dcache > 0 then
--       llg( hero_only ).crazy_points -= 1
      ll_global.hero_only.crazy_points = ll_global.hero_only.crazy_points - 1
--       llg( hero_only ).crazy_dcache -= 1
      ll_global.hero_only.crazy_dcache = ll_global.hero_only.crazy_dcache - 1
--
--     End If
    end
--
--
--     cache_wait = Timer + cache_delay
    cache_wait = timer + cache_delay
--
--
--
--   End If
  end
--
--   If Timer > cache_wait Then cache_wait = 0
  if timer > cache_wait then cache_wait = 0 end
--
--
--
--
-- End Sub
end
--
-- Sub decay_crazy()
function decay_crazy()
--
--   Static As Double crazy_decay = .3, crazy_delay
  if crazy_decay == nil then crazy_decay = .3 end
  if crazy_delay == nil then crazy_delay = 0 end
--
--   If crazy_delay = 0 Then
  if crazy_delay == 0 then
--
--     crazy_delay = Timer + crazy_decay
    crazy_delay = timer + crazy_decay
--
--
--     If llg( hero_only ).crazy_points > 0 Then
    if ll_global.hero_only.crazy_points > 0 then
--
--       If llg( hero_only ).crazy_points > 105 Then
      if ll_global.hero_only.crazy_points > 105 then
--         llg( hero_only ).crazy_points = 105
        ll_global.hero_only.crazy_points = 105
--
--       End If
      end
--
--       llg( hero_only ).crazy_dcache += 1
      ll_global.hero_only.crazy_dcache = ll_global.hero_only.crazy_dcache + 1
--
--
--     End If
    end
--
--
--   End If
  end
--
--   If Timer > crazy_delay Then crazy_delay = 0
  if timer > crazy_delay then crazy_delay = 0 end
--
--
-- End Sub
end

-- Private Sub dir_keys()
function dir_keys()
--
--   Static As Double SLIDE_CONSTANT = .02
  local SLIDE_CONSTANT = .02
--
--   With llg( hero )
--
--     .momentum_history.i( 0 ) = 0
  ll_global.hero.momentum_history.i[0] = 0
--     .momentum_history.i( 1 ) = 0
  ll_global.hero.momentum_history.i[1] = 0
--     .momentum_history.i( 2 ) = 0
  ll_global.hero.momentum_history.i[2] = 0
--     .momentum_history.i( 3 ) = 0
  ll_global.hero.momentum_history.i[3] = 0
--
--     If .walk_hold = 0 Then
  if ll_global.hero.walk_hold == 0 then
--
--       '' walk_hold timer is initialized
--
--       If MultiKey ( llg( l_key.code ) ) Then
    if input:down("left") then
--         '' hit left
--
--         .direction = 3
      ll_global.hero.direction = 3
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 4 Then
      if ll_global.hero.is_pushing == 4 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( r_key.code ) ) Then
    if input:down("right") then
--         '' hit right
--
--         .direction = 1
      ll_global.hero.direction = 1
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 2 Then
      if ll_global.hero.is_pushing == 2 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( d_key.code ) ) Then
    if input:down("down") then
--         '' hit down
--
--         .direction = 2
      ll_global.hero.direction = 2
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 3 Then
      if ll_global.hero.is_pushing == 3 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( u_key.code ) )   Then
    if input:down("up") then
--         '' hit up
--
--         .direction = 0
      ll_global.hero.direction = 0
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--         If llg( hero.is_pushing ) = 1 Then
      if ll_global.hero.is_pushing == 1 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

-- Sub hero_continue_movement( mn As _char_type Ptr )
function hero_continue_movement(mn)
--
--   If mn->dead <> 0 Then Exit Sub
  if mn.dead ~= 0 then return end
--
--   If MultiKey ( llg( u_key ).code ) Or MultiKey ( llg( r_key ).code ) Or MultiKey ( llg( d_key ).code ) Or MultiKey ( llg( l_key ).code ) Then
  if input:down("up") or input:down("right") or input:down("down") or input:down("left") then
--     '' hit a directional arrow
--     If mn->switch_room = -1 Then
    if mn.switch_room == -1 then
--
--       If MultiKey ( llg( l_key ).code ) Then
      if input:down("left") then
--         '' hit left
--
--         mn->direction = 3
        mn.direction = 3
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( r_key ).code ) Then
      if input:down("right") then
--         '' hit right
--
--         mn->direction = 1
        mn.direction = 1
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( d_key ).code ) Then
      if input:down("down") then
--         '' hit down
--
--         mn->direction = 2
        mn.direction = 2
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( u_key ).code )   Then
      if input:down("up") then
--         '' hit up
--
--         mn->direction = 0
        mn.direction = 0
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--     End If
    end
--
--   End If
  end
--
--
-- End Sub
end

-- Sub LLObject_GrabItems( o As char_type Ptr )
function LLObject_GrabItems(o)
--
--   With *( o )
  local with0 = o
--     If .dead = 0 Then
  if with0.dead == 0 then
--       '' hasn't been picked up, or it didn't spawn yet
--
--       Dim As vector_pair origin, target
    local origin, target = get_next_vector_pair(), get_next_vector_pair()
--
--       origin = LLO_VP( VarPtr( llg( hero ) ) )
    origin = LLO_VP(ll_global.hero)
--
--       target.u = .coords
    target.u.x = with0.coords.x
    target.u.y = with0.coords.y
--       target.v.x = 8
    target.v.x = 8
--       target.v.y = 8
    target.v.y = 8
--
--       If check_bounds( origin, target ) = 0 Then
    if check_bounds(origin, target) == 0 then
--
--         Select Case .dropped
--
--           Case 1
      if with0.dropped == 1 then
--             If llg( hero ).hp < llg( hero ).maxhp Then llg( hero ).hp += 1
        if ll_global.hero.hp < ll_global.hero.maxhp then ll_global.hero.hp = ll_global.hero.hp + 1 end
--             antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--             play_sample( llg( snd )[sound_healthgrab] )
          ll_global.snd[sound_healthgrab]:play()
--
--           Case 2
      elseif with0.dropped == 2 then
--             llg( hero ).money += ( .n_gold * 5 )
        ll_global.hero.money = ll_global.hero.money + (with0.n_gold * 5)
--             antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--             play_sample( llg( snd )[sound_cashget], 0 )
        ll_global.snd[sound_cashget]:play()
--
--           Case 3
      elseif with0.dropped == 3 then
--             llg( hero ).money += ( .n_silver )
        ll_global.hero.money = ll_global.hero.money + (with0.n_silver)
--             antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--             play_sample( llg( snd )[sound_cashget], 0 )
        ll_global.snd[sound_cashget]:play()
--
--
--         End Select
      end
--
--         .dropped = 0
      with0.dropped = 0
--
--         __make_dead ( o )
      __make_dead(o)
--         __cripple   ( o )
      __cripple(o)
--
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
-- End Sub
end

-- Sub LLObject_TouchSequence( o As char_type Ptr )
function LLObject_TouchSequence(o)
--
--   Dim As Integer touching, stuff, res, op, i
  local touching, stuff, res, op, i = 0, 0, 0, 0, 0
--
--   With *( o )
  local with0 = o
--
--     touching = LLObject_isTouching( llg( hero ), o[0] )
  touching = LLObject_isTouching(ll_global.hero, o)
--
--     stuff = -1
  stuff = -1
--
--     stuff And= ( .dead = 0 )
  stuff = bit.band(stuff, (with0.dead == 0) and -1 or 0)
--
--     stuff And= ( .seq_release = 0 )
  stuff = bit.band(stuff, (with0.seq_release == 0) and -1 or 0)
--     '' no sequence lock
--     stuff And= ( ( .unique_id = u_keydoor ) Imp ( llg( hero ).key <> 0 ) )
  stuff = bit.band(stuff, imp(with0.unique_id == u_keydoor and -1 or 0, ll_global.hero.key ~= 0 and -1 or 0))
--     '' if its a key door, then if you have a key..
--     stuff And= ( ( .unique_id = u_fkeydoor ) Imp ( llg( hero_only ).b_key <> 0 ) )
  stuff = bit.band(stuff, imp(with0.unique_id == u_fkeydoor and -1 or 0, ll_global.hero_only.b_key ~= 0 and -1 or 0))
--     '' if its a fkey door, then if you have a fkey..
--
--     If stuff Then
  if stuff ~= 0 then
--
--       If touching = 0 Then
    if touching == 0 then
--
--         If .spawn_cond <> 0 Then
      if with0.spawn_cond ~= 0 then
--
--           If .spawn_info->active_n <> 0 Then
        if with0.spawn_info.active_n ~= 0 then
--
--             res = -1
          res = -1
--             For i = 0 To .spawn_info->active_n - 1
          for i = 0, with0.spawn_info.active_n - 1 do
--
--               op = ( llg( now )[.spawn_info->active_spawn[i].code_index] <> 0 )
            op = ll_global.now[with0.spawn_info.active_spawn[i].code_index] ~= 0 and -1 or 0
--               If .spawn_info->active_spawn[i].code_state = 0 Then
            if with0.spawn_info.active_spawn[i].code_state == 0 then
--                 op = Not op
              op = bit.bnot(op)
--
--               End If
            end
--
--               res And= op
            res = bit.band(res, op)
--
--             Next
          end
--
--           Else
        else
--             res = -1
          res = -1
--
--           End If
        end
--
--         Else
      else
--           res = -1
        res = -1
--
--         End If
      end
--
--         If res <> 0 Then
      if res ~= 0 then
--           '' all conditions met
--           llg( seq ) = .seq + .sel_seq
        ll_global.seq = with0.seq
        ll_global.seqi = with0.sel_seq
--
--         End If
      end
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
-- End Sub
end

-- Sub LLObject_ActionSequence( o As char_type Ptr )
function LLObject_ActionSequence(o)
--
--
--   Dim As Integer facing, touching
  local facing, touching = 0, 0
--   Dim As vector_pair origin, target
  local origin, target = get_next_vector_pair(), get_next_vector_pair()
--
--   With *( o )
  local with0 = o
--
--     facing = is_facing( VarPtr( llg( hero ) ), o )
  facing = is_facing(ll_global.hero, o)
--     touching = LLObject_isTouching( llg( hero ), o[0] )
  touching = LLObject_isTouching(ll_global.hero, o)
--
--     If facing = 0 And touching = 0 Then
  if facing == 0 and touching == 0 then
--
--       If .seq_release = 0 Then
    if with0.seq_release == 0 then
--
--         If .dead = 0 Then
      if with0.dead == 0 then
--
--           llg( seq ) = .seq + .sel_seq
        ll_global.seq = with0.seq
        ll_global.seqi = with0.sel_seq
--
--         End If
      end
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
-- End Sub
end

-- Sub LLObject_CheckSpawn( o As char_type Ptr )
function LLObject_CheckSpawn(o)
--
--   Dim As Integer op, i, res, do_stuff
  local op, i, res, do_stuff = 0, 0, 0, 0
--
--   With *( o )
  local with0 = o
--
--     If .spawn_kill_trig = 0 Then
  if with0.spawn_kill_trig == 0 then
--
--       If .spawn_wait_trig = 0 Then
    if with0.spawn_wait_trig == 0 then
--
--         If .spawn_info->wait_n <> 0 Then
      if with0.spawn_info.wait_n ~= 0 then
--
--           res = -1
        res = -1
--           For i = 0 To .spawn_info->wait_n - 1
        for i = 0, with0.spawn_info.wait_n - 1 do
--
--             op = ( llg( now )[.spawn_info->wait_spawn[i].code_index] <> 0 )
          op = (ll_global.now[with0.spawn_info.wait_spawn[i].code_index] ~= 0) and -1 or 0
--             If .spawn_info->wait_spawn[i].code_state = 0 Then
          if with0.spawn_info.wait_spawn[i].code_state == 0 then
--               op = Not op
            op = bit.bnot(op)
--
--             End If
          end
--
--             res And= op
          res = bit.band(res, op)
--
--           Next
        end
--
--           If res <> 0 Then
        if res ~= 0 then
--             '' all conditions met
--
--             do_stuff = .num
          do_stuff = with0.num
--
--             LLSystem_CopyNewObject( *o )
          LLSystem_CopyNewObject(o)
--
--             .num = do_stuff
          with0.num = do_stuff
--             .spawn_wait_trig = -1
          with0.spawn_wait_trig = -1
--
--           End If
        end
--
--         End If
      end
--
--       End If
    end
--
--       If .spawn_info->kill_n <> 0 Then
    if with0.spawn_info.kill_n ~= 0 then
--
--         res = -1
      res = -1
--         For i = 0 To .spawn_info->kill_n - 1
      for i = 0, with0.spawn_info.kill_n - 1 do
--
--           op = ( llg( now )[.spawn_info->kill_spawn[i].code_index] <> 0 )
        op = (ll_global.now[with0.spawn_info.kill_spawn[i].code_index] ~= 0 and -1 or 0)
--           If .spawn_info->kill_spawn[i].code_state = 0 Then
        if with0.spawn_info.kill_spawn[i].code_state == 0 then
--             op = Not op
          op = bit.bnot(op)
--
--           End If
        end
--
--           res And= op
        res = bit.band(res, op)
--
--         Next
      end
--
--         If res <> 0 Then
      if res ~= 0 then
--           '' all conditions met
--
--           __make_dead  ( o )
        __make_dead(o)
--           __cripple  ( o )
        __cripple(o)
--           .seq_release = 0
        with0.seq_release = 0
--
--           .spawn_kill_trig = -1
        with0.spawn_kill_trig = -1
--
--           if .unique_id = u_biglarva then
        if with0.unique_id == u_biglarva then
--             LLObject_ShiftState( o, 3 )
          LLObject_ShiftState(o, 3)
--
--           end if
        end
--
--           if .unique_id = u_ghut then
        if with0.unique_id == u_ghut then
--             LLObject_ShiftState( o, 3 )
          LLObject_ShiftState(o, 3)
--
--           end if
        end
--
--         End If
      end
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

-- Function LLSystem_ReadSaveFile( saveName As String ) As ll_saving_data Ptr
function LLSystem_ReadSaveFile(saveName)
--
--   '' Routine type: Constructor ( ll_saving_data )
--   ''
--   '' Only returns a structure if saveName contains a file.
--   '' NO INTEGRITY CHECK IS DONE, if you edit the save file and it crashes
--   '' don't come crying to me.
--
--
--   '' Implementation:
--   ''
--   ''
--   '' pointer to the returned structure. (if any)
--   Dim As ll_saving_data Ptr res
  local res = nil
--   ''
--   '' Open VFile handle.
--   Dim As Integer openVFile
--   ''
--   '' Buffer to load decompressed file.
--   Dim As uByte saveMemory()
--
--
--   If Dir( saveName ) <> "" Then
  if love.filesystem.getInfo(saveName) then
--     '' The file exists, but i'm way too damn lazy to check
--     '' if its valid or not.
--     ''
--     '' Initialize a structure to fill and return
--     res = CAllocate( Len( ll_saving_data ) )
    res = create_ll_saving_data()
--     ''
--     '' Decompress the file into the buffer.
--     zLib_DeCompress( saveName, saveMemory() )
--     ''
--     '' Get a valid VFile handle.
--     openVFile = VFile_FreeFile()
--     ''
--     '' "Open" the buffer as a VFile
--     VFile_Open( saveMemory(), openVFile )
    local blob = loadBlob(saveName)
--
--       With *( res )
    local with0 = res
--
--         '' Read the savegame information.
--
--         VFile_Get openVFile, , .hp
    with0.hp = blob:read()
--         VFile_Get openVFile, , .maxhp
    with0.maxhp = blob:read()
--
--         VFile_Get openVFile, , .gold
    with0.gold = blob:read()
    --with0.gold = 100
--         VFile_Get openVFile, , .weapon
    with0.weapon = blob:read()
--         VFile_Get openVFile, , VF_Array( .hasItem )
    with0.hasItem = blob:read()
-- '        VFile_Get openVFile, , .item
--         VFile_Get openVFile, , .bar
    with0.bar = blob:read()
--
--         VFile_Get openVFile, , VF_Array( .hasCostume )
    with0.hasCostume = blob:read()
--         VFile_Get openVFile, , .isWearing
    with0.isWearing = blob:read()
--
--         VFile_Get openVFile, , .key
    with0.key = blob:read()
--         VFile_Get openVFile, , .b_key
    with0.b_key = blob:read()
--
--         VFile_Get openVFile, , .map
    with0.map = blob:read()
--         VFile_Get openVFile, , .entry
    with0.entry = blob:read()
--
--         VFile_Get openVFile, , VF_Array( .happen )
    with0.happen = blob:read()
--
--         VFile_Get openVFile, , .rooms
    with0.rooms = blob:read()
--
--         if .rooms <> 0 then
    if with0.rooms ~= 0 then
--
--           .hasVisited = callocate( len( ubyte ) * /' <- Unecessary, lol '/ .rooms )
      with0.hasVisited = {}
--           dim as integer iterRoomy
      local iterRoomy = 0
--
--           for iterRoomy = 0 to .rooms - 1
      for iterRoomy = 0, with0.rooms - 1 do
--             VFile_Get openVFile, , .hasVisited[iterRoomy]
        with0.hasVisited[iterRoomy] = blob:read()
--
--           next
      end
--
--         end if
    end
--
--       End With
--
--
--     '' "Close" the VFile.
--     VFile_Close( openVFile )
--
--   End If
  end
--
--
--   Return res
  return res
--
--
-- End Function
end

-- Sub LLSystem_WriteSaveFile( saveName As String, entry As Integer )
function LLSystem_WriteSaveFile(saveName, entry)
--
--   '' Routine type: Procedure
--   ''
--   '' Writes information from the global "hero"
--   '' structure into a compressed savefile.
--
--
--   '' Implementation:
--   ''
--   ''
--   '' Open VFile handle.
--   Dim As Integer openVFile
--   ''
--   '' Iterate through the "now" array
--   Dim As Integer i
--   ''
--   '' Buffer to save compressed file.
--   Redim As uByte saveMemory( 0 )
--
--
--   ''
--   '' Get a valid VFile handle.
--   openVFile = VFile_FreeFile()
  local blob = BlobWriter()
--   ''
--   '' "Open" the buffer as a VFile
--   VFile_Open( saveMemory(), openVFile )
--
--     '' Write the savegame information.
--
--     VFile_Put openVFile, , llg( hero ).hp
  blob:write(ll_global.hero.hp)
--     VFile_Put openVFile, , llg( hero ).maxhp
  blob:write(ll_global.hero.maxhp)
--
--     VFile_Put openVFile, , llg( hero ).money
  blob:write(ll_global.hero.money)
--     VFile_Put openVFile, , llg( hero_only ).has_weapon
  blob:write(ll_global.hero_only.has_weapon)
--
--     VFile_Put openVFile, , VF_Array( llg( hero_only ).hasItem )
  blob:write(ll_global.hero_only.hasItem)
--     VFile_Put openVFile, , llg( hero_only ).has_bar
  blob:write(ll_global.hero_only.has_bar)
--
--     VFile_Put openVFile, , VF_Array( llg( hero_only ).hasCostume )
  blob:write(ll_global.hero_only.hasCostume)
--     VFile_Put openVFile, , llg( hero_only ).isWearing
  blob:write(ll_global.hero_only.isWearing)
--
--
--     VFile_Put openVFile, , llg( hero ).key
  blob:write(ll_global.hero.key)
--     VFile_Put openVFile, , llg( hero_only ).b_key
  blob:write(ll_global.hero_only.b_key)
--
--     VFile_Put openVFile, , kfp( llg( map )->filename )
  blob:write(string.gsub(ll_global.map.filename, "data/map/", ""))
--     VFile_Put openVFile, , entry
  blob:write(entry)
--
--     VFile_Put openVFile, , Type <VFile_vector> ( llg( now ), LL_EVENTS_MAX, -1 )
  blob:write(ll_global.now)
--
--     dim as integer roomsHere, iterRooms
  local roomsHere, iterRooms = 0, 0
--     roomsHere = llg( map )->rooms
  roomsHere = ll_global.map.rooms
--
--     if llg( map )->isDungeon then
  if ll_global.map.isDungeon ~= 0 then
--       VFile_Put openVFile, , roomsHere
    blob:write(roomsHere)
--
--       for iterRooms = 0 to roomsHere - 1
    for iterRooms = 0, roomsHere - 1 do
--         VFile_Put openVFile, , llg( miniMap ).room[iterRooms].hasVisited
      --FIXME: icefield.mni does not exist. So when the player tries to save
      --the game from that map, the following crashes because the minimap has
      --no rooms. I vaguely recall perhaps the original game crashing when that
      --save point is used; we should confirm if this is the case and revisit this.
      if ll_global.miniMap.room[iterRooms] ~= nil then
        blob:write(ll_global.miniMap.room[iterRooms].hasVisited)
      else
        blob:write(0)
      end
--
--       next
    end
--
--     else
  else
--       roomsHere = 0
    roomsHere = 0
--       VFile_Put openVFile, , roomsHere
    blob:write(roomsHere)
--
--     end if
  end
--
--
--
--
--
--     VFile_Save( openVFile, saveMemory() )
  love.filesystem.write(saveName, blob:tostring())
--     zLib_Compress( saveMemory(), saveName, 9 )
--
--
--
--   '' "Close" the VFile.
--   VFile_Close( openVFile )
--
--
-- End Sub
end

-- Sub LLObject_CheckGTorchLit( this As char_type Ptr )
function LLObject_CheckGTorchLit(this)
--
--     Dim As Integer chk
  local chk = 0
--     For chk = 0 To now_room().enemies -1
  for chk = 0, now_room().enemies - 1 do
--
--       If now_room().enemy[chk].unique_id = u_gtorch Then
    if now_room().enemy[chk].unique_id == u_gtorch then
--         '' its a special torch
--
--         Dim As vector_pair origin, target
      local origin, target = get_next_vector_pair(), get_next_vector_pair()
--         origin.u.x = this->projectile->coords[0].x
      origin.u.x = this.projectile.coords[0].x
--         origin.u.y = this->projectile->coords[0].y
      origin.u.y = this.projectile.coords[0].y
--         origin.v.x = this->anim[this->proj_anim]->x
      origin.v.x = this.anim[this.proj_anim].x
--         origin.v.y = this->anim[this->proj_anim]->y
      origin.v.y = this.anim[this.proj_anim].y
--
--         target.u = now_room().enemy[chk].coords
      target.u.x = now_room().enemy[chk].coords.x
      target.u.y = now_room().enemy[chk].coords.y
--         target.v = now_room().enemy[chk].perimeter
      target.v.x = now_room().enemy[chk].perimeter.x
      target.v.y = now_room().enemy[chk].perimeter.y
--
--
--
--
--         If check_bounds( origin, target ) = 0 Then
      if check_bounds(origin, target) == 0 then
--
--           With now_room().enemy[chk]
        local with0 = now_room().enemy[chk]
--
--             '' hit, trigger torch
--             If .funcs.active_state = 0 Then
        if with0.funcs.active_state == 0 then
--               .jump_timer = 0
          with0.jump_timer = 0
--
--               LLObject_ShiftState( Varptr( now_room().enemy[chk] ), .hit_state )
          LLObject_ShiftState(now_room().enemy[chk], with0.hit_state)
--               LLObject_ClearProjectiles( now_room().enemy[0] )
          LLObject_ClearProjectiles(now_room().enemy[0])
--
--             End If
        end
--
--           End With
--
--         End If
      end
--
--       End If
    end
--
--     Next
  end
--
-- End Sub
end

function enemy_main()
  -- With now_room()
  --
  --   If .enemies > 0 Then
  --     act_enemies( .enemies, .enemy )
  act_enemies(now_room().enemies, now_room().enemy)
  --
  --   End If
  --   If .temp_enemies > 0 Then
  if now_room().temp_enemies > 0 then
  --     act_enemies( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
    act_enemies(now_room().temp_enemies, now_room().temp_enemy)
  --
  --   End If
  end
  --
  -- End With
end

-- Sub change_room( o As char_type Ptr, _call As Byte = 0, t As Integer = 0 )
function change_room(o, _call, t)
  _call = _call and _call or 0
  t = t and t or 0
--
--   Static As Integer switch_type, switch_state
  if switch_type == nil and switch_state == nil then
    switch_type, switch_state = 0, 0
  end
--
--   If _call <> 0 Then
  if _call ~= 0 then
--     switch_type = t
    switch_type = t
--     switch_state = 0
    switch_state = 0
--
--     Exit Sub
    return
--
--   End If
  end
--
--
--
--
--   Select Case switch_state
--
--
--     Case 0
  if switch_state == 0 then
--       '' lynn invincible
--
--       Dim As Integer all_momentum
    local all_momentum = 0
--       For all_momentum = 0 To 3
    for all_momentum = 0, 3 do
--
--         o->momentum.i( all_momentum ) = 0
      o.momentum.i[all_momentum] = 0
--
--       Next
    end
--
--       Select Case switch_type
--
--         Case 0
    if switch_type == 0 then
--
--           With llg( map )->room[now_room().teleport[o->switch_room].to_room]
      local with0 = ll_global.map.room[now_room().teleport[o.switch_room].to_room]
--
--             If .song_changes Then
      if with0.song_changes ~= 0 then
--
--               If llg( now )[.song_changes] <> 0 Then
        if ll_global.now[with0.song_changes] ~= 0 then
--                 llg( song_wait ) = .changes_to
          ll_global.song_wait = with0.changes_to
--
--               Else
        else
--                 llg( song_wait ) = .song
          ll_global.song_wait = with0.song
--
--               End If
        end
--
--             Else
      else
--               llg( song_wait ) = .song
        ll_global.song_wait = with0.song
--
--             End If
      end
--
--             if llg( song ) then
      if ll_global.song ~= 0 then
--
--               If llg( song ) <> llg( song_wait ) Then
        if ll_global.song ~= ll_global.song_wait then
--                 llg( song_fade ) = -1
          ll_global.song_fade = -1
--
--               End If
        end
--
--             end if
      end
--
--           End With
--
--
--
--         Case 1
    elseif switch_type == 1 then
--
--
--           If o->switch_room = -2 Then
      if o.switch_room == -2 then
--
--             llg( song_fade ) = -1
        ll_global.song_fade = -1
--             llg( song_wait ) = -1
        ll_global.song_wait = -1
--
--           Else
      else
--
--             #macro regularChange()
        function regularChange()
--
--               llg( song_wait ) = now_room().teleport[o->switch_room].to_song
          ll_global.song_wait = now_room().teleport[o.switch_room].to_song
--               llg( song_fade ) = -1
          ll_global.song_fade = -1
--
--             #endmacro
        end
--
--             '' hack coming back from houses...
--             If llg( map )->filename = "data\map\inhouse.map" Then
        --FIXME: Not sure how we are treating slashes in map filenames right now.
        if ll_global.map.filename == "data/map/inhouse.map" then
--               If now_room().teleport[o->switch_room].to_song = 9 Then
          if now_room().teleport[o.switch_room].to_song == 9 then
--                 If llg( now )[199] <> 0 Then
            if ll_global.now[199] ~= 0 then
--                 Else
            else
--                   If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
              if now_room().teleport[o.switch_room].to_song ~= ll_global.song then
--                     '' song is going to change
--                     regularChange()
                regularChange()
--                   End If
              end
--                 End If
            end
--               Else
          else
--                 If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
            if now_room().teleport[o.switch_room].to_song ~= ll_global.song then
--                   '' song is going to change
--                   regularChange()
              regularChange()
--                 End If
            end
--               End If
          end
--             Else
        else
--               If llg( map )->filename = "data\map\forest_fall.map" Then
          if ll_global.map.filename == "data/map/forest_fall.map" then
--                 If llg( this_room ).i = 4 Then
            if ll_global.this_room.i == 4 then
--                   If llg( now )[199] <> 0 Then
              if ll_global.now[199] ~= 0 then
--                   Else
              else
--                     If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                if now_room().teleport[o.switch_room].to_song ~= ll_global.song then
--                       '' song is going to change
--                       regularChange()
                  regularChange()
--                     End If
                end
--                   End If
              end
--                 Else
            else
--                   If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
              if now_room().teleport[o.switch_room].to_song ~= ll_global.song then
--                     '' song is going to change
--                     regularChange()
                regularChange()
--                   End If
              end
--                 End If
            end
--               Else
          else
--                 If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
            if now_room().teleport[o.switch_room].to_song ~= ll_global.song then
--                   '' song is going to change
--                   regularChange()
              regularChange()
--                 End If
            end
--               End If
          end
--             End If
        end
--           End If
      end
--
--
--       End Select
    end
--
--
--
--       switch_state += __make_invincible ( o )
    switch_state = switch_state + __make_invincible(o)
--
--
--     Case 1
  elseif switch_state == 1 then
--       '' do the fade
--
--       If llg( hero_only ).fadeStyle And LLFADE_WHITE Then
    if bit.band(ll_global.hero_only.fadeStyle, LLFADE_WHITE) ~= 0 then
--         switch_state += __fade_to_white( o )
      switch_state = switch_state + __fade_to_white(o)
--
--       Else'If llg( hero_only ).fadeStyle And LLFADE_NORMAL Then
    else
--
--         If o->fade_out = 0 Then
      if o.fade_out == 0 then
--
--           Dim As Integer hi_r, cols, r, g, b
        local hi_r, cols, r, g, b = 0, 0, 0, 0, 0
--           For cols = 0 To 255
        for cols = 0, 255 do
--
--             Palette Get cols, r, g, b
          r, g, b = palette_get_255(cols)
--
--             If r > hi_r Then
          if r > hi_r then
--               hi_r = r
            hi_r = r
--
--             End If
          end
--
--           Next
        end
--
--           o->fade_out = hi_r \ 4
        o.fade_out = math.floor(hi_r / 4)
--
--         End If
      end
--
--         switch_state += __fade_to_black ( o )
      switch_state = switch_state + __fade_to_black(o)
--
--       End If
    end
--
--       If switch_state = 2 Then
    if switch_state == 2 then
--         '' its gonna progress, last minute sh!t
--
--         o->fade_out = 0
      o.fade_out = 0
--
--         o->song_fade_count = 0
      o.song_fade_count = 0
--
--
--         If llg( song_fade ) <> 0 Then
      if ll_global.song_fade ~= 0 then
--
--           #IfDef ll_audio
--             bass_channelstop( llg( sng ) )
        love.audio.stop()
--
--           #EndIf
--
--         End If
      end
--
--       End If
    end
--
--
--     Case 2
  elseif switch_state == 2 then
--       '' switch thing! (either or)
--
--       Select Case switch_type
--
--         Case 0
    if switch_type == 0 then
--
--           llg( seq ) = 0
      ll_global.seq = nil
      ll_global.seqi = 0
--
--           llg( hero ).coords.x = now_room().teleport[o->switch_room].dx
      ll_global.hero.coords.x = now_room().teleport[o.switch_room].dx
--           llg( hero ).coords.y = now_room().teleport[o->switch_room].dy
      ll_global.hero.coords.y = now_room().teleport[o.switch_room].dy
--
--           If llg( this_room ).i <> now_room().teleport[o->switch_room].to_room Then
      if ll_global.this_room.i ~= now_room().teleport[o.switch_room].to_room then
--
--             #IfDef LL_LOGROOMCHANGE
--               LLSystem_Log( "Reached switch (room " & llg( this_room ).i & ")", "roomchange.txt" )
--
--             #EndIf
--
--             del_room_enemies now_room().enemies, now_room().enemy
--             del_room_enemies now_room().temp_enemies, Varptr( now_room().temp_enemy( 0 ) )
--
--             #IfDef LL_LOGROOMCHANGE
--               LLSystem_Log( "Reached deletion (room " & llg( this_room ).i & ")", "roomchange.txt" )
--
--             #EndIf
--
--             now_room().temp_enemies = 0
        now_room().temp_enemies = 0
--
--             llg( this_room ).i = now_room().teleport[o->switch_room].to_room
        ll_global.this_room.i = now_room().teleport[o.switch_room].to_room
--
--             llg( dark ) = now_room().dark
        ll_global.dark = now_room().dark
--
--             set_up_room_enemies now_room().enemies, now_room().enemy
        set_up_room_enemies(now_room().enemies, now_room().enemy)
--
--             #IfDef LL_LOGROOMCHANGE
--               LLSystem_Log( "Reached initialize (room " & llg( this_room ).i & ")", "roomchange.txt" )
--
--             #EndIf
--
--             If now_room().seq <> 0 Then
        if now_room().seq ~= nil then
--               o->seq = now_room().seq
          o.seq = now_room().seq
          o.seqi = now_room().seqi
--
--             End If
        end
--
--           End If
      end
--
--           switch_state += 1
      switch_state = switch_state + 1
--
--         Case 1
    elseif switch_type == 1 then
--           enter_map( o, llg( map ), "data\map\" & o->to_map, o->to_entry ) '' "
      enter_map(o, ll_global, "data/map/"..o.to_map, o.to_entry)
--           set_up_room_enemies now_room().enemies, now_room().enemy
      set_up_room_enemies(now_room().enemies, now_room().enemy)
--
--           switch_state += 1
      switch_state = switch_state + 1
--
--       End Select
    end
--
--       If llg( song_wait ) = -1 Then
    if ll_global.song_wait == -1 then
--
--         llg( song_wait ) = now_room().song
      ll_global.song_wait = now_room().song
--
--       End If
    end
--
--       If llg( song_fade ) <> 0 Then
    if ll_global.song_fade ~= 0 then
--
--         llg( song ) = llg( song_wait )
      ll_global.song = ll_global.song_wait
--
--         LLMusic_Start( *music_strings( llg( song ) ) )
      LLMusic_Start(music_strings[ll_global.song])
--
--       End If
    end
--
--       If llg( hero_only ).isLoading Then
    if ll_global.hero_only.isLoading ~= 0 then
--         llg( hero_only ).isLoading = FALSE
      ll_global.hero_only.isLoading = FALSE
--         llg( do_hud ) = -1
      ll_global.do_hud = -1
--
--       End If
    end
--
--       If llg( hero_only ).invisibleEntry = 0 Then
    if ll_global.hero_only.invisibleEntry == 0 then
--         o->invisible = 0
      o.invisible = 0
--
--       Else
    else
--         llg( hero_only ).invisibleEntry = 0
      ll_global.hero_only.invisibleEntry = 0
--         llg( hero ).invisible = 1
      ll_global.hero.invisible = 1
--
--       End If
    end
--
--     Case 3
  elseif switch_state == 3 then
--
--       #IfDef LL_LOGROOMCHANGE
--         LLSystem_Log( "Start fade up" )
--
--       #EndIf
--       '' fade back up
--       '' gray is implictly given priority.
--       If llg( hero_only ).fadeStyle And LLFADE_GRAY Then
    if bit.band(ll_global.hero_only.fadeStyle, LLFADE_GRAY) ~= 0 then
--         switch_state += __fade_down_to_gray( o )
      switch_state = switch_state + __fade_down_to_gray(o)
--       ElseIf llg( hero_only ).fadeStyle And LLFADE_WHITE Then
    elseif bit.band(ll_global.hero_only.fadeStyle, LLFADE_WHITE) ~= 0 then
--         switch_state += __fade_down_to_color( o )
      switch_state = switch_state + __fade_down_to_color(o)
--       Else'If llg( hero_only ).fadeStyle And LLFADE_NORMAL Then
    else
--         switch_state += __fade_up_to_color( o )
      switch_state = switch_state + __fade_up_to_color(o)
--
--       End If
    end
--
--
--       If switch_state = 4 Then
    if switch_state == 4 then
--         '' moving along...
--         #IfDef LL_LOGROOMCHANGE
--           LLSystem_Log( "Fade Succeded" )
--
--         #EndIf
--         llg( song_fade ) = 0
      ll_global.song_fade = 0
--
--       End If
    end
--
--
--     Case 4
  elseif switch_state == 4 then
--       '' make lynn vulnerable
--       #IfDef LL_LOGROOMCHANGE
--         LLSystem_Log( "Make vulnerable" )
--
--       #EndIf
--
--       switch_state += __make_vulnerable ( o )
    switch_state = switch_state + __make_vulnerable(o)
--
--
--     Case 5
  elseif switch_state == 5 then
--       '' final anything :)
--
--       llg( seq ) = o->seq
    ll_global.seq = o.seq
    ll_global.seqi = o.seqi
--
--       o->seq = 0
    o.seq = nil
    o.seqi = 0
--
--       o->switch_room = -1
    o.switch_room = -1
--
--       switch_state = -1
    switch_state = -1
--       switch_type = -1
    switch_type = -1
--
--       If llg( map )->isDungeon <> 0 Then
    if ll_global.map.isDungeon ~= 0 then
--         llg( minimap ).room[llg( this_room ).i].hasVisited = -1
      if ll_global.miniMap.room[ll_global.this_room.i] == nil then
        ll_global.miniMap.room[ll_global.this_room.i] = create_LL_MiniMapRoomType()
      end
      ll_global.miniMap.room[ll_global.this_room.i].hasVisited = -1
--
--       End If
    end
--
--       llg( hero_only ).fadeStyle = LLFADE_NORMAL
    ll_global.hero_only.fadeStyle = LLFADE_NORMAL
--
--       #IfDef LL_LOGROOMCHANGE
--         LLSystem_Log( "Final stuff OK" )
--
--       #EndIf
--
--   End Select
  end
--
--
-- End Sub
end

-- Private Sub keyboardSelected()
function keyboardSelected()
--
--   Const As Double key_Delay = .5
  local key_Delay = .5
--
--   Dim As Integer key_up, key_right, key_down, key_left
  local key_up, key_right, key_down, key_left = 0, 0, 0, 0
--   Dim As Double hkey_up, hkey_right, hkey_down, hkey_left
  local hkey_up, hkey_right, hkey_down, hkey_left = 0, 0, 0, 0
--   Static As Double dkey_up, dkey_right, dkey_down, dkey_left
  if dkey_up == nil then dkey_up = 0.0 end
  if dkey_right == nil then dkey_right = 0.0 end
  if dkey_down == nil then dkey_down = 0.0 end
  if dkey_left == nil then dkey_left = 0.0 end
--
--
--   key_up    = IIf( dkey_up    = 0, MultiKey( sc_up    ), 0 )
  key_up = iif(dkey_up == 0, input:down("up") and -1 or 0, 0)
--   key_right = IIf( dkey_right = 0, MultiKey( sc_right ), 0 )
  key_right = iif(dkey_right == 0, input:down("right") and -1 or 0, 0)
--   key_down  = IIf( dkey_down  = 0, MultiKey( sc_down  ), 0 )
  key_down = iif(dkey_down == 0, input:down("down") and -1 or 0, 0)
--   key_left  = IIf( dkey_left  = 0, MultiKey( sc_left  ), 0 )
  key_left = iif(dkey_left == 0, input:down("left") and -1 or 0, 0)
--
--   If key_up    = 0 And MultiKey( sc_up    ) Then hkey_up = -1
  if key_up == 0 and input:down("up") then hkey_up = -1 end
--   If key_right = 0 And MultiKey( sc_right ) Then hkey_right = -1
  if key_right == 0 and input:down("right") then hkey_right = -1 end
--   If key_down  = 0 And MultiKey( sc_down  ) Then hkey_down = -1
  if key_down == 0 and input:down("down") then hkey_down = -1 end
--   If key_left  = 0 And MultiKey( sc_left  ) Then hkey_left = -1
  if key_left == 0 and input:down("left") then hkey_left = -1 end
--
--
--   Select Case As Const llg( menu ).selectedItem
--
--     Case 0
  if ll_global.menu.selectedItem == 0 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 12
    if key_up == -1 then ll_global.menu.selectedItem = 12 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 1
    if key_right == -1 then ll_global.menu.selectedItem = 1 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 3
    if key_down == -1 then ll_global.menu.selectedItem = 3 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_left == -1 then ll_global.menu.selectedItem = 18 end
--
--     Case 1
  elseif ll_global.menu.selectedItem == 1 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 13
    if key_up == -1 then ll_global.menu.selectedItem = 13 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 2
    if key_right == -1 then ll_global.menu.selectedItem = 2 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 4
    if key_down == -1 then ll_global.menu.selectedItem = 4 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 0
    if key_left == -1 then ll_global.menu.selectedItem = 0 end
--
--     Case 2
  elseif ll_global.menu.selectedItem == 2 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 14
    if key_up == -1 then ll_global.menu.selectedItem = 14 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_right == -1 then ll_global.menu.selectedItem = 18 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 5
    if key_down == -1 then ll_global.menu.selectedItem = 5 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 1
    if key_left == -1 then ll_global.menu.selectedItem = 1 end
--
--     Case 3
  elseif ll_global.menu.selectedItem == 3 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 0
    if key_up == -1 then ll_global.menu.selectedItem = 0 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 4
    if key_right == -1 then ll_global.menu.selectedItem = 4 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 6
    if key_down == -1 then ll_global.menu.selectedItem = 6 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_left == -1 then ll_global.menu.selectedItem = 18 end
--
--     Case 4
  elseif ll_global.menu.selectedItem == 4 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 1
    if key_up == -1 then ll_global.menu.selectedItem = 1 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 5
    if key_right == -1 then ll_global.menu.selectedItem = 5 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 7
    if key_down == -1 then ll_global.menu.selectedItem = 7 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 3
    if key_left == -1 then ll_global.menu.selectedItem = 3 end
--
--     Case 5
  elseif ll_global.menu.selectedItem == 5 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 2
    if key_up == -1 then ll_global.menu.selectedItem = 2 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_right == -1 then ll_global.menu.selectedItem = 18 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 8
    if key_down == -1 then ll_global.menu.selectedItem = 8 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 4
    if key_left == -1 then ll_global.menu.selectedItem = 4 end
--
--     Case 6
  elseif ll_global.menu.selectedItem == 6 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 3
    if key_up == -1 then ll_global.menu.selectedItem = 3 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 7
    if key_right == -1 then ll_global.menu.selectedItem = 7 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 9
    if key_down == -1 then ll_global.menu.selectedItem = 9 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_left == -1 then ll_global.menu.selectedItem = 19 end
--
--     Case 7
  elseif ll_global.menu.selectedItem == 7 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 4
    if key_up == -1 then ll_global.menu.selectedItem = 4 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 8
    if key_right == -1 then ll_global.menu.selectedItem = 8 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 10
    if key_down == -1 then ll_global.menu.selectedItem = 10 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 6
    if key_left == -1 then ll_global.menu.selectedItem = 6 end
--
--     Case 8
  elseif ll_global.menu.selectedItem == 8 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 5
    if key_up == -1 then ll_global.menu.selectedItem = 5 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_right == -1 then ll_global.menu.selectedItem = 19 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 11
    if key_down == -1 then ll_global.menu.selectedItem = 11 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 7
    if key_left == -1 then ll_global.menu.selectedItem = 7 end
--
--     Case 9
  elseif ll_global.menu.selectedItem == 9 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 6
    if key_up == -1 then ll_global.menu.selectedItem = 6 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 10
    if key_right == -1 then ll_global.menu.selectedItem = 10 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 12
    if key_down == -1 then ll_global.menu.selectedItem = 12 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_left == -1 then ll_global.menu.selectedItem = 19 end
--
--     Case 10
  elseif ll_global.menu.selectedItem == 10 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 7
    if key_up == -1 then ll_global.menu.selectedItem = 7 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 11
    if key_right == -1 then ll_global.menu.selectedItem = 11 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 13
    if key_down == -1 then ll_global.menu.selectedItem = 13 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 9
    if key_left == -1 then ll_global.menu.selectedItem = 9 end
--
--     Case 11
  elseif ll_global.menu.selectedItem == 11 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 8
    if key_up == -1 then ll_global.menu.selectedItem = 8 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_right == -1 then ll_global.menu.selectedItem = 19 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 14
    if key_down == -1 then ll_global.menu.selectedItem = 14 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 10
    if key_left == -1 then ll_global.menu.selectedItem = 10 end
--
--     Case 12
  elseif ll_global.menu.selectedItem == 12 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 9
    if key_up == -1 then ll_global.menu.selectedItem = 9 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 13
    if key_right == -1 then ll_global.menu.selectedItem = 13 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 0
    if key_down == -1 then ll_global.menu.selectedItem = 0 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 14
    if key_left == -1 then ll_global.menu.selectedItem = 14 end
--
--     Case 13
  elseif ll_global.menu.selectedItem == 13 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 10
    if key_up == -1 then ll_global.menu.selectedItem = 10 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 14
    if key_right == -1 then ll_global.menu.selectedItem = 14 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 1
    if key_down == -1 then ll_global.menu.selectedItem = 1 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 12
    if key_left == -1 then ll_global.menu.selectedItem = 12 end
--
--     Case 14
  elseif ll_global.menu.selectedItem == 14 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 11
    if key_up == -1 then ll_global.menu.selectedItem = 11 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 12
    if key_right == -1 then ll_global.menu.selectedItem = 12 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 2
    if key_down == -1 then ll_global.menu.selectedItem = 2 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 13
    if key_left == -1 then ll_global.menu.selectedItem = 13 end
--
-- '    Case 15
-- '      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 12
-- '      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 16
-- '      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 0
-- '      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 17
-- '
-- '    Case 16
-- '      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 13
-- '      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 17
-- '      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 1
-- '      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 15
-- '
-- '    Case 17
-- '      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 14
-- '      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 15
-- '      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 2
-- '      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 16
-- '
--     Case 18
  elseif ll_global.menu.selectedItem == 18 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_up == -1 then ll_global.menu.selectedItem = 19 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 3
    if key_right == -1 then ll_global.menu.selectedItem = 3 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 19
    if key_down == -1 then ll_global.menu.selectedItem = 19 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 5
    if key_left == -1 then ll_global.menu.selectedItem = 5 end
--
--     Case 19
  elseif ll_global.menu.selectedItem == 19 then
--       If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_up == -1 then ll_global.menu.selectedItem = 18 end
--       If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 6
    if key_right == -1 then ll_global.menu.selectedItem = 6 end
--       If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 18
    if key_down == -1 then ll_global.menu.selectedItem = 18 end
--       If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 8
    if key_left == -1 then ll_global.menu.selectedItem = 8 end
--
--   End Select
  end
--
--   #Define delayStopper(__DIREC__)             _
--                                               _
--     If hkey_##__DIREC__ = 0 Then             :_
--                                              :_
--       If key_##__DIREC__ = ( Not 0 ) Then    :_
--         dkey_##__DIREC__ = Timer + key_Delay :_
--                                              :_
--       Else                                   :_
--         dkey_##__DIREC__ = 0                 :_
--                                              :_
--       End If                                 :_
--                                              :_
--     End If
--
--   delayStopper( up )

  if hkey_up == 0 then
    if key_up == -1 then
      dkey_up = timer + key_Delay
    else
      dkey_up = 0
    end
  end

--   delayStopper( right )

  if hkey_right == 0 then
    if key_right == -1 then
      dkey_right = timer + key_Delay
    else
      dkey_right = 0
    end
  end

--   delayStopper( down )

  if hkey_down == 0 then
    if key_down == -1 then
      dkey_down = timer + key_Delay
    else
      dkey_down = 0
    end
  end

--   delayStopper( left )

  if hkey_left == 0 then
    if key_left == -1 then
      dkey_left = timer + key_Delay
    else
      dkey_left = 0
    end
  end

--
--   If Timer > dkey_up    Then dkey_up = 0
  if timer > dkey_up then dkey_up = 0 end
--   If Timer > dkey_right Then dkey_right = 0
  if timer > dkey_right then dkey_right = 0 end
--   If Timer > dkey_down  Then dkey_down = 0
  if timer > dkey_down then dkey_down = 0 end
--   If Timer > dkey_left  Then dkey_left = 0
  if timer > dkey_left then dkey_left = 0 end
--
--
-- End Sub
end

-- Private Function handleKeybSelected()
function handleKeybSelected()
--
--   Function = 0
--
--
--   If MultiKey( llg( conf_key ).code ) Or MultiKey( sc_enter ) Then
  if input:down("action") then
--
--     Select Case As Const llg( menu ).selectedItem
--
--       Case 0
    if ll_global.menu.selectedItem == 0 then
--         If llg( hero_only ).has_weapon >= 0 Then
      if ll_global.hero_only.has_weapon >= 0 then
--           llg( hero_only ).weapon = 0
        ll_global.hero_only.weapon = 0
--
--         End If
      end
--
--       Case 1
    elseif ll_global.menu.selectedItem == 1 then
--         If llg( hero_only ).has_weapon >= 1 Then
      if ll_global.hero_only.has_weapon >= 1 then
--           llg( hero_only ).weapon = 1
        ll_global.hero_only.weapon = 1
--
--         End If
      end
--
--       Case 2
    elseif ll_global.menu.selectedItem == 2 then
--         If llg( hero_only ).has_weapon >= 2 Then
      if ll_global.hero_only.has_weapon >= 2 then
--           llg( hero_only ).weapon = 2
        ll_global.hero_only.weapon = 2
--
--         End If
      end
--
--       Case 3
    elseif ll_global.menu.selectedItem == 3 then
-- '        If llg( hero_only ).has_item >= 1 Then
--         If llg( hero_only ).hasItem( 0 ) Then
      if ll_global.hero_only.hasItem[0] ~= 0 then
--           llg( hero_only ).selected_item = 1
        ll_global.hero_only.selected_item = 1
--
--         End If
      end
--
--       Case 4
    elseif ll_global.menu.selectedItem == 4 then
-- '        If llg( hero_only ).has_item >= 2 Then
--         If llg( hero_only ).hasItem( 1 ) Then
      if ll_global.hero_only.hasItem[1] ~= 0 then
--           llg( hero_only ).selected_item = 2
        ll_global.hero_only.selected_item = 2
--
--         End If
      end
--
--       Case 5
    elseif ll_global.menu.selectedItem == 5 then
--         If llg( hero_only ).hasItem( 2 ) Then
      if ll_global.hero_only.hasItem[2] ~= 0 then
--           llg( hero_only ).selected_item = 3
        ll_global.hero_only.selected_item = 3
--
--         End If
      end
--
--       Case 6
    elseif ll_global.menu.selectedItem == 6 then
--         If llg( hero_only ).hasItem( 3 ) Then
      if ll_global.hero_only.hasItem[3] ~= 0 then
--           llg( hero_only ).selected_item = 4
        ll_global.hero_only.selected_item = 4
--
--         End If
      end
--
--       Case 7
    elseif ll_global.menu.selectedItem == 7 then
--         If llg( hero_only ).hasItem( 4 ) Then
      if ll_global.hero_only.hasItem[4] ~= 0 then
--           llg( hero_only ).selected_item = 5
        ll_global.hero_only.selected_item = 5
--
--         End If
      end
--
--       Case 8
    elseif ll_global.menu.selectedItem == 8 then
--         If llg( hero_only ).hasItem( 5 ) Then
      if ll_global.hero_only.hasItem[5] ~= 0 then
--           llg( hero_only ).selected_item = 6
        ll_global.hero_only.selected_item = 6
--
--         End If
      end
--
--       Case 9
    elseif ll_global.menu.selectedItem == 9 then
--         If llg( hero_only ).hasCostume( 0 ) <> 0 Then
      if ll_global.hero_only.hasCostume[0] ~= 0 then
--           llg( hero_only ).isWearing = 0
        ll_global.hero_only.isWearing = 0
--           set_regular()
        set_regular()
--
--         End If
      end
--
--
--       Case 10
    elseif ll_global.menu.selectedItem == 10 then
--         If llg( hero_only ).hasCostume( 1 ) <> 0 Then
      if ll_global.hero_only.hasCostume[1] ~= 0 then
--           llg( hero_only ).isWearing = 1
        ll_global.hero_only.isWearing = 1
--           set_cougar()
        set_cougar()
--
--         End If
      end
--
--
--       Case 11
    elseif ll_global.menu.selectedItem == 11 then
--         If llg( hero_only ).hasCostume( 2 ) <> 0 Then
      if ll_global.hero_only.hasCostume[2] ~= 0 then
--           llg( hero_only ).isWearing = 2
        ll_global.hero_only.isWearing = 2
--           set_lynnity()
        set_lynnity()
--
--         End If
      end
--
--       Case 12
    elseif ll_global.menu.selectedItem == 12 then
--         If llg( hero_only ).hasCostume( 3 ) <> 0 Then
      if ll_global.hero_only.hasCostume[3] ~= 0 then
--           llg( hero_only ).isWearing = 3
        ll_global.hero_only.isWearing = 3
--           set_ninja()
        set_ninja()
--
--         End If
      end
--
--       Case 13
    elseif ll_global.menu.selectedItem == 13 then
--         If llg( hero_only ).hasCostume( 4 ) <> 0 Then
      if ll_global.hero_only.hasCostume[4] ~= 0 then
--           llg( hero_only ).isWearing = 4
        ll_global.hero_only.isWearing = 4
--           set_bikini()
        set_bikini()
--
--         End If
      end
--
--       Case 14
    elseif ll_global.menu.selectedItem == 14 then
--         If llg( hero_only ).hasCostume( 5 ) <> 0 Then
      if ll_global.hero_only.hasCostume[5] ~= 0 then
--           llg( hero_only ).isWearing = 5
        ll_global.hero_only.isWearing = 5
--           set_rknight()
        set_rknight()
--
--         End If
      end
--
-- '      Case 15
-- '        If llg( hero_only ).hasCostume( 6 ) <> 0 Then
-- '          llg( hero_only ).isWearing = 6
-- '
-- '        End If
-- '
-- '      Case 16
-- '        If llg( hero_only ).hasCostume( 7 ) <> 0 Then
-- '          llg( hero_only ).isWearing = 7
-- '
-- '        End If
-- '
-- '      Case 17
-- '        If llg( hero_only ).hasCostume( 8 ) <> 0 Then
-- '          llg( hero_only ).isWearing = 8
-- '
-- '        End If
-- '
--       Case 18
    elseif ll_global.menu.selectedItem == 18 then

--         Return -1
      return -1
--
--       Case 19
    elseif ll_global.menu.selectedItem == 19 then

--         jump_to_title()
      jump_to_title()
--         Return -1
      return -1
--
--
--     End Select
    end
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function menu_Input()
function menu_Input()
--
--   If llg( locationChanged ) Then
--
--     Dim As Integer selected = mouseSelected()
--     If selected <> -1 Then
--       llg( menu ).selectedItem = selected
--
--     End If
--
--   End If
--
--   keyboardSelected()
  keyboardSelected()

--
--   Return handleKeybSelected() or handleMouseSelected()
  return handleKeybSelected()
--
-- End Function
end

-- Sub jump_to_title()
function jump_to_title()
--
--
--   Dim As Integer lx, ly, ld, i
  local lx, ly, ld, i = 0, 0, 0, 0
--
--
--   now_room().teleports += 1
  now_room().teleports = now_room().teleports + 1
--   now_room().teleport = Reallocate( now_room().teleport, now_room().teleports *  Len( teleport_type ) )
--   MemSet( Varptr( now_room().teleport[now_room().teleports - 1] ), 0, Len( teleport_type ) )
  now_room().teleport[now_room().teleports - 1] = create_teleport_type()
--
--   now_room().teleport[now_room().teleports - 1].to_map = "title.map"
  now_room().teleport[now_room().teleports - 1].to_map = "title.map"
--   now_room().teleport[now_room().teleports - 1].to_room = 0
  now_room().teleport[now_room().teleports - 1].to_room = 0
--   now_room().teleport[now_room().teleports - 1].to_song = 20
  now_room().teleport[now_room().teleports - 1].to_song = 20
--
--   change_room( 0, -1, 1 )
  change_room(0, -1, 1)
--
--   lx = llg( hero ).coords.x
  lx = ll_global.hero.coords.x
--   ly = llg( hero ).coords.y
  ly = ll_global.hero.coords.y
--   ld = llg( hero ).direction
  ld = ll_global.hero.direction
--
--   ctor_hero( Varptr( llg( hero ) ) )
  ctor_hero(ll_global.hero)
--
--   llg( hero ).coords.x = lx
  ll_global.hero.coords.x = lx
--   llg( hero ).coords.y = ly
  ll_global.hero.coords.y = ly
--   llg( hero ).direction = ld
  ll_global.hero.direction = ld
--
--   llg( hero ).fade_time = .003
  ll_global.hero.fade_time = .003
--   llg( hero ).walk_speed = .009
  ll_global.hero.walk_speed = .009
--
--   llg( hero_only ).invisibleEntry = 1
  ll_global.hero_only.invisibleEntry = 1
--   llg( hero_only ).selected_item = 0
  ll_global.hero_only.selected_item = 0
--
--   For i = 0 To 8
  for i = 0, 8 do
--     llg( hero_only ).hasCostume(i) = FALSE
    ll_global.hero_only.hasCostume[i] = FALSE
--
--   Next
  end
--   For i = 0 To 5
  for i = 0, 5 do
--     llg( hero_only ).hasItem(i) = FALSE
    ll_global.hero_only.hasItem[i] = FALSE
--
--   Next
  end
--   llg( hero_only ).hasCostume(0) = -1
  ll_global.hero_only.hasCostume[0] = -1
--   llg( hero_only ).isWearing = 0
  ll_global.hero_only.isWearing = 0
--
--   llg( hero ).switch_room = now_room().teleports - 1
  ll_global.hero.switch_room = now_room().teleports - 1
--
--   llg( hero ).to_map = now_room().teleport[llg( hero ).switch_room].to_map
  ll_global.hero.to_map = now_room().teleport[ll_global.hero.switch_room].to_map
--   llg( hero ).to_entry = now_room().teleport[llg( hero ).switch_room].to_room
  ll_global.hero.to_entry = now_room().teleport[ll_global.hero.switch_room].to_room
--
--   MemSet( llg( now ), 0, LL_EVENTS_MAX )
  for i = 0, LL_EVENTS_MAX - 1 do
    ll_global.now[i] = 0
  end
--   llg( do_hud ) = 0
  ll_global.do_hud = 0
--
--   llg( xxyxx ) = 0
  ll_global.xxyxx = 0
--
--
--   antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--   antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--   antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
--   antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
--   antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
--
--
-- End Sub
end

-- Sub handle_pause_menu()
function handle_pause_menu()
--
--   Static As Integer esc_Hold, end_Hold
--
--   If end_Hold <> 0 Then
--     If MultiKey( sc_escape ) = 0  Then end_Hold = 0
--
--   End If
--
--   If llg( hero_only ).attacking = 0 Then
  if ll_global.hero_only.attacking == 0 then
--     If llg( hero ).switch_room = -1 Then
    if ll_global.hero.switch_room == -1 then
--       If llg( seq ) = 0 Then
      if ll_global.seq == nil then
--         If llg( hero ).menu_sel = 0 Then
        if ll_global.hero.menu_sel == 0 then
--           If llg( hero ).dead = 0 Then
          if ll_global.hero.dead == 0 then
--
--             If MultiKey( sc_escape ) And ( end_Hold = 0 ) Then
            if input:pressed("pause") then
              --NOTE: drawing is our global flag for turning on drawing for the
              --current loop, not relevant to the original codebase.
              drawing = true
--               esc_Hold = -1
--
--
--               SetMouse , , 1
--
--               llg( menu ).selectedItem = 18
--               Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
--               Flip
--               Put( 0, 0 ), llg( menu_ScreenSave )
--
--               Do
              repeat
                timer = love.timer.getTime()
                input:update()
--
--
--                 Dim As Integer mx, my
--
--                 mx = fb_Global.mouse.x
--                 my = fb_Global.mouse.y
--
--                 fb_GetMouse()
--                 fb_GetKey()
--
--                 llg( locationChanged ) And= 0
--                 If ( fb_Global.mouse.x <> mx ) Or ( fb_Global.mouse.y <> my ) Then
--                   llg( locationChanged ) = Not 0
--
--                 End If
--
--                 If MultiKey( sc_escape ) = 0 Then
--                   esc_Hold = 0
--
--                 End If
--
--                 Put( 0, 0 ), llg( menu_ScreenSave )
                love.graphics.draw(savedCanvas)
--                 If menu_Input() Then
                if menu_Input() ~= 0 then
--                   Exit Do
                   break
--
--                 End If
                end
--
--                 menu_Blit()
                menu_Blit()
--                 '' pause menu
--
--                 fb_ScreenRefresh()
--                 Sleep 1
--
--                 If MultiKey( sc_escape ) Then
                if input:pressed("pause") == true then
--
--                   If esc_Hold = 0 Then
--                     end_Hold = -1
--                     Exit Do
                  break
--
--                   End If
--
--                 End If
                end
--
--                 If fb_WindowKill() Then
--                   End
--
--                 End If
--
--               Loop
                coroutine.yield()
              until false
--
--               Flip
--               Put( 0, 0 ), llg( menu_ScreenSave )
--
--             End If
            end
--
--           End If
          end
--
--         End If
        end
--
--       End If
      end
--
--     End If
    end
--
--   End If
  end
--
--
-- End Sub
end

-- Sub enter_map( _char As char_type Ptr, _m As map_type Ptr, desc As String, _entry As Integer )
--NOTE: _m is actually expected to be the ll_global object,
--and the .map property is used throughout.
function enter_map(_char, _m, desc, _entry)
--
--   Dim As Integer _
--     _fade, _
--     _song, _
--     _wait, _
--     cary
  local _fade, _song, _wait, cary = 0, 0, 0, 0
--
--
--   If _m <> 0 Then
  if _m ~= nil then
--     cary = Not 0
    cary = -1
--     _fade = llg( song_fade )
    _fade = ll_global.song_fade
--     _song = llg( song )
    _song = ll_global.song
--     _wait = llg( song_wait )
    _wait = ll_global.song_wait
--
--   End If
  end
--   map_Destroy( _m )
--
--   _m = LLSystem_LoadMap( desc )
  _m.map = LLSystem_LoadMap(desc)
--
--   '' if flag ptr set, access it.
--   if llg( hero_only ).roomVisited then
  if ll_global.hero_only.roomVisited ~= nil then
--     dim as integer iRoom
    local iRoom = 0
--
--     for iRoom = 0 to _m->rooms - 1
    for iRoom = 0, _m.map.rooms - 1 do
--
      if ll_global.miniMap.room[iRoom] == nil then
        ll_global.miniMap.room[iRoom] = create_LL_MiniMapRoomType()
      end
--       llg( miniMap ).room[iRoom].hasVisited = llg( hero_only ).roomVisited[iRoom]
      ll_global.miniMap.room[iRoom].hasVisited = ll_global.hero_only.roomVisited[iRoom]
--
--     next
    end
--
--     clean_Deallocate( llg( hero_only ).roomVisited )
    ll_global.hero_only.roomVisited = nil
--
--   end if
  end
--
--
--   If cary <> 0 Then
  if cary ~= 0 then
--     llg( song_fade ) = _fade
    ll_global.song_fade = _fade
--     llg( song ) = _song
    ll_global.song = _song
--     llg( song_wait ) = _wait
    ll_global.song_wait = _wait
--
--   End If
  end
--
--   _char->coords.x         = _m->entry[_entry].x
  _char.coords.x = _m.map.entry[_entry].x
--   _char->coords.y         = _m->entry[_entry].y
  _char.coords.y = _m.map.entry[_entry].y
--
--   _char->direction = _m->entry[_entry].direction
  _char.direction = _m.map.entry[_entry].direction
--
--   llg( this_room.i )  = _m->entry[_entry].room
  ll_global.this_room.i = _m.map.entry[_entry].room
--
--   '' active sequence
--   llg( hero ).seq = _m->entry[_entry].seq
  ll_global.hero.seq = _m.map.entry[_entry].seq
  ll_global.hero.seqi = _m.map.entry[_entry].seqi
--
--   llg( dark ) = now_room().dark
  ll_global.dark = now_room().dark
--
--
-- End Sub
end

-- Private Sub hero_attack( hr As _char_type Ptr )
function hero_attack(hr)
--
--
--   With *hr
--
--     '' increment this function loop
--     .funcs.current_func[.attack_state] += .funcs.func[.attack_state][.funcs.current_func[.attack_state]] ( hr )
  hr.funcs.current_func[hr.attack_state] = hr.funcs.current_func[hr.attack_state] + hr.funcs.func[hr.attack_state][hr.funcs.current_func[hr.attack_state]](hr)
--
--
--     Dim As Integer call_back
  local call_back = false
--     call_back = ( .funcs.current_func[.attack_state] >= .funcs.func_count[.attack_state] )
  call_back = (hr.funcs.current_func[hr.attack_state] >= hr.funcs.func_count[hr.attack_state])
--
--     If call_back Then
  if call_back == true then
--       '' lynn called back
--
--       .funcs.current_func[.attack_state] = 0
    hr.funcs.current_func[hr.attack_state] = 0
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--       llg( hero ).psycho = 0
    ll_global.hero.psycho = 0
--
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

function act_enemies(_enemies, _enemy)
  -- Dim As Integer do_stuff
  --
  -- For do_stuff = 0 To _enemies - 1
  for do_stuff = 0, _enemies - 1 do
  --
  --
  --   With _enemy[do_stuff]
    local with0 = _enemy[do_stuff]

    --NOTE: This is a hack to enable the pointer math in
    --__anger_fireball_circle to work. It addresses this - 1,
    --which in FB would go to the _char_type previous in memory,
    --so to simulate this we tag every object in this loop with the
    --previous one. This will be nil when do_stuff is 0, but the logic
    --in that callback method does not operate, I don't think, in that
    --case.
    with0.prev = _enemy[do_stuff - 1]
  --
  --     If LLObject_IsWithin( Varptr( _enemy[do_stuff] ) ) Then
    if LLObject_IsWithin(with0) ~= 0 then
  --
  --       If ( .seq_paused <> 0 ) And ( llg( seq ) <> 0 ) Then
      if (with0.seq_paused ~= 0) and (ll_global.seq ~= nil) then
  --
  --       Else
      else
  --
  --
  --         .seq_paused = 0
        with0.seq_paused = 0
  --
  --
  --         if .unique_id = u_healthguy then
        if with0.unique_id == u_healthguy then
  --           __healthguy_branch( Varptr( _enemy[do_stuff] ) )
          __healthguy_branch(_enemy[do_stuff])
  --
  --         end if
        end
  --
  --
  --         If .unique_id <> u_sparkle Then
        if with0.unique_id ~= u_sparkle then
  --
  --           Dim As vector_pair target, origin
  --
  --           If .unique_id = u_slimeman Then
  --             If .chap = 255 Then
  --               .mad = 1
  --
  --             End If
  --
  --           End If
  --
  --           If llg( hero ).menu_sel <> 0 Then
          if ll_global.hero.menu_sel ~= 0 then
  --
  --             If ( .unique_id <> u_savepoint ) And ( .unique_id <> u_menu ) Then
            if (with0.unique_id ~= u_savepoint) and (with0.unique_id ~= u_menu) then
  --
  --               Continue For
              goto continue
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --           .last_cycle_ice = .on_ice
          with0.last_cycle_ice = with0.on_ice
  --           .on_ice = 0
          with0.on_ice = 0
  --
  --           check_ice( _enemy[do_stuff] )
          check_ice(_enemy[do_stuff])
  --
  --
  --           If .unique_id = u_core Then
          if with0.unique_id == u_core then
  --             '' Hack Fest!!!!!!!!!!!!
  --
  --             If llg( now )[725] Then
            if ll_global.now[725] ~= 0 then
  --
  --               Dim As Integer enemyIterate, stateConfirm
              local enemyIterate, stateConfirm = 0, 0
  --               stateConfirm = -1
              stateConfirm = -1
  --               Select Case .shifty_state
  --               '' if wave dead then advance
  --                 Case 0
              if with0.shifty_state == 0 then
  --                   .shifty_state += 1
                with0.shifty_state = with0.shifty_state + 1
  --                   For enemyIterate = 5 To 10
                for enemyIterate = 5, 10 do
  --                     now_room().enemy[enemyIterate].trigger = TRUE
                  now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                   Next
                end
  --                   play_sample( sound_turret, 80 )
                ll_global.snd[sound_turret]:setVolume(.8)
                ll_global.snd[sound_turret]:play()
  --                   .unstoppable_by_object = 0
                with0.unstoppable_by_object = 0
  --
  --                 Case 1
              elseif with0.shifty_state == 1 then
  --                   '' 5- 10
  --                   For enemyIterate = 5 To 10
                for enemyIterate = 5, 10 do
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                  stateConfirm = bit.band(stateConfirm, now_room().enemy[enemyIterate].dead)
  --                   Next
                end
  --                   If stateConfirm Then
                if stateConfirm ~= 0 then
  --                     .shifty_state += 1
                  with0.shifty_state = with0.shifty_state + 1
  --                     For enemyIterate = 11 To 18
                  for enemyIterate = 11, 18 do
  --                       now_room().enemy[enemyIterate].trigger = TRUE
                    now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
                  end
  --                     play_sample( sound_turret, 80 )
                  ll_global.snd[sound_turret]:setVolume(.8)
                  ll_global.snd[sound_turret]:play()
  --
  --                   End If
                end
  --
  --                 Case 2
              elseif with0.shifty_state == 2 then
  --                   '' 11 - 18
  --                   For enemyIterate = 11 To 18
                for enemyIterate = 11, 18 do
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                  stateConfirm = bit.band(stateConfirm, now_room().enemy[enemyIterate].dead)
  --                   Next
                end
  --                   If stateConfirm Then
                if stateConfirm ~= 0 then
  --                     .shifty_state += 1
                  with0.shifty_state = with0.shifty_state + 1
  --                     For enemyIterate = 19 To 28
                  for enemyIterate = 19, 28 do
  --                       now_room().enemy[enemyIterate].trigger = TRUE
                    now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
                  end
  --                     play_sample( sound_turret, 80 )
                  ll_global.snd[sound_turret]:setVolume(.8)
                  ll_global.snd[sound_turret]:play()

  --
  --                   End If
                end
  --
  --                 Case 3
              elseif with0.shifty_state == 3 then
  --                   '' 19 - 28
  --                   For enemyIterate = 19 To 28
                for enemyIterate = 19, 28 do
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                  stateConfirm = bit.band(stateConfirm, now_room().enemy[enemyIterate].dead)
  --                   Next
                end
  --                   If stateConfirm Then
                if stateConfirm ~= 0 then
  --                     .shifty_state += 1
                  with0.shifty_state = with0.shifty_state + 1
  --                     For enemyIterate = 29 To 48
                  for enemyIterate = 29, 48 do
  --                       now_room().enemy[enemyIterate].trigger = TRUE
                    now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
                  end
  --                     play_sample( sound_turret, 80 )
                  ll_global.snd[sound_turret]:setVolume(.8)
                  ll_global.snd[sound_turret]:play()

  --
  --                   End If
                end
  --
  --                 Case 4
              elseif with0.shifty_state == 4 then
  --                   '' 29 - 48
  --                   For enemyIterate = 29 To 48
                for enemyIterate = 29, 48 do
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                  stateConfirm = bit.band(stateConfirm, now_room().enemy[enemyIterate].dead)
  --                   Next
                end
  --                   If stateConfirm Then
                if stateConfirm ~= 0 then
  --                     .shifty_state += 1
                  with0.shifty_state = with0.shifty_state + 1
  --                     For enemyIterate = 0 To 7
                  for enemyIterate = 0, 7 do
  --                       .anim[.current_anim]->frame[0].face[enemyIterate].invincible = 0
                    with0.anim[with0.current_anim].frame[0].face[enemyIterate].invincible = 0
  --
  --                     Next
                  end
  --                     .invincible = 0
                  with0.invincible = 0
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .jump_state )
                  LLObject_ShiftState(_enemy[do_stuff], with0.jump_state)
  --
  --                   End If
                end
  --
  --                 Case 5
              elseif with0.shifty_state == 3 then

  --                   '' core vulnerable
  --
  --               End Select
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --
  --           If llg( hero_only ).attacking <> 0 Then
          if ll_global.hero_only.attacking ~= 0 then
  --             LLObject_MAINAttack( 1, Varptr( _enemy[do_stuff] ), Varptr( llg( hero ) ) )
            -- NOTE: The only place this function is called, the count _enemies is passed
            -- in as 1, and the current enemy in act_enemies is passed in as _enemy. Therefore,
            -- we are simplifying this to just pass the enemy in to begin with and eliminate the loop.
            LLObject_MAINAttack(with0, ll_global.hero)
  --
  --           End If
          end
  --
  --
  --           If ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Then
          if (with0.unique_id == u_anger) or (with0.unique_id == u_sterach) then
  --
  --             If .hit <> 0 Then
            if with0.hit ~= 0 then
  --               '' This is how all hit state shifts should be handled.
  --               '' This runs parallel to any running state.
  --               If __anger_flyback( Varptr( _enemy[do_stuff] ) ) <> 0 Then
              if __anger_flyback(_enemy[do_stuff]) ~= 0 then
  --
  --                 .hit = 0
                with0.hit = 0
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --           If ( .unique_id = u_beamcrystal ) Or _
          if (with0.unique_id == u_beamcrystal) or
  --              ( .unique_id = u_boss5_right ) Or _
             (with0.unique_id == u_boss5_right) or
  --              ( .unique_id = u_boss5_down ) Or _
             (with0.unique_id == u_boss5_down) or
  --              ( .unique_id = u_boss5_left ) Or _
             (with0.unique_id == u_boss5_left) or
  --              ( .unique_id = u_boss5_crystal ) Then
             (with0.unique_id == u_boss5_crystal) then
  --
  --             LLObject_ProjectileDamage( now_room().enemies, now_room().enemy, Varptr( _enemy[do_stuff] ) )
            LLObject_ProjectileDamage(now_room().enemies, now_room().enemy, _enemy[do_stuff])
  --
  --           End If
          end
  --
  --
  --           If ( .on_ice <> 0 ) Then
          if (with0.on_ice ~= 0) then
  --
  --             __calc_slide( Varptr( _enemy[do_stuff] ) )
            __calc_slide(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If .on_ice = 0 Then
          if with0.on_ice == 0 then
  --             __stop_grip( Varptr( _enemy[do_stuff] ) )
            __stop_grip(with0)
  --
  --           End If
          end
  --
  --
  --           If .walk_hold = 0 Then
          if with0.walk_hold == 0 then
  --
  --             If .walk_steps = 0 Then
            if with0.walk_steps == 0 then
  --               __momentum_move ( Varptr( _enemy[do_stuff] ) )
              __momentum_move(_enemy[do_stuff])
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --
  --           If  .hurt <> 0 Then
          if with0.hurt ~= 0 then
  --             '' this enemy is showing damage effects
  --
  --             If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
            if (with0.unique_id == u_dyssius) or (with0.unique_id == u_steelstrider) then
  --
  --             Else
            else
  --
  --               If  .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
              if with0.funcs.current_func[with0.funcs.active_state] == with0.funcs.func_count[with0.funcs.active_state] then
  --                 '' the enemy called back (damage is done)
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
                LLObject_ShiftState(_enemy[do_stuff], with0.reset_state)
  --
  --                 If .unique_id = u_ferus Then
                if with0.unique_id == u_ferus then
  --
  --                   LLObject_ClearProjectiles( _enemy[do_stuff] )
                  LLObject_ClearProjectiles(with0)
  --                   .radius = Timer
                  with0.radius = timer
  --
  --
  --                 End If
                end
  --
  --                 If .unique_id = u_grult Then
                if with0.unique_id == u_grult then
  --
  --                   LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
                  LLObject_ShiftState(with0, with0.stun_state)
  --                   .funcs.current_func[.funcs.active_state] = 2
                  with0.funcs.current_func[with0.funcs.active_state] = 2
  --
  --                 End If
                end
  --
  --                 LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
                LLObject_ClearDamage(with0)
  --                 .flash_count = 0
                with0.flash_count = 0
  --                 .flash_timer = 0
                with0.flash_timer = 0
  --                 .invisible = 0
                with0.invisible = 0
  --
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --           If .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
          if with0.funcs.current_func[with0.funcs.active_state] == with0.funcs.func_count[with0.funcs.active_state] then
  --             '' if function block reaches end, return to beginning.
  --
  --             .funcs.current_func[.funcs.active_state] = 0
            with0.funcs.current_func[with0.funcs.active_state] = 0
  --
  --           End If
          end
  --
  --
  --           If .dead = 0 Then
          if with0.dead == 0 then
  --             '' entity is not dead
  --
  --             If .hp <= 0 Then
            if with0.hp <= 0 then
  --               '' entity is below the hp limit (marked for death)
  --
  --
  --
  --               If .dead_sound <> 0 Then
              if with0.dead_sound ~= 0 then
  --                 play_sample( llg( snd )[.dead_sound] )
                ll_global.snd[with0.dead_sound]:play()
  --
  --               End If
              end
  --
  --               LLObject_ShiftState( Varptr( _enemy[do_stuff] ), _enemy[do_stuff].death_state )
              LLObject_ShiftState(with0, with0.death_state)
  --
  --             End If
            end
  --
  --             If .dead = 0 Then
            if with0.dead == 0 then
  --               If .froggy <> 0 Then
              if with0.froggy ~= 0 then
  --                 '' this entity can become mad
  --
  --
  --                 If ( .mad = 0 ) Then
                if (with0.mad == 0) then
  --                   '' entity is not mad
  --
  --                   If ( .funcs.active_state < .reset_state ) Then
                  if (with0.funcs.active_state < with0.reset_state) then
  --
  --                     '' entity is not resetting
  --
  --                     '' implicit proximity detection
  --                     .funcs.active_state = in_proximity( Varptr( _enemy[do_stuff] ) )
                    with0.funcs.active_state = in_proximity(_enemy[do_stuff])
  --
  --                   End If
                  end
  --
  --                 End If
                end
  --
  --               End If
              end
  --
  --               If .mad <> 0 Then
              if with0.mad ~= 0 then
  --                 '' entity is mad
  --
  --                 '' see if its far enough to get a reset
  --                 .funcs.active_state = out_proximity( Varptr( _enemy[do_stuff] ) )
                with0.funcs.active_state = out_proximity(_enemy[do_stuff])
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --           If .projectile Then
          if with0.projectile ~= 0 then
  --             If .projectile->active <> 0 Then
            if with0.projectile.active ~= 0 then
  --               '' projectile triggered
  --
  --               __do_proj ( Varptr( _enemy[do_stuff] ) )
              __do_proj(_enemy[do_stuff])
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --           If .unique_id = u_ferus Then
  --
  --             if .radius = 0 then
  --               .radius = Timer + 3 + ( Rnd * 3 )
  --
  --             end if
  --
  --             If Timer > .radius Then
  --
  --               .radius = 0
  --               __trigger_projectile( Varptr( _enemy[do_stuff] ) )
  --
  --
  --             End If
  --
  --
  --
  --           End If
  --
  --
  --           If .pushable <> 0 Then
          if with0.pushable ~= 0 then
  --             '' the entity is pushable
  --
  --             __push ( Varptr( _enemy[do_stuff] ) )
            __push(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If .vol_fade_trig <> 0 Then
  --             '' projectile triggered
  --
  --             __do_vol_fade ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If llg( seq ) = 0 Then
          if ll_global.seq == nil then
  --             '' no sequence happening already
  --
  --
  --             If llg( hero ).switch_room = -1 Then
            if ll_global.hero.switch_room == -1 then
  --
  --               If .action_sequence <> 0 Then
              if with0.action_sequence ~= 0 then
  --                 '' ths entity loads a sequence when you action it
  --
  --                 If llg( hero_only ).action <> 0 Then
                if ll_global.hero_only.action ~= 0 then
  --
  --                   LLObject_ActionSequence( Varptr( _enemy[do_stuff] ) )
                  LLObject_ActionSequence(_enemy[do_stuff])
  --
  --                 End If
                end
  --
  --
  --               End If
              end
  --
  --
  --
  --
  --               If .touch_sequence <> 0 Then
              if with0.touch_sequence ~= 0 then
  --                 '' ths entity loads a sequence when you touch it
  --
  --                 LLObject_TouchSequence( Varptr( _enemy[do_stuff] ) )
                LLObject_TouchSequence(with0)
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --           If .grult_proj_trig <> 0 Then
          if with0.grult_proj_trig ~= 0 then
  --
  --
  --             '' projectile triggered (concurrent functionality)
  --             __do_grult_proj ( Varptr( _enemy[do_stuff] ) )
            __do_grult_proj(_enemy[do_stuff])
  --
  --             LLObject_CheckGTorchLit( Varptr( _enemy[do_stuff] ) )
            LLObject_CheckGTorchLit(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --
  --           If .anger_proj_trig <> 0 Then
          if with0.anger_proj_trig ~= 0 then
  --             __do_anger_proj ( Varptr( _enemy[do_stuff] ) )
            __do_anger_proj(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If .unique_id = u_grult Then
          if with0.unique_id == u_grult then
  --
  -- '              If .funcs.active_state <> .stun_state Then
  --             If .funcs.active_state = 0 Or ( .funcs.active_state = .proj_state )Then
            if with0.funcs.active_state == 0 or (with0.funcs.active_state == with0.proj_state) then
  --
  --
  --               If llg( dark ) <> 4 Then
              if ll_global.dark ~= 4 then
  --                 '' stunned
  --
  --                 .stun_return_trig = 0
                with0.stun_return_trig = 0
  --                 LLObject_ClearProjectiles( _enemy[do_stuff] )
                LLObject_ClearProjectiles(_enemy[do_stuff])
  --                 .fly_timer = 0
                with0.fly_timer = 0
  --                 .fly_count = 0
                with0.fly_count = 0
  --                 .grult_proj_trig = 0
                with0.grult_proj_trig = 0
  --
  --
  --                 .jump_counter = 0
                with0.jump_counter = 0
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
                LLObject_ShiftState(_enemy[do_stuff], with0.stun_state)
  --
  --               End If
              end
  --
  --             Else'If (.funcs.active_state = .stun_state) Or (.funcs.active_state = .hit_state) Then
            else
  --
  --
  --               If (.stun_return_trig = 0) Then
              if (with0.stun_return_trig == 0) then
  --
  -- '                    If now_room().dark = 4 Then
  --                 If llg( dark ) = 4 Then
                if ll_global.dark == 4 then
  --                   .stun_return_trig = 1
                  with0.stun_return_trig = 1
  --
  --                 End If
                end
  --                   '' un-stunned!
  --
  --                 If .stun_return_trig = 1 Then
                if with0.stun_return_trig == 1 then
  --
  --                   If .dead = 0 Then
                  if with0.dead == 0 then
  --
  --                     .jump_counter = 0
                    with0.jump_counter = 0
  --
  --                     .hurt = 0
                    with0.hurt = 0
  --
  --
  --                     LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
                    LLObject_ClearDamage(_enemy[do_stuff])
  --
  --                     .fly_count = 0
                    with0.fly_count = 0
  --                     .fly_timer = 0
                    with0.fly_timer = 0
  --                     .flash_timer = 0
                    with0.flash_timer = 0
  --                     .invisible = 0
                    with0.invisible = 0
  --                     .mad =  0
                    with0.mad = 0
  --
  --                     .invincible = -1
                    with0.invincible = -1
  --
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
                    LLObject_ShiftState(_enemy[do_stuff], with0.reset_state)
  --
  --
  --
  --
  --                   End If
                  end
  --
  --                 End If
                end
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --
  --           If .spawn_cond <> 0 Then
          if with0.spawn_cond ~= 0 then
  --             LLObject_CheckSpawn( Varptr( _enemy[do_stuff] ) )
            LLObject_CheckSpawn(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If .unique_id = u_gbutton Then
          if with0.unique_id == u_gbutton then
  --
  --             Dim As LLObject_CollisionType collisionCheck
            local collisionCheck = create_LLObject_CollisionType()

  --             Dim As Integer buttonSet, rockCheck
            local buttonSet, rockCheck = 0, 0
  --
  --             collisionCheck = LLObject_Collision( llg( hero ), _enemy[do_stuff] )
            collisionCheck = LLObject_Collision(ll_global.hero, _enemy[do_stuff])
  --             If collisionCheck.isColliding = -1 Then
            if collisionCheck.isColliding == -1 then
  --               buttonSet = -1
              buttonSet = -1
  --
  --             End If
            end
  --
  --             If buttonSet = 0 Then
            if buttonSet == 0 then
  --
  --               For rockCheck = 0 To now_room().enemies - 1
              for rockCheck = 0, now_room().enemies - 1 do
  --
  --                 If now_room().enemy[rockCheck].unique_id = u_pushrock Then
                if now_room().enemy[rockCheck].unique_id == u_pushrock then
  --                   collisionCheck = LLObject_Collision( now_room().enemy[rockCheck], _enemy[do_stuff] )
                  collisionCheck = LLObject_Collision(now_room().enemy[rockCheck], _enemy[do_stuff])
  --                   If collisionCheck.isColliding = -1 Then
                  if collisionCheck.isColliding == -1 then
  --                     buttonSet = -1
                    buttonSet = -1
  --                     Exit For
                    break
  --
  --                   End If
                  end
  --
  --                 End If
                end
  --
  --               Next
              end
  --
  --             End If
            end
  --
  --             .funcs.active_state = IIf( buttonSet, 1, 0 )
            with0.funcs.active_state = iif(buttonSet ~= 0, 1, 0)
  --
  --
  --
  --
  --           End If
          end
  --
  --           If ( .unique_id = u_gold ) Or ( .unique_id = u_silver ) Or ( .unique_id = u_health ) Then
          if (with0.unique_id == u_gold) or (with0.unique_id == u_silver) or (with0.unique_id == u_health) then
  --             '' this is loot to pick up
  --
  --             LLObject_GrabItems( Varptr( _enemy[do_stuff] ) )
            LLObject_GrabItems(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If .unique_id = u_ltorch Then
          if with0.unique_id == u_ltorch then
  --
  --             LLObject_TorchModify( Varptr( _enemy[do_stuff] ) )
            LLObject_TorchModify(_enemy[do_stuff])
  --
  --           End If
          end
  --
  --           If  .dmg.id <> 0 Then
          if with0.dmg.id ~= 0 then
  --             '' enemy was hit by lynn
  --
  --             __flashy( Varptr( _enemy[do_stuff] ) )
            __flashy(with0)
  --
  --           End If
          end
  --
  --
  --           If Timer > .walk_hold Then .walk_hold = 0
          if timer > with0.walk_hold then with0.walk_hold = 0 end
  --
  --
  --
  --             If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
          if with0.animControl[with0.current_anim].frame[with0.frame].concurrents ~= 0 then
  --
  --               LLEngine_ExecuteConcurrents( Varptr( _enemy[do_stuff] ) )
            LLEngine_ExecuteConcurrents(_enemy[do_stuff])
  --
  --
  --             End If
          end
  --
  --           If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
          if (with0.unique_id == u_dyssius) or (with0.unique_id == u_steelstrider) then
  --
  --             If .dead = 0 Then
            if with0.dead == 0 then
  --
  --               If .sway <> 0 Then
              if with0.sway ~= 0 then
  --
  --                 If Timer > .sway Then
                if timer > with0.sway then
  --                   __dyssius_jump_slide( Varptr( _enemy[do_stuff] ) )
                  __dyssius_jump_slide(_enemy[do_stuff])
  --                   .sway = 0
                  with0.sway = 0
  --
  --                   .fly_count = 0
                  with0.fly_count = 0
  --                   .fly_timer = 0
                  with0.fly_timer = 0
  --                   .flash_timer = 0
                  with0.flash_timer = 0
  --                   .invisible = 0
                  with0.invisible = 0
  --                   .hurt = 0
                  with0.hurt = 0
  --
  --                   If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
                  if (with0.projectile.coords[0].x ~= 0) or (with0.projectile.coords[0].y ~= 0) then
  --
  --                     LLObject_ClearProjectiles( _enemy[do_stuff] )
                    LLObject_ClearProjectiles(_enemy[do_stuff])
  --
  --                   End If
                  end
  --
  --                 End If
                end
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --         End If
        end
  --
  --         .funcs.current_func[.funcs.active_state] += .funcs.func[.funcs.active_state][.funcs.current_func[.funcs.active_state]] ( VarPtr( _enemy[do_stuff] ) )
        local result = with0.funcs.func[with0.funcs.active_state][with0.funcs.current_func[with0.funcs.active_state]](with0)
        with0.funcs.current_func[with0.funcs.active_state] = with0.funcs.current_func[with0.funcs.active_state] + result
  --
  --       End If
      end
  --
  --     End If
    end
  --
  --   End With
  --
  -- Next
    ::continue::
  end
  --
  -- If _enemy = Varptr( now_room().temp_enemy( 0 ) ) Then
  --   maintain_temps( Varptr( now_room() ) )
  --
  -- End If

end

-- Sub update_cam( mn As char_type Ptr = 0 )
function update_cam(mn)
--
--   If mn = 0 Then mn = Varptr( llg( hero ) )
  mn = mn or ll_global.hero
--
--   Dim As Integer cam_x, cam_y
  local cam_x, cam_y = 0, 0
--
--   With ll_global
--
--     cam_x = mn->coords.x - ( ( ( .sx ) - ( mn->perimeter.x Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
  cam_x = mn.coords.x - (bit.rshift((ll_global.sx) - bit.rshift(mn.perimeter.x, 1), 1)) - 1
--     If cam_x < 0 Then cam_x = 0
  if cam_x < 0 then cam_x = 0 end
--     If cam_x > ( now_room().x Shl 4 ) - .sx Then cam_x = ( now_room().x Shl 4 ) - .sx '' mul tileX, multileX
  if cam_x > bit.lshift(now_room().x, 4) - ll_global.sx then
    cam_x = bit.lshift(now_room().x, 4) - ll_global.sx
  end
--
--     cam_y = mn->coords.y - ( ( ( .sy ) - ( mn->perimeter.y Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
  cam_y = mn.coords.y - (bit.rshift((ll_global.sy) - bit.rshift(mn.perimeter.y, 1), 1)) - 1
--     If cam_y < 0 Then cam_y = 0
  if cam_y < 0 then cam_y = 0 end
--      If cam_y > ( now_room().y Shl 4 ) - .sy Then cam_y = ( now_room().y Shl 4 ) - .sy '' mul tileY, mul tileY
  if cam_y > bit.lshift(now_room().y, 4) - ll_global.sy then
    cam_y = bit.lshift(now_room().y, 4) - ll_global.sy
  end
--
--     .this_room.cx = cam_x
  ll_global.this_room.cx = cam_x
--     .this_room.cy = cam_y
  ll_global.this_room.cy = cam_y
--
--
--   End With
--
--
-- End Sub
end

--Function move_object( o As char_type Ptr, only_looking As Integer = 0, moment As Double = 1, recurring As Integer = 0 ) As uInteger
function move_object(o, only_looking, moment, recurring)
  only_looking = only_looking or 0
  moment = moment or 1
  recurring = recurring or 0
    -- Dim As Integer mx, my '' holds open axes
  local mx, my = 0, 0

    --
    -- Select Case o->direction
    --
    --   Case 0
  if o.direction == 0 then
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or (o.unstoppable_by_screen ~= 0) then
    --       '' object "y" is bigger than 0, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        local cae = check_against_entities(0, o)
        if cae ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
  end
    --   Case 1
  if o.direction == 1 then
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or (o.unstoppable_by_screen ~= 0) then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 1 or o.unstoppable_by_object ~= 0 then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
  end
    --   Case 2
  if o.direction == 2 then
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen ~= 0) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 3
  if o.direction == 3 then
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or (o.unstoppable_by_screen ~= 0) then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 4
  if o.direction == 4 then
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or (o.unstoppable_by_screen ~= 0) then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or (o.unstoppable_by_screen ~= 0) then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 5
  if o.direction == 5 then
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or (o.unstoppable_by_screen ~= 0) then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or (o.unstoppable_by_screen ~= 0) then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 6
  if o.direction == 6 then
    --
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen ~= 0) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or (o.unstoppable_by_screen ~= 0) then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 7
  if o.direction == 7 then
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen ~= 0) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    end
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or (o.unstoppable_by_screen ~= 0) then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, (only_looking ~= 0) or (recurring ~= 0)) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object ~= 0) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --
    -- Return ( mx Shl 16 ) Or my
  return bit.bor(bit.lshift(mx, 16), my)

end

  -- Function check_walk ( o As char_type Ptr, d As Integer, psfing = 0 ) Static
function check_walk(o, d, psfing)
  psfing = psfing or 0
  --
  --   If ( o->coords.x < 0 ) Or ( o->coords.y < 0 ) Or ( ( o->coords.x + o->perimeter.x ) > ( now_room().x Shl 4 ) ) Or ( ( o->coords.y + o->perimeter.y ) > ( now_room().y Shl 4 ) ) Then
  if (o.coords.x < 0) or (o.coords.y < 0) or ((o.coords.x + o.perimeter.x) > bit.lshift(now_room().x, 4)) or ((o.coords.y + o.perimeter.y) > bit.lshift(now_room().y, 4)) then
  --     Return FALSE
    return false
  --
  --   End If
  end
  --
  --
  --   Dim As Integer x_offset_2, y_offset_2, x_tile_2, y_tile_2, quads_x, quads_y, x_aligned, y_aligned
  --   dim as= integer t_index
  local t_index
  --   Dim As Integer layer
  local layer
  --   Dim As Integer crawl_axis, crawl
  local crawl_axis, crawl
  --   Dim As Integer x_opt, y_opt
  local x_opt, y_opt
  --   Dim As Integer tile_free, psf_free
  local tile_free, psf_free = true, true
  --
  --   x_aligned = 0
  local x_aligned = 0
  --   y_aligned = 0
  local y_aligned = 0
  --
  --   x_tile_2 = Int( o->coords.x ) Shr 3
  local x_tile_2 = bit.rshift(math.floor(o.coords.x), 3)
  --   y_tile_2 = Int( o->coords.y ) Shr 3
  local y_tile_2 = bit.rshift(math.floor(o.coords.y), 3)
  --
  --   x_offset_2 = Int( o->coords.x ) And 7
  local x_offset_2 = bit.band(math.floor(o.coords.x), 7)
  --   y_offset_2 = Int( o->coords.y ) And 7
  local y_offset_2 = bit.band(math.floor(o.coords.y), 7)
  --
  --   quads_x = Int( o->perimeter.x ) Shr 3
  local quads_x = bit.rshift(math.floor(o.perimeter.x), 3)
  --   quads_y = Int( o->perimeter.y ) Shr 3
  local quads_y = bit.rshift(math.floor(o.perimeter.y), 3)
  --
  --   If x_offset_2 <> 0 Then
  if x_offset_2 ~= 0 then
  --     quads_x += 1
    quads_x = quads_x + 1
  --
  --   Else
  else
  --     x_aligned = 1
    x_aligned = 1
  --
  --   End If
  end
  --
  --   If y_offset_2 <> 0 Then
  if y_offset_2 ~= 0 then
  --     quads_y += 1
    quads_y = quads_y + 1
  --
  --   Else
  else
  --     y_aligned = 1
    y_aligned = 1
  --
  --   End If
  end
  --
  --   '' prime
  --   if psfing then
  if psfing ~= 0 then
  --     psf_free = TRUE
    psf_free = true
  --
  --   else
  else
  --     tile_free = TRUE
    tile_free = true
  --
  --   end if
  end
  --
  --     Select Case d Mod 2
  --
  --       Case 0
  if d % 2 == 0 then
  --
  --         crawl_axis = quads_x
    crawl_axis = quads_x
  --
  --       Case 1
  elseif d % 2 == 1 then
  --
  --         crawl_axis = quads_y
    crawl_axis = quads_y
  --
  --     End Select
  end
  --
  --
  --     For layer = 0 To 2
  for layer = 0, 2 do
  --
  --
  --       For crawl = 0 To crawl_axis - 1
    for crawl = 0, crawl_axis - 1 do
  --
  --
  --         Select Case d
  --
  --
  --           Case 0
      if d == 0 then
  --
  --             x_opt = ( x_tile_2 + crawl )
        x_opt = (x_tile_2 + crawl)
  --             y_opt = ( y_tile_2 - y_aligned )
        y_opt = (y_tile_2 - y_aligned)
  --
  --           Case 1
      elseif d == 1 then
  --
  --             x_opt = ( quads_x - 1 ) + x_tile_2 + x_aligned
        x_opt = (quads_x - 1) + x_tile_2 + x_aligned
  --             y_opt = ( y_tile_2 + crawl )
        y_opt = (y_tile_2 + crawl)
  --
  --           Case 2
      elseif d == 2 then
  --
  --             x_opt = ( x_tile_2 + crawl )
        x_opt = (x_tile_2 + crawl)
  --             y_opt = ( quads_y - 1 ) + y_tile_2 + y_aligned
        y_opt = (quads_y - 1) + y_tile_2 + y_aligned
  --
  --           Case 3
      elseif d == 3 then
  --
  --             x_opt = ( x_tile_2 - x_aligned )
        x_opt = (x_tile_2 - x_aligned)
  --             y_opt = ( y_tile_2 + crawl )
        y_opt = (y_tile_2 + crawl)
  --
  --
  --         End Select
      end
  --
  --         t_index = ( ( y_opt Shl 3 ) Shr 4 ) * now_room().x + ( ( x_opt Shl 3 ) Shr 4 )
      t_index = bit.rshift(bit.lshift(y_opt, 3), 4) * now_room().x + bit.rshift(bit.lshift(x_opt, 3), 4) + 1
  --
  --         If Bit( now_room().layout[layer][t_index], 15 - quad_calc( x_opt, y_opt ) ) <> 0 Then
      local tile = now_room().layout[layer][t_index]
      local quad = quad_calc(x_opt, y_opt)
      local bit_index = 15 - quad
      if testbit(tile, bit_index) ~= 0 then
  --           if psfing then
        if psfing ~= 0 then
  --             psf_free = FALSE
          psf_free = false
  --
  --           else
        else
  --             tile_free = FALSE
          tile_free = false
  --
  --           end if
        end
  --
  --         End If
      else
      end
  --
  --       Next
    end
  --
  --     Next
  end
  --
  --
  --   If tile_free = FALSE Then
  if tile_free == false then
  --
  --     If psfing = FALSE Then
    if psfing == 0 then
  --
  --       If o->unique_id = u_lynn Then
      if o.unique_id == u_lynn then
  --         check_psf( o, d )
        check_psf(o, d)
  --
  --       Else
      else
  --         If o->unique_id = u_pushrock Then
        if o.unique_id == u_pushrock then
  --           check_psf( o, d )
          check_psf(o, d)
  --
  --         End If
        end
  --
  --       End If
      end
  --
  --     End If
    end
  --
  --   End If
  end
  --
  --
  --   if psfing then

  if psfing ~= 0 then
  --     Return psf_free
    return psf_free
  --   else
  else
  --
  --     Return tile_free
    return tile_free
  --   end if
  end
  --
  --
  --
  -- End Function

end

-- Function check_against_entities( d As Integer = 0, o As char_type Ptr ) As Integer' Static
function check_against_entities(d, o)
  d = d or 0
--
--
--   Dim As Integer cycle, relay
  local cycle, relay = 0, 0
--
--
--   With now_room()
  local with0 = now_room()
--
--     If .enemies = 0 Then
  if with0.enemies == 0 then
--       '' there are no objects to collide with in this room
--       Return 0
    return 0
--
--     End If
  end
--
--     For cycle = 0 To .enemies - 1
  for cycle = 0, with0.enemies - 1 do
--       '' cycle thru enemies
--
--       If o->num <> .enemy[cycle].num Then
    if o.num ~= with0.enemy[cycle].num then
--         '' if this "o" isn't this enemy, then check it against this enemy
--         relay = check_against( o, .enemy, cycle, d )
      relay = check_against({[0] = o}, with0.enemy, cycle, d)
--         If relay Then Return relay
      if relay ~= 0 then return relay end
--
--       End If
    end
--
--     Next
  end
--
--
--
--     For cycle = 0 To .temp_enemies - 1
  for cycle = 0, with0.temp_enemies - 1 do
--       '' cycle through temp enemies
--
--       If o->num <> .temp_enemy( cycle ).num Then
    if o.num ~= with0.temp_enemy[cycle].num then
--         '' if this "o" isn't this temp enemy, then check it against this temp enemy
--         relay = check_against( o, Varptr( .temp_enemy( 0 ) ), cycle, d )
      relay = check_against({[0] = o}, with0.temp_enemy, cycle, d)
--         If relay Then Return relay
      if relay ~= 0 then return relay end
--
--       End If
    end
--
--     Next
  end
--
--   End With
--
--
--
--   If o->unique_id <> u_lynn Then
  if o.unique_id ~= u_lynn then
--     '' if this "o" isn't lynn, check the "o" against her
--
--     If llg( hero_only ).attacking = 0 Then
    if ll_global.hero_only.attacking == 0 then
--       relay = check_against( o, Varptr( llg( hero ) ), 0, d )
      relay = check_against({[0] = o}, {[0] = ll_global.hero}, 0, d)
--       If relay Then Return relay
      if relay ~= 0 then return relay end
--
--     End If
    end
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function check_against( o As char_type Ptr, othr As char_type Ptr, check As Integer, d As Integer ) Static
function check_against(o, othr, check, d)
--
--
--   #Define LLObject_Impassable(__THISCHAR__,__FACE__)          _
  function LLObject_Impassable(__THISCHAR__, __FACE__)
    --NOTE: There had been a tenary operator here
    --and the problem with how I ported iif is that it evaluates both
    --arguments always, which causes a crash here if faces == 0. So we might
    --have to look out for more bugs wherever iif is used for this reason. We
    --may have to go back to Lua's ternary idiom directly.
    if __THISCHAR__.anim[__THISCHAR__.current_anim].frame[LLObject_CalculateFrame(__THISCHAR__)].faces == 0 then
      return __THISCHAR__.impassable
    else
      return __THISCHAR__.anim[__THISCHAR__.current_anim].frame[LLObject_CalculateFrame(__THISCHAR__)].face[__FACE__].impassable
    end
  end
--
--
--   '' moving object to static object collision detection
--
  --NOTE: Function = 0 sets return value to 0, but we just return 0
  --at the end instead---Should work the same, but just keeping this
  --note here in case...
--   Function = 0
--
--   Dim As Vector opty
  local opty = get_next_vector()
--   Dim As vector_pair m, n
  local m, n = get_next_vector_pair(), get_next_vector_pair()
--   Dim As Integer faces, faces2
  local faces, faces2 = 0, 0
--   Dim As Integer check_fields, check_fields2
  local check_fields, check_fields2 = 0, 0
--
--   dim as integer res
--   res = 0
  local res = 0
--
--   opty.x = 0
  opty.x = 0
--   opty.y = 0
  opty.y = 0
--
--   Select Case d
--
--     Case 0
  if d == 0 then
--       opty.y = -1
    opty.y = -1
--
--     Case 1
  elseif d == 1 then
--       opty.x = 1
    opty.x = 1
--
--     Case 2
  elseif d == 2 then
--       opty.y = 1
    opty.y = 1
--
--     Case 3
  elseif d == 3 then
--       opty.x = -1
    opty.x = -1
--
--
--   End Select
  end
--
--   o->frame_check          = LLObject_CalculateFrame( o[0] )
  o[0].frame_check = LLObject_CalculateFrame(o[0])
--   othr[check].frame_check = LLObject_CalculateFrame( othr[check] )
  othr[check].frame_check = LLObject_CalculateFrame(othr[check])
--
--   With othr[check]:
  local with0 = othr[check]
--     With .anim[.current_anim]->frame[.frame_check]:
  local with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--       faces  = IIf( .faces = 0, 0, .faces -1 ):
  faces = (with1.faces == 0) and 0 or with1.faces - 1
--     End With:
--   End With

--   With *( o )     :
  with0 = o[0]
--     With .anim[.current_anim]->frame[.frame_check]:
  with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--       faces2 = IIf( .faces = 0, 0, .faces -1 ):
  faces2 = (with1.faces == 0) and 0 or with1.faces - 1
--     End With:
--   End With
--
--   For check_fields = 0 To faces
  for check_fields = 0, faces do
--
--     For check_fields2 = 0 To faces2
    for check_fields2 = 0, faces2 do
--
--       m.u = V2_Add( o->coords, opty )
      m.u = V2_Add(o[0].coords, opty)
--       n.u = othr[check].coords
      n.u.x = othr[check].coords.x
      n.u.y = othr[check].coords.y
--
--       calc_positions( o, m, check_fields2 )
      calc_positions(o[0], m, check_fields2)

--       calc_positions( Varptr( othr[check] ), n, check_fields )
      calc_positions(othr[check], n, check_fields)
--
--
--       If check_bounds( m, n ) = 0 Then
      if check_bounds(m, n) == 0 then
--
--         If o->unique_id = u_charger Then
        if o.unique_id == u_charger then
--
--           If othr[check].unique_id = u_charger Then
          if othr[check].unique_id == u_charger then
--             '' kill both!
--
--             o->hp = 0
            o[0].hp = 0
--             othr[check].hp = 0
            othr[check].hp = 0
--
--             return 0
            return 0
--
--           End If
          end
--
--         End If
        end
--
        local impassable = 0
        if                                            (
                    --                                  ( LLObject_Impassable( o[0], check_fields2 ) = 0 ) And ( LLObject_Impassable( othr[check], check_fields ) = 0 )      _
                                                        ( LLObject_Impassable( o[0], check_fields2) == 0 ) and ( LLObject_Impassable( othr[check], check_fields) == 0 )
                    --                                                                              Or                                                                       _
                                                                                                    or
                    --                                         ( ( o[0].dead ) Or ( othr[check].dead ) Or ( othr[check].unique_id = u_gold ) )                               _
                                                               ( ( o[0].dead ~= 0 ) or ( othr[check].dead ~= 0 ) or (othr[check].unique_id == u_gold ) )
                    --                                ),                                                                                                                     _
                                                      ) then
          if                                                 (
                      --                                       ( Not ( othr[check].unique_id = u_chest         ) ) And                                                         _
                                                               ( not ( othr[check].unique_id == u_chest        ) ) and
                      --                                       ( Not ( othr[check].unique_id = u_bluechest     ) ) And                                                         _
                                                               ( not ( othr[check].unique_id == u_bluechest    ) ) and
                      --                                       ( Not ( othr[check].unique_id = u_bluechestitem ) )                                                             _
                                                               ( not (othr[check].unique_id == u_bluechestitem ) )
                      --                                     ),                                                                                                                _
                                                             ) then
            impassable = 0
          else
            impassable = 1
          end
        else
          if (othr[check].unique_id == u_sparkle ) or (othr[check].unique_id == u_gbutton ) or (o[0].unique_id == u_godstat ) then
            impassable = 0
          else
            impassable = 1
          end
        end

        if (( o[0].unique_id == u_dyssius ) or (o[0].unique_id == u_steelstrider ) ) and (othr[check].unique_id == u_lynn ) then
          res = 1
        else
          if impassable ~= 0 then
            if othr[check].unstoppable_by_object ~= 0 then
              res = 0
            else
              if o[0].unstoppable_by_object ~= 0 then
                res = 0
              else
                res = 1
              end
            end
          else
            res = 0
          end
        end
--
--         If res = 1 Then
        if res == 1 then
--
--           return res
          return res
--
--         end if
        end

      -- End If
      end
--
--     Next
    end
--
--   Next
  end
--
--
  return 0
-- End Function
end

-- Sub calc_positions( obj As char_type Ptr, v As vector_pair, _face As Integer )
function calc_positions(obj, v, _face)
--
--   With obj->anim[obj->current_anim]->frame[obj->frame_check]
  local with0 = obj.anim[obj.current_anim].frame[obj.frame_check]
--
--     If .faces = 0 Then
  if with0.faces == 0 then
--
--       v.v = obj->perimeter
    v.v.x = obj.perimeter.x
    v.v.y = obj.perimeter.y
--
--     Else
  else
--
--       v.u.x += .face[_face].x - obj->animControl[obj->current_anim].x_off
    v.u.x = v.u.x + with0.face[_face].x - obj.animControl[obj.current_anim].x_off
--       v.u.y += .face[_face].y - obj->animControl[obj->current_anim].y_off
    v.u.y = v.u.y + with0.face[_face].y - obj.animControl[obj.current_anim].y_off
--
--       v.v.x = .face[_face].w
    v.v.x = with0.face[_face].w
--       v.v.y = .face[_face].h
    v.v.y = with0.face[_face].h
--
--     End If
  end
--
--   End With
--
-- End Sub
end

-- Sub check_psf( o As char_type Ptr, d As Integer )
function check_psf(o, d)
--
--
--   Dim As Integer layercheck, pnts, tmp_dir, po_x, po_y, pol, tmp_d
  local layercheck, pnts, tmp_dir, po_x, po_y, pol, tmp_d = 0, 0, 0, 0, 0, 0, 0
--   Dim As Integer tx_2 = ( 8 ), ty_2 = ( 8 )
  local tx_2, ty_2 = 8, 8
--   Dim As Integer x_crawl, y_crawl
  local x_crawl, y_crawl = 0, 0
--
--   in_dir_small( d )
  d = in_dir_small(d)
--
--   tmp_dir = o->direction
  tmp_dir = o.direction
--   tmp_d = d
  tmp_d = d
--
--   If ( d And 1 ) = 0 Then
  if bit.band(d, 1) == 0 then
--     If rl_key() Then Exit sub
    if rl_key() then
      return
    end
--     pnts = ( o->perimeter.x Shr 3 ) '' div tx_2
    pnts = bit.rshift(o.perimeter.x, 3)
--     x_crawl = tx_2
    x_crawl = tx_2
--
--   Else
  else
--     If ud_key() Then Exit Sub
    if ud_key() then
      return
    end
--     pnts = ( o->perimeter.y Shr 3 ) '' div ty_2
    pnts = bit.rshift(o.perimeter.y, 3)
--     y_crawl = ty_2
    y_crawl = ty_2
--
--   End If
  end
--
--   po_x = Int( o->coords.x )
  po_x = math.floor(o.coords.x)
--   po_y = Int( o->coords.y )
  po_y = math.floor(o.coords.y)
--
--   Select Case d
--
--     Case 0
--
--     Case 1
  if d == 1 then
--
--       po_x += Int( o->perimeter.x ) - tx_2
    po_x = po_x + math.floor(o.perimeter.x) - tx_2
--
--     Case 2
  elseif d == 2 then
--
--       po_x += Int( o->perimeter.x )
    po_x = po_x + math.floor(o.perimeter.x)
--       po_y += Int( o->perimeter.y ) - ty_2
    po_y = po_y + math.floor(o.perimeter.y) - ty_2
--
--     Case 3
  elseif d == 3 then
--
--       po_y += Int( o->perimeter.y )
    po_y = po_y + math.floor(o.perimeter.y)
--
--
--   End Select
  end
--
--
--   Select Case d Shr 1
--
--     Case 0
  if bit.rshift(d, 1) == 0 then
--
--       pol = 1
    pol = 1
--
--     Case Else
  else
--
--       pol = -1
    pol = -1
--
--   End Select
  end
--
--
--   For layercheck = 0 To 2
  for layercheck = 0, 2 do
--
--     Dim As tile_quad slider, chkr
    local slider, chkr = create_tile_quad(), create_tile_quad()
--     Dim As Integer crawl, x_opt, y_opt, po_quad, mi_quad, op_quad
    local crawl, x_opt, y_opt, po_quad, mi_quad, op_quad = 0, 0, 0, 0, 0, 0
--
--     crawl = 0
    crawl = 0
--
--     x_opt = ( crawl * x_crawl * pol ) + po_x
    x_opt = (crawl * x_crawl * pol) + po_x
--     y_opt = ( crawl * y_crawl * pol ) + po_y
    y_opt = (crawl * y_crawl * pol) + po_y
--
--     slider.x = ( x_opt ) Shr 4 '' div tileX
    slider.x = bit.rshift(x_opt, 4)
--     slider.y = ( y_opt ) Shr 4 '' div tileY
    slider.y = bit.rshift(y_opt, 4)
--     slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2
    slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--     chkr = quad_seek( slider, d )
    chkr = quad_seek(slider, d)
--     po_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
    po_quad = testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad)
--
--
--     For crawl = 1 To pnts - 1
    for crawl = 1, pnts - 1 do
--
--       x_opt = ( crawl * x_crawl * pol ) + po_x
      x_opt = (crawl * x_crawl * pol) + po_x
--       y_opt = ( crawl * y_crawl * pol ) + po_y
      y_opt = (crawl * y_crawl * pol) + po_y
--
--       slider.x = ( x_opt ) Shr 4 '' div tileX
      slider.x = bit.rshift(x_opt, 4)
--       slider.y = ( y_opt ) Shr 4 '' div tileY
      slider.y = bit.rshift(y_opt, 4)
--       slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2
      slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--       chkr = quad_seek( slider, d )
      chkr = quad_seek(slider, d)

--       mi_quad Or = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
      mi_quad = bit.bor(mi_quad, testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad))
--
--     Next
    end
--
--     '' unnecessary syntactically, but it's clarification that counts, kids.
--     crawl = pnts
    crawl = pnts
--
--     x_opt = ( crawl * x_crawl * pol ) + po_x
    x_opt = (crawl * x_crawl * pol) + po_x
--     y_opt = ( crawl * y_crawl * pol ) + po_y
    y_opt = (crawl * y_crawl * pol) + po_y
--
--     slider.x = ( x_opt ) Shr 4
    slider.x = bit.rshift(x_opt, 4)
--     slider.y = ( y_opt ) Shr 4
    slider.y = bit.rshift(y_opt, 4)
--     slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 )
    slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--     chkr = quad_seek( slider, d )
    chkr = quad_seek(slider, d)
--     op_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
    op_quad = testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad)
--
--
--     d = tmp_d
    d = tmp_d
--     '' got all the quads
--
--
--     If ( po_quad <> 0 ) And ( op_quad <> 0 ) Then
    if (po_quad ~= 0) and (op_quad ~= 0) then
--       Exit sub
      return
--
--     End If
    end
--
--
--     If ( po_quad <> 0 ) And ( op_quad = 0 ) Then
    if (po_quad ~= 0) and (op_quad == 0) then
--     '' clockwise
--       o->direction += 1
      o.direction = o.direction + 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--
--     If ( po_quad = 0 ) And ( op_quad <> 0 ) Then
    if po_quad == 0 and op_quad ~= 0 then
--       '' counter clockwise
--       o->direction -= 1
      o.direction = o.direction - 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--
--     If ( po_quad = 0 ) And ( op_quad = 0 ) And ( mi_quad <> 0 ) Then
    if (po_quad == 0) and (op_quad == 0) and (mi_quad ~= 0) then
--     '' clockwise
--       o->direction += 1
      o.direction = o.direction + 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--   Next
  end
--
-- End Sub
end
--
--
--
--
-- Function quad_seek( t_in As tile_quad, d As Integer ) As tile_quad
function quad_seek(t_in, d)
--
--   Dim As Integer opt, to_quad, to_tile_x, to_tile_y
  local opt, to_quad, to_tile_x, to_tile_y = 0, 0, 0, 0
--
--   to_tile_x = t_in.x
  to_tile_x = t_in.x
--   to_tile_y = t_in.y
  to_tile_y = t_in.y
--
--   Select Case As Const d
--
--     Case 0
  if d == 0 then
--
--       opt = -2
    opt = -2
--
--     Case 1
  elseif d == 1 then
--
--       opt = 1
    opt = 1
--
--     Case 2
  elseif d == 2 then
--
--       opt = 2
    opt = 2
--
--     Case 3
  elseif d == 3 then
--
--       opt = -1
    opt = -1
--
--   End Select
  end
--
--   to_quad = opt + t_in.quad
  to_quad = opt + t_in.quad
--
--   Select Case As Const d '' overflow
--
--     Case 0
  if d == 0 then
--
--       If to_quad < 0 Then
    if to_quad < 0 then
--         ''move tile up one
--
--         to_tile_y -= 1
      to_tile_y = to_tile_y - 1
--         to_quad = IIf( to_quad = -2, 2, 3 )
      to_quad = ((to_quad == -2) and 2 or 3)
--
--       End If
    end
--
--     Case 1
  elseif d == 1 then
--
--       If ( Abs( to_quad ) And 1 ) = 0 Then
    if bit.band(math.abs(to_quad), 1) == 0 then
--         ''move tile right one
--
--         to_tile_x += 1
      to_tile_x = to_tile_x + 1
--         to_quad = IIf( to_quad = 2, 0, 2 )
      to_quad = ((to_quad == 2) and 0 or 2)
--
--       End If
    end
--
--     Case 2
  elseif d == 2 then
--
--       If to_quad > 3 Then
    if to_quad > 3 then
--         ''move tile down one
--
--         to_tile_y += 1
      to_tile_y = to_tile_y + 1
--         to_quad = IIf( to_quad = 4, 0, 1 )
      to_quad = ((to_quad == 4) and 0 or 1)
--
--       End If
    end
--
--     Case 3
  elseif d == 3 then
--
--       If ( Abs( to_quad ) And 1 ) <> 0 Then
    if bit.band(math.abs(to_quad), 1) ~= 0 then
--         ''move tile left one
--
--         to_tile_x -= 1
      to_tile_x = to_tile_x - 1
--         to_quad = IIf( to_quad = 1, 3, 1 )
      to_quad = ((to_quad == 1) and 3 or 1)
--
--       End If
    end
--
--   End Select
  end
--
--   Return Type <tile_quad> ( to_tile_x, to_tile_y, to_quad )
  local result = create_tile_quad()
  result.x = to_tile_x
  result.y = to_tile_y
  result.quad = to_quad
  return result
--
-- End Function
end
--
-- Sub init_splash()
function init_splash()
--
--
--   Dim As Any Ptr ll_SplashScreen
--
--   dim as double justLongEnough
--   justLongEnough = timer + 3.5
--
--   Screen 13, , 2, iif( isFullscreen(), 1, 0 )
--
--   Sleep 1000, 1
--   SetMouse , , 0
--   fb_Global.display.pal = load_pal( "data\palette\ll.pal" )
--   Palette Using fb_Global.display.pal
--
--   ll_SplashScreen = ImageCreate( 320, 200 )
--
--   Bload "data\pictures\splash_screen.bmp", ll_SplashScreen
--
--
--
--   llg( hero ).fade_time = .0001
--   Do
--   Loop Until __fade_to_black( VarPtr( llg( hero ) ) )
--
--   Put( 0, 0 ), ll_SplashScreen
--
--
--   llg( hero ).fade_time = .01
--   Do
--   Loop Until __fade_up_to_color( VarPtr( llg( hero ) ) )
--
--
--   #IfDef ll_audio
--     ' initialize f mod
--
--     If bass_init() = 0 Then
--       bass_init( 0 )
--
--     End If
--
--     init_snd()
  init_snd()
--
--   #EndIf
--
--   Kill "objectload.txt"
--   Kill "imageload.txt"
--
--
--   LLSystem_CachePictureFiles( "data\pictures" )
--   LLSystem_CacheObjectFiles( "data\object" )
--
--
--   do while justLongEnough > timer
--     sleep 1
--   loop
--
--   llg( hero ).fade_time = .01
--   Do
--   Loop Until __fade_to_black( Varptr( llg( hero ) ) )
--   Cls
--
--   llg( hero ).fade_time = .003
--
--   shift_pal()
--
--   ImageDestroy( ll_SplashScreen )
--
--   Sleep 300, 1
--
--
-- End Sub
end

-- Function LLMiniMap_SizeX()
function LLMiniMap_SizeX()
--
--   Dim As Integer accumulateSizes, i, combine
  local accumulateSizes, i, combine = 0, 0, 0
--
--   For i = 0 To llg( map )->rooms - 1
  for i = 0, ll_global.map.rooms - 1 do
--
--     If llg( miniMap ).room[i].floor <> llg( miniMapFloor ) Then Continue For
    if ll_global.miniMap.room[i].floor ~= ll_global.miniMapFloor then goto continue end
--
--     combine = llg( map )->room[i].x + llg( miniMap ).room[i].location.x
    combine = ll_global.map.room[i].x + ll_global.miniMap.room[i].location.x
--
--     If combine > accumulateSizes Then
    if combine > accumulateSizes then
--       accumulateSizes = combine
      accumulateSizes = combine
--
--     End If
    end
--
    ::continue::
--   Next
  end
--
--   Return accumulateSizes
  return accumulateSizes
--
--
-- End Function
end
--
--
-- Function LLMiniMap_SizeY()
function LLMiniMap_SizeY()
--
--   Dim As Integer accumulateSizes, i, combine
  local accumulateSizes, i, combine = 0, 0, 0
--
--   For i = 0 To llg( map )->rooms - 1
  for i = 0, ll_global.map.rooms - 1 do
--
--     If llg( miniMap ).room[i].floor <> llg( miniMapFloor ) Then Continue For
    if ll_global.miniMap.room[i].floor ~= ll_global.miniMapFloor then goto continue end
--
--     combine = llg( map )->room[i].y + llg( miniMap ).room[i].location.y
    combine = ll_global.map.room[i].y + ll_global.miniMap.room[i].location.y
--
--     If combine > accumulateSizes Then
    if combine > accumulateSizes then
--       accumulateSizes = combine
      accumulateSizes = combine
--
--     End If
    end
--
    ::continue::
--   Next
  end
--
--   Return accumulateSizes
  return accumulateSizes
--
--
-- End Function
end
--
-- Function LLMiniMap_Floors()
function LLMiniMap_Floors()
--
--   dim as integer iRoom, floorFound, iFloor
  local iRoom, floorFound, iFloor = 0, 0, 0
--   redim as integer floors( 0 )
  local floors = {[0] = 0}
--
--   floors( 0 ) = 9999
  floors[0] = 9999
--
--   dim as integer alreadyFound
  local alreadyFound = 0
--   for iRoom = 0 to llg( map )->rooms - 1
  for iRoom = 0, ll_global.map.rooms - 1 do
--     for iFloor = 0 to floorFound
    for iFloor = 0, floorFound do
--       if floors( iFloor ) = llg( miniMap ).room[iRoom].floor then
      if floors[iFloor] == ll_global.miniMap.room[iRoom].floor then
--         alreadyFound = TRUE
        alreadyFound = TRUE
--         exit for
        break
--       end if
      end
--
--     next
    end
--
--     if alreadyFound = FALSE then
    if alreadyFound == FALSE then
--       floors( floorFound ) = llg( miniMap ).room[iRoom].floor
      floors[floorFound] = ll_global.miniMap.room[iRoom].floor
--       floorFound += 1
      floorFound = floorFound + 1
--
--       redim preserve floors( floorFound )
--
--       floors( floorFound ) = 9999
      floors[floorFound] = 9999
--
--     end if
    end
--
--
--   next
  end
--
--   return ubound( floors )
  return #floors - 1
--
-- end function
end
--
-- Function LLMiniMap_TopFloor()
function LLMiniMap_TopFloor()
--
--   dim as uinteger tf = ( 2 ^ 31 )
  local tf = -math.huge
--   dim as integer topFloor = tf, iRoom
  local topFloor, iRoom = tf, 0
--
--   for iRoom = 0 to llg( map )->rooms - 1
  for iRoom = 0, ll_global.map.rooms - 1 do
--
--     if llg( miniMap ).room[iRoom].floor > topFloor then
    if ll_global.miniMap.room[iRoom].floor > topFloor then
--       topFloor = llg( miniMap ).room[iRoom].floor
      topFloor = ll_global.miniMap.room[iRoom].floor
--
--     end if
    end
--
--   next
  end
--
--   return topFloor
  return topFloor
--
-- end function
end
--
-- Function LLMiniMap_BottomFloor()
function LLMiniMap_BottomFloor()
--
--   dim as integer bottomFloor = ( 2 ^ 31 ) - 1, iRoom
  local bottomFloor, iRoom = math.huge, 0
--
--   for iRoom = 0 to llg( map )->rooms - 1
  for iRoom = 0, ll_global.map.rooms - 1 do
--
--     if llg( miniMap ).room[iRoom].floor < bottomFloor then
    if ll_global.miniMap.room[iRoom].floor < bottomFloor then
--       bottomFloor = llg( miniMap ).room[iRoom].floor
      bottomFloor = ll_global.miniMap.room[iRoom].floor
--
--     end if
    end
--
--   next
  end
--
--   return bottomFloor
  return bottomFloor
--
-- end function
end
--
-- Sub LLMiniMap_UpdateCam( minimap_Local As LL_MiniMapType )
function LLMiniMap_UpdateCam(minimap_Local)
--
--   With minimap_Local.camera
  local with0 = minimap_Local.camera
--
--     If .x > ( LLMiniMap_SizeX() - 320 ) Then .x = ( LLMiniMap_SizeX() - 320 )
  if with0.x > (LLMiniMap_SizeX() - 320) then with0.x = (LLMiniMap_SizeX() - 320) end
--     If .x < 0 Then .x = 0
  if with0.x < 0 then with0.x = 0 end
--
--     If .y > ( LLMiniMap_SizeY() - 160 ) Then .y = ( LLMiniMap_SizeY() - 160 )
  if with0.y > (LLMiniMap_SizeY() - 160) then with0.y = (LLMiniMap_SizeY() - 160) end
--     If .y < 0 Then .y = 0
  if with0.y < 0 then with0.y = 0 end
--
--   End With
--
--
-- End Sub
end
--
--
-- Sub handle_MiniMap()
function handle_MiniMap()
--
--   static as double moveDelay, roomu, roomd
  if moveDelay == nil then moveDelay = 0.0 end
  if roomu == nil then roomu = 0.0 end
  if roomd == nil then roomd = 0.0 end
--
--   If llg( map )->isDungeon <> 0 Then
  if ll_global.map.isDungeon ~= 0 then
--
--     If MultiKey( sc_m ) Then
    if input:pressed("map") then
--
      drawing = true
--
--       llg( miniMap ).camera.x = ( llg( miniMap ).room[llg( this_room ).i].location.x + ( now_room().x Shr 1 ) ) - 160
      ll_global.miniMap.camera.x = ll_global.miniMap.room[ll_global.this_room.i].location.x + bit.rshift(now_room().x, 1) - 160
--       llg( miniMap ).camera.y = ( llg( miniMap ).room[llg( this_room ).i].location.y + ( now_room().y Shr 1 ) ) - 80
      ll_global.miniMap.camera.y = ll_global.miniMap.room[ll_global.this_room.i].location.y + bit.rshift(now_room().y, 1) - 80
--       llg( miniMapFloor ) = llg( miniMap ).room[llg( this_room ).i].floor
      ll_global.miniMapFloor = ll_global.miniMap.room[ll_global.this_room.i].floor
--
--       Do
      repeat
        input:update()
        timer = love.timer.getTime()
--
--         fb_GetKey()
--
--         if timer > moveDelay then
        if timer > moveDelay then
--
--           If MultiKey( sc_up ) Then
          if input:down("up") then
--             llg( miniMap ).camera.y -= 1
            ll_global.miniMap.camera.y = ll_global.miniMap.camera.y - 1
--           End If
          end
--           If MultiKey( sc_right ) Then
          if input:down("right") then
--             llg( miniMap ).camera.x += 1
            ll_global.miniMap.camera.x = ll_global.miniMap.camera.x + 1
--           End If
          end
--           If MultiKey( sc_down ) Then
          if input:down("down") then
--             llg( miniMap ).camera.y += 1
            ll_global.miniMap.camera.y = ll_global.miniMap.camera.y + 1
--           End If
          end
--           If MultiKey( sc_left ) Then
          if input:down("left") then
--             llg( miniMap ).camera.x -= 1
            ll_global.miniMap.camera.x = ll_global.miniMap.camera.x - 1
--           End If
          end
--
--           moveDelay = timer + .023
          --NOTE: Increased the speed because I felt it was too slow
          moveDelay = timer + .01
--
--         end if
        end
--
--         If MultiKey( sc_leftbracket ) Then
        if input:down("cycleleft") then
--           if roomd = 0 then
          if roomd == 0 then
--             if llg( miniMapFloor ) > LLMiniMap_BottomFloor() then
            if ll_global.miniMapFloor > LLMiniMap_BottomFloor() then
--               llg( miniMapFloor ) -= 1
              ll_global.miniMapFloor = ll_global.miniMapFloor - 1
--
              --NOTE: This was not in the original code. Reset the minimap
              --camera when changing floors. In some dungeons if you changed
              --floors away from the floor you were on, then back to the floor
              --you first viewed, the floor would no longer be visible.
--              llg( miniMap ).camera.x = ( llg( miniMap ).room[llg( this_room ).i].location.x + ( now_room().x Shr 1 ) ) - 160
              ll_global.miniMap.camera.x = ll_global.miniMap.room[ll_global.this_room.i].location.x + bit.rshift(now_room().x, 1) - 160
--              llg( miniMap ).camera.y = ( llg( miniMap ).room[llg( this_room ).i].location.y + ( now_room().y Shr 1 ) ) - 80
              ll_global.miniMap.camera.y = ll_global.miniMap.room[ll_global.this_room.i].location.y + bit.rshift(now_room().y, 1) - 80
--             end if
            end
--             roomd = -1
            roomd = -1
--
--           end if
          end
--         else
        else
--           roomd = 0
          roomd = 0
--
--         end if
        end
--
--         If MultiKey( sc_rightbracket ) Then
        if input:down("cycleright") then
--           if roomu = 0 then
          if roomu == 0 then
--             if llg( miniMapFloor ) < LLMiniMap_TopFloor() then
            if ll_global.miniMapFloor < LLMiniMap_TopFloor() then
--               llg( miniMapFloor ) += 1
              ll_global.miniMapFloor = ll_global.miniMapFloor + 1
--
              --NOTE: This was not in the original code. Reset the minimap
              --camera when changing floors. In some dungeons if you changed
              --floors away from the floor you were on, then back to the floor
              --you first viewed, the floor would no longer be visible.
--              llg( miniMap ).camera.x = ( llg( miniMap ).room[llg( this_room ).i].location.x + ( now_room().x Shr 1 ) ) - 160
              ll_global.miniMap.camera.x = ll_global.miniMap.room[ll_global.this_room.i].location.x + bit.rshift(now_room().x, 1) - 160
--              llg( miniMap ).camera.y = ( llg( miniMap ).room[llg( this_room ).i].location.y + ( now_room().y Shr 1 ) ) - 80
              ll_global.miniMap.camera.y = ll_global.miniMap.room[ll_global.this_room.i].location.y + bit.rshift(now_room().y, 1) - 80
--             end if
            end
--             roomu = -1
            roomu = -1
--
--           end if
          end
--         else
        else
--           roomu = 0
          roomu = 0
--
--         end if
        end
--
--         LLMiniMap_UpdateCam( llg( minimap ) )
        LLMiniMap_UpdateCam(ll_global.miniMap)
--         minimap_Blit()
        minimap_Blit()
--
--         if fb_WindowKill() then
--           end
--
--         end if
--
--
--         fb_ScreenRefresh()
        coroutine.yield()
--
--       Loop Until MultiKey( 1 )
      until input:pressed("map")
--
--       llg( miniMapFloor ) = llg( miniMap ).room[llg( this_room ).i].floor
      ll_global.miniMapFloor = ll_global.miniMap.room[ll_global.this_room.i].floor
--
--       hold_key( 1 )
--
--     End If
    end
--
--   End If
  end
--
-- End Sub
end

-- Sub LLObject_VectorPosition( obj As char_type, vecPair As vector_pair, faceIndex As Integer )
function LLObject_VectorPosition(obj, vecPair, faceIndex)
--
--
--   vecPair.u = obj.coords
  vecPair.u.x = obj.coords.x
  vecPair.u.y = obj.coords.y
--
--   With obj.anim[obj.current_anim]->frame[LLObject_CalculateFrame( obj )]
  local with0 = obj.anim[obj.current_anim].frame[LLObject_CalculateFrame(obj)]
--
--     If .faces = 0 Then
  if with0.faces == 0 then
--
--       vecPair.v = obj.perimeter
    vecPair.v.x = obj.perimeter.x
    vecPair.v.y = obj.perimeter.y
--
--     Else
  else
--
--       vecPair.u.x += .face[faceIndex].x - obj.animControl[obj.current_anim].x_off
    vecPair.u.x = vecPair.u.x + with0.face[faceIndex].x - obj.animControl[obj.current_anim].x_off
--       vecPair.u.y += .face[faceIndex].y - obj.animControl[obj.current_anim].y_off
    vecPair.u.y = vecPair.u.y + with0.face[faceIndex].y - obj.animControl[obj.current_anim].y_off
--
--       vecPair.v.x = .face[faceIndex].w
    vecPair.v.x = with0.face[faceIndex].w
--       vecPair.v.y = .face[faceIndex].h
    vecPair.v.y = with0.face[faceIndex].h
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

-- Function LLObject_Collision( o As char_type, o2 As char_type ) As LLObject_CollisionType
function LLObject_Collision(o, o2)
--
--   Dim As LLObject_CollisionType res
  local res = create_LLObject_CollisionType()
--   Dim As Integer faces, faces2
  local faces, faces2 = 0, 0
--   Dim As Integer i, i2
  local i, i2 = 0, 0
--
--   Dim As vector_pair ov, ov2
  local ov, ov2 = get_next_vector_pair(), get_next_vector_pair()
--
--   With o
  local with0 = o
--
--     .frame_check = LLObject_CalculateFrame( o )
  with0.frame_check = LLObject_CalculateFrame(o)
--
--     With .anim[.current_anim]->frame[.frame_check]
  local with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--
--       faces = IIf( .faces = 0, 0, .faces - 1 )
  faces = iif(with1.faces == 0, 0, with1.faces - 1)
--
--     End With
--
--   End With
--
--   With o2
  local with2 = o2
--
--     .frame_check = LLObject_CalculateFrame( o2 )
  with2.frame_check = LLObject_CalculateFrame(o2)
--
--     With .anim[.current_anim]->frame[.frame_check]
  local with3 = with2.anim[with2.current_anim].frame[with2.frame_check]
--
--       faces2 = IIf( .faces = 0, 0, .faces - 1 )
  faces2 = iif(with3.faces == 0, 0, with3.faces - 1)
--
--     End With
--
--   End With
--
--   For i = 0 To faces
  for i = 0, faces do
--
--     LLObject_VectorPosition( o, ov, i )
    LLObject_VectorPosition(o, ov, i)
--
--     For i2 = 0 To faces2
    for i2 = 0, faces2 do
--
--       LLObject_VectorPosition( o2, ov2, i2 )
      LLObject_VectorPosition(o2, ov2, i2)
--
--       If check_bounds( ov, ov2 ) = 0 Then
      if check_bounds(ov, ov2) == 0 then
--         '' touching
--
--         res.isColliding = -1
        res.isColliding = -1
--         res.faces.x = i
        res.faces.x = i
--         res.faces.y = i2
        res.faces.y = i2
--
--         Return res
        return res
--
--       End If
      end
--
--     Next i2
    end
--
--   Next i
  end
--
--   Return res
  return res
--
--
-- End Function
end

-- Sub LLObject_ClearProjectiles( char As char_type )
function LLObject_ClearProjectiles(char)
--
--   if char.projectile = 0 then exit sub
  if char.projectile == 0 then return end
--
--   Dim As Integer numOfProjectiles, incre
  local numOfProjectiles, incre = 0, 0
--
--   With char
  local with0 = char
--
--     For incre = 0 To .projectile->projectiles - 1
  for incre = 0, with0.projectile.projectiles - 1 do
--       .projectile->coords[incre] = Type <vector> ( 0, 0 )
    with0.projectile.coords[incre].x = 0
    with0.projectile.coords[incre].y = 0
--
--     Next
  end
--     .projectile->plock = 0
  with0.projectile.plock = 0
--     .projectile->active = 0
  with0.projectile.active = 0
--     .projectile->refreshTime = 0
  with0.projectile.refreshTime = 0
--     .projectile->saveDirection = 0
  with0.projectile.saveDirection = 0
--     .projectile->travelled = 0
  with0.projectile.travelled = 0
--     .projectile->sound = 0
  with0.projectile.sound = 0
--
--   End With
--
--
--
-- End Sub
end

-- Sub LLObject_InitializeProjectiles( char As char_type )
function LLObject_InitializeProjectiles(char)
--
--
--   With char
  local with0 = char
--
--
--     Dim As Integer beamModification
  local beamModification = 0
--     beamModification = IIf( .proj_style = PROJECTILE_BEAM, 2, 1 )
  beamModification = iif(with0.proj_style == PROJECTILE_BEAM, 2, 1)
--
--     Select Case As Const .unique_id
--
--       Case u_boss5_left
  if with0.unique_id == u_boss5_left then
--         .projectile->direction = 3
    with0.projectile.direction = 3
--
--       Case u_boss5_right
  elseif with0.unique_id == u_boss5_right then
--         .projectile->direction = 1
    with0.projectile.direction = 1
--
--       Case u_boss5_down
  elseif with0.unique_id == u_boss5_down then
--         .projectile->direction = 2
    with0.projectile.direction = 2
--
--       Case u_statue
  elseif with0.unique_id == u_statue then
--         .projectile->direction = 2
    with0.projectile.direction = 2
--
--       Case Else
  else
--
--         If .projectile->saveDirection = 0 Then
    if with0.projectile.saveDirection == 0 then
--           .projectile->direction = .direction
      with0.projectile.direction = with0.direction
--           .projectile->saveDirection = -1
      with0.projectile.saveDirection = -1
--
--         End If
    end
--
--     End Select
  end
--
--     Select Case As Const .unique_id
--
--       '' Soooo close... anim needs vectors
--       '' .projectile->coords[0] = V2_Subtract( V2_Add( .coords, V2_Scale( .perimeter, .5 ) ), V2_Scale( .anim[.proj_anim]->coords, .5 ) )
--
--       Case u_boss5_left, u_boss5_right
  if with0.unique_id == u_boss5_left or with0.unique_id == u_boss5_right then
--         .projectile->coords[0].x = ( .coords.x + .perimeter.x \ 2 ) - ( .anim[.proj_anim]->x \ 2 )
    with0.projectile.coords[0].x = (with0.coords.x + math.floor(with0.perimeter.x / 2)) - math.floor(with0.anim[with0.proj_anim].x / 2)
--         .projectile->coords[0].y = ( .coords.y + .perimeter.y \ 2 ) - 3
    with0.projectile.coords[0].y = (with0.coords.y + math.floor(with0.perimeter.y / 2)) - 3
--
--       Case Else
  else
--
--         Dim As Integer i
    local i = 0
--
--
--         .projectile->startVector.x = ( .coords.x + .perimeter.x \ 2 ) - ( .anim[.proj_anim]->x \ 2 )
    with0.projectile.startVector.x = (with0.coords.x + math.floor(with0.perimeter.x / 2)) - math.floor(with0.anim[with0.proj_anim].x / 2)
--         .projectile->startVector.y = ( .coords.y + .perimeter.y \ 2 ) - ( .anim[.proj_anim]->y \ 2 )
    with0.projectile.startVector.y = (with0.coords.y + math.floor(with0.perimeter.y / 2)) - math.floor(with0.anim[with0.proj_anim].y / 2)
--
--         For i = 0 To .projectile->projectiles - 1
    for i = 0, with0.projectile.projectiles - 1 do
--           .projectile->coords[i] = .projectile->startVector
      with0.projectile.coords[i].x = with0.projectile.startVector.x
      with0.projectile.coords[i].y = with0.projectile.startVector.y
--
--         Next
    end
--
--     End Select
  end
--
--     Select Case As Const .proj_style
--
--       Case PROJECTILE_BEAM
  if with0.proj_style == PROJECTILE_BEAM then
--
--         Select Case As Const .projectile->direction
--
--           Case 0
    if with0.projectile.direction == 0 then
--
--             .projectile->coords[1].x = .projectile->coords[0].x
      with0.projectile.coords[1].x = with0.projectile.coords[0].x
--             .projectile->coords[1].y = .projectile->coords[0].y - ( 8 * beamModification )
      with0.projectile.coords[1].y = with0.projectile.coords[0].y - (8 * beamModification)
--
--           Case 1
    elseif with0.projectile.direction == 1 then
--
--             .projectile->coords[1].x = .projectile->coords[0].x + ( 8 * beamModification )
      with0.projectile.coords[1].x = with0.projectile.coords[0].x + (8 * beamModification)
--             .projectile->coords[1].y = .projectile->coords[0].y
      with0.projectile.coords[1].y = with0.projectile.coords[0].y
--
--           Case 2
    elseif with0.projectile.direction == 2 then
--
--             .projectile->coords[1].x = .projectile->coords[0].x
      with0.projectile.coords[1].x = with0.projectile.coords[0].x
--             .projectile->coords[1].y = .projectile->coords[0].y + ( 8 * beamModification )
      with0.projectile.coords[1].y = with0.projectile.coords[0].y + (8 * beamModification)
--
--           Case 3
    elseif with0.projectile.direction == 3 then
--
--             .projectile->coords[1].x = .projectile->coords[0].x - ( 8 * beamModification )
      with0.projectile.coords[1].x = with0.projectile.coords[0].x - (8 * beamModification)
--             .projectile->coords[1].y = .projectile->coords[0].y
      with0.projectile.coords[1].y = with0.projectile.coords[0].y
--
--         End Select
    end
--
--
--       Case PROJECTILE_DIAGONAL
--       Case PROJECTILE_CROSS
--       Case PROJECTILE_8WAY
--       Case PROJECTILE_FIREBALL
--       Case PROJECTILE_SPIRAL
--
--
--     End Select
  end
--
--   End With
--
-- End Sub
end

-- Sub LLObject_IncrementProjectiles( char As char_type )
function LLObject_IncrementProjectiles(char)
--
--   With char
  local with0 = char
--
--     Select Case As Const .proj_style
--
--       Case PROJECTILE_ORB
  if with0.proj_style == PROJECTILE_ORB then
--
--         Select Case As Const .projectile->direction
--
--           Case 0: .projectile->coords[0].y -= 8
    if with0.projectile.direction == 0 then
      with0.projectile.coords[0].y = with0.projectile.coords[0].y - 8
--
--           Case 1: .projectile->coords[0].x += 8
    elseif with0.projectile.direction == 1 then
      with0.projectile.coords[0].x = with0.projectile.coords[0].x + 8
--
--           Case 2: .projectile->coords[0].y += 8
    elseif with0.projectile.direction == 2 then
      with0.projectile.coords[0].y = with0.projectile.coords[0].y + 8
--
--           Case 3: .projectile->coords[0].x -= 8
    elseif with0.projectile.direction == 3 then
      with0.projectile.coords[0].x = with0.projectile.coords[0].x - 8
    end
--
--         End Select
--
--       Case PROJECTILE_BEAM
  elseif with0.proj_style == PROJECTILE_BEAM then
--
--         Dim As vector tempVector
    local tempVector0 = get_next_vector()
    local tempVector1 = get_next_vector()
--
--         tempVector = .projectile->coords[0]
    tempVector0.x = with0.projectile.coords[0].x
    tempVector0.y = with0.projectile.coords[0].y
--
--         .projectile->coords[0] = .projectile->coords[1]
    with0.projectile.coords[0].x = with0.projectile.coords[1].x
    with0.projectile.coords[0].y = with0.projectile.coords[1].y
--         .projectile->coords[1] = V2_Add( .projectile->coords[1], V2_Subtract( .projectile->coords[1], tempVector ) )

    tempVector1 = V2_Add(with0.projectile.coords[1], V2_Subtract(with0.projectile.coords[1], tempVector0))
    with0.projectile.coords[1].x = tempVector1.x
    with0.projectile.coords[1].y = tempVector1.y

--
--       Case PROJECTILE_DIAGONAL
  elseif with0.proj_style == PROJECTILE_DIAGONAL then
--
--         .projectile->coords[0].x -= 1
    with0.projectile.coords[0].x = with0.projectile.coords[0].x - 1
--         .projectile->coords[0].y -= 1
    with0.projectile.coords[0].y = with0.projectile.coords[0].y - 1
--
--         .projectile->coords[1].x += 1
    with0.projectile.coords[1].x = with0.projectile.coords[1].x + 1
--         .projectile->coords[1].y -= 1
    with0.projectile.coords[1].y = with0.projectile.coords[1].y - 1
--
--         .projectile->coords[2].x += 1
    with0.projectile.coords[2].x = with0.projectile.coords[2].x + 1
--         .projectile->coords[2].y += 1
    with0.projectile.coords[2].y = with0.projectile.coords[2].y + 1
--
--         .projectile->coords[3].x -= 1
    with0.projectile.coords[3].x = with0.projectile.coords[3].x - 1
--         .projectile->coords[3].y += 1
    with0.projectile.coords[3].y = with0.projectile.coords[3].y + 1
--
--
--       Case PROJECTILE_CROSS, PROJECTILE_8WAY, PROJECTILE_SCHIZO
  elseif with0.proj_style == PROJECTILE_CROSS or
         with0.proj_style == PROJECTILE_8WAY or
         with0.proj_style == PROJECTILE_SCHIZO then
--
--         Dim As Integer i
    local i = 0
--         Dim As Double a, m
    local a, m = 0.0, 0.0
--
--         m = 360 / .projectile->projectiles
    m = 360 / with0.projectile.projectiles
--         For i = 0 To .projectile->projectiles - 1
    for i = 0, with0.projectile.projectiles - 1 do
--
--           .projectile->coords[i].x += Sin( a * rad )
      with0.projectile.coords[i].x = with0.projectile.coords[i].x + math.sin(a * rad)
--           .projectile->coords[i].y += Cos( a * rad )
      with0.projectile.coords[i].y = with0.projectile.coords[i].y + math.cos(a * rad)
--
--           a += m
      a = a + m
--
--         Next
    end
--
--       Case PROJECTILE_SPIRAL, PROJECTILE_SUN
  elseif with0.proj_style == PROJECTILE_SPIRAL or
         with0.proj_style == PROJECTILE_SUN then
--
--         Dim As Integer i
    local i = 0
--         Dim As Double a, m
    local a, m = 0.0, 0.0
--
--         m = 360 / .projectile->projectiles
    m = 360 / with0.projectile.projectiles
--         For i = 0 To .projectile->projectiles - 1
    for i = 0, with0.projectile.projectiles - 1 do
--
--           .projectile->coords[i].x = .projectile->startVector.x + Sin( ( ( a + .sway ) Mod 360 ) * rad ) * ( .projectile->travelled )
      with0.projectile.coords[i].x = with0.projectile.startVector.x + math.sin(((a + with0.sway) % 360) * rad) * (with0.projectile.travelled)
--           .projectile->coords[i].y = .projectile->startVector.y + Cos( ( ( a + .sway ) Mod 360 ) * rad ) * ( .projectile->travelled )
      with0.projectile.coords[i].y = with0.projectile.startVector.y + math.cos(((a + with0.sway) % 360) * rad) * (with0.projectile.travelled)
--
--           a += m
      a = a + m
--
--         Next
    end
--
--         If .sway = 359 Then
    if with0.sway == 359 then
--           .sway = 0
      with0.sway = 0
--
--         Else
    else
--           .sway += 1
      with0.sway = with0.sway + 1
--
--         End If
    end
--
--
--       Case PROJECTILE_TRACK '' implied target hero; could be genericized.
  elseif with0.proj_style == PROJECTILE_TRACK then
--
--
--         If ( .projectile->travelled And 3 ) = 0 Then
    if bit.band(with0.projectile.travelled, 3) == 0 then
--
--           If ( Abs( .projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then
      if (math.abs(with0.projectile.coords[0].x - ll_global.hero.coords.x) < 48) then
--
--             If ( Abs( .projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then
        if (math.abs(with0.projectile.coords[0].y - ll_global.hero.coords.y) < 48) then
--
--               .projectile->plock = 1
          with0.projectile.plock = 1
--
--             End If
        end
--
--           End If
      end
--
--           If .projectile->plock = 0 Then
      if with0.projectile.plock == 0 then
--
--             Dim As vector_pair thisProjectile
        local thisProjectile = get_next_vector_pair()
--
--             With .projectile->coords[0]
        local with1 = with0.projectile.coords[0]
--
--               thisProjectile.u.x = .x
        thisProjectile.u.x = with1.x
--               thisProjectile.u.y = .y
        thisProjectile.u.y = with1.y
--
--             End With
--
--             thisProjectile.v = Type <vector> ( .anim[.proj_anim]->x, .anim[.proj_anim]->y )
        thisProjectile.v.x = with0.anim[with0.proj_anim].x
        thisProjectile.v.y = with0.anim[with0.proj_anim].y
--
--             .projectile->flightPath = V2_CalcFlyback( V2_MidPoint( LLO_VP( Varptr( llg( hero ) ) ) ), V2_MidPoint( thisProjectile ) )
        local tempVector = V2_CalcFlyback(V2_MidPoint(LLO_VP(ll_global.hero)), V2_MidPoint(thisProjectile))
        with0.projectile.flightPath.x = tempVector.x
        with0.projectile.flightPath.y = tempVector.y
--
--           End If
      end
--
--         End If
    end
--
--        .projectile->coords[0] = V2_Add( .projectile->coords[0], .projectile->flightPath )
    local tempVector = V2_Add(with0.projectile.coords[0], with0.projectile.flightPath)
    with0.projectile.coords[0].x = tempVector.x
    with0.projectile.coords[0].y = tempVector.y
--
--     End Select
  end
--
--   End With
--
-- End Sub
end

-- Private Sub sequence_LoadGame( savedInfo As ll_saving_data Ptr )
function sequence_LoadGame(savedInfo)
--
--   '' only called from play_sequence
--
--   llg( hero ).hp              = savedInfo->hp
  ll_global.hero.hp = savedInfo.hp
--   llg( hero ).maxhp           = savedInfo->maxhp
  ll_global.hero.maxhp = savedInfo.maxhp
--
--   llg( hero ).money           = savedInfo->gold
  ll_global.hero.money = savedInfo.gold
--   llg( hero_only ).has_weapon = savedInfo->weapon
  ll_global.hero_only.has_weapon = savedInfo.weapon
-- '  llg( hero_only ).has_item   = savedInfo->item
--   memcpy( @llg( hero_only ).hasItem(0), @savedInfo->hasItem(0), 6 * len( integer ) )
  for k, v in pairs(savedInfo.hasItem) do
    ll_global.hero_only.hasItem[k] = v
  end
--
--   llg( hero_only ).has_bar    = savedInfo->bar
  ll_global.hero_only.has_bar = savedInfo.bar
--
--   llg( hero ).key             = savedInfo->key
  ll_global.hero.key = savedInfo.key
--   llg( hero_only ).b_key      = savedInfo->b_key
  ll_global.hero_only.b_key = savedInfo.b_key
--
--   llg( hero ).to_map          = savedInfo->map
  ll_global.hero.to_map = savedInfo.map
--   llg( hero ).to_entry        = savedInfo->entry
  ll_global.hero.to_entry = savedInfo.entry
--
--   llg( hero_only ).weapon     = llg( hero_only ).has_weapon
  ll_global.hero_only.weapon = ll_global.hero_only.has_weapon
--
--   MemCpy( Varptr( llg( hero_only ).hasCostume( 0 ) ), Varptr( savedInfo->hasCostume( 0 ) ), 9 )
  for k, v in pairs(savedInfo.hasCostume) do
    ll_global.hero_only.hasCostume[k] = v
  end
--   llg( hero_only ).isWearing = savedInfo->isWearing
  ll_global.hero_only.isWearing = savedInfo.isWearing
--
--
--   '            '' hack
--   '            llg( hero ).to_map = "icefield.map"
--   '            llg( hero ).to_entry = 1
--   '            llg( hero_only ).hasCostume( 1 ) = -1
--   '            llg( hero_only ).hasCostume( 2 ) = -1
--   '            llg( hero_only ).hasCostume( 3 ) = -1
--   '            llg( hero ).to_map          = "arx.map"
--
--   '' :::::::::::::::::::::::::::::::::::::
--
--   Select Case llg( hero_only ).isWearing
--
--     Case 0
  if ll_global.hero_only.isWearing == 0 then
--       set_regular()
    set_regular()
--
--     Case 1
  elseif ll_global.hero_only.isWearing == 1 then
--       set_cougar()
    set_cougar()
--
--     Case 2
  elseif ll_global.hero_only.isWearing == 2 then
--       set_lynnity()
    set_lynnity()
--
--     Case 3
  elseif ll_global.hero_only.isWearing == 3 then
--       set_ninja()
    set_ninja()
--
--     Case 4
  elseif ll_global.hero_only.isWearing == 4 then
--       set_bikini()
    set_bikini()
--
--     Case 5
  elseif ll_global.hero_only.isWearing == 5 then
--       set_rknight()
    set_rknight()
--
--
--   End Select
  end
--
--
--   MemCpy( llg( now ), Varptr( savedInfo->happen( 0 ) ), LL_EVENTS_MAX )
  for i = 0, LL_EVENTS_MAX - 1 do
    ll_global.now[i] = savedInfo.happen[i]
  end
--
--
--   llg( hero_only ).has_weapon = llg( hero_only ).weapon' + 1
  ll_global.hero_only.has_weapon = ll_global.hero_only.weapon
--
--   llg( hero ).switch_room = -2
  ll_global.hero.switch_room = -2
--
--   #IfDef ll_audio
--     BASS_ChannelStop( now_room().enemy[5].playing_handle )
--
--   #EndIf
--
--
--   change_room( 0, -1, 1 )
  change_room(0, -1, 1)
--
--
--   llg( hero ).fade_time = .003
  ll_global.hero.fade_time = .003
--
--   llg( hero_only ).action_lock = 0
  ll_global.hero_only.action_lock = 0
--   llg( hero ).chap = 0
  ll_global.hero.chap = 0
--   llg( hero ).menu_sel = 0
  ll_global.hero.menu_sel = 0
--
--   dim iRooms as integer
  local iRooms = 0
--
--   if savedInfo->rooms <> 0 then
  if savedInfo.rooms ~= 0 then
--     llg( hero_only ).roomVisited = callocate( savedInfo->rooms )
    ll_global.hero_only.roomVisited = {}
    for i = 0, savedInfo.rooms - 1 do
      ll_global.hero_only.roomVisited[i] = 0
    end
--
--     for iRooms = 0 to savedInfo->rooms - 1
    for iRooms = 0, savedInfo.rooms - 1 do
--       llg( hero_only ).roomVisited[iRooms] = savedInfo->hasVisited[iRooms]
      ll_global.hero_only.roomVisited[iRooms] = savedInfo.hasVisited[iRooms]
--
--     next
    end
--
--   end if
  end
--
--   hold_key( sc_enter )
--
--   antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--   antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--   antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
--   antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
--   antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
--
--
-- End Sub
end
--
--
--
-- Sub sequence_AssignEntityData( ByRef charData As char_type, ByRef commandData As command_data )
function sequence_AssignEntityData(charData, commandData)
--
--   With commandData
  local with0 = commandData
--
--     If charData.mod_lock = 0 Then
  if charData.mod_lock == 0 then
--
--       If .seq_pause <> 0 Then
    if with0.seq_pause ~= 0 then
--
--         charData.seq_paused =  1
      charData.seq_paused = 1
--
--       End If
    end
--
--       charData.mod_lock = 1
    charData.mod_lock = 1
--
--     End If
  end
--
--     If .modify_direction <> 0 Then
  if with0.modify_direction ~= 0 then
--
--       charData.direction =  ( .reserved_1 - 1 )
    --NOTE: Removed .reserved_1 because it is a union with .modify_direction
    charData.direction = (with0.modify_direction - 1)
--
--     End If
  end
--
--     If .free_to_move = 0 Then
  if with0.free_to_move == 0 then
--
--       llg( hero_only ).action_lock = -1
    ll_global.hero_only.action_lock = -1
--
--     End If
  end
--
--     If .abs_x <> 0 Then
  if with0.abs_x ~= 0 then
--       charData.coords.x =  ( .abs_x )
    charData.coords.x = (with0.abs_x)
--
--     End If
  end
--
--     If .abs_y <> 0 Then
  if with0.abs_y ~= 0 then
--       charData.coords.y =  ( .abs_y )
    charData.coords.y = (with0.abs_y)
--
--     End If
  end
--
--     if .fadeTime then
  if with0.fadeTime ~= 0 then
--       charData.fade_time =  ( .fadeTime )
    charData.fade_time = (with0.fadeTime)
--
--     end if
  end
--
--
--     If .display_hud <> 0 Then
  if with0.display_hud ~= 0 then
--
--       llg( do_hud ) = -1
    ll_global.do_hud = -1
--
--     End If
  end
--
--
--     '' fill entity with settings stored in the sequence structure
--     charData.dest_x = .dest_x
  charData.dest_x = with0.dest_x
--     charData.dest_y = .dest_y
  charData.dest_y = with0.dest_y_box_invis
--
--
--     If .jump_count <> 0 Then
  if with0.jump_count ~= 0 then
--
--       charData.jump_count = .jump_count
    charData.jump_count = with0.jump_count
--
--     End If
  end
--
--     charData.chap = .chap
  charData.chap = with0.chap
--
--     If .walk_speed <> 0 Then
  if with0.walk_speed ~= 0 then
--
--       charData.walk_speed = .walk_speed
    charData.walk_speed = with0.walk_speed
--
--     End If
  end
--
--   End With
--
-- End Sub
end
--
-- Sub sequence_FullReset( resetSequence As sequence_type )
function sequence_FullReset(resetSequence)
--   '' last command executed
--   Dim As Integer commandDismantle, entDismantle
  local commandDismantle, entDismantle = 0, 0
--
--   #Define activeEntity resetSequence.ent[.active_ent]
--
--   With resetSequence
  local with0 = resetSequence
--
--     For commandDismantle = 0 To .commands - 1
  for commandDismantle = 0, with0.commands - 1 do
--       '' command iter.
--       With .Command[commandDismantle]
    local with1 = with0.Command[commandDismantle]
--
--         For entDismantle = 0 To .ents - 1
    for entDismantle = 0, with1.ents - 1 do
--           '' command ent iter.
--           With .ent[entDismantle]
      local with2 = with1.ent[entDismantle]
--
--             If .active_ent <> SF_BOX Then
      if with2.active_ent ~= SF_BOX then
--               '' reset command ents' status
--               activeEntity->mod_lock = 0
        resetSequence.ent[with2.active_ent].mod_lock = 0
--               activeEntity->seq_paused = 0
        resetSequence.ent[with2.active_ent].seq_paused = 0
--               activeEntity->return_trig = 0
        resetSequence.ent[with2.active_ent].return_trig = 0
--
--             End If
      end
--
--             .ent_func = 0
      with2.ent_func = 0
--
--           End With
--
--         Next
    end
--
--       End With
--
--     Next
  end
--
--     .current_command = 0
  with0.current_command = 0
--
--     llg( hero_only ).action_lock = 0
  ll_global.hero_only.action_lock = 0
--
--   End With
--
-- End Sub
end
--
--
-- Private Function sequence_ExitCondition( activeChar As char_type Ptr )
function sequence_ExitCondition(activeChar)
--
--   If llg( hero_only ).dropoutSequence Then
  if ll_global.hero_only.dropoutSequence == TRUE then
--     '' the map change flag was set
--     llg( hero_only ).dropoutSequence = FALSE
    ll_global.hero_only.dropoutSequence = FALSE
--     If llg( hero ).switch_room <> -1 Then
    if ll_global.hero.switch_room ~= -1 then
--       '' switch room, clear seq
--       sequence_FullReset( *llg( seq ) )
      sequence_FullReset(ll_global.seq[ll_global.seqi])
--       llg( seq ) = 0
      ll_global.seq = nil
      ll_global.seqi = 0
--
--     End If
    end
--     Return TRUE
    return true
--
--   End If
  end
--
--   If llg( hero_only ).isLoading Then
  if ll_global.hero_only.isLoading ~= 0 then
--     '' Loading a saved game
--     sequence_LoadGame( activeChar->save( activeChar->menu_sel ).link )
    sequence_LoadGame(activeChar.save[activeChar.menu_sel].link)
--
--     sequence_FullReset( *llg( seq ) )
    sequence_FullReset(ll_global.seq[ll_global.seqi])
--     llg( seq ) = 0
    ll_global.seq = nil
    ll_global.seqi = 0
--     Return TRUE
    return true
--
--   End If
  end
--
-- End Function
end
--
--
--
-- Private Sub sequence_CommandIncrement( resetSequence As sequence_type )
function sequence_CommandIncrement(resetSequence)
--
--   #Define activeEntity resetSequence.ent[.active_ent]
--NOTE: Lua has no macros so we have to just search replace
--and use the correct with0/with1 local: resetSequence.ent[with0.active_ent]
--
--   Dim As Integer reset_ents
  local reset_ents = 0
--
--   With resetSequence
  local with0 = resetSequence
--
--     For reset_ents = 0 To .Command[.current_command].ents - 1
  for reset_ents = 0, with0.Command[with0.current_command].ents - 1 do
--       '' cycle through command entities
--       With .Command[.current_command].ent[reset_ents]
    local with1 = with0.Command[with0.current_command].ent[reset_ents]
--
--         If .active_ent <> SF_BOX Then
    if with1.active_ent ~= SF_BOX then
--           '' Working with a char_type
--           activeEntity->return_trig = 0
      resetSequence.ent[with1.active_ent].return_trig = 0
--           activeEntity->jump_counter = 0
      resetSequence.ent[with1.active_ent].jump_counter = 0
--           .ent_state = .hold_state
      with1.ent_state = with1.hold_state
--           .ent_func = 0
      with1.ent_func = 0
--
--         End If
    end
--
--       End With
--
--     Next
  end
--
--     '' increment command
--     .current_command += 1
  with0.current_command = with0.current_command + 1
--
--   End With
--
-- End Sub
end
--
--
--
-- Function sequence_isCommandProgressing( thisSequence As sequence_type, currentEntity As Integer )
function sequence_isCommandProgressing(thisSequence, currentEntity)
--
--   #Define activeEntity thisSequence.ent[.active_ent]
--NOTE: Lua has no macros so we have to just search replace
--and use the correct with0/with1 local: thisSequence.ent[with0.active_ent]
--
--   '' Check through for completion
--   Dim As Integer check_ents, command_isProgressing
  local check_ents, command_isProgressing = 0, false
--
--   With thisSequence
  local with0 = thisSequence
--
--     '' Prime the pump
--     command_isProgressing = TRUE
  command_isProgressing = true
--     For check_ents = 0 To .Command[.current_command].ents - 1
  for check_ents = 0, with0.Command[with0.current_command].ents - 1 do
--       '' cycle thru the entity callbacks
--       With .Command[.current_command].ent[check_ents]
    local with1 = with0.Command[with0.current_command].ent[check_ents]
--
--         If .active_ent <> SF_BOX Then
    if with1.active_ent ~= SF_BOX then
--           '' Entity called back
--           command_isProgressing And= ( activeEntity->return_trig <> 0 )
      command_isProgressing = command_isProgressing and (thisSequence.ent[with1.active_ent].return_trig ~= 0)
--
--         Else
    else
--           '' Box called back
--           command_isProgressing And= ( llg( t_rect ).activated = FALSE )
      command_isProgressing = command_isProgressing and (ll_global.t_rect.activated == 0)
--
--         End If
    end
--
--       End With
--
--     Next
  end
--
--     With .Command[.current_command].ent[currentEntity]
  local with1 = with0.Command[with0.current_command].ent[currentEntity]
--
--       If .carries_all Then
  if with1.carries_all ~= 0 then
--         '' This command ent takes precedence
--         If .active_ent <> SF_BOX Then
    if with1.active_ent ~= SF_BOX then
--
--           If activeEntity->return_trig = 1 Then
      if thisSequence.ent[with1.active_ent].return_trig == 1 then
--             '' Its actor called back
--             command_isProgressing = TRUE
        command_isProgressing = true
--
--           End If
      end
--
--         Else
    else
--
--           If llg( t_rect ).activated = FALSE Then
      if ll_global.t_rect.activated == 0 then
--
--             command_isProgressing = TRUE
        command_isProgressing = true
--
--           End If
      end
--
--         End If
    end
--
--       End If
  end
--
--     End With
--
--   End With
--
--   Function = command_isProgressing
  return command_isProgressing
--
-- End Function
end

-- Sub play_sequence ( _seq As sequence_type Ptr )
--NOTE: We change how we process sequences by passing in
--the parent table of the sequence, so that we can reset it from
--within this function.
function play_sequence(_seqParent)
  if _seqParent.seq == nil then return end
  local _seq = _seqParent.seq[_seqParent.seqi]
--
--
--   If _seq = 0 Then Exit Sub
  if _seq == nil then return end
--
--   #Define activeEntity _seq->ent[.active_ent]
  --NOTE: Lua has no macros so we have to just search replace
  --and use the correct with0/with1 local: _seq.ent[with0.active_ent]
--
--   Static box_IsInited As Integer
  if box_IsInited == nil then box_IsInited = false end
--
--   llg( dbgstring ) = Str( box_IsInited )
--
--   llg( do_hud ) = 0
  ll_global.do_hud = 0
--
--   Assert( _seq->Command )
--
--   Dim As Integer do_ents
  local do_ents = 0
--
--   For do_ents = 0 To _seq->Command[_seq->current_command].ents - 1
  for do_ents = 0, _seq.Command[_seq.current_command].ents - 1 do
--     '' cycle through current command's entities
--
--     Assert( _seq->Command[_seq->current_command].ent )
--
--     With _seq->Command[_seq->current_command].ent[do_ents]
    local with0 = _seq.Command[_seq.current_command].ent[do_ents]
--       '' set up a jump loop, for do_ents
--       If .active_ent = SF_BOX Then
    if with0.active_ent == SF_BOX then
--         '' this isn't any old char_type
--         If box_IsInited = FALSE Then
      if box_IsInited == false then
--           '' box has not been initialized; lock
--
--           box_IsInited = TRUE
        box_IsInited = true
--           destroy_box( Varptr( llg( t_rect ) ) )
        ll_global.t_rect = nil
--
-- '          clear llg( t_rect ), 0, len( boxcontrol_type )
--
--           llg( t_rect ) = make_box( .text, .free_to_move, .text_color, .box_invis, .auto_box, .mod_x, .mod_y, .text_speed )
        ll_global.t_rect = make_box(with0.text, with0.free_to_move, with0.text_color, with0.dest_y_box_invis, with0.auto_box, with0.mod_x, with0.mod_y, with0.water_align_union_text_speed)
--
--         End If
      end
--
--       Else
    else
--         '' not a box
--         sequence_AssignEntityData( *activeEntity, _seq->Command[_seq->current_command].ent[do_ents] )
      sequence_AssignEntityData(_seq.ent[with0.active_ent], _seq.Command[_seq.current_command].ent[do_ents])
--
--         If .water_align <> 0 Then
      if with0.water_align_union_text_speed ~= 0 then
--           '' flag to loop the backround is set
--           If llg( hero ).coords.y = 2000 Then
        if ll_global.hero.coords.y == 2000 then
--             '' top boundary of water hit
--             Dim As Integer change_ents
          local change_ents = 0
--
--             For change_ents = 0 To _seq->Command[_seq->current_command].ents - 1
          for change_ents = 0, _seq.Command[_seq.current_command].ents - 1 do
--               '' cycle through entities to be adjusted
--               With _seq->Command[_seq->current_command].ent[change_ents]
            local with1 = _seq.Command[_seq.current_command].ent[change_ents]
--
--                 If .active_ent <> SF_BOX Then
            if with1.active_ent ~= SF_BOX then
--                   '' bad pointer mojo
--                   If activeEntity->no_cam = FALSE Then
              if _seq.ent[with1.active_ent].no_cam == 0 then
--                     '' entity is camera relative, shift it
--                     activeEntity->coords.y += 5376
                _seq.ent[with1.active_ent].coords.y = _seq.ent[with1.active_ent].coords.y + 5376
--
--                   End If
              end
--
--                 End If
            end
--
--               End With
--
--             Next
          end
--
--           End If
        end
--
--         End If
      end
--
--         If activeEntity->return_trig Then
      if _seq.ent[with0.active_ent].return_trig ~= 0 then
--           '' this entity called back already
--           Continue For
        goto continue
--
--         End If
      end
--
--         '' **************************************************************************
--         '' do the entities function           ***************************************
--         .ent_func += activeEntity->funcs.func[.ent_state][.ent_func] ( activeEntity )
--         ''                                    ***************************************
--         '' **************************************************************************
      with0.ent_func = with0.ent_func + _seq.ent[with0.active_ent].funcs.func[with0.ent_state][with0.ent_func](_seq.ent[with0.active_ent])
--
--
--         '' Stuff that gets set in entities' functions
--         '' #########
--                     If sequence_ExitCondition( activeEntity ) Then
      if sequence_ExitCondition(_seq.ent[with0.active_ent]) then
--
--                       box_IsInited = FALSE
        box_IsInited = false
--                       Exit Sub
        return
--
--                     End If
      end
--
--                     If activeEntity->state_shift <> 0 Then
      if _seq.ent[with0.active_ent].state_shift ~= 0 then
--                       '' Just a hack for the menu, as far as I can see.
--                       .ent_state = activeEntity->state_shift
        with0.ent_state = _seq.ent[with0.active_ent].state_shift
--                       .ent_func = 0
        with0.ent_func = 0
--
--                       activeEntity->state_shift = 0
        _seq.ent[with0.active_ent].state_shift = 0
--
--                     End If
      end
--         '' #########
--
--
--         If .ent_func = activeEntity->funcs.func_count[.ent_state] Then
      if with0.ent_func == _seq.ent[with0.active_ent].funcs.func_count[with0.ent_state] then
--           '' Overflow
--           .ent_func = 0
        with0.ent_func = 0
--
--         End If
      end
--
--
--
--       End If
    end
--
--       If sequence_isCommandProgressing( *_seq, do_ents ) Then
    if sequence_isCommandProgressing(_seq, do_ents) then
--         '' all entities called back
--
--         sequence_CommandIncrement( *_seq )
      sequence_CommandIncrement(_seq)
--         box_IsInited = FALSE
      box_IsInited = false
--
--         Exit For
      break
--
--       End If
    end
--
--     End With
--
  ::continue::
--   Next
  end
--
--   If _seq->current_command = _seq->commands Then
  if _seq.current_command == _seq.commands then
--
--     sequence_FullReset( *_seq )
    sequence_FullReset(_seq)
--
--     _seq = 0
    _seqParent.seq = nil
    _seqParent.seqi = 0
--     llg( hero ).chap = 0
    ll_global.hero.chap = 0
--     llg( do_hud ) = -1
    ll_global.do_hud = -1
--
--
--   End If
  end
--
--
-- End Sub
end

-- Function touched_frame_face( c As char_type Ptr, v As vector_pair ) As Integer
function touched_frame_face(c, v)
--
--   Dim As vector_pair origin
  local origin = get_next_vector_pair()
--   Dim As Integer face_check
  local face_check = 0
--
--   With *( c )
--
  --NOTE: Pulled this frame_check assignment up to blit_enemy_loot.
  --This function is only used from that location. .frame was used to
  --decide whether to call touched_bound_box or touched_frame_face based
  --on how many faces the frame has. Problem is, .frame_check and .frame
  --can be out of sync in some cases. So we use .frame_check all the way
  --up to blit_enemy_loot so it is not out of sync. I THINK that this was
  --a bug in the original code that worked by coincidence most of the time,
  --but I am leaving this note here just in case I effed something up.
--     .frame_check = LLObject_CalculateFrame( c[0] )
--
--     For face_check = 0 To .anim[.current_anim]->frame[.frame].faces - 1
  for face_check = 0, c.anim[c.current_anim].frame[c.frame_check].faces - 1 do
--
--       origin = LLO_VPE( c, OV_FACE, face_check )
    origin = LLO_VPE(c, OV_FACE, face_check)
--
--       If ( check_bounds( origin, v ) = 0 ) Then
    if (check_bounds(origin, v) == 0) then
--         Return face_check
      return face_check
--
--       End If
    end
--
--     Next
  end
--
--   End With
--
--   Return -1
  return -1
--
--
-- End Function
end
--
--
--
-- Function touched_bound_box( c As char_type Ptr, v As vector_pair ) As Integer
function touched_bound_box(c, v)
--
--   Return check_bounds( LLObject_VectorPair( c ), v )
  return check_bounds(LLObject_VectorPair(c), v)
--
-- End Function
end

-- Sub LLEngine_ExecuteConcurrents( o As char_type Ptr )
function LLEngine_ExecuteConcurrents(o)
--
--   Dim As Integer i
  local i = 0
--
--   With *( o )
  local with0 = o
--
--     For i = 0 To .animControl[.current_anim].frame[.frame].concurrents - 1
  for i = 0, with0.animControl[with0.current_anim].frame[with0.frame].concurrents - 1 do
--
--       With .animControl[.current_anim].frame[.frame].concurrent[i]
    local with1 = with0.animControl[with0.current_anim].frame[with0.frame].concurrent[i]
--
--         act_enemies( 1, .char )
    act_enemies(1, {[0] = with1.char})
--
--         .char->coords = V2_Add(                                               _
    local temp_vector = V2_Add(
--                                 o->coords,                                    _
                                o.coords,
--                                 V2_Subtract(                                  _
                                V2_Subtract(
--                                              .origin,                         _
                                              with1.origin,
--                                              V2_Scale( .char->perimeter, .5 ) _
                                              V2_Scale(with1.char.perimeter, .5)
--                                            )                                  _
                                            )
--                               )
                              )
    with1.char.coords.x = temp_vector.x
    with1.char.coords.y = temp_vector.y
--
--       End With
--
--     Next
  end
--
--   End With
--
--
-- End Sub
end

-- Sub LLObject_TorchModify( o As char_type Ptr )
function LLObject_TorchModify(o)
--
--
--
--   Dim As Integer chk
  local chk = 0
--   Dim As vector res
  local res = get_next_vector()
--
--   With *( o )
  local with0 = o
--
--     For chk = 0 To now_room().enemies -1
  for chk = 0, now_room().enemies - 1 do
--
--       If now_room().enemy[chk].dead = 0 Then
    if now_room().enemy[chk].dead == 0 then
--
--         Select Case As Const now_room().enemy[chk].unique_id
--
--           Case u_eguard, u_bguard, u_tguard, u_cguard, u_bshape, u_gshape
      if now_room().enemy[chk].unique_id == u_eguard or
         now_room().enemy[chk].unique_id == u_bguard or
         now_room().enemy[chk].unique_id == u_tguard or
         now_room().enemy[chk].unique_id == u_cguard or
         now_room().enemy[chk].unique_id == u_bshape or
         now_room().enemy[chk].unique_id == u_gshape then
--
--             res = V2_Absolute( _
        local m = get_next_vector_pair()
        local n = get_next_vector_pair()
        m.u.x = with0.coords.x
        m.u.y = with0.coords.y
        m.v.x = with0.perimeter.x
        m.v.y = with0.perimeter.y
        n.u.x = now_room().enemy[chk].coords.x
        n.u.y = now_room().enemy[chk].coords.y
        n.v.x = now_room().enemy[chk].perimeter.x
        n.v.y = now_room().enemy[chk].perimeter.y
        res = V2_Absolute(
--                                V2_Subtract(                                                                                                     _
          V2_Subtract(
--                                             V2_MidPoint( Type <vector_pair> ( .coords, .perimeter ) ),                                          _
            V2_MidPoint(m),
--                                             V2_MidPoint( Type <vector_pair> ( now_room().enemy[chk].coords, now_room().enemy[chk].perimeter ) ) _
              V2_MidPoint(n)
--                                           )                                                                                                     _
            )
--                              )
          )
--
--         End Select
      end
--
--         Select Case As Const now_room().enemy[chk].unique_id
--
--           Case u_eguard, u_bguard, u_tguard, u_cguard
      if now_room().enemy[chk].unique_id == u_eguard or
         now_room().enemy[chk].unique_id == u_bguard or
         now_room().enemy[chk].unique_id == u_tguard or
         now_room().enemy[chk].unique_id == u_cguard then
--
--             If res.x < .vision_field Then
        if res.x < with0.vision_field then
--               If res.y < .vision_field Then
          if res.y < with0.vision_field then
--
--                 .current_anim = 3 '' LOW TORCH
            with0.current_anim = 3
--                 Exit Sub
            return
--
--               End If
          end
--
--             End If
        end
--
--
--           Case u_bshape
      elseif now_room().enemy[chk].unique_id == u_bshape then
--
--             If res.x < .vision_field Then
        if res.x < with0.vision_field then
--               If res.y < .vision_field Then
          if res.y < with0.vision_field then
--
--                 .current_anim = 1 '' RED TORCH
            with0.current_anim = 1
--                 Exit Sub
            return
--
--               End If
          end
--
--             End If
        end
--
--           Case u_gshape
      elseif now_room().enemy[chk].unique_id == u_gshape then
--
--             If res.x < .vision_field Then
        if res.x < with0.vision_field then
--               If res.y < .vision_field Then
          if res.y < with0.vision_field then
--
--                 .current_anim = 2 '' GREEN TORCH
            with0.current_anim = 2
--                 Exit Sub
            return
--
--               End If
          end
--
--             End If
        end
--
--         End Select
      end
--
--       End If
    end
--
--     Next
  end
--
--   .current_anim = 0 '' nothing special.
  with0.current_anim = 0
--
--   End With
--
--
-- End Sub
end

-- Sub LLMusic_SetVolume( volumeDesired As Integer )
function LLMusic_SetVolume(volume)
--
--   #IfDef ll_audio
--
--     bass_setconfig( BASS_CONFIG_GVOL_MUSIC, volumeDesired )
  ll_global.sng:setVolume(volume / 100)
--
--   #EndIf
--
-- End Sub
end

-- Sub LLMusic_Stop()
function LLMusic_Stop()
--
--   #IfDef ll_audio
--
--     bass_channelstop( llg( sng ) )
  ll_global.sng:stop()
--
--   #EndIf
--
-- End Sub
end

-- Sub LLMusic_Start( songName As String )
function LLMusic_Start(songName)
--
--   Dim As uinteger ret
--
--   #ifdef ll_audio
--
--     ret = BASS_MusicLoad ( 0, songName, 0, 0, BASS_MUSIC_AUTOFREE Or BASS_SAMPLE_LOOP, 44100 )
--
--     If bass_channelplay( ret, 0 ) <> 0 Then
--       llg( sng ) = ret
--
--     End If
--
--   #endif
--
-- End Sub
  if songName ~= "" and love.filesystem.getInfo(songName) then
    ll_global.sng = love.audio.newSource(songName, "stream")
    ll_global.sng:setLooping(true)
    ll_global.sng:play()
  end
end

-- Sub LLMusic_Fade()
function LLMusic_Fade()
--
--   Const As Integer slices = 64
  local slices = 64
--
--   If Timer > llg( hero_only ).songFade->pulse Then
  if timer > ll_global.hero_only.songFade.pulse then
--
--     Dim As Double tmp_val
    local tmp_val = 0.0
--     tmp_val = ( slices - llg( hero_only ).songFade->travelled )
    tmp_val = (slices - ll_global.hero_only.songFade.travelled)
--     tmp_val *= 1.5625 '' ( 100 / 64 )
    tmp_val = (tmp_val * 1.5625)
--
--     LLMusic_SetVolume( CInt( tmp_val ) )
    LLMusic_SetVolume(tmp_val)
--
--     llg( hero_only ).songFade->travelled += 1
    ll_global.hero_only.songFade.travelled = ll_global.hero_only.songFade.travelled + 1
--
--     llg( hero_only ).songFade->pulse = Timer + llg( hero_only ).songFade->pulseLength
    ll_global.hero_only.songFade.pulse = timer + ll_global.hero_only.songFade.pulseLength
--
--   End If
  end
--
--   If llg( hero_only ).songFade->travelled = slices Then
  if ll_global.hero_only.songFade.travelled == slices then
--
--     LLMusic_Stop()
    LLMusic_Stop()
--     LLMusic_SetVolume( 100 )
    LLMusic_SetVolume(100)
--
--     clean_Deallocate( llg( hero_only ).songFade )
    ll_global.hero_only.songFade = nil
--
--   End If
  end
--
-- End Sub
end

-- Function is_facing( o As _char_type Ptr, o2 As _char_type Ptr ) As Integer
function is_facing(o, o2)
--
--
--   Dim As Integer facing
  local facing = 0
--
--   Select Case o->direction
--
--     Case 0
  if o.direction == 0 then
--
--       If o->coords.y >=  ( o2->coords.y +  ( o2->perimeter.y - 1 )  )  And  ( o->coords.x >=  ( o2->coords.x -  ( o->perimeter.x - 1 )  )  Or  ( o->coords.x <=  (  ( o2->coords.x + o2->perimeter.x )  +  ( o->perimeter.x - 1 )  )  )  )  Then
    if o.coords.y >= (o2.coords.y + (o2.perimeter.y - 1)) and (o.coords.x >= (o2.coords.x - (o.perimeter.x - 1)) or (o.coords.x <= ((o2.coords.x + o2.perimeter.x) + (o.perimeter.x - 1)))) then
--         facing = 0
      facing = 0
--
--       Else
    else
--         facing = -1
      facing = -1
--
--       End If
    end
--
--     Case 2
  elseif o.direction == 2 then
--
--       If o->coords.y +  ( llg( map )->tileset->y - 1 )  <=   ( o2->coords.y )  And  ( o->coords.x >=  ( o2->coords.x -  ( llg( map )->tileset->x - 1 )  )  Or  ( o->coords.x <=  (  ( o2->coords.x + o2->perimeter.x )  +  ( llg( map )->tileset->x - 1 )  )  )  )  Then
    if o.coords.y + (ll_global.map.tileset.y - 1) <= (o2.coords.y) and (o.coords.x >= (o2.coords.x  - (ll_global.map.tileset.x - 1)) or (o.coords.x <= (( o2.coords.x + o2.perimeter.x) + (ll_global.map.tileset.x - 1)))) then
--         facing = 0
      facing = 0
--
--       Else
    else
--         facing = -1
      facing = -1
--
--       End If
    end
--
--     Case 3
  elseif o.direction == 3 then
--
--       If o->coords.x >=  ( o2->coords.x +  ( o2->perimeter.x - 1 )  )  And  ( o->coords.y >=  ( o2->coords.y ) Or ( o->coords.y <=  ( o2->coords.y + o2->perimeter.y ) ) )  Then
    if o.coords.x >= (o2.coords.x + (o2.perimeter.x - 1)) and (o.coords.y >= (o2.coords.y) or (o.coords.y <= (o2.coords.y + o2.perimeter.y))) then
--         facing = 0
      facing = 0
--
--       Else
    else
--         facing = -1
      facing = -1
--
--       End If
    end
--
--     Case 1
  elseif o.direction == 1 then
--
--       If o->coords.x +  ( llg( map )->tileset->x - 1 )  <=  ( o2->coords.x )  And  ( o->coords.y >=  ( o2->coords.y )  Or  ( o->coords.y <=  (  ( o2->coords.y + o2->perimeter.y )  )  )  )  Then
    if o.coords.x + (ll_global.map.tileset.x - 1) <= (o2.coords.x ) and (o.coords.y >= (o2.coords.y) or (o.coords.y <= ((o2.coords.y + o2.perimeter.y)))) then
--         facing = 0
      facing = 0
--
--       Else
    else
--         facing = -1
      facing = -1
--
--       End If
    end
--
--
--   End Select
  end
--
--   Return facing
  return facing
--
--
-- End Function
end

-- private function text_Center( myString as string )
function text_Center(myString)
--
-- 	const as integer screenX = 320
  local screenX = 320
--
-- 	dim as integer stringLen = len( myString )
  local stringLen = #myString
--
-- 	return ( screenX shr 1 ) - ( stringLen shl 2 )
  return bit.rshift(screenX, 1) - bit.lshift(stringLen, 2)
--
--
-- end function
end
--
-- private function alignText( mystring as string ) as string
function alignText(mystring)
--
--   dim as integer lenString = len( mystring )
  local lenString = #mystring
--
--
--   return space( ( 40 - lenString ) shr 1 ) & myString
  return space(bit.rshift((40 - lenString), 1))..mystring
--
--
-- end function
end
--
-- private sub CreditScroll()
function CreditScroll()
--
--   dim as string creditsString
  local creditsString = ""
--
--   creditsString = ""
  creditsString = ""
--                   ''                                        ''
--
--   creditsString += alignText( "Directed by Josiah Tobin and cha0s" )        + chr( 10 )
  creditsString = creditsString..alignText("Directed by Josiah Tobin and cha0s").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "All art by Josiah Tobin (some parallax" )    + chr( 10 )
  creditsString = creditsString..alignText("ALL art by Josiah Tobin (some parallax").."\n"
--   creditsString += alignText( "backgrounds edited from stock art)" )        + chr( 10 )
  creditsString = creditsString..alignText("backgrounds edited from stock art)").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "All programming by cha0s" )                  + chr( 10 )
  creditsString = creditsString..alignText("All programming by cha0s").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Music and sound effects composed by" )       + chr( 10 )
  creditsString = creditsString..alignText("Music and sound effects composed by").."\n"
--   creditsString += alignText( "Josiah Tobin (some stock effects used" )     + chr( 10 )
  creditsString = creditsString..alignText("Josiah Tobin (some stock effects used").."\n"
--   creditsString += alignText( "in the creation of certain sounds)" )        + chr( 10 )
  creditsString = creditsString..alignText("in the creation of certain sounds)").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Additional sounds by cha0s" )                + chr( 10 )
  creditsString = creditsString..alignText("Additional sounds by cha0s").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Dialog and manuscript by Josiah Tobin" )     + chr( 10 )
  creditsString = creditsString..alignText("Dialog and manuscript by Josiah Tobin").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Additional dialog by cha0s" )                + chr( 10 )
  creditsString = creditsString..alignText("Additional dialog by cha0s").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Maps by Josiah Tobin" )                      + chr( 10 )
  creditsString = creditsString..alignText("Maps by Josiah Tobin").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Cutscenes scripted by cha0s" )               + chr( 10 )
  creditsString = creditsString..alignText("Cutscenes scripted by cha0s").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "All dungeons designed by Josiah Tobin" )     + chr( 10 )
  creditsString = creditsString..alignText("All dungeons designed by Josiah Tobin").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Lynn 'Kona' Dempsey as:" )                   + chr( 10 )
  creditsString = creditsString..alignText("Lynn 'Kona' Dempsey as:").."\n"
--   creditsString += alignText( "the voice of Lynn" )                         + chr( 10 )
  creditsString = creditsString..alignText("the voice of Lynn").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Josiah Tobin special thanks:" )              + chr( 10 )
  creditsString = creditsString..alignText("Josiah Tobin special thanks:").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Amelia 'Tassimmet' Bennett," )               + chr( 10 )
  creditsString = creditsString..alignText("Amelia 'Tassimmet' Bennett,").."\n"
--   creditsString += alignText( "Chris Greer, James Kinney," )                + chr( 10 )
  creditsString = creditsString..alignText("Chris Greer, James Kinney,").."\n"
--   creditsString += alignText( "Lynn Dempsey, Brian Tobin," )                + chr( 10 )
  creditsString = creditsString..alignText("Lynn Dempsey, Brian Tobin,").."\n"
--   creditsString += alignText( "Stephen Gazzard, 'The Reset Button'," )      + chr( 10 )
  creditsString = creditsString..alignText("Stephen Gazzard, 'The Reset Button',").."\n"
--   creditsString += alignText( "Anyone else who helped me out " )            + chr( 10 )
  creditsString = creditsString..alignText("Anyone else who helped me out ").."\n"
--   creditsString += alignText( "or inspired me." )                           + chr( 10 )
  creditsString = creditsString..alignText("or inspired me.").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "cha0s special thanks:" )                     + chr( 10 )
  creditsString = creditsString..alignText("cha0s special thanks:").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "v1ctor, and everyone who contributes" )      + chr( 10 )
  creditsString = creditsString..alignText("v1ctor, and everyone who contributes").."\n"
--   creditsString += alignText( "to the FreeBASIC Compiler..." )              + chr( 10 )
  creditsString = creditsString..alignText("to the FreeBASIC Compiler...").."\n"
--   creditsString += alignText( "(http://www.freebasic.net/forum)" )          + chr( 10 )
  creditsString = creditsString..alignText("(http://www.freebasic.net/forum)").."\n"
--   creditsString += alignText( "Without it, this game would" )               + chr( 10 )
  creditsString = creditsString..alignText("Without it, this game would").."\n"
--   creditsString += alignText( "not have been possible." )                   + chr( 10 )
  creditsString = creditsString..alignText("not have been possible.").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Shouts out to:" )                            + chr( 10 )
  creditsString = creditsString..alignText("Shouts out to:").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "Autumn, Boy, Dana, 'Diny, Doc. D," )          + chr( 10 )
  creditsString = creditsString..alignText("Autumn, Boy, Dana, 'Diny, Doc. D,").."\n"
--   creditsString += alignText( "Fat Al, Gal, Guido, Harvey, HinD," )         + chr( 10 )
  creditsString = creditsString..alignText("Fat Al, Gal, Guido, Harvey, HinD,").."\n"
--   creditsString += alignText( "Jay, Jaz, Jewish, Katie, Lizzie," )          + chr( 10 )
  creditsString = creditsString..alignText("Jay, Jaz, Jewish, Katie, Lizzie,").."\n"
--   creditsString += alignText( "Katty, Kiana, Kith, marzec, Matt," )        + chr( 10 )
  creditsString = creditsString..alignText("Katty, Kiana, Kith, marzec, Matt,").."\n"
--   creditsString += alignText( "'niff, rel, Ron, Sara, Shelby," )            + chr( 10 )
  creditsString = creditsString..alignText("'niff, rel, Ron, Sara, Shelby,").."\n"
--   creditsString += alignText( "Stephanie (both!), The O.B.'s" )             + chr( 10 )
  creditsString = creditsString..alignText("Stephanie (both!), The O.B.'s").."\n"
--   creditsString += ""                                                       + chr( 10 )
--   creditsString += alignText( "Anyone else I missed... Love ya." )          + chr( 10 )
  creditsString = creditsString..alignText("Anyone else I missed... Love ya.").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "The Testers:" )                              + chr( 10 )
  creditsString = creditsString..alignText("The Testers:").."\n"
--   creditsString += alignText( "Deleter, Kiwi Dan, Lachie Dazdarian," )      + chr( 10 )
  creditsString = creditsString..alignText("Deleter, Kiwi Dan, Lachie Dazdarian,").."\n"
--   creditsString += alignText( "Pritchard, Ryan Szrama, syn9," )             + chr( 10 )
  creditsString = creditsString..alignText("Pritchard, Ryan Szrama, syn9,").."\n"
--   creditsString += alignText( "voodooattack, Virus Scanner" )               + chr( 10 )
  creditsString = creditsString..alignText("voodooattack, Virus Scanner").."\n"
  creditsString = creditsString.."\n"
  creditsString = creditsString.."\n"
  creditsString = creditsString.."\n"
  creditsString = creditsString.."\n"
  creditsString = creditsString.."\n"
  creditsString = creditsString..alignText("Ported to Love2D by Derek Andrews").."\n"
  creditsString = creditsString..alignText("so that this gem may continue to").."\n"
  creditsString = creditsString..alignText("be enjoyed for years to come.").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += alignText( "And, thank you for playing!" )               + chr( 10 )
  creditsString = creditsString..alignText("And, thank you for playing!").."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--   creditsString += ""                                                       + chr( 10 )
  creditsString = creditsString.."\n"
--
--
--
--
--   dim as integer creditY
  local creditY = 0
--   creditY = 200
  creditY = 200
--
--   do
  repeat
    love.graphics.clear()
--     creditY -= 1
    creditY = creditY - 1
--   	graphicalString( creditsString, 0, creditY, 15 )
    graphicalString(creditsString, 0, creditY, 15)
--
--     fb_ScreenRefresh()
    coroutine.yield()
--     sleep 80
    sleep(80)
-- '    if multikey( sc_space ) = 0 then
-- '      sleep 60
-- '
-- '    end if
--     fb_GetKey()
--     if fb_WindowKill() then end
--
-- 	loop until creditY < ( 200 - ( 90 * 16 ) )
  until creditY < (200 - (104 * 16))
--
-- 	cls
--
-- end sub
end

-- sub LL_RollCredits()
function LL_RollCredits()
--
-- 	if stillPlaying() then exit sub
--
--   dim as double timeDelay
  local timeDelay = 0.0
--   dim as string currentText
  local currentText = ""
--
--   cls
  clearmode = false
  love.graphics.clear()
--   fb_ScreenRefresh()
--
--   timeDelay = timer + 3
  timeDelay = timer + 3
--   currentText = "Written by Josiah Tobin,"
  currentText = "Written by Josiah Tobin,"
-- 	graphicalString( currentText, text_Center( currentText ), 88, 15 )
  graphicalString(currentText, text_Center(currentText), 88, 15)
--
--   currentText = "brought to life by cha0s"
  currentText = "brought to life by cha0s"
-- 	graphicalString( currentText, text_Center( currentText ), 104, 15 )
  graphicalString(currentText, text_Center(currentText), 104, 15)
--
--   fb_ScreenRefresh()
  coroutine.yield()
--   llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  ll_global.hero_only.songFade = create_songFading_type()
--   llg( hero_only ).songFade->pulseLength = ( 5 / 64 )
  ll_global.hero_only.songFade.pulseLength = (5 / 64)

--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()

--     if llg( hero_only ).songFade then
    if ll_global.hero_only.songFade ~= nil then
--       LLMusic_Fade()
      LLMusic_Fade()
--
--     end if
    end
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until llg( hero_only ).songFade = 0
  until ll_global.hero_only.songFade == nil
--
  repeat
--   do
--     sleep 1
    sleep(1)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until __fade_to_black( @llg( hero ) )
  until __fade_to_black(ll_global.hero) ~= 0
--
--   cls
  love.graphics.clear()
--   fb_ScreenRefresh()
  coroutine.yield()
--
--   __color_on( @llg( hero ) )
  __color_on(ll_global.hero)
--   LLMusic_Start( "data\music\holy.it" )
  LLMusic_Start("data/music/holy.it")
--
--   CreditScroll()
  CreditScroll()
--
--   __color_off( @llg( hero ) )
  __color_off(ll_global.hero)
--   dim as LLSystem_ImageHeader ptr imageWhore
--
--   imageWhore = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\title.spr" ) )
  local imageWhore = getImageHeader("data/pictures/char/title.spr")
--   '' 256, 64
--   put ( 160 - 128, 100 - 32 ), imageWhore->image
  draw(imageWhore.image, 160 - 128, 100 - 32)
--   fb_ScreenRefresh()
  coroutine.yield()
--
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until __fade_up_to_color( @llg( hero ) )
  until __fade_up_to_color(ll_global.hero) ~= 0
--
--
--   llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  ll_global.hero_only.songFade = create_songFading_type()
--   llg( hero_only ).songFade->pulseLength = ( 5 / 64 )
  ll_global.hero_only.songFade.pulseLength = (5 / 64)
--   timeDelay = timer + 4
  timeDelay = timer + 4
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
--     if llg( hero_only ).songFade then
    if ll_global.hero_only.songFade ~= nil then
--       LLMusic_Fade()
      LLMusic_Fade()
--
--     end if
    end
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until llg( hero_only ).songFade = 0
  until ll_global.hero_only.songFade == nil
--
-- 	llg( hero ).fade_time = .06
  ll_global.hero.fade_time = .06
--   do
  repeat
--     sleep 1
    sleep(1)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until __fade_to_black( @llg( hero ) )
  until __fade_to_black(ll_global.hero) ~= 0
--   __color_off( @llg( hero ) )
  __color_off(ll_global.hero)
--
--   imageWhore = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\moth_wings.spr" ) )
  imageWhore = getImageHeader("data/pictures/char/moth_wings.spr")
--   '' 96, 64
--
--   __color_off( @llg( hero ) )
--   put ( 160 - 48, 100 - 32 ), imageWhore->image
--   fb_ScreenRefresh()
--   put ( 160 - 48, 100 - 32 ), imageWhore->image
--
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
    love.graphics.clear()
    draw(imageWhore.image, imageWhore.quads[0], 160 - 48, 100 - 32)
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until __fade_up_to_color( @llg( hero ) )
  until __fade_up_to_color(ll_global.hero) ~= 0
--
--   timeDelay = timer + 2
  timeDelay = timer + 2
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
    love.graphics.clear()
    draw(imageWhore.image, imageWhore.quads[0], 160 - 48, 100 - 32)
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until timer > timeDelay
  until timer > timeDelay
--
--   dim as integer curFrame
  local curFrame = 0
--   do
  repeat
--     sleep 100, 1
    sleep(100)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
--
--     fb_ScreenRefresh()
--     put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]
    love.graphics.clear()
    draw(imageWhore.image, imageWhore.quads[curFrame], 160 - 48, 100 - 32)
--
--     if curFrame = 3 then
    if curFrame == 3 then
--       play_sample( llg( snd )[sound_rayflap2], 80 )
      ll_global.snd[sound_rayflap2]:setVolume(.8)
      ll_global.snd[sound_rayflap2]:play()
--
--     end if
    end
--
--     curFrame += 1
    curFrame = curFrame + 1
    coroutine.yield()
-- 	loop until curFrame = imageWhore->frames
  until curFrame == imageWhore.frames
-- 	curFrame -= 1
  curFrame = curFrame - 1
--
--   put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]
--
--   timeDelay = timer + 2
  timeDelay = timer + 2
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
    love.graphics.clear()
    draw(imageWhore.image, imageWhore.quads[curFrame], 160 - 48, 100 - 32)
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until timer > timeDelay
  until timer > timeDelay
--
--
--   dim as string theEnd = "The End."
  local theEnd = "The End."
--   dim as integer theEndLoc, iter
  local theEndLoc, iter = 0, 0
--   iter = 1
  iter = 1
--   do
  repeat
--     sleep 300, 1
    sleep(300)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
--
--     put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]
    love.graphics.clear()
    draw(imageWhore.image, imageWhore.quads[curFrame], 160 - 48, 100 - 32)
--
--     graphicalString( mid( theEnd, 1, iter ), text_Center( theEnd ) + 4, 168, 15 )
    graphicalString(theEnd:sub(1, iter), text_Center(theEnd) + 4, 168, 15)
--     iter += 1
    iter = iter + 1
--
--     fb_ScreenRefresh()
    coroutine.yield()
-- 	loop until iter = 9
  until iter == 9
--
--   timeDelay = timer + 3
  timeDelay = timer + 3
--   do
  repeat
--     sleep 10
    sleep(10)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until timer > timeDelay
  until timer > timeDelay
--
--   sleep
--
--   do
  repeat
--     sleep 1
    sleep(1)
    timer = love.timer.getTime()
--     fb_GetKey()
--     if fb_WindowKill() then end
    coroutine.yield()
-- 	loop until __fade_to_black( @llg( hero ) )
  until __fade_to_black(ll_global.hero) ~= 0
--
--
-- end sub
end
