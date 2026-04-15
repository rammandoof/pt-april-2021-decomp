function string_split_as_ds_list(argument0, argument1)
{
    argument0 += " ";
    var _current_str = "";
    var _list = ds_list_create();
    
    for (var i = 1; i < (string_length(argument0) + 1); i++)
    {
        var _char = string_char_at(argument0, i);
        
        if (_char != argument1)
        {
            _current_str += _char;
        }
        else
        {
            ds_list_add(_list, _current_str);
            _current_str = "";
        }
    }
    
    return _list;
}

function function_overload(argument0, argument1)
{
    var _size = ds_list_size(argument0);
    
    switch (_size - 1)
    {
        case -1:
            argument[1]();
            break;
        
        case 0:
            argument[1](ds_list_find_value(argument0, 0));
            break;
        
        case 1:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1));
            break;
        
        case 2:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1), ds_list_find_value(argument0, 2));
            break;
        
        case 3:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1), ds_list_find_value(argument0, 2), ds_list_find_value(argument0, 3));
            break;
        
        case 4:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1), ds_list_find_value(argument0, 2), ds_list_find_value(argument0, 3), ds_list_find_value(argument0, 4));
            break;
        
        case 5:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1), ds_list_find_value(argument0, 2), ds_list_find_value(argument0, 3), ds_list_find_value(argument0, 4), ds_list_find_value(argument0, 5));
            break;
        
        case 6:
            argument[1](ds_list_find_value(argument0, 0), ds_list_find_value(argument0, 1), ds_list_find_value(argument0, 2), ds_list_find_value(argument0, 3), ds_list_find_value(argument0, 4), ds_list_find_value(argument0, 5), ds_list_find_value(argument0, 6));
            break;
    }
}

function DebugCommand(argument0, argument1, argument2, argument3) constructor
{
    command_id = argument0;
    description = argument1;
    format = argument2;
    func = argument3;
    
    Invoke = function(argument0)
    {
        if (argument0 != undefined)
            function_overload(argument0, func);
        else
            func();
    };
}
