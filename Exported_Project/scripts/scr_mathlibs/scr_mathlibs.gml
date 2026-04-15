function Vector2(argument0, argument1) constructor
{
    x = argument0;
    y = argument1;
    
    Update = function(argument0, argument1)
    {
        x = argument0;
        y = argument1;
    };
    
    UpdateVector = function(argument0)
    {
        x = argument0.x;
        y = argument0.y;
    };
    
    Add = function(argument0, argument1)
    {
        x += argument0;
        y += argument1;
    };
    
    AddVector = function(argument0)
    {
        x += argument0.x;
        y += argument0.y;
    };
    
    Multiply = function(argument0, argument1)
    {
        x *= argument0;
        y *= argument1;
    };
    
    Divide = function(argument0, argument1)
    {
        x /= argument0;
        y /= argument1;
    };
    
    MultiplyVector = function(argument0)
    {
        x *= argument0.x;
        y *= argument0.y;
    };
    
    DivideVector = function(argument0)
    {
        x /= argument0.x;
        y /= argument0.y;
    };
}

function cycle(argument0, argument1, argument2)
{
    var delta = argument2 - argument1;
    var result = (argument0 - argument1) % delta;
    
    if (result < 0)
        result += delta;
    
    return result + argument1;
}

function angle_rotate(argument0, argument1, argument2)
{
    var diff = cycle(argument1 - argument0, -180, 180);
    
    if (diff < -argument2)
        return argument0 - argument2;
    
    if (diff > argument2)
        return argument0 + argument2;
    
    return argument1;
}

function get_velocity(argument0, argument1)
{
    return argument0 / argument1;
}

function Wave(argument0, argument1, argument2, argument3)
{
    var a4 = (argument1 - argument0) * 0.5;
    return argument0 + a4 + (sin((((current_time * 0.001) + (argument2 * argument3)) / argument2) * (2 * pi)) * a4);
}

function distance_to_pos(argument0, argument1, argument2, argument3, argument4, argument5)
{
    return abs(argument0 - argument2) <= argument4 && abs(argument1 - argument3) <= argument5;
}

function distance_between_points(argument0, argument1, argument2, argument3)
{
    return sqrt(sqr(argument2 - argument0) + sqr(argument3 - argument1));
}
