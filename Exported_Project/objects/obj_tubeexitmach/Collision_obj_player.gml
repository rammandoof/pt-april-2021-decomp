if (other.tube_id == id)
    exit;

if (playerid > -1)
    exit;

if (state != states.normal)
    exit;

if (other.state == states.hurt)
    exit;

if (other.state == states.gotoplayer)
    exit;

if (object_index != obj_tubeenter && other.state != states.tube)
    exit;

var _offset_x = 32 * image_xscale;
var _offset_y = 14 * image_yscale;

with (other)
{
    state = states.tube;
    hsp = 0;
    movespeed = 0;
    vsp = 0;
    tube_vsp = 0;
    x = Approach(x, other.x + _offset_x, other.approach_spd);
    y = Approach(y, other.y + _offset_y, other.approach_spd);
}

if (floor(other.x) == (x + _offset_x) && floor(other.y) == (y + _offset_y))
{
    other.x = x + _offset_x;
    other.y = y + _offset_y;
    image_index = 0;
    playerid = other.id;
    other.state = states.tube;
    other.hsp = 0;
    other.vsp = 0;
    other.tube_vsp = 0;
    state = states.tube;
}
