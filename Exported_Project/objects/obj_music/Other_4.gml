if (!global.panic && global.combo < 50 && !global.snickchallenge && !instance_exists(obj_hungrypillar))
{
    if (instance_exists(obj_pepperman))
    {
        audio_stop_all();
        scr_sound(mu_chase);
    }
    
    roomname = room_get_name(room);
    global.mu = -4;
    var trackposition = 1;
    
    switch (string_letters(roomname))
    {
        case "rmlevelselect":
            global.mu = -4;
            trackposition = 0;
            break;
        
        case "characterselect":
            global.mu = 118;
            trackposition = 0;
            break;
        
        case "Realtitlescreen":
            global.mu = 109;
            trackposition = 0;
            break;
        
        case "hubroom":
        case "Titlescreen":
        case "halloweenentrance":
            global.mu = 93;
            trackposition = 0;
            break;
        
        case "PProom":
            global.mu = 110;
            trackposition = 0;
            break;
        
        case "entrance":
            global.mu = (obj_player1.character == "P") ? 98 : 121;
            break;
        
        case "dungeon":
            for (var i = 0; i < 20; i++)
            {
                if (roomname == ("dungeon_" + string(i)) && i <= 8)
                    global.mu = 108;
                else if (roomname == ("dungeon_" + string(i)) && i > 8)
                    global.mu = 116;
            }
            
            break;
        
        case "strongcold":
            if (roomname == "strongcold_1")
            {
                global.mu = 100;
            }
            else
            {
                for (var i = 0; i < 20; i++)
                {
                    if (roomname == ("strongcold_" + string(i)) && i <= 8 && i > 1)
                        global.mu = 119;
                    else if (roomname == ("strongcold_" + string(i)) && i > 8)
                        global.mu = 116;
                }
            }
            
            break;
        
        case "medieval":
            for (var i = 0; i < 20; i++)
            {
                if (roomname == ("medieval_" + string(i)) && i <= 2)
                    global.mu = 111;
                else if (roomname == ("medieval_" + string(i)) && i > 2 && i <= 5)
                    global.mu = 101;
                else if (roomname == ("medieval_" + string(i)) && i > 5)
                    global.mu = 99;
            }
            
            break;
        
        case "ruin":
            for (var i = 0; i < 20; i++)
            {
                if (roomname == ("ruin_" + string(i)) && i <= 6)
                    global.mu = 112;
                else if (roomname == ("ruin_" + string(i)) && i > 6)
                    global.mu = 113;
            }
            
            break;
        
        case "floorroom":
            for (var i = 0; i < 20; i++)
            {
                if (roomname == ("floor1_room" + string(i)) && i <= 9)
                    global.mu = 89;
                else if (roomname == ("floor1_room" + string(i)) && i > 9)
                    global.mu = 91;
            }
            
            break;
        
        case "forest":
            if (roomname == "forest_4" || roomname == "forest_4b")
                global.mu = 127;
            else
                global.mu = 128;
            
            break;
        
        case "chateau":
            global.mu = 100;
            break;
        
        case "farm":
            global.mu = 123;
            break;
        
        case "graveyard":
            global.mu = 125;
            break;
        
        case "ufo":
            global.mu = 124;
            break;
        
        case "beach":
            global.mu = 131;
            break;
        
        case "entrancesecret":
        case "chateausecret":
        case "strongcoldsecret":
        case "medievalsecret":
            global.mu = 94;
            break;
        
        case "ruinsecret":
            global.mu = 95;
            break;
        
        case "dungeonsecret":
            global.mu = 96;
            break;
        
        case "dragonlair":
            global.mu = 120;
            break;
        
        case "floorsecret":
            global.mu = 122;
            break;
        
        case "ufosecret":
            global.mu = 126;
            break;
        
        case "graveyardsecret":
            global.mu = 129;
            break;
        
        case "farmsecret":
            global.mu = 130;
            break;
    }
    
    if (global.mu != -4 && !audio_is_playing(global.mu))
    {
        audio_stop_all();
        scr_sound(global.mu);
        pausedmusic = global.mu;
        
        if (trackposition)
            audio_sound_set_track_position(global.music, fadeoff);
    }
    else if (global.mu == -4)
    {
        if (room == rm_levelselect)
            audio_stop_all();
    }
}

if (room == custom_lvl_room)
    alarm[0] = 4;
