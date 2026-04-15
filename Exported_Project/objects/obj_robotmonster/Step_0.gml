playerinst = instance_nearest(x, y, obj_player);

switch (state)
{
    case states.normal:
        scr_robot_normal();
        scr_robot_detect();
        break;
    
    case states.enemy_turn:
        scr_robot_turn();
        scr_robot_detect();
        break;
    
    case states.enemy_chase:
        scr_robot_chase();
        image_speed = 0.25;
        break;
    
    case states.throwing:
        scr_robot_attack();
        break;
}

if (random_buffer > 0)
    random_buffer--;
else
    random_buffer = random_max + irandom_range(-random_max, random_min);

scr_collide();
