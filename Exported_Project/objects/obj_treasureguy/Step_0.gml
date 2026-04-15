if (room == rm_editor)
    exit;

switch (state)
{
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
        scr_enemy_stun();
        break;
    
    case states.pizzagoblin_throw:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
    
    case states.enemy_rage:
        scr_enemy_rage();
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

targetplayer = global.coop ? instance_nearest(x, y, obj_player) : obj_player1;

if (state == states.enemy_walk)
{
    sprite_index = walkspr;
    hsp = 0;
}

if (state == states.enemy_idle)
{
    if (sprite_index == scaredspr)
    {
        if (image_index > (image_number - 1))
            state = states.enemy_chase;
    }
    else
    {
        sprite_index = spr_treasureguy_idle;
        image_speed = 0.35;
    }
}

if (state != states.enemy_idle && state != states.grabbed && state != states.hit && state != states.enemy_stun && state != states.enemy_chase && !running)
{
    if ((x < (targetplayer.x + threshold_x) && x > (targetplayer.x - threshold_x)) && (y < (targetplayer.y + threshold_y) && y > (targetplayer.y - threshold_y)))
    {
        state = states.enemy_idle;
        image_index = 0;
        sprite_index = scaredspr;
        scaredbuffer = scared_max;
        
        if (x != targetplayer.x)
            image_xscale = sign(x - targetplayer.x);
    }
}

if (state == states.enemy_chase)
{
    image_speed = 0.5;
    
    if (hsp != 0)
        sprite_index = spr_treasureguy_escape;
    else
        sprite_index = spr_treasureguy_escape;
    
    if (runmovespeed < runmovespeed_max)
        runmovespeed += accel;
    else
        runmovespeed = runmovespeed_max;
    
    hsp = image_xscale * runmovespeed;
    
    if (grounded)
    {
        if (scr_solid(x + sign(hsp), y))
        {
            if (!jumped)
            {
                vsp = -9;
                jumped = 1;
            }
            else
            {
                runmovespeed = 0;
                image_xscale *= -1;
                jumped = 0;
            }
        }
        else
        {
            jumped = 0;
        }
    }
    
    if (distance_to_object(targetplayer) > idle_threshold)
        state = states.enemy_walk;
}

if (state != states.grabbed)
    depth = 0;

if (state != states.enemy_stun)
    thrown = 0;

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
