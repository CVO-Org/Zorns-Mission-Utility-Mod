class CfgFunctions
{
    class ADDON          // Tag
    {
        class COMPONENT           // Category
        {
            file = PATH_TO_FUNC;
            class init_cba_eh { preInit = 1; };
            
            class register {};
            class init_layer {};

            class add_action {};
            class action_statement {};
            class action_condition {};

            class reveal_object {};
            class play_sound {};


            class register_cleanup {};
            class delete_layer {};
        };
    }; 
};
