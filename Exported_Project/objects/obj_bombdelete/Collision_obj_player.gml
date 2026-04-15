if (!collide)
{
    if (other.state == states.handstandjump)
    {
        other.state = states.bombdelete;
        collide = 1;
    }
}
