if (other.y > other.yprevious && other.state != states.backbreaker && other.state != states.grind && other.state != states.bump && other.y < y)
{
    with (other)
    {
        if (!scr_transformationcheck())
            exit;
        
        while (place_meeting(x, y, obj_grindrailslope))
            y--;
    }
    
    if (other.movespeed < 10)
        other.movespeed = 10;
    
    other.state = states.grind;
}
