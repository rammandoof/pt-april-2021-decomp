if (image_xscale == other.image_xscale && hsp != 0 && other.hsp != 0 && id < other.id && state != states.grabbed && state != states.enemy_stun && state != states.enemy_turn && other.state != states.enemy_turn && other.state != states.grabbed && other.state != states.enemy_stun)
    hsp = -other.image_xscale;
