if (state == states.grabbed)
    scr_enemy_grabbed();

if (thrown)
{
    var _num = instance_place_list(x + hsp, y, obj_destructibles, global.instancelist, false);
    
    if (_num > 0)
    {
        for (var i = 0; i < ds_list_size(global.instancelist); i++)
            instance_destroy(ds_list_find_value(global.instancelist, i));
        
        ds_list_clear(global.instancelist);
    }
    
    _num = instance_place_list(x, y + vsp, obj_destructibles, global.instancelist, false);
    
    if (_num > 0)
    {
        for (var i = 0; i < ds_list_size(global.instancelist); i++)
            instance_destroy(ds_list_find_value(global.instancelist, i));
        
        ds_list_clear(global.instancelist);
    }
}

if (state != states.grabbed && state != states.pummel)
    scr_collide();

if (invtime > 0)
    invtime--;

if (sprite_index == walkspr && hsp != 0 && floor(image_index) == (image_number - 1))
    create_particle(x - (image_xscale * 20), y + 43, particle.cloudeffect, 0);

if (state == states.enemy_walk)
    image_speed = 0.35 + (global.baddiespeed * 0.05);
else if (state != states.enemy_charge)
    image_speed = 0.35;

if (dodgebuffer > 0)
    dodgebuffer--;

with (instance_nearest(x, y, obj_player))
{
    if (state == states.backbreaker)
    {
        other.stunned = 0;
        
        if (other.state != states.pizzagoblin_throw && !other.provoked && other.bombreset > 0)
        {
            other.bombreset = 0;
            other.provoked = 1;
        }
        
        other.scaredbuffer = 0;
    }
    else if (other.state != states.pizzagoblin_throw)
    {
        other.provoked = 0;
    }
}
