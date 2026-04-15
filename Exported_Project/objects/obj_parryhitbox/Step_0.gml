var my_player = obj_player1.id;

if (player_id == obj_banditochicken_dynamite)
    my_player = obj_player2.id;

if (my_player.state != states.backbreaker && my_player.state != states.parry)
    instance_destroy();

image_xscale = my_player.xscale;

sprite_index = global.finalgame_parry ? spr_parryhitbox : spr_player_mask;