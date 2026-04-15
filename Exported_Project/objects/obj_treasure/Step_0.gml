if (player == obj_grindrailslope)
{
    if (sprite_index == sprgot && obj_player1.state != states.gottreasure)
        instance_destroy();
}

if (player == obj_banditochicken_dynamite)
{
    if (sprite_index == sprgot && obj_player2.state != states.gottreasure)
        instance_destroy();
}

if (sprite_index != sprgot)
    sprite_index = spridle;

if (player == obj_hardmode && place_meeting(x, y, obj_player))
{
    var num = instance_place_list(x, y, obj_player, global.instancelist, false);
    
    for (var i = 0; i < num; i++)
    {
        var _player = ds_list_find_value(global.instancelist, i);
        
        with (_player)
        {
            if (state != states.gotoplayer)
            {
                treasure_x = x;
                treasure_y = y;
                treasure_room = room;
                
                if (grounded)
                {
                    ds_list_add(global.saveroom, other.id);
                    global.treasure = 1;
                    hsp = 0;
                    vsp = 0;
                    
                    if (other.sprite_index == other.spridle)
                    {
                        other.alarm[0] = 150;
                        state = states.gottreasure;
                        scr_soundeffect(sfx_secretfound);
                    }
                    
                    other.sprite_index = other.sprgot;
                    other.x = x;
                    other.y = y - 35;
                    obj_tv.showtext = 1;
                    obj_tv.message = "YOU GOT A TOWER SECRET TREASURE!!!";
                    obj_tv.alarm[0] = 200;
                    other.player = (object_index == obj_player1) ? obj_grindrailslope : obj_banditochicken_dynamite;
                }
                
                ds_list_clear(global.instancelist);
                break;
            }
        }
    }
    
    ds_list_clear(global.instancelist);
}
