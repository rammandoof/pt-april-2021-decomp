depth = -500;
FINAL_PARRY = new DebugCommand("final_parry", "Enables/Disables Final Game Parrying Hitbox", "final_parry", function()
{
	global.finalgame_parry = !global.finalgame_parry
});
NOCLIP = new DebugCommand("noclip", "Enables/Disables noclip", "noclip", function()
{
	with(obj_player) 
	{
		if (state != states.debugstate)
			state = states.debugstate
		else
			state = states.normal
	}
});
GIVEKEY = new DebugCommand("givekey", "", "givekey", function()
{
    global.key_inv = 1;
});
SETCOMBO = new DebugCommand("set_combo", "Set the combo", "set_combo <combo> <combotime:optional>", function(arg0, arg1)
{
    if (arg0 == undefined)
        exit;
    
    if (arg1 == undefined)
        arg1 = 60;
    
    global.combo = arg0;
    global.combotime = arg1;
    
    with (obj_player)
        supercharge = 10;
});
GIVEHEAT = new DebugCommand("giveheat", "Gives heat", "giveheat", function()
{
    global.style += 100;
});
ALLTOPPINS = new DebugCommand("alltoppins", "Adds all the toppins", "alltoppins", function()
{
    if (!instance_exists(obj_pizzakincheese))
        instance_create(obj_player1.x, obj_player1.y, obj_pizzakincheese);
    
    if (!instance_exists(obj_pizzakintomato))
        instance_create(obj_player1.x, obj_player1.y, obj_pizzakintomato);
    
    if (!instance_exists(obj_pizzakinsausage))
        instance_create(obj_player1.x, obj_player1.y, obj_pizzakinsausage);
    
    if (!instance_exists(obj_pizzakinpineapple))
        instance_create(obj_player1.x, obj_player1.y, obj_pizzakinpineapple);
    
    if (!instance_exists(obj_pizzakinshroom))
        instance_create(obj_player1.x, obj_player1.y, obj_pizzakinshroom);
    
    global.cheesefollow = 1;
    global.tomatofollow = 1;
    global.sausagefollow = 1;
    global.pineapplefollow = 1;
    global.shroomfollow = 1;
});
PANIC = new DebugCommand("panic", "Toggles pizza time", "panic <minutes> <seconds>", function(arg0, arg1)
{
    if (arg0 != undefined)
    {
        arg0 = get_number_string(arg0);
        global.minutes = arg0;
    }
    
    if (arg1 != undefined)
    {
        arg1 = get_number_string(arg1);
        global.seconds = clamp(arg1, 0, 60);
    }
    
    global.panic = !global.panic;
    
    if (global.panic)
        obj_camera.alarm[1] = 60;
});
SHOW_COLLISIONS = new DebugCommand("showcollisions", "Shows the collisions", "showcollisions <bool>", function(arg0)
{
    if (arg0 == undefined)
        exit;
    
    arg0 = get_bool(arg0);
    
    if (arg0 != undefined)
    {
        showcollisions = arg0;
        event_perform(ev_other, ev_room_start);
    }
});
SHOW_HUD = new DebugCommand("showhud", "Shows the HUD", "showhud <bool>", function(arg0)
{
    if (arg0 == undefined)
        exit;
    
    arg0 = get_bool(arg0);
    show_debug_message(!arg0);
    
    if (arg0 != undefined)
    {
        showhud = arg0;
        
        with (obj_tv)
        {
            visible = arg0;
            show_debug_message(visible);
        }
        
        with (obj_camera)
        {
            visible = arg0;
            show_debug_message(visible);
        }
        
        with (obj_roomname)
        {
            visible = arg0;
            show_debug_message(visible);
        }
        
        with (obj_pigtotal)
        {
            visible = arg0;
            show_debug_message(visible);
        }
    }
});
PLAYER_ROOM = new DebugCommand("player_room", "Go to given room", "player_room <targetRoom> <targetDoor>", function(arg0, arg1)
{
    if (arg0 == undefined)
        exit;
    
    if (arg1 == undefined)
        exit;
    
    arg0 = asset_get_index(arg0);
    
    if (arg0 == -1)
        exit;
    
    with (obj_player)
    {
        targetRoom = arg0;
        targetDoor = arg1;
    }
    
    instance_create(x, y, obj_fadeout);
});
CAMERA_ZOOM = new DebugCommand("camera_zoom", "Zoom", "camera_zoom <targetzoom> <spd>", function(arg0, arg1)
{
    if (arg0 == undefined)
        exit;
    
    if (arg1 != undefined)
        arg1 = get_number_string(arg1);
    
    with (obj_camera)
    {
        targetzoom = arg0;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (arg1 != undefined)
            zoomspd = abs(arg1);
    }
});
HARDMODE = new DebugCommand("hardmode", "Toggles hardmode", "hardmode <bool>", function(arg0)
{
    if (arg0 == undefined)
        exit;
    
    arg0 = get_bool(arg0);
    show_debug_message(!arg0);
    
    if (arg0 != undefined)
    {
        global.hardmode = arg0;
        
        with (obj_hardmode)
            event_perform(ev_other, ev_room_start);
    }
});
PLAYER_SET_STATE = new DebugCommand("player_set_state", "Changes the player state", "player_set_state <states.state>", function(arg0)
{
    if (arg0 == undefined)
        exit;
    
    arg0 = ds_map_find_value(state_map, arg0);
    
    if (!is_undefined(arg0))
    {
        with (obj_player)
        {
            if (object_index == obj_player1 || global.coop)
            {
                state = arg0;
                var _spr = sprite_index;
                
                switch (arg0)
                {
                    case states.normal:
                        _spr = spr_idle;
                        break;
                    
                    case states.cheesepep:
                        _spr = spr_cheesepep_idle;
                        break;
                    
                    case states.knightpep:
                        _spr = spr_knightpepidle;
                        break;
                }
                
                sprite_index = _spr;
                image_index = 0;
            }
        }
    }
});
active = 0;
showcollisions = 1;
showhud = 1;
state_map = ds_map_create();
ds_map_set(state_map, "states.normal", states.normal);
ds_map_set(state_map, "states.cheesepep", states.cheesepep);
ds_map_set(state_map, "states.knightpep", states.knightpep);
command_list = ds_list_create();
ds_list_add(command_list, SHOW_HUD, SHOW_COLLISIONS, PLAYER_ROOM, CAMERA_ZOOM, HARDMODE, PLAYER_SET_STATE, PANIC, ALLTOPPINS, GIVEHEAT);
ds_list_add(command_list, SETCOMBO, GIVEKEY, NOCLIP, FINAL_PARRY);
input_text = "";
input_text_list = ds_list_create();
input_buffer = 0;
input_max = 1;
delete_buffer = 0;
delete_max = 8;
keyboard_string = "";
lastplayerstate = obj_player1.state;

