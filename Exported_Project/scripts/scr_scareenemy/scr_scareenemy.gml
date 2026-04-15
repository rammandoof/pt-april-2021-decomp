function scr_scareenemy()
{
    var player = instance_nearest(x, y, obj_player);
    
    if (state != states.grabbed && state != states.enemy_stun && state != states.hit)
    {
        if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
        {
            if (sprite_index != scaredspr && state != states.enemy_stun && state != states.enemy_staggered && (player.state == states.chainsawbump || player.state == states.mach3 || player.state == states.rideweenie || player.state == states.rocket || player.state == states.tacklecharge || player.state == states.knightpepslopes))
            {
                state = states.enemy_idle;
                sprite_index = scaredspr;
                
                if (x != player.x)
                    image_xscale = -sign(x - player.x);
                
                scaredbuffer = 100;
                
                if (grounded)
                    vsp = -5;
            }
        }
    }
}
