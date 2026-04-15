function scr_hurtplayer(argument0)
{
    with (argument0)
    {
        if (global.failcutscene)
            continue;
        
        if (state == states.mach3 || (state == states.grab && sprite_index == spr_swingding))
        {
            if (state == states.grab)
            {
                var _gby = (object_index == obj_player1) ? 1 : 2;
                
                with (obj_baddie)
                {
                    if (state == states.grabbed && grabbedby == _gby)
                        instance_destroy();
                }
            }
            
            state = states.parry;
            sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
            image_index = 0;
            image_speed = 0.35;
            taunttimer = 20;
            movespeed = 8;
            parry_inst = -4;
            parry_count = parry_max;
            
            with (instance_create(x, y, obj_parryeffect))
                image_xscale = other.xscale;
            
            flash = 1;
        }
        else if (state == states.parry)
        {
        }
        else if (state == states.backbreaker || state == states.chainsaw)
        {
        }
        else if (state == states.firemouth)
        {
        }
        else if (state == states.fireass)
        {
        }
        else if ((state == states.knightpep || state == states.knightpepattack || state == states.knightpepslopes) && cutscene == 0)
        {
        }
        else if (state == states.ghost)
        {
        }
        else if (state == states.slipnslide)
        {
        }
        else if (state == states.chainsawbump)
        {
        }
        else if (state == states.bombpep && hurted == 0)
        {
        }
        else if (state == states.rideweenie)
        {
        }
        else if (state == states.barrel)
        {
        }
		else if state == states.debugstate
		{
		}
        else if (state == states.boxxedpep)
        {
            hsp = -xscale * 4;
            vsp = -5;
            state = states.bump;
            sprite_index = spr_bump;
            alarm[5] = 2;
            alarm[8] = 60;
            alarm[7] = 120;
            hurted = 1;
        }
        else if (state == states.tumble)
        {
        }
        else if (pizzashield == 1)
        {
            pizzashield = 0;
            
            with (instance_create(x, y, obj_sausageman_dead))
                sprite_index = spr_pizzashield_collectible;
            
            hsp = -xscale * 4;
            vsp = -5;
            state = states.bump;
            sprite_index = spr_bump;
            invhurt_buffer = 120;
            alarm[8] = 60;
            alarm[7] = 120;
            hurted = 1;
            scr_soundeffect(sfx_pephurt);
        }
        else if (state != states.hurt && state != states.grabbed && (hurted == 0 || state == states.cheesepep || state == states.cheesepepstickside || state == states.cheesepepstickup) && cutscene == 0)
        {
            if (instance_exists(obj_hardmode))
                global.heatmeter_count = (global.heatmeter_threshold - 1) * global.heatmeter_threshold_count;
            
            if (instance_exists(obj_bosscontroller))
                obj_bosscontroller.player_hp -= 30;
            
            global.combo = 0;
            global.combotime = 0;
            global.heattime = 0;
            global.style -= 25;
            
            if (character == "V")
                global.playerhealth -= 25;
            
            if (state == states.mort)
            {
                with (instance_create(x, y, obj_sausageman_dead))
                    sprite_index = spr_mortdead;
                
                repeat (6)
                {
                    with (instance_create(x, y, obj_debris))
                        sprite_index = spr_feather;
                }
                
                grav = 0.5;
            }
            
            if (global.pizzadelivery == 0)
            {
                with (instance_create(x, y, obj_smallnumber))
                {
                    negative = 1;
                    number = "-50";
                }
            }
            
            if (global.pizzadelivery == 1)
            {
                if (global.hp > 1)
                {
                    global.hp -= 1;
                    
                    with (obj_camera)
                        healthshaketime = 60;
                }
                else
                {
                    with (obj_music)
                        arena = 0;
                    
                    vsp = -20;
                    global.hp = 0;
                    global.pizzadelivery = 0;
                    cutscene = 1;
                    
                    with (instance_create(x, y, obj_debris))
                        sprite_index = spr_healthpickupeaten;
                    
                    with (instance_create(0, 0, obj_cutscene_handler))
                    {
                        var player = other;
                        scene_info = [[cutscene_taxi_start, player], [cutscene_waitfor_sprite, player], [cutscene_set_sprite, player, spr_player_outofpizza2, 0.5, player.xscale], [cutscene_player_check_ground, player], [cutscene_set_sprite, player, spr_player_outofpizza3, 0.5, player.xscale], [cutscene_waitfor_sprite, player], [cutscene_set_sprite, player, spr_player_outofpizza4, 0.5, player.xscale], [cutscene_taxi_end, player, forest_4]];
                    }
                }
            }
            
            if (state == states.grabbed)
            {
                if (object_index == obj_player1)
                    y = obj_player2.y;
                else
                    y = obj_player1.y;
            }
            
            scr_soundeffect(sfx_pephurt);
            alarm[8] = 100;
            alarm[7] = 50;
            hurted = 1;
            
            if (xscale == other.image_xscale)
                sprite_index = spr_hurtjump;
            else
                sprite_index = spr_hurt;
            
            movespeed = 12;
            vsp = -5;
            timeuntilhpback = 300;
            instance_create(x, y, obj_spikehurteffect);
            state = states.hurt;
            image_index = 0;
            flash = 1;
            global.hurtcounter += 1;
            var loseamount = 50 * (global.stylethreshold + 1);
            
            if (global.pizzadelivery == 0)
            {
                if (global.collect > loseamount)
                    global.collect -= loseamount;
                else
                    global.collect = 0;
            }
            
            if (global.pizzadelivery == 0)
            {
                if (global.collect != 0)
                {
                    if (character == "P" || character == "V")
                    {
                        repeat (10)
                        {
                            with (instance_create(x, y, obj_pizzaloss))
                                sprite_index = choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect);
                        }
                    }
                    else
                    {
                        repeat (10)
                            instance_create(x, y, obj_pizzaloss);
                    }
                }
            }
        }
    }
}
