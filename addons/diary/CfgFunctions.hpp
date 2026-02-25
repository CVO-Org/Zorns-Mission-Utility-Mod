class CfgFunctions
{
    class ADDON
    {
        class diary {
            file = PATH_TO_FUNC_SUB(diary);

            class createDiaryCategory {};
            class createDiarySubject {};

        };
        class api {
            file = PATH_TO_FUNC_SUB(api);
            
            class setEntry {};
            class setPersonality {};
            class setEnemyForces {};
            class setAlliedForces {};
        };
        
    };
};
