with (other)
{
    if (scr_transformationcheck())
    {
        if (!grounded && state != states.stunned)
        {
            scr_losepoints();
            state = states.bump;
            hsp = 0;
            vsp = 10;
        }
    }
}
