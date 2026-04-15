if (room == rm_editor)
    exit;

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
        scr_enemy_stun();
        break;
    
    case states.pizzagoblin_throw:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
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

if (state == states.enemy_stun && lasthp != hp && !tired && grounded)
{
    tired = 1;
    stunned = 10;
    lasthp = hp;
    killprotection = 0;
}

if (state != states.enemy_stun)
    birdcreated = 0;

if (stuntouchbuffer > 0)
    stuntouchbuffer--;

if (!instance_exists(spawnenemyID) && state == states.enemy_walk)
{
    state = states.enemy_idle;
    sprite_index = spr_tank_spawnenemy;
    image_index = 0;
    
    with (instance_create(x, y - 18, content))
    {
        important = 1;
        other.spawnenemyID = id;
    }
}

var player = instance_nearest(x, y, obj_player);

if (bombreset > 0)
    bombreset--;

if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
{
    if (state != states.enemy_rage && bombreset <= 0 && global.stylethreshold >= 3 && state == states.enemy_walk)
    {
        state = states.enemy_rage;
        sprite_index = spr_tank_chargestart;
        
        if (x != player.x)
            image_xscale = -sign(x - player.x);
        
        ragebuffer = 100;
        image_index = 0;
        image_speed = 0.5;
        flash = 1;
        alarm[4] = 5;
        bombreset = 200;
        create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
    }
    else if (x != player.x && state != states.enemy_rage && grounded && bombreset <= 0)
    {
        if (state == states.enemy_walk)
        {
            state = states.pizzagoblin_throw;
            hsp = 0;
            sprite_index = spr_tank_shoot;
        }
    }
}

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (hitboxcreate == 0 && state == states.enemy_rage)
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_minijohn_hitbox))
        ID = other.id;
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
        baddieID = other.id;
        other.boundbox = 1;
    }
}
