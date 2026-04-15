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

if (state != states.enemy_stun)
    birdcreated = 0;

if (state == states.enemy_walk && y > ystart && !scr_solid(x, y - 1))
    y--;

if (state == states.enemy_walk && y < ystart && !scr_solid(x, y + 1))
    y++;

if (state == states.enemy_stun)
    grav = 0.5;
else
    grav = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.enemy_charge)
    scr_scareenemy();

if (sprite_index == spr_ancho_chargestart && floor(image_index) == (image_number - 1))
{
    if (hitboxcreate == 0 && state == states.enemy_charge)
    {
        hitboxcreate = 1;
        
        with (instance_create(x, y, obj_forkhitbox))
            ID = other.id;
    }
    
    sprite_index = spr_ancho_charge;
    movespeed = 10;
}

var player = instance_nearest(x, y, obj_player);

if (ragebuffer > 0)
    ragebuffer--;

if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
{
    if (state != states.enemy_rage && ragebuffer == 0 && global.stylethreshold >= 3 && (state == states.enemy_walk || state == states.enemy_charge))
    {
        state = states.enemy_rage;
        sprite_index = spr_ancho_rage1;
        
        if (x != player.x)
            image_xscale = -sign(x - player.x);
        
        ragebuffer = 100;
        image_index = 0;
        image_speed = 0.5;
        flash = 1;
        alarm[4] = 5;
        
        with (instance_create(x, y, obj_forkhitbox))
        {
            sprite_index = spr_bighitbox;
            mask_index = spr_bighitbox;
            ID = other.id;
        }
        
        create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
    }
    else if (x != player.x && state != states.enemy_charge && y == ystart)
    {
        if (state == states.enemy_walk)
        {
            image_index = 0;
            image_xscale = -sign(x - obj_player.x);
            state = states.enemy_charge;
            sprite_index = spr_ancho_chargestart;
        }
    }
}

if (state == states.enemy_stun || state == states.enemy_walk)
    movespeed = 0;

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
