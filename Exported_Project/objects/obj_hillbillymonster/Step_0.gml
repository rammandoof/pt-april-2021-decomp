playerinst = instance_nearest(x, y, obj_player);
image_speed = 0.35;

switch (state)
{
    case states.enemy_idle:
        scr_hillbilly_idle();
        break;
    
    case states.enemy_chase:
        scr_hillbilly_chase();
        scr_hillbilly_destroyables();
        break;
    
    case states.normal:
        scr_hillbilly_detect();
        break;
    
    case states.machslide:
        scr_hillbilly_machslide();
        scr_hillbilly_destroyables();
        break;
}

scr_collide();
