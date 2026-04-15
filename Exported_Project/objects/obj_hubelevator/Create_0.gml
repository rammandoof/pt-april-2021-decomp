state = states.normal;
hub_array[0] = [179, "WORLD 1"];
hub_array[1] = [439, "WORLD 2"];
playerid = -4;
selected = 0;

switch (room)
{
    case hub_room1:
        selected = 0;
        break;
    
    case hub_room2:
        selected = 1;
        break;
}
