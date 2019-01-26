state("Treadnauts")
{
    //bool isLoading : 0x0036BA34;
    //based off of the AlanWake ASl https://raw.githubusercontent.com/tduva/LiveSplit-ASL/master/AlanWake.asl

    byte level : "mono.dll", 0x001F6994, 0x14, 0x9C, 0x20, 0x44, 0x88;
    // byte level : 0x010A6F34, 0x34, 0x44, 0x0, 0xC, 0x38;
    // byte level : 0x010A6F34, 0x38, 0x44, 0x0, 0xC, 0x38;
    // byte level : 0x010A719C, 0x34, 0x44, 0x0, 0xC, 0x38;
    // byte level : 0x010A719C, 0x38, 0x44, 0x0, 0xC, 0x38;
    //isPaused is 'guaranteed to work' on v1.00
    bool isPaused : "mono.dll", 0x001F4684, 0xF0, 0x84C;
}

startup
{
    settings.Add("reminder", false, "This is not a setting, just a reminder to use gametime for any pausing stuff ;)");
    settings.Add("clearpause", false, "Pause after clear for single segments/keep unchecked for RTA");
    settings.Add("resetatzero", false, "If you go back to level 1, reset?");
    settings.Add("clearend", true, "Stop time after clearing the last stage.");
    settings.Add("pauseend", false, "Pause time after clearing the last stage.");

    settings.Add("rustvalley", true, "Rust Valley");
    settings.Add("level0", true, "01 - Terrace", "rustvalley");
    settings.Add("level1", true, "02 - Pond", "rustvalley");
    settings.Add("level2", true, "03 - Clearing", "rustvalley");
    settings.Add("level3", true, "04 - River", "rustvalley");
    settings.Add("level4", true, "05 - Wind Farm", "rustvalley");
    settings.Add("level5", true, "06 - Thicket", "rustvalley");
    settings.Add("level6", true, "07 - Canopy", "rustvalley");
    settings.Add("level7", true, "08 - Compass", "rustvalley");
    settings.Add("level8", true, "09 - Crosscut", "rustvalley");
    settings.Add("level9", true, "10 - Orchard", "rustvalley");

    settings.Add("dreamland", true, "Dreamland");
    settings.Add("level10", true, "11 - Survey", "dreamland");
    settings.Add("level11", true, "12 - Junkyard", "dreamland");
    settings.Add("level12", true, "13 - Static", "dreamland");
    settings.Add("level13", true, "14 - Quarantine", "dreamland");
    settings.Add("level14", true, "15 - Henhouse", "dreamland");
    settings.Add("level15", true, "16 - Contraption", "dreamland");
    settings.Add("level16", true, "17 - VHS", "dreamland");
    settings.Add("level17", true, "18 - Weather Station", "dreamland");
    settings.Add("level18", true, "19 - Hydra", "dreamland");
    settings.Add("level19", true, "20 - Cradle", "dreamland");

    settings.Add("saltharbor", true, "Salt Harbor");
    settings.Add("level20", true, "21 - Avalanche", "saltharbor");
    settings.Add("level21", true, "22 - Flotsam", "saltharbor");
    settings.Add("level22", true, "23 - Igloo", "saltharbor");
    settings.Add("level23", true, "24 - Half Pipe", "saltharbor");
    settings.Add("level24", true, "25 - Glacier", "saltharbor");
    settings.Add("level25", true, "26 - Flurry", "saltharbor");
    settings.Add("level26", true, "27 - Dunes", "saltharbor");
    settings.Add("level27", true, "28 - Slush", "saltharbor");
    settings.Add("level28", true, "29 - Hedgehogs", "saltharbor");
    settings.Add("level29", true, "30 - Ice Shelf", "saltharbor");

    settings.Add("wavedistrict", true, "Wave District");
    settings.Add("level30", true, "31 - Big Screen", "wavedistrict");
    settings.Add("level31", true, "32 - Apartments", "wavedistrict");
    settings.Add("level32", true, "33 - Skyscrapers", "wavedistrict");
    settings.Add("level33", true, "34 - Uptown", "wavedistrict");
    settings.Add("level34", true, "35 - Downtown", "wavedistrict");
    settings.Add("level35", true, "36 - Destination", "wavedistrict");
    settings.Add("level36", true, "37 - Wavy", "wavedistrict");
    settings.Add("level37", true, "38 - Big Bro", "wavedistrict");
    settings.Add("level38", true, "39 - Zeitgeist", "wavedistrict");
    settings.Add("level39", true, "40 - Kappa", "wavedistrict");

    Action<string> DebugOutput = (text) => {
        print("[Treadnauts Autosplitter] "+text);
    };
    vars.DebugOutput = DebugOutput;
}

init
{
    vars.cleared = 0;
}

exit
{

}

update
{

}

start
{

}

split
{
    //if you choose a previous level on accident it will not split, and it makes sure the current level is new
    if (old.level == vars.cleared){
        print(current.level.ToString());
        if (current.level == old.level + 1)
        {
            vars.cleared = current.level;
            // Check setting for previous level value, because the split would
            // be for the end of the previous level
            if (settings["level"+old.level])
            {
                // vars.DebugOutput("Split Start of Level "+ current.level);
                return true;
            }
        }
        if (current.level == 39 && current.isPaused){
            vars.cleared = 0;
            return true;
        }
    }
}

reset
{
    if (settings["clearpause"] && current.level == 0)
    {
        vars.cleared = 0;
    }
}

isLoading
{
    // vars.DebugOutput("Pause is "+ current.isPaused);

    if (settings["clearpause"] && current.level != 39){
        return current.isPaused;
    }
    if (settings["pauseend"]){
        return current.isPaused;
    }
}
