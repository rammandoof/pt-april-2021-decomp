if (other.cutscene == 0 && other.state != states.freefall && other.state != states.freefallprep && other.state != states.gotoplayer)
{
    sprite_index = spr_bigmushroom_bounce;
    
    if (other.state == states.jump || other.state == states.normal)
        other.sprite_index = spr_player_machfreefall;
    
    image_index = 0;
    other.vsp = -20;
    other.jumpstop = 1;
}
