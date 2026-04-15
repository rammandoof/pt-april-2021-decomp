if (sprite_index != spr_mortspawn && sprite_index != spr_mortfall)
{
    with (other)
    {
        repeat (6)
            create_debris(x, y, spr_feather);
        
        mort = 1;
        instance_create_unique(x, y, obj_mortfollow);
        global.mort = 1;
        tv_push_prompt_once(tv_create_prompt("This is the mort powerup text", tvprompts.transfo, spr_tv_mort, 3), "mort");
    }
    
    instance_destroy();
}
