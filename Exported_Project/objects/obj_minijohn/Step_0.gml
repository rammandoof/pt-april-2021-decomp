if (room == rm_editor)
    exit;

switch (state)
{
    case states.enemy_idle:
        scr_enemy_idle();
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
        scr_enemy_stun();
        break;
    
    case states.pizzagoblin_throw:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
    
    case states.enemy_chase:
        scr_enemy_chase();
        break;
    
    case states.pummel:
        scr_enemy_pummel();
        break;
    
    case states.enemy_staggered:
        scr_enemy_staggered();
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

if (global.stylethreshold >= 3 && ragecooldown == 0)
{
    var player = instance_nearest(x, y, obj_player);
    
    if (state == states.enemy_chase)
    {
        if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
        {
            image_xscale = -sign(x - player.x);
            sprite_index = spr_minijohn_rage1;
            image_index = 0;
            vsp = -8;
            flash = 1;
            alarm[4] = 5;
            ragecooldown = 100;
            state = states.enemy_rage;
            create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
            
            with (instance_create(x, y, obj_forkhitbox))
            {
                sprite_index = spr_bighitbox;
                mask_index = spr_bighitbox;
                ID = other.id;
            }
        }
    }
}

if (ragecooldown > 0)
    ragecooldown--;

if (state != states.enemy_stun)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.enemy_chase)
    momentum = 0;

if (state == states.enemy_walk || state == states.enemy_idle)
{
    var targetplayer = obj_player1;
    
    if (obj_player1.spotlight == 0)
        targetplayer = obj_player2;
    
    movespeed = 4;
    
    if (targetplayer.x != x)
        image_xscale = -sign(x - targetplayer.x);
    
    state = states.enemy_chase;
}

if (hitboxcreate == 0 && state == states.enemy_chase)
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_minijohn_hitbox))
        ID = other.id;
}

if (instance_exists(obj_player2))
{
    if ((obj_player2.x > (x - 400) && obj_player2.x < (x + 400)) && (y <= (obj_player2.y + 60) && y >= (obj_player2.y - 60)))
    {
        if (state != states.enemy_idle && obj_player2.state == states.mach3)
        {
            state = states.enemy_idle;
            sprite_index = scaredspr;
            
            if (x != obj_player2.x)
                image_xscale = -sign(x - obj_player2.x);
        }
    }
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
