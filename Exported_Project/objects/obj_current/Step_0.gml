if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state != states.golf && state != states.gotoplayer)
        {
            if (place_meeting(x, y + 1, other))
            {
                state = states.slipnslide;
                xscale = sign(other.image_xscale);
                movespeed = 16;
                sprite_index = spr_currentplayer;
            }
        }
    }
}
