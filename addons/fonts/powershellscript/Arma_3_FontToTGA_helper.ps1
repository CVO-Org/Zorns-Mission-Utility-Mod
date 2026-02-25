# Define array of sizes
$sizes = @(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 44, 46, 48, 50, 54, 58, 60, 64, 70, 80, 90, 100)
$cfgStrings = New-Object System.Collections.ArrayList
$location = "D:\SteamLibrary\steamapps\common\Arma 3 Tools\FontToTGA\"
# Path to the .exe file
$exe_path = "./FontToTga.exe"

Write-Output "/// ----------------------------------------------------------------------- \\\"
Write-Output "|     THIS IS                                                                 |"
Write-Output '|         "Arma 3 FontToTga.exe helper"                                       |'
Write-Output "|         written by: Nelis75733126                                           |"
Write-Output "|         version number: 0.2.3                                               |"
Write-Output "|         GitHub repository:                                                  |"
Write-Output "|             https://github.com/Nelis75733126/Arma_3_FontToTGA_helper         |"
Write-Output "\\\ ----------------------------------------------------------------------- ///"
Write-Output ""
Write-Output "--- FIRST UP ---"
Write-Output "    This script assumes the location of FontToTga.exe is the following:"
Write-Output ("        {0}" -f $location)
Write-Output "    Please verify that it is the correct location for your system..."
Start-Sleep -Seconds 1
$isPathOK = Read-Host "        Is it correct? type y for yes, or n for no"
if ($isPathOK -eq "y")
    {
        Write-Output "    Location confirmed and set."
        Set-Location $location
    } elseif ($isPathOK -eq "n")
        {
            Write-Output "    Understood. Please provide the actual location: "
            $location = Read-Host "    "
            Write-Output "    Received. this script will asume that location exists."
            Write-Output "..."
            Start-Sleep -Seconds 1
            if ($location[-1] -eq !"\")
                {
                    $location = $location + "\"
                }
            Set-Location $location
        }
Write-Output "..."
Write-Output ""
Write-Output "--- Next up ---"
Write-Output "    This script needs the exact so-called 'full name' of the font you want to convert."
Write-Output "    You can find that full name by:"
Write-Output "        - opening up the fonts app on your Windows system (On Windows 11: Settings >> Personalisation >> Fonts)"
Write-Output "        - clicking the font you want to convert."
Write-Output "        - under 'Metadata', use the drop-down box to select the variant, if any."
Write-Output "        - then read what it says to the right of 'Full name'."
Write-Output "        - enter that name below. it is case insensitive,"
Write-Output "            however, your use of capital letters will have effect on the names used in the output location and in the config."
Write-Output "            also, if you enter a non-existing font name, FontToTGA.exe defaults to the Arial font."
Write-Output "            so if FontToTGA.exe generated that instead, it was unable to find the font you provided."
Write-Output ""
Read-Host "press ENTER when ready"
Write-Output ""
Write-Output "--- ok here we go ---"
$font = Read-Host "     Please enter the full name of the font"
Write-Output ("    Got it. font: {0}" -f $font)
$fontShort = $font -replace '\s+', ''
Write-Output "..."
Write-Output ""
Write-Output "--- Font sizes ---"
Write-Output "    By default, this script will make FontToTGA.exe generate these font sizes in pt format:"
Write-Output ("    {0}" -f ($sizes -join ","))
Write-Output "        those sizes have been chosen because it is a range of common sizes that can be used in the game."
Write-Output "            you can choose to go bigger if you want."
$fontSizeAgreed = Read-Host "    Do you agree with those font sizes? if yes, press ENTER. otherwise, type n"
if ($fontSizeAgreed -eq "n")
    {
        Write-Output ""
        Write-Output "    ok. next up: the sizes you desire, provided in this format:"
        Write-Output "        [number, number, number, number, number, number, number]"
        Write-Output "        (where number is the alphanumeric size you desire)"
        $inputSizes = Read-Host "       please enter the font sizes you wish"
        # Remove the square brackets and split the string into an array
        $sizes = $inputSizes.TrimStart('[').TrimEnd(']').Split(',') | ForEach-Object { $_.Trim() }
        Write-Output ("    ....Received: {0}" -f ($sizes -join ","))
    }
Write-Output ""
Write-Output "This script is ready to call upon FontToTga.exe to generate all the textures."
$doGenerate = Read-Host ("    Do you want a CfgFontFamilies config for the '{0}' font?, if yes, press ENTER. if no, press n" -f $font)
if ($doGenerate -eq "n")
    {
        Write-Output ("    Understood. will only generate a config for '{0}'" -f $font)
    } elseif ($doGenerate -eq "")
        {
            $doGenerate = "y"
            Write-Output "    Allright. calling FontToTga.exe now..."
            Write-Output "..."
            Start-Sleep -Seconds 1
        }
#Loop through the sizes array
forEach ($size in $sizes)
    {
        $fontPath = "Fonts\$fontShort\$fontShort$size"
        $cfgStrings.Add("$fontPath") | Out-Null
        # Construct the command string
        $command = "$exe_path -maxTexSize=2048 -size=$size `"$font`" $fontPath"
        if ($doGenerate -eq "y")
            {
                Invoke-Expression $command
            }
    }

if ($doGenerate -eq "y")
    {
        Write-Output ""
        Write-Output "FontToTga.exe seems to be done with the conversion."
        Write-Output "    The .fxy and .tga files for the '$font' font can be found in:"
        Write-Output ("        {0}Fonts\{1}" -f $location, $fontShort)
        Write-Output "-----------------------------------------------"
        Write-Output "IMPORTANT: It should be noted that those .tga files need to be converted to .paa using the application 'ImageToPAA', which is also available inside Arma 3 Tools."
        Write-Output "-----------------------------------------------"
        Write-Output ""
        Read-Host "press ENTER to confirm"
    }
Write-Output "..."
Start-Sleep -Seconds 1
Write-Output ""
Write-Output ("--- NEXT UP: CfgFontFamilies config entry for '{0}'---" -f $font)
Start-Sleep -Seconds 1
Write-Output "    In order to write the correct config, you must provide the exact name of the addon you are planning to include the font in."
Write-Output "    That name will be the so-called 'TAG' given to the addon via its classname in CfgPatches."
$addonName = Read-Host "        please provide that name"
Write-Output "..."
Start-Sleep -Seconds 1
Write-Output "    Generating config..."
Write-Output "..."
Start-Sleep -Seconds 1

$config = New-Object System.Collections.ArrayList
$null = $config.Add("class CfgFontFamilies")
$null = $config.Add("    {")
$null = $config.Add("        class $fontShort")
$null = $config.Add("            {")
$null = $config.Add("                fonts[] =")
$null = $config.Add("                    {")

for ($i = 0; $i -lt $cfgStrings.count; $i++)
    {
        $cfgStrings[$i] = "$addonName\" + $cfgStrings[$i]
        $null = $config.Add('                        "{0}",' -f $cfgStrings[$i])
    }
# remove the comma at the end of the last string
$config[-1] = $config[-1] -replace '.$'

$null = $config.Add("                    };")
$null = $config.Add("            };")
$null = $config.Add("    };")

Write-Output "    Config for '$font' generated. here it is:"
Write-Output ""
Write-Output "// #### CONFIG START ####"
Write-Output ""
Write-Output $config
Write-Output ""
Write-Output "// #### CONFIG END ####"
Write-Output ""
Start-Sleep -Seconds 1
Write-Output "..."
Write-Output ""
Write-Output "This script is done. Have a nice day."
pause