function get_bool(arg0)
{
    if (arg0 == "true")
    {
        arg0 = true;
        return arg0;
    }
    else if (arg0 == "false")
    {
        arg0 = false;
        return arg0;
    }
    else if (is_real(real(string_digits(arg0))))
    {
        arg0 = bool(real(string_digits(arg0)));
        return arg0;
    }
    
    return undefined;
}

function get_number_string(arg0)
{
    var n = arg0;
    
    if (is_string(arg0))
    {
        n = real(string_digits(arg0));
        
        if (string_char_at(arg0, 1) == "-")
            n = -real(string_digits(arg0));
    }
    
    return n;
}

function check_command(arg0)
{
    if (!ds_list_empty(arg0))
    {
        for (var i = 0; i < ds_list_size(command_list); i++)
        {
            var _cmd = ds_list_find_value(command_list, i);
            
            if (ds_list_find_value(arg0, 0) == _cmd.command_id)
                return i;
        }
    }
    
    return -1;
}

function get_command_list(arg0)
{
    var r = ds_list_create();
    
    for (var i = 0; i < ds_list_size(command_list); i++)
    {
        var _cmd = ds_list_find_value(command_list, i);
        
        if (string_copy(_cmd.command_id, 1, string_length(arg0)) == arg0)
            ds_list_add(r, _cmd);
    }
    
    if (!ds_list_empty(r))
    {
        return r;
    }
    else
    {
        ds_list_destroy(r);
        return -4;
    }
}