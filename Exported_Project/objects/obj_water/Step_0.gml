if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state != states.gotoplayer && state != states.mach3 && state != states.parry && sprite_index != spr_mach3boost)
        {
            if (place_meeting(x, y + 1, other))
            {
                scr_losepoints();
                image_index = 0;
                state = states.fireass;
                vsp = -21;
                instance_create(x, y + 20, obj_piranneapplewater);
                sprite_index = spr_scaredjump1;
                
                with (instance_create(x, y, obj_superdashcloud))
                    sprite_index = spr_watereffect;
            }
        }
    }
}

with (instance_place(x, y - 1, obj_baddie))
    instance_destroy();
