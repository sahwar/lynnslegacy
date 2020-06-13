require("game/engine--object")
require("game/macros")

-- Loops over the enemies of the current room and spawns them
function set_up_room_enemies(enemies)
    -- Dim As Integer setup
    --
    --
    -- For setup = 0 To enemies - 1
  for setup = 1, #enemies do
    --   '' cycle thru these enemies
    --
    --   With enemy[setup]
    local enemy = enemies[setup]
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If .spawn_info->wait_n > 0 Then
    --
    --         If LLObject_SpawnWait( Varptr( enemy[setup] ) ) <> 0 Then
    --
    --           '' done waiting
    --
    --           LLSystem_CopyNewObject( enemy[setup] )
    LLSystem_ObjectLoad(enemy)
    --
    --         Else
    --           Dim As String oldid
    --
    --           oldid = enemy[setup].id
    --
    --           LLSystem_ObjectDeepCopy( enemy[setup], *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( "data\object\null.xml" ) ) )
    --           enemy[setup].id = oldid
    --
    --         End If
    --
    --       Else
    --
    --         LLSystem_CopyNewObject( enemy[setup] )
    --
    --       End If
    --
    --     Else
    --
    --     '' if regular then spawn
    --       LLSystem_CopyNewObject( enemy[setup] )
    --
    --     End If
    --
    --     '' setting a couple last vars
    --     .num = setup
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If LLObject_SpawnKill( Varptr( enemy[setup] ) ) <> 0 Then
    --         '' all conditions met to kill
    --
    --         __make_dead  ( Varptr( enemy[setup] ) )
    --         __cripple  ( Varptr( enemy[setup] ) )
    --
    --         If(                                     _
    --             ( .unique_id = u_chest         ) Or _
    --             ( .unique_id = u_bluechest     ) Or _
    --             ( .unique_id = u_bluechestitem ) Or _
    --             ( .unique_id = u_ghut          ) Or _
    --             ( .unique_id = u_button        ) Or _
    --             ( .unique_id = u_gbutton       )    _
    --           ) Then
    --           .current_anim = 1
    --
    --         End If
    --
    --
    --         .seq_release = 0
    --
    --         .spawn_kill_trig = -1
    --
    --
    --         if .unique_id = u_biglarva then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --         if .unique_id = u_ghut then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --       End If
    --
    --     End If
    --
    --   End With
    --
    --   #IfDef LL_LOGRoomEnemySetup
    --     LLSystem_Log( "Initialized room["& llg( this_room ).i &"] enemy " & setup, "set_up_room_enemies.txt" )
    --
    --   #EndIf
    --
    -- Next
  end
end

