with (other)
{
    if ((other.state == states.enemy_stun && other.thrown == 1) || (other.state == states.grabbed && obj_player.state == states.superslam))
        instance_destroy();
}
