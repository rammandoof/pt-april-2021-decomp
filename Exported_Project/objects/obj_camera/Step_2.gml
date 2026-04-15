var _player1 = obj_player1.spotlight ? obj_player1 : obj_player2;
var _player2 = obj_player1.spotlight ? obj_player2 : obj_player1;
var _p1state = _player1.state;

if (_p1state == states.backbreaker || _p1state == states.chainsaw)
    _p1state = _player1.tauntstoredstate;

var _p1spr = _player1.sprite_index;
var _p1movespeed = _player1.movespeed;

switch (_player1.character)
{
    case "P":
        var _validstate = _p1state == states.mach1 || _p1state == states.mach2 || _p1state == states.mach3 || _p1state == states.climbwall || _p1state == states.machslide || _p1state == states.machroll || _p1state == states.handstandjump;
        spr_speedbarHUD = spr_speedbar;
        spr_speedbar_index = 0;
        
        if (_validstate)
        {
            if (_p1movespeed < 2.4)
            {
                spr_speedbar_index = 0;
            }
            else if (_p1movespeed >= 2.4 && _p1movespeed < 4.8)
            {
                spr_speedbar_index = 1;
            }
            else if (_p1movespeed >= 4.8 && _p1movespeed < 7.2)
            {
                spr_speedbar_index = 2;
            }
            else if (_p1movespeed >= 7.2 && _p1movespeed < 9.6)
            {
                spr_speedbar_index = 3;
            }
            else if (_p1movespeed >= 9.6 && _p1movespeed < 12)
            {
                spr_speedbar_index = 4;
            }
            else if (_p1movespeed >= 12)
            {
                spr_speedbarHUD = spr_speedbarmax;
                spr_speedbar_index = -1;
            }
        }
        
        break;
    
    case "N":
        var _p1pogospeed = _player1.pogospeed;
        spr_speedbarHUD = spr_speedbar;
        
        if (_p1pogospeed < 10)
        {
            spr_speedbar_index = 0;
        }
        else if (_p1pogospeed >= 10 && _p1pogospeed < 14)
        {
            spr_speedbar_index = 3;
        }
        else if (_p1pogospeed >= 14)
        {
            spr_speedbar_index = -1;
            spr_speedbarHUD = spr_speedbar;
        }
        
        break;
    
    case "V":
        spr_speedbarHUD = -4;
        break;
}

var _char = _player1.character;
ispeppino = _player1.ispeppino;

