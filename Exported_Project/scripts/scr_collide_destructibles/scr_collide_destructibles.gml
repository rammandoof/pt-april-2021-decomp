function scr_collide_destructibles()
{
    for (var i = 0; i < 2; i++)
    {
        var _obj_player = asset_get_index(concat("obj_player", i + 1));
        
        with (_obj_player)
        {
            if ((state == states.jump && sprite_index == spr_playerN_noisebombspinjump) || (state == states.pogo && pogochargeactive == 1))
            {
                with (instance_place(x + xscale, y, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
                
                with (instance_place(x + hsp + xscale, y, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
                
                with (instance_place(x, y + vsp + 1, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
                
                with (instance_place(x, (y + vsp) - 1, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
                
                with (instance_place(x, y + 1, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
                
                with (instance_place(x, y - 1, obj_destructibles))
                {
                    GamepadSetVibration(0, 0.8, 0.8, 0.5);
                    instance_destroy();
                }
            }
            
            if (state == states.tumble)
            {
                with (instance_place(x + xscale, y, obj_rollblock))
                    instance_destroy();
            }
            
            if (state == states.mach3 && sprite_index == spr_player_fightball)
            {
                with (instance_place(x + xscale, y, obj_fightballblock))
                    instance_destroy();
            }
            
            if (state == states.punch || state == states.cheeseball || state == states.rocket || state == states.faceplant || state == states.slipnslide || state == states.tacklecharge || sprite_index == spr_barrelroll || state == states.crouchslide || state == states.mach2 || state == states.chainsawbump || state == states.mach3 || state == states.knightpep || state == states.machroll || state == states.knightpepslopes || state == states.tumble || state == states.hookshot || state == states.shoulderbash)
            {
                if (place_meeting(x + hsp, y, obj_destructibles))
                {
                    if (character != "V")
                    {
                        with (instance_place(x + hsp, y, obj_destructibles))
                        {
                            GamepadSetVibration(0, 0.8, 0.8, 0.5);
                            instance_destroy();
                        }
                        
                        if (state == states.mach2)
                            machpunchAnim = 1;
                    }
                }
            }
            
            if (state == states.hurt && thrown == 1)
            {
                if (place_meeting(x - hsp, y, obj_destructibles))
                {
                    with (instance_place(x - hsp, y, obj_destructibles))
                    {
                        GamepadSetVibration(0, 0.8, 0.8, 0.5);
                        instance_destroy();
                    }
                }
            }
            
            if ((state == states.knightpep || state == states.superslam || state == states.hookshot) && vsp > 0)
            {
                if (place_meeting(x, y + 1, obj_destructibles))
                {
                    with (instance_place(x, y + 1, obj_destructibles))
                    {
                        GamepadSetVibration(0, 0.8, 0.8, 0.5);
                        instance_destroy();
                    }
                }
            }
            
            if (place_meeting(x, y + 1, obj_destructibleplatform))
            {
                with (instance_place(x, y + 1, obj_destructibleplatform))
                {
                    falling = 1;
                    
                    if (falling == 1)
                        image_speed = 0.35;
                }
            }
            
            if (vsp <= 0.5 && (state == states.jump || state == states.pogo || state == states.punch || state == states.climbwall || state == states.fireass || state == states.Sjump || state == states.mach2 || state == states.mach3 || (state == states.punch && (sprite_index == spr_player_breakdanceuppercut || sprite_index == spr_player_breakdanceuppercutend))))
            {
                var vy = -1;
                
                if (state == states.punch && (sprite_index == spr_player_breakdanceuppercut || sprite_index == spr_player_breakdanceuppercutend))
                    vy = vsp;
                
                if (place_meeting(x, y + vy, obj_destructibles))
                {
                    with (instance_place(x, y + vy, obj_destructibles))
                    {
                        GamepadSetVibration(0, 0.6, 0.6, 0.5);
                        instance_destroy();
                        
                        with (other)
                        {
                            if (state != states.Sjump && state != states.punch && state != states.climbwall)
                                vsp = 0;
                            
                            if (state == states.Sjump)
                                vsp = -11;
                        }
                    }
                }
            }
            
            if (vsp >= 0 && (state == states.freefall || state == states.freefallland))
            {
                if (place_meeting(x, y + vsp + 2, obj_destructibles))
                {
                    with (instance_place(x, y + vsp + 2, obj_destructibles))
                    {
                        with (_obj_player)
                        {
                            if (place_meeting(x, y + vsp + 2, obj_bigdestructibles))
                            {
                                var _inst = instance_place(x, y + vsp + 2, obj_bigdestructibles);
                                
                                if (instance_exists(_inst))
                                {
                                    var j = 0;
                                    var _max = 256;
                                    
                                    while (!place_meeting(x, y + 1, obj_bigdestructibles))
                                    {
                                        y += 1;
                                        j++;
                                        
                                        if (j >= _max)
                                            break;
                                    }
                                }
                                
                                if (freefallsmash <= 10)
                                {
                                    if (shotgunAnim == 0)
                                        sprite_index = spr_bodyslamland;
                                    else
                                        sprite_index = spr_shotgunjump2;
                                    
                                    state = states.freefallland;
                                    image_index = 0;
                                }
                            }
                        }
                        
                        instance_destroy();
                    }
                }
            }
            
            if (state == states.freefall || state == states.freefallland)
            {
                if (place_meeting(x, y + 1, obj_metalblock) && freefallsmash > 10)
                {
                    with (instance_place(x, y + 1, obj_metalblock))
                        instance_destroy();
                }
            }
            
            if (state == states.handstandjump || state == states.punch)
            {
                with (obj_destructibles)
                {
                    if (place_meeting(x - _obj_player.hsp, y, _obj_player))
                    {
                        with (_obj_player)
                        {
                            if (place_meeting(x + hsp, y, obj_bigdestructibles))
                            {
                                sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_punch);
                                image_index = 0;
                                state = states.tackle;
                                movespeed = 3;
                                vsp = -3;
                                instance_destroy(other);
                            }
                            else if (other.object_index != obj_bigdestructibles)
                            {
                                instance_destroy(other);
                            }
                        }
                    }
                }
            }
        }
    }
}
