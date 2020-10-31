radioConfig = {
    Controls = {
        Activator = { -- Open/Close Radio
            Name = "INPUT_SELECT_CHARACTER_MICHAEL", -- Control name
            Key = 166, -- F5
        },
        Secondary = {
            Name = "INPUT_SPRINT",
            Key = 21, -- Left Shift
            Enabled = true, -- Require secondary to be pressed to open radio with Activator
        },
        Toggle = { -- Toggle radio on/off
            Name = "INPUT_CONTEXT", -- Control name
            Key = 51, -- E
        },
        Increase = { -- Increase Frequency
            Name = "INPUT_CELLPHONE_RIGHT", -- Control name
            Key = 175, -- Right Arrow
            Pressed = false,
        },
        Decrease = { -- Decrease Frequency
            Name = "INPUT_CELLPHONE_LEFT", -- Control name
            Key = 174, -- Left Arrow
            Pressed = false,
        },
        Input = { -- Choose Frequency
            Name = "INPUT_REPLAY_FOVINCREASE", -- Control name
            Key = 314, -- Numpad +
            Pressed = false,
        },
        Broadcast = {
            Name = "INPUT_VEH_CINEMATIC_DOWN_ONLY", -- Control name
            Key = 97, -- Numpad +
        },
        ToggleClicks = { -- Toggle radio click sounds
            Name = "INPUT_SELECT_WEAPON", -- Control name
            Key = 37, -- Tab
        }
    },
    Frequency = {
        Private = { -- List of private frequencies
            [797] = true, -- Make 797 a private Police frequency
            [798] = true, -- Make 798 a private EMS frequency
            [799] = true, -- Make 799 a private LAFD frequency
            [800] = true, -- Make 800 a private frequency
        }, -- List of private frequencies
        Current = 1, -- Don't touch
        CurrentIndex = 1, -- Don't touch
        Min = 1, -- Minimum frequency
        Max = 800, -- Max number of frequencies
        List = {}, -- Frequency list, Don't touch
        Access = {}, -- List of freqencies a player has access to
    },
    AllowRadioWhenClosed = true -- Allows the radio to be used when not open (uses police radio animation) 
}