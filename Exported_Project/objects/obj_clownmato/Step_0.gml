switch (state)
{
    case states.enemy_walk:
        scr_enemy_walk();
        
        if ((sprite_index == spr_clownmato_land || sprite_index == spr_clownmato_bounce) && floor(image_index) == (image_number - 1))
        {
            sprite_index = spr_clownmato_fall;
            image_index = 0;
        }
        
        if (grounded)
        {
            sprite_index = spr_clownmato_land;
            image_index = 0;
            vsp = -jumpspeed;
        }
        
        break;
    
    case states.enemy_stun:
        sprite_index = stunspr;
        
        if (grounded)
            hsp = 0;
        
        if (stunbuffer > 0)
            stunbuffer--;
        
        if (stuntouchbuffer > 0)
            stuntouchbuffer--;
        else
            state = states.enemy_walk;
        
        break;
}
