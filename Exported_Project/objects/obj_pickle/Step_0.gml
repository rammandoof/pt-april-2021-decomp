if (room == rm_editor)
    exit;

if (!instance_exists(cloneid))
    cloneid = -4;

switch (state)
{
    case states.enemy_idle:
        scr_enemy_idle();
        break;
    
    case states.enemy_charge:
        scr_enemy_charge();
        break;
    
    case states.enemy_turn:
        scr_enemy_turn();
        break;
    
    case states.enemy_walk:
        scr_enemy_walk();
        break;
    
    case states.enemy_land:
        scr_enemy_land();
        break;
    
    case states.hit:
        scr_enemy_hit();
        break;
    
    case states.enemy_stun:
        image_alpha = 1;
        scr_enemy_stun();
        break;
    
    case states.pizzagoblin_throw:
        image_alpha = 1;
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        image_alpha = 1;
        scr_enemy_grabbed();
        break;
    
    case states.enemy_chase:
        scr_enemy_chase();
        break;
}

if (state == states.enemy_stun && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != states.enemy_stun)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.enemy_stun)
    thrown = 0;

if (state != states.enemy_chase && image_alpha >= 1)
    scr_scareenemy();

if (bombreset > 0)
    bombreset--;

if (sprite_index == scaredspr)
{
    image_alpha = 1;
    attacking = 0;
}

if (bombreset == 0 && state == states.enemy_walk)
{
    attacking = 0;
    targetplayer = global.coop ? instance_nearest(x, y, obj_player) : obj_player1;
    
    if ((targetplayer.x > (x - threshold_x) && targetplayer.x < (x + threshold_x)) && (y <= (targetplayer.y + threshold_y) && y >= (targetplayer.y - threshold_y)))
    {
        attacking = 1;
        pos = sign(x - targetplayer.x);
        state = states.enemy_chase;
        fade = 1;
    }
}

if (state == states.enemy_chase)
{
    if (fade)
    {
        if (image_alpha > 0)
        {
            if (hsp < -0.2 || hsp > 0.2)
                hsp *= 0.5;
            
            image_alpha -= fadeout_time;
        }
        else if (image_alpha <= 0)
        {
            x = targetplayer.x;
            y = targetplayer.y;
            
            if (pos != 0 && !scr_solid(x + (pos * attack_offset), y))
            {
                x = targetplayer.x + (pos * attack_offset);
                
                if (place_meeting(x, y, obj_pickle))
                {
                    if (!scr_solid(x + 32, y))
                        x += 32;
                    else if (!scr_solid(x - 32, y))
                        x -= 32;
                }
            }
            
            if (!scr_solid(x, y + 1))
            {
                var yy = y;
                var ground = 0;
                
                for (var i = 1; i < ground_check; i++)
                {
                    if (scr_solid(x, y + i))
                    {
                        ground = 1;
                        i--;
                        yy = y + i;
                        break;
                    }
                }
                
                if (ground)
                    y = yy;
            }
            
            fade = 0;
        }
    }
    else
    {
        if (image_alpha < 1)
            image_alpha += fadein_time;
        
        if (image_alpha >= 1)
        {
            image_alpha = 1;
            image_index = 0;
            sprite_index = spr_pickle_attack;
            var old_xscale = image_xscale;
            image_xscale = -sign(x - targetplayer.x);
            
            if (image_xscale == 0)
                image_xscale = old_xscale;
            
            state = states.pizzagoblin_throw;
            
            if (global.stylethreshold >= 3 && cloneid == -4)
            {
                var tx = image_xscale * 32;
                
                if (scr_solid(x + tx, y))
                    tx = 0;
                
                cloneid = instance_create(x + tx, y, obj_pickle);
                
                with (cloneid)
                {
                    cloneid = other.id;
                    important = 1;
                    bombreset = 0;
                    image_index = 0;
                    image_xscale = other.image_xscale;
                    state = states.pizzagoblin_throw;
                    hsp = other.image_xscale * 2;
                    vsp = -6;
                }
                
                flash = 1;
                alarm[4] = 5;
                create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
            }
        }
    }
}

invincible = attacking;

if (state == states.enemy_idle)
{
    if (scaredbuffer > 0 && attacking)
    {
        image_alpha = 0.8;
        invincible = 1;
    }
}

if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
