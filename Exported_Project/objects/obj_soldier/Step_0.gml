if (room == rm_editor)
    exit;

switch (state)
{
    case states.enemy_idle:
        if (sprite_index != spr_soldier_idleend)
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

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

scr_scareenemy();
var player = instance_nearest(x, y, obj_player);

switch (state)
{
    case states.enemy_idle:
        if (bush)
        {
            var col = collision_line(x, y, player.x, player.y, obj_solid, false, true);
            var col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true);
            var colX = player.x > (x - threshold_x) && player.x < (x + threshold_x);
            var colY = player.y > (y - threshold_y) && player.y < (y + threshold_y);
            
            if (sprite_index != scaredspr && col == -4 && col2 == -4 && colX && colY)
            {
                if (x != player.x)
                    image_xscale = sign(player.x - x);
                
                bush = 0;
                sprite_index = spr_soldier_idleend;
                image_index = 0;
            }
        }
        else if (sprite_index == spr_soldier_idleend && floor(image_index) == (image_number - 1))
        {
            state = states.enemy_walk;
            sprite_index = spr_soldier_walk;
        }
        
        break;
    
    case states.enemy_charge:
        hsp = Approach(hsp, 0, 0.5);
        
        if (sprite_index == spr_soldier_shootstart && floor(image_index) == (image_number - 1))
            sprite_index = spr_soldier_shoot;
        
        if (sprite_index != spr_soldier_shootstart)
        {
            if (bullet_count > 0)
            {
                if (can_fire)
                {
                    can_fire = 0;
                    alarm[5] = fire_max;
                    bullet_count--;
                    sprite_index = spr_soldier_shoot;
                    image_index = 0;
                    hsp -= (image_xscale * recoil_spd);
                    
                    with (instance_create(x, y, obj_enemybullet))
                        image_xscale = other.image_xscale;
                }
            }
            else if (floor(image_index) == (image_number - 1))
            {
                sprite_index = walkspr;
                attack_cooldown = attack_max;
                state = states.enemy_walk;
            }
        }
        
        break;
    
    case states.enemy_walk:
        if (attack_cooldown > 0)
        {
            attack_cooldown--;
        }
        else
        {
            var col = collision_line(x, y, player.x, player.y, obj_solid, false, true);
            var col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true);
            var colX = player.x > (x - threshold_x) && player.x < (x + threshold_x);
            var colY = player.y > (y - threshold_y) && player.y < (y + threshold_y);
            
            if (sprite_index != scaredspr && col == -4 && col2 == -4 && colX && colY)
            {
                if (x != player.x)
                    image_xscale = sign(player.x - x);
                
                sprite_index = spr_soldier_shootstart;
                image_index = 0;
                state = states.enemy_charge;
                bullet_count = bullet_max;
                can_fire = 1;
            }
        }
        
        break;
}

if (global.stylethreshold >= 3)
{
    if (state == states.enemy_walk)
    {
        if ((player.x > (x - 200) && player.x < (x + 200)) && (y <= (player.y + 60) && y >= (player.y - 60)))
        {
            if (state != states.enemy_rage && ragebuffer == 0)
            {
                hitboxcreate = 0;
                state = states.enemy_rage;
                sprite_index = spr_soldier_knife;
                
                if (x != player.x)
                    image_xscale = -sign(x - player.x);
                
                ragebuffer = 100;
                image_index = 0;
                image_speed = 0.5;
                flash = 1;
                alarm[4] = 5;
                create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
            }
        }
    }
    
    if (ragebuffer > 0)
        ragebuffer--;
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
