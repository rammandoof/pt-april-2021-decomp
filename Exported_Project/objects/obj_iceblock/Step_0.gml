if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state != states.gotoplayer && place_meeting(x, y + 1, other))
        {
            if (state == states.knightpep)
            {
                state = states.knightpepslopes;
            }
            else if (state != states.knightpepslopes)
            {
                state = states.slipnslide;
                sprite_index = spr_slipnslide;
            }
            
            if (movespeed < 12)
                movespeed = 12;
        }
    }
}
