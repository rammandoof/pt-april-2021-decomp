function scr_player_knightpepslopes()
{
    if ((x + hsp) == xprevious)
        slope_buffer--;
    else
        slope_buffer = 20;
    
    alarm[5] = 2;
    alarm[7] = 60;
    hurted = 1;
    hsp = xscale * movespeed;
    
    if (sprite_index == spr_knightpepdownslope)
        movespeed = 15;
    
    if (!scr_slope())
        sprite_index = spr_knightpepcharge;
    
    if (scr_slope())
        sprite_index = spr_knightpepdownslope;
    
    if ((scr_solid(x + sign(hsp), y) && !place_meeting(x + sign(hsp), y, obj_destructibles) && !scr_slope()) || slope_buffer <= 0)
    {
        if (character == "P")
        {
            var i = 0;
            
            repeat (5)
            {
                with (create_debris(x, y, spr_knightdebris))
                    image_index = i;
                
                i++;
            }
        }
        else if (character == "N")
        {
            var i = 0;
            
            repeat (3)
            {
                with (create_debris(x, y, spr_playerN_knightarmor))
                    image_index = i;
                
                i++;
            }
        }
        else
        {
            repeat (6)
                create_debris(x, y, spr_metalblockdebris);
        }
        
        if (x != other.x)
            hsp = sign(x - other.x) * 5;
        else
            hsp = 5;
        
        vsp = -3;
        scr_soundeffect(sfx_bumpwall);
        scr_soundeffect(sfx_loseknight);
        image_index = 0;
        image_index = 0;
        flash = 1;
        state = states.bump;
    }
    
    if (movespeed <= 0 && sprite_index == spr_knightpepcharge)
    {
        sprite_index = spr_knightpepidle;
        state = states.knightpep;
    }
    
    image_speed = 0.4;
}