if (_char == "P" && ispeppino)
{
    spr_player = spr_pepinoHUD;
    
    switch (_p1spr)
    {
        case spr_knightpep_thunder:
            spr_player = spr_pepinoHUDthunder;
            break;
        
        case spr_knightpep_start:
            spr_player = spr_pepinoHUD;
            break;
        
        case spr_knightpep_downslope:
            spr_player = spr_pepinoHUDknight;
            break;
        
        case spr_knightpep_charge:
            spr_player = spr_pepinoHUDknight;
            break;
        
        case spr_bombpep_end:
            spr_player = spr_pepinoHUDbombend;
            break;
        
        case spr_bombpep_intro:
        case spr_bombpep_runabouttoexplode:
        case spr_bombpep_run:
        case spr_player_fireass:
            spr_player = spr_pepinoHUDscream;
            break;
        
        case spr_player_victory:
            spr_player = spr_pepinoHUDhappy;
            break;
        
        case spr_player_machroll:
        case spr_player_tumble:
            spr_player = spr_pepinoHUDrolling;
            break;
        
        case spr_player_dive:
        case spr_player_machslideboost:
            spr_player = spr_pepinoHUDmach2;
            break;
        
        case spr_player_machslideboost3:
            spr_player = spr_pepinoHUDmach3;
            break;
        
        case spr_player_fireassend:
            spr_player = spr_pepinoHUDhurt;
            break;
    }
    
    if (spr_player == spr_pepinoHUD && instance_exists(obj_itspizzatime))
        spr_player = spr_pepinoHUDscream;
    
    if (spr_player == spr_pepinoHUD && global.combo >= 20)
        spr_player = spr_pepinoHUDmenacing;
    
    if (spr_player == spr_pepinoHUD)
    {
        switch (_p1state)
        {
            case states.knightpep:
                if (sprite_index != _player1.spr_knightpepstart)
                    spr_player = spr_pepinoHUDknight;
                
                break;
            
            case states.knightpepslopes:
                spr_player = spr_pepinoHUDknight;
                break;
            
            case states.Sjumpland:
                spr_player = spr_pepinoHUDstun;
                break;
            
            case states.freefallland:
                if (shake_mag > 0)
                    spr_player = spr_pepinoHUDstun;
                
                break;
            
            case states.keyget:
            case states.smirk:
            case states.gottreasure:
                spr_player = spr_pepinoHUDhappy;
                break;
            
            case states.mach1:
            case states.chainsaw:
            case states.freefallprep:
            case states.freefall:
            case states.tackle:
            case states.Sjump:
            case states.slam:
            case states.Sjumpprep:
            case states.grab:
            case states.punch:
            case states.backbreaker:
            case states.backkick:
            case states.uppunch:
            case states.shoulder:
                spr_player = spr_pepinoHUDmach1;
                break;
            
            case states.mach2:
            case states.climbwall:
            case states.handstandjump:
            case states.superslam:
                spr_player = spr_pepinoHUDmach2;
                break;
            
            case states.mach3:
                spr_player = spr_pepinoHUDmach3;
                
                if (_p1spr == spr_player_crazyrun)
                    spr_player = spr_pepinoHUDmach4;
                
                break;
            
            case states.hurt:
            case states.timesup:
            case states.bombpep:
                spr_player = spr_pepinoHUDhurt;
                break;
            
            case states.bossintro:
                if (_p1spr == spr_player_bossintro || _p1spr == spr_player_idle)
                    spr_player = spr_pepinoHUDhurt;
                else if (_p1spr == spr_player_levelcomplete)
                    spr_player = spr_pepinoHUDhappy;
                
                break;
        }
        
        if (spr_player == spr_pepinoHUD)
        {
            if (global.stylethreshold == 2)
                spr_player = spr_pepinoHUD3hp;
            else if (_p1spr == spr_player_hurtidle || _p1spr == spr_player_hurtwalk)
                spr_player = spr_pepinoHUD1hp;
            else if (global.stylethreshold >= 3)
                spr_player = spr_pepinoHUDpanic;
            else if (_p1spr == spr_shotgun_pullout)
                spr_player = spr_pepinoHUDmenacing;
        }
    }
}
else if (_char == "N" || (_char == "P" && !ispeppino))
{
    spr_player = spr_noiseHUD_idle;
    
    switch (_p1spr)
    {
        case _player1.spr_knightpepthunder:
            spr_player = spr_noiseHUD_thunder;
            break;
        
        case _player1.spr_knightpepstart:
            spr_player = spr_noiseHUD_knight;
            break;
        
        case _player1.spr_bombpepend:
            spr_player = spr_noiseHUD_bomb;
            break;
        
        case _player1.spr_bombpepintro:
        case _player1.spr_bombpeprunabouttoexplode:
        case _player1.spr_bombpeprun:
        case _player1.spr_fireass:
            spr_player = spr_noiseHUD_panic;
            break;
        
        case spr_player_victory:
            spr_player = spr_noiseHUD_happy;
            break;
        
        case spr_player_machroll:
        case spr_player_tumble:
            spr_player = spr_pepinoHUDrolling;
            break;
        
        case _player1.spr_dive:
        case _player1.spr_machslideboost:
            spr_player = spr_noiseHUD_mach2;
            break;
        
        case _player1.spr_mach3boost:
            spr_player = spr_noiseHUD_mach3;
            break;
        
        case _player1.spr_fireassend:
            spr_player = spr_noiseHUD_hurt;
            break;
    }
    
    if (spr_player == spr_noiseHUD_idle && instance_exists(obj_itspizzatime))
        spr_player = spr_noiseHUD_panic;
    
    if (spr_player == spr_noiseHUD_idle && global.combo >= 20)
        spr_player = spr_noiseHUD_menacing;
    
    if (spr_player == spr_noiseHUD_idle)
    {
        switch (_p1state)
        {
            case states.knightpep:
                if (sprite_index != _player1.spr_knightpepstart)
                    spr_player = spr_noiseHUD_knight;
                
                break;
            
            case states.knightpepslopes:
                spr_player = spr_noiseHUD_knight;
                break;
            
            case states.Sjumpland:
                spr_player = spr_noiseHUD_groundpound;
                break;
            
            case states.freefallland:
                if (shake_mag > 0)
                    spr_player = spr_noiseHUD_groundpound;
                
                break;
            
            case states.keyget:
            case states.smirk:
            case states.gottreasure:
                spr_player = spr_noiseHUD_happy;
                break;
            
            case states.mach1:
            case states.chainsaw:
            case states.freefallprep:
            case states.freefall:
            case states.tackle:
            case states.Sjump:
            case states.slam:
            case states.Sjumpprep:
            case states.grab:
            case states.punch:
            case states.backbreaker:
            case states.backkick:
            case states.uppunch:
            case states.shoulder:
                spr_player = spr_noiseHUD_mach1;
                break;
            
            case states.pogo:
            case states.mach2:
            case states.climbwall:
            case states.handstandjump:
            case states.superslam:
                spr_player = spr_noiseHUD_mach2;
                break;
            
            case states.mach3:
                spr_player = spr_noiseHUD_mach3;
                
                if (_p1spr == _player1.spr_crazyrun)
                    spr_player = spr_noiseHUD_crazyrun;
                
                break;
            
            case states.hurt:
            case states.timesup:
            case states.bombpep:
                spr_player = spr_noiseHUD_hurt;
                break;
            
            case states.bossintro:
                if (_p1spr == spr_player_bossintro || _p1spr == spr_player_idle)
                    spr_player = spr_noiseHUD_hurt;
                else if (_p1spr == spr_player_levelcomplete)
                    spr_player = spr_noiseHUD_happy;
                
                break;
        }
        
        if (spr_player == spr_noiseHUD_idle)
        {
            if (_player1.angry)
                spr_player = spr_noiseHUD_angry;
            else if (_p1spr == _player1.spr_hurtidle || _p1spr == _player1.spr_hurtwalk)
                spr_player = spr_noiseHUD_lowhealth;
            else if (global.panic || global.miniboss)
                spr_player = spr_noiseHUD_panic;
            else if (_p1spr == spr_shotgun_pullout)
                spr_player = spr_noiseHUD_menacing;
        }
    }
}
else if (_char == "V")
{
    spr_speedbarHUD = -4;
    spr_player = spr_playerV_normalHUD;
    
    if ((healthshaketime > 0 && playerhealthup) || _p1spr == spr_playerV_keydoor || _p1state == states.keyget || _p1state == states.gottreasure)
        spr_player = spr_playerV_happyHUD;
    else if (_p1state == states.boots)
        spr_player = spr_playerV_machHUD;
    else if ((healthshaketime > 0 && playerhealthup) && _p1state == states.hurt)
        spr_player = spr_playerV_hurtHUD;
    else if (global.panic)
        spr_player = spr_playerV_panicHUD;
    else if (_player1.angry)
        spr_player = spr_playerV_angryHUD;
}
