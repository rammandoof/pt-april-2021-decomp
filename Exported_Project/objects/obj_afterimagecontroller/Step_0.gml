for (var i = 0; i < ds_list_size(global.afterimage_list); i++)
{
    var b = ds_list_find_value(global.afterimage_list, i);
    
    with (b)
    {
        for (var l = 0; l < array_length(alarm); l++)
        {
            if (alarm[l] >= 0)
                alarm[l]--;
        }
        
        switch (identifier)
        {
            case afterimage.mach3_effect:
                if (!(playerid.state == states.jump && playerid.sprite_index == spr_playerN_noisebombspinjump) && playerid.pizzapepper == 0 && playerid.sprite_index != spr_player_barrelroll && playerid.state != states.grabbing && playerid.state != states.parry && playerid.state != states.chainsawbump && playerid.state != states.punch && playerid.state != states.chainsawbump && playerid.state != states.rideweenie && playerid.state != states.crouchslide && playerid.state != states.grabbed && playerid.pogochargeactive == 0 && playerid.state != states.tacklecharge && playerid.state != states.mach3 && playerid.state != states.climbwall && playerid.state != states.hookshot && playerid.state != states.enemy_charge && playerid.state != states.mach2 && playerid.state != states.handstandjump && playerid.state != states.machslide && playerid.state != states.slam && playerid.state != states.mach4 && playerid.state != states.machfreefall && playerid.state != states.superslam && playerid.state != states.machroll && playerid.state != states.chainsaw && playerid.state != states.Sjump && playerid.state != states.boxxedpep)
                    alarm[0] = 0;
                
                visible = playerid.visible;
                break;
            
            case afterimage.heatattack:
                x += hsp;
                y += vsp;
                break;
        }
        
        if (alarm[1] == 0)
        {
            other.alpha[identifier] = 0;
            alarm[2] = 3;
        }
        
        if (alarm[2] == 0)
        {
            other.alpha[identifier] = 1;
            alarm[2] = 3;
        }
        
        if (alarm[0] == 0)
        {
            b = undefined;
            ds_list_delete(global.afterimage_list, i);
            i--;
        }
        else
        {
        }
    }
}