function enemy_main()
  -- With now_room()
  --
  --   If .enemies > 0 Then
  --     act_enemies( .enemies, .enemy )
  act_enemies(now_room().enemies)
  --
  --   End If
  --   If .temp_enemies > 0 Then
  --     act_enemies( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
  --
  --   End If
  --
  -- End With
end

function act_enemies(enemies)
  -- Dim As Integer do_stuff
  --
  -- For do_stuff = 0 To _enemies - 1
  for i = 1, #enemies do
  --
  --
  --   With _enemy[do_stuff]
    local enemy = enemies[i]
  --
  --     If LLObject_IsWithin( Varptr( _enemy[do_stuff] ) ) Then
    if LLObject_IsWithin(enemy) then
  --
  --       If ( .seq_paused <> 0 ) And ( llg( seq ) <> 0 ) Then
      --TODO: Actually port the above if statement once we understand the sequence system.
      if false then
  --
  --       Else
      else
  --
  --
  --         .seq_paused = 0
  --
  --
  --         if .unique_id = u_healthguy then
  --           __healthguy_branch( Varptr( _enemy[do_stuff] ) )
  --
  --         end if
  --
  --
  --         If .unique_id <> u_sparkle Then
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
  --
  --             If ( .unique_id <> u_savepoint ) And ( .unique_id <> u_menu ) Then
  --
  --               Continue For
  --
  --             End If
  --
  --           End If
  --
  --
  --           .last_cycle_ice = .on_ice
  --           .on_ice = 0
  --
  --           check_ice( _enemy[do_stuff] )
  --
  --
  --           If .unique_id = u_core Then
  --             '' Hack Fest!!!!!!!!!!!!
  --
  --             If llg( now )[725] Then
  --
  --               Dim As Integer enemyIterate, stateConfirm
  --               stateConfirm = -1
  --               Select Case .shifty_state
  --               '' if wave dead then advance
  --                 Case 0
  --                   .shifty_state += 1
  --                   For enemyIterate = 5 To 10
  --                     now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                   Next
  --                   play_sample( sound_turret, 80 )
  --                   .unstoppable_by_object = 0
  --
  --                 Case 1
  --                   '' 5- 10
  --                   For enemyIterate = 5 To 10
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 11 To 18
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 2
  --                   '' 11 - 18
  --                   For enemyIterate = 11 To 18
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 19 To 28
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 3
  --                   '' 19 - 28
  --                   For enemyIterate = 19 To 28
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 29 To 48
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 4
  --                   '' 29 - 48
  --                   For enemyIterate = 29 To 48
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 0 To 7
  --                       .anim[.current_anim]->frame[0].face[enemyIterate].invincible = 0
  --
  --                     Next
  --                     .invincible = 0
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .jump_state )
  --
  --                   End If
  --
  --                 Case 5
  --                   '' core vulnerable
  --
  --               End Select
  --
  --             End If
  --
  --           End If
  --
  --
  --
  --           If llg( hero_only ).attacking <> 0 Then
  --             LLObject_MAINAttack( 1, Varptr( _enemy[do_stuff] ), Varptr( llg( hero ) ) )
  --
  --           End If
  --
  --
  --           If ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Then
  --
  --             If .hit <> 0 Then
  --               '' This is how all hit state shifts should be handled.
  --               '' This runs parallel to any running state.
  --               If __anger_flyback( Varptr( _enemy[do_stuff] ) ) <> 0 Then
  --
  --                 .hit = 0
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --           If ( .unique_id = u_beamcrystal ) Or _
  --              ( .unique_id = u_boss5_right ) Or _
  --              ( .unique_id = u_boss5_down ) Or _
  --              ( .unique_id = u_boss5_left ) Or _
  --              ( .unique_id = u_boss5_crystal ) Then
  --
  --             LLObject_ProjectileDamage( now_room().enemies, now_room().enemy, Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If ( .on_ice <> 0 ) Then
  --
  --             __calc_slide( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .on_ice = 0 Then
  --             __stop_grip( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If .walk_hold = 0 Then
  --
  --             If .walk_steps = 0 Then
  --               __momentum_move ( Varptr( _enemy[do_stuff] ) )
  --
  --             End If
  --
  --           End If
  --
  --
  --
  --           If  .hurt <> 0 Then
  --             '' this enemy is showing damage effects
  --
  --             If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
  --
  --             Else
  --
  --               If  .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
  --                 '' the enemy called back (damage is done)
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
  --
  --                 If .unique_id = u_ferus Then
  --
  --                   LLObject_ClearProjectiles( _enemy[do_stuff] )
  --                   .radius = Timer
  --
  --
  --                 End If
  --
  --                 If .unique_id = u_grult Then
  --
  --                   LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
  --                   .funcs.current_func[.funcs.active_state] = 2
  --
  --                 End If
  --
  --                 LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
  --                 .flash_count = 0
  --                 .flash_timer = 0
  --                 .invisible = 0
  --
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --           If .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
  --             '' if function block reaches end, return to beginning.
  --
  --             .funcs.current_func[.funcs.active_state] = 0
  --
  --           End If
  --
  --
  --           If .dead = 0 Then
  --             '' entity is not dead
  --
  --             If .hp <= 0 Then
  --               '' entity is below the hp limit (marked for death)
  --
  --
  --
  --               If .dead_sound <> 0 Then
  --                 play_sample( llg( snd )[.dead_sound] )
  --
  --               End If
  --
  --               LLObject_ShiftState( Varptr( _enemy[do_stuff] ), _enemy[do_stuff].death_state )
  --
  --             End If
  --
  --             If .dead = 0 Then
  --               If .froggy <> 0 Then
  --                 '' this entity can become mad
  --
  --
  --                 If ( .mad = 0 ) Then
  --                   '' entity is not mad
  --
  --                   If ( .funcs.active_state < .reset_state ) Then
  --
  --                     '' entity is not resetting
  --
  --                     '' implicit proximity detection
  --                     .funcs.active_state = in_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --               If .mad <> 0 Then
  --                 '' entity is mad
  --
  --                 '' see if its far enough to get a reset
  --                 .funcs.active_state = out_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --           If .projectile Then
  --             If .projectile->active <> 0 Then
  --               '' projectile triggered
  --
  --               __do_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --             End If
  --
  --           End If
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
  --             '' the entity is pushable
  --
  --             __push ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
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
  --             '' no sequence happening already
  --
  --
  --             If llg( hero ).switch_room = -1 Then
  --
  --               If .action_sequence <> 0 Then
  --                 '' ths entity loads a sequence when you action it
  --
  --                 If llg( hero_only ).action <> 0 Then
  --
  --                   LLObject_ActionSequence( Varptr( _enemy[do_stuff] ) )
  --
  --                 End If
  --
  --
  --               End If
  --
  --
  --
  --
  --               If .touch_sequence <> 0 Then
  --                 '' ths entity loads a sequence when you touch it
  --
  --                 LLObject_TouchSequence( Varptr( _enemy[do_stuff] ) )
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --           If .grult_proj_trig <> 0 Then
  --
  --
  --             '' projectile triggered (concurrent functionality)
  --             __do_grult_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --             LLObject_CheckGTorchLit( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If .anger_proj_trig <> 0 Then
  --             __do_anger_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_grult Then
  --
  -- '              If .funcs.active_state <> .stun_state Then
  --             If .funcs.active_state = 0 Or ( .funcs.active_state = .proj_state )Then
  --
  --
  --               If llg( dark ) <> 4 Then
  --                 '' stunned
  --
  --                 .stun_return_trig = 0
  --                 LLObject_ClearProjectiles( _enemy[do_stuff] )
  --                 .fly_timer = 0
  --                 .fly_count = 0
  --                 .grult_proj_trig = 0
  --
  --
  --                 .jump_counter = 0
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
  --
  --               End If
  --
  --             Else'If (.funcs.active_state = .stun_state) Or (.funcs.active_state = .hit_state) Then
  --
  --
  --               If (.stun_return_trig = 0) Then
  --
  -- '                    If now_room().dark = 4 Then
  --                 If llg( dark ) = 4 Then
  --                   .stun_return_trig = 1
  --
  --                 End If
  --                   '' un-stunned!
  --
  --                 If .stun_return_trig = 1 Then
  --
  --                   If .dead = 0 Then
  --
  --                     .jump_counter = 0
  --
  --                     .hurt = 0
  --
  --
  --                     LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
  --
  --                     .fly_count = 0
  --                     .fly_timer = 0
  --                     .flash_timer = 0
  --                     .invisible = 0
  --                     .mad =  0
  --
  --                     .invincible = -1
  --
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
  --
  --
  --
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --
  --           If .spawn_cond <> 0 Then
  --             LLObject_CheckSpawn( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_gbutton Then
  --
  --             Dim As LLObject_CollisionType collisionCheck
  --             Dim As Integer buttonSet, rockCheck
  --
  --             collisionCheck = LLObject_Collision( llg( hero ), _enemy[do_stuff] )
  --             If collisionCheck.isColliding = -1 Then
  --               buttonSet = -1
  --
  --             End If
  --
  --             If buttonSet = 0 Then
  --
  --               For rockCheck = 0 To now_room().enemies - 1
  --
  --                 If now_room().enemy[rockCheck].unique_id = u_pushrock Then
  --                   collisionCheck = LLObject_Collision( now_room().enemy[rockCheck], _enemy[do_stuff] )
  --                   If collisionCheck.isColliding = -1 Then
  --                     buttonSet = -1
  --                     Exit For
  --
  --                   End If
  --
  --                 End If
  --
  --               Next
  --
  --             End If
  --
  --             .funcs.active_state = IIf( buttonSet, 1, 0 )
  --
  --
  --
  --
  --           End If
  --
  --           If ( .unique_id = u_gold ) Or ( .unique_id = u_silver ) Or ( .unique_id = u_health ) Then
  --             '' this is loot to pick up
  --
  --             LLObject_GrabItems( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_ltorch Then
  --
  --             LLObject_TorchModify( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If  .dmg.id <> 0 Then
  --             '' enemy was hit by lynn
  --
  --             __flashy( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If Timer > .walk_hold Then .walk_hold = 0
  --
  --
  --
  --             If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
  --
  --               LLEngine_ExecuteConcurrents( Varptr( _enemy[do_stuff] ) )
  --
  --
  --             End If
  --
  --           If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
  --
  --             If .dead = 0 Then
  --
  --               If .sway <> 0 Then
  --
  --                 If Timer > .sway Then
  --                   __dyssius_jump_slide( Varptr( _enemy[do_stuff] ) )
  --                   .sway = 0
  --
  --                   .fly_count = 0
  --                   .fly_timer = 0
  --                   .flash_timer = 0
  --                   .invisible = 0
  --                   .hurt = 0
  --
  --                   If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
  --
  --                     LLObject_ClearProjectiles( _enemy[do_stuff] )
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --         End If
  --
  --         .funcs.current_func[.funcs.active_state] += .funcs.func[.funcs.active_state][.funcs.current_func[.funcs.active_state]] ( VarPtr( _enemy[do_stuff] ) )
        --log.debug("enemy.funcs.active_state: "..enemy.funcs.active_state)
        --log.debug("enemy.funcs.current_func[enemy.funcs.active_state]: "..enemy.funcs.current_func[enemy.funcs.active_state])
        local result = enemy.funcs.func[enemy.funcs.active_state][enemy.funcs.current_func[enemy.funcs.active_state]](enemy)
        --log.debug("result: "..(result and result or "nil"))
        enemy.funcs.current_func[enemy.funcs.active_state] = enemy.funcs.current_func[enemy.funcs.active_state] + result
--NOTE: The above line should be ported to Lua first as it is what actually performs the function execution.
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
  end
  --
  -- If _enemy = Varptr( now_room().temp_enemy( 0 ) ) Then
  --   maintain_temps( Varptr( now_room() ) )
  --
  -- End If

end

--Function move_object( o As char_type Ptr, only_looking As Integer = 0, moment As Double = 1, recurring As Integer = 0 ) As uInteger
function move_object(o, only_looking, moment, recurring)
  log.debug("move_object called.")
    -- Dim As Integer mx, my '' holds open axes
   local mx, my = 0, 0
    --
    -- Select Case o->direction
    --
    --   Case 0
  if o.direction == 0 then
    log.debug("o.direction is 0.")
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or o.unstoppable_by_screen then
      log.debug("o.coords.y: "..o.coords.y)
      log.debug("o.unstoppable_by_screen: "..o.unstoppable_by_screen)
    --       '' object "y" is bigger than 0, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, only_looking or recurring) or o.unstoppable_by_tile ~= 0 then
        log.debug("check_walk(o, 0, only_looking or recurring): "..(check_walk(o, 0, only_looking or recurring) and "true" or "false"))
        log.debug("o.unstoppable_by_tile: "..o.unstoppable_by_tile)
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, o) ~= 1 or o.unstoppable_by_object then
          log.debug("check_against_entities(0, o): "..(check_against_entities(0, o) and "true" or "false"))
          log.debug("o.unstoppable_by_object: "..o.unstoppable_by_object)
          log.debug("only_looking: "..only_looking)
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
            log.debug("only_looking: "..only_looking)
            log.debug("moment: "..moment)
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
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --
    --   Case 2
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
    --
    --           End If
    --
    --           my = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --   Case 3
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --   Case 4
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
    --
    --           End If
    --
    --           my = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --   Case 5
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
    --
    --           End If
    --
    --           my = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --
    --       End If
    --
    --     End If
    --
    --   Case 6
    --
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
    --
    --           End If
    --
    --           my = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --   Case 7
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
    --
    --           End If
    --
    --           my = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
    --
    --
    --           If only_looking = 0 Then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
    --
    --           End If
    --
    --           mx = 1
    --
    --         End If
    --
    --       End If
    --
    --     End If
    --
    --
    -- End Select
    --
    --
    -- Return ( mx Shl 16 ) Or my
  return bit.bor(bit.lshift(mx, 16), my)

end

  -- Function check_walk ( o As char_type Ptr, d As Integer, psfing = 0 ) Static
function check_walk(o, d, psfing)
  psfing = psfing or 0
  --
  --   If ( o->coords.x < 0 ) Or ( o->coords.y < 0 ) Or ( ( o->coords.x + o->perimeter.x ) > ( now_room().x Shl 4 ) ) Or ( ( o->coords.y + o->perimeter.y ) > ( now_room().y Shl 4 ) ) Then
  --     Return FALSE
  --
  --   End If
  --
  --
  --   Dim As Integer x_offset_2, y_offset_2, x_tile_2, y_tile_2, quads_x, quads_y, x_aligned, y_aligned
  --   dim as integer t_index
  --   Dim As Integer layer
  --   Dim As Integer crawl_axis, crawl
  --   Dim As Integer x_opt, y_opt
  --   Dim As Integer tile_free, psf_free
  --
  --   x_aligned = 0
  --   y_aligned = 0
  --
  --   x_tile_2 = Int( o->coords.x ) Shr 3
  --   y_tile_2 = Int( o->coords.y ) Shr 3
  --
  --   x_offset_2 = Int( o->coords.x ) And 7
  --   y_offset_2 = Int( o->coords.y ) And 7
  --
  --   quads_x = Int( o->perimeter.x ) Shr 3
  --   quads_y = Int( o->perimeter.y ) Shr 3
  --
  --   If x_offset_2 <> 0 Then
  --     quads_x += 1
  --
  --   Else
  --     x_aligned = 1
  --
  --   End If
  --
  --   If y_offset_2 <> 0 Then
  --     quads_y += 1
  --
  --   Else
  --     y_aligned = 1
  --
  --   End If
  --
  --   '' prime
  --   if psfing then
  --     psf_free = TRUE
  --
  --   else
  --     tile_free = TRUE
  --
  --   end if
  --
  --     Select Case d Mod 2
  --
  --       Case 0
  --
  --         crawl_axis = quads_x
  --
  --       Case 1
  --
  --         crawl_axis = quads_y
  --
  --     End Select
  --
  --
  --     For layer = 0 To 2
  --
  --
  --       For crawl = 0 To crawl_axis - 1
  --
  --
  --         Select Case d
  --
  --
  --           Case 0
  --
  --             x_opt = ( x_tile_2 + crawl )
  --             y_opt = ( y_tile_2 - y_aligned )
  --
  --           Case 1
  --
  --             x_opt = ( quads_x - 1 ) + x_tile_2 + x_aligned
  --             y_opt = ( y_tile_2 + crawl )
  --
  --           Case 2
  --
  --             x_opt = ( x_tile_2 + crawl )
  --             y_opt = ( quads_y - 1 ) + y_tile_2 + y_aligned
  --
  --           Case 3
  --
  --             x_opt = ( x_tile_2 - x_aligned )
  --             y_opt = ( y_tile_2 + crawl )
  --
  --
  --         End Select
  --
  --         t_index = ( ( y_opt Shl 3 ) Shr 4 ) * now_room().x + ( ( x_opt Shl 3 ) Shr 4 )
  --
  --         If Bit( now_room().layout[layer][t_index], 15 - quad_calc( x_opt, y_opt ) ) <> 0 Then
  --           if psfing then
  --             psf_free = FALSE
  --
  --           else
  --             tile_free = FALSE
  --
  --           end if
  --
  --         End If
  --
  --       Next
  --
  --     Next
  --
  --
  --   If tile_free = FALSE Then
  --
  --     If psfing = FALSE Then
  --
  --       If o->unique_id = u_lynn Then
  --         check_psf( o, d )
  --
  --       Else
  --         If o->unique_id = u_pushrock Then
  --           check_psf( o, d )
  --
  --         End If
  --
  --       End If
  --
  --     End If
  --
  --   End If
  --
  --
  --   if psfing then
  --     Return psf_free
  --   else
  --
  --     Return tile_free
  --   end if
  --
  --
  --
  --FIXME: Just returning true for now instead of porting, so we can see something moving sooner. Remove
  return true
  -- End Function

end

-- Function check_against_entities( d As Integer = 0, o As char_type Ptr ) As Integer' Static
function check_against_entities(d, o)
  d = d or 0
--
--
--   Dim As Integer cycle, relay
--
--
--   With now_room()
--
--     If .enemies = 0 Then
--       '' there are no objects to collide with in this room
--       Return 0
--
--     End If
--
--     For cycle = 0 To .enemies - 1
--       '' cycle thru enemies
--
--       If o->num <> .enemy[cycle].num Then
--         '' if this "o" isn't this enemy, then check it against this enemy
--         relay = check_against( o, .enemy, cycle, d )
--         If relay Then Return relay
--
--       End If
--
--     Next
--
--
--
--     For cycle = 0 To .temp_enemies - 1
--       '' cycle through temp enemies
--
--       If o->num <> .temp_enemy( cycle ).num Then
--         '' if this "o" isn't this temp enemy, then check it against this temp enemy
--         relay = check_against( o, Varptr( .temp_enemy( 0 ) ), cycle, d )
--         If relay Then Return relay
--
--       End If
--
--     Next
--
--   End With
--
--
--
--   If o->unique_id <> u_lynn Then
--     '' if this "o" isn't lynn, check the "o" against her
--
--     If llg( hero_only ).attacking = 0 Then
--       relay = check_against( o, Varptr( llg( hero ) ), 0, d )
--       If relay Then Return relay
--
--     End If
--
--   End If
--
--
--
-- End Function
  --FIXME: Returning 0 while porting just so we can get something moving without
  --collision checks. Remove.
  return 0
end
