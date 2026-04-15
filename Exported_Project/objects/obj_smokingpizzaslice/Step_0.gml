if (room == rm_editor)
    exit;

if (bombreset > 0)
    bombreset--;

switch (state)
{
    case states.enemy_walk:
        if (substate_buffer > 0)
        {
            substate_buffer--;
        }
        else
        {
            substate_buffer = substate_max;
            var old_substate = substate;
            
            while (substate == old_substate)
                substate = choose(states.enemy_walk, states.enemy_idle, states.enemy_turn, states.pizzagoblin_throw);
            
            if (substate == states.enemy_walk)
            {
                image_xscale = choose(-1, 1);
            }
            else if (substate == states.enemy_turn)
            {
                sprite_index = spr_pizzaslug_turn;
                image_index = 0;
                hsp = 0;
            }
        }
        
        switch (substate)
        {
            case states.enemy_walk:
                image_speed = 0.35;
                
                if (sprite_index != spr_pizzaslug_walk)
                {
                    image_index = 0;
                    sprite_index = spr_pizzaslug_walk;
                }
                
                scr_enemy_walk();
                break;
            
            case states.enemy_idle:
                image_speed = 0.35;
                hsp = 0;
                sprite_index = spr_pizzaslug_idle;
                break;
            
            case states.enemy_turn:
                image_speed = 0.35;
                substate_buffer = 5;
                
                if (sprite_index == spr_pizzaslug_turn && floor(image_index) == (image_number - 1))
                {
                    image_xscale *= -1;
                    substate_buffer = substate_max;
                    substate = states.enemy_idle;
                    sprite_index = spr_pizzaslug_idle;
                }
                
                break;
            
            case states.pizzagoblin_throw:
                state = states.pizzagoblin_throw;
                substate_buffer = 0;
                image_index = 0;
                sprite_index = spr_pizzaslug_cough;
                break;
        }
        
        break;
    
    case states.enemy_idle:
        scr_enemy_idle();
        break;
    
    case states.enemy_turn:
        scr_enemy_turn();
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

if (global.stylethreshold >= 3 && ragecooldown == 0)
{
    var player = instance_nearest(x, y, obj_player);
    
    if (state == states.enemy_walk)
    {
        if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
        {
            if (x != player.x)
                image_xscale = -sign(x - player.x);
            
            image_speed = 0.6;
            hsp = 0;
            shot = 0;
            sprite_index = spr_pizzaslug_rage;
            image_index = 0;
            state = states.enemy_rage;
            flash = 1;
            alarm[4] = 5;
            create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
        }
    }
}

if (ragecooldown > 0)
    ragecooldown--;

scr_scareenemy();

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
