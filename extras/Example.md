Example

```ccp
//Server's server.cfg
[...]
forcedDifficulty = "myUnitsDifficultyProfile1";
```

```ccp
//Mods config.cpp

class CfgAILevelPresets {
    class PREFIX_AISkill_Default {
        displayName = "Unit Preset 1";
        precisionAI = 0.4;
        skillAI = 1.0;
    };
};


class CfgDifficultyPresets {
    class myUnitsDifficultyProfile1: Custom {
        description = "Unit Difficulty 1";
        displayName = "Unit Difficulty 1";
        levelAI = "PREFIX_AISkill_Default";
        optionDescription = "Unit Difficulty 1";
        optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
        class Options {
            autoReport = 0;
            cameraShake = 1;
            commands = 0;
            deathMessages = 0;
            detectedMines = 0;
            enemyTags = 0;
            friendlyTags = 0;
            groupIndicators = 0;
            mapContent = 0;
            mapContentEnemy = 0;
            mapContentMines = 0;
            mapContentPing = 0;
            multipleSaves = 0;
            reducedDamage = 0;
            scoreTable = 0;
            squadRadar = 0;
            staminaBar = 0;
            stanceIndicator = 0;
            tacticalPing = 0;
            thirdPersonView = 0;
            visionAid = 0;
            vonID = 0;
            waypoints = 0;
            weaponCrosshair = 0;
            weaponInfo = 2;
        };
    };
};

```
