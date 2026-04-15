if (place_meeting(x, y, other) && other.state != states.backbreaker && other.state != states.bump && other.y > other.yprevious && other.y < y)
{
    with (other)
    {
        if (!scr_transformationcheck())
            exit;
    }
    
    other.y = y - 49;
    
    if (other.movespeed < 10)
        other.movespeed = 10;
    
    other.state = states.grind;
}
