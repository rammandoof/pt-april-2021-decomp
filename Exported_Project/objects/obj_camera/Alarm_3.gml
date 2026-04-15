if (room == rank_room)
    exit;

if (!global.panic)
    exit;

if (instance_exists(obj_treasure))
    exit;

var _foundtoppin = 0;

if (!ds_list_empty(global.followerlist))
{
    var _inst = -4;
    
    for (var i = 0; i < ds_list_size(global.followerlist); i++)
    {
        var b = ds_list_find_value(global.followerlist, i);
        
        if (instance_exists(b) && object_get_parent(b.object_index) == obj_pizzakinparent)
            _inst = b;
    }
    
    if (_inst != -4)
    {
        switch (_inst.object_index)
        {
            case obj_pizzakinshroom:
                global.shroomfollow = 0;
                break;
            
            case obj_pizzakinpineapple:
                global.pineapplefollow = 0;
                break;
            
            case obj_pizzakinsausage:
                global.sausagefollow = 0;
                break;
            
            case obj_pizzakintomato:
                global.tomatofollow = 0;
                break;
            
            case obj_pizzakincheese:
                global.cheesefollow = 0;
                break;
        }
        
        _foundtoppin = 1;
        create_particle(_inst.x, _inst.y, particle.genericpoofeffect, 0);
		instance_destroy(_inst);
    }
}

if (!_foundtoppin)
{
    var playerid = obj_player1.spotlight ? obj_player1.id : obj_player2.id;
    
    with (playerid)
    {
        instance_destroy(obj_fadeout);
        
        if (state != states.gottreasure)
        {
            targetDoor = "A";
            room = timesuproom;
            state = states.timesup;
            sprite_index = spr_Timesup;
            image_index = 0;
            audio_stop_all();
            scr_soundeffect(mu_timesup);
        }
        else
        {
            other.alarm[3] = 15;
        }
    }
}
else
{
    alarm[3] = 150;
}
