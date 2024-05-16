Regular FSR2FSR3 installation
First, find out which mod version you need. Two ways to achieve this:
Automatic: Go to https://mods.lukefz.xyz/
and check if your game is mentioned in the game dropdown. If it is, use that version.
Manual: Find out which version of FSR2 the game uses.
You can do this by using the PCGamingWiki, checking in ⁠game-compatibility-list, or asking in the discord.
NOTE: Certain games (Ratchet & Clank: Rift Apart) use a different implementation of FSR2, but might also be listed as using version 2.2 on the wiki.
You can detect these by looking for a file called ffx_fsr2_x64.dll in the game directory.
If your game has that file in its game directory, please use the SDK version of the mod.
Once you know which version of FSR2 the game uses, download the mod version corresponding to the FSR2 version from the website.
Navigate to your game executable.
For most games this should be in the root game directory, but also check the Notes section for your game's compatibility list entry for any specific directory you might need to use instead.
For Unreal Engine games, you should use the executable ending with -Shipping.exe, which should be in a subdirectory. Do not use the executable found in the root game directory!
Extract the downloaded mod archive into the folder with the game executable.
Launch the game. If everything worked correctly, there should be a new console window with a few log messages and FSR3 working once you enable FSR2 (or DLSS in select games.

Notes
If you are on linux, you need to add an environment variable WINEDLLOVERRIDES="winmm=n,b" to get the mod to work.
For Steam games you can do that by adding WINEDLLOVERRIDES="winmm=n,b" %COMMAND% into your launch parameters in game properties.
If the game requires a (fake) NVIDIA GPU according to its entry in ⁠game-compatibility-list, and you are currently using an AMD GPU, you need to extract enable_fake_gpu.zip next to the game executable.
You can also manually set fake_nvidia_gpu = true in the mod's config file, fsr2fsr3.config.toml, 
which will be created after launching the game for the first time with the mod installed.
You might get an outdated driver message on launch. This is expected, as the game tries to compare your AMD driver version with the much-larger NVIDIA driver versions, so it can safely be ignored.
Some games might require you to add a nvngx.dll file next to the executable. To achieve this, copy the "nvngx.dll" from the "optional_nvngx_files" folder into the parent directory and run the "EnableSignatureOverride.reg" file.
On Linux, you need to run it in the wine-prefix for that specific game. You can do that via winetricks or protontricks for Steam games.
Launch Protontricks, select the game, select OK on the default prefix, then choose an option to launch regedit. 
From there, in the top left select import and navigate to EnableSignatureOverride.reg and select it, confirm every popup. 


How to disable the Epic Games Store overlay
Games bought from the Epic Store have a high chance of randomly crashing when the overlay is enabled.
To disable it, follow these steps:
Go into your Epic Games Store installation folder (usually C:/Program Files (x86)/Epic Games/Launcher)
Navigate to Portal/Extras/Overlay
Rename EOSOverlayRenderer-Win32-Shipping.exe and EOSOverlayRenderer-Win64-Shipping.exe to something else, like disabled-EOSOverlayRenderer.exe
Navigate to C:/Program Files (x86)/Epic Games/Epic Online Services/managedArtifaces/ and, if they exist, rename the two executables like you did in step 3.

How to enable the Fake GPU or AMD Unreal Engine Workaround
Find the correct config (fsr2fsr3.config.toml, launch the game once to create it) entry:
Fake GPU: fake_nvidia_gpu
AMD Workaround: amd_unreal_engine_dlss_workaround
Change false to true next to it

How to enable DLSS Frame Generation in Nixxes Games (Spider-Man, Miles Morales, Ratchet & Clank)
Add -forceReflexMarkers to the launch arguments.

How to upgrade from an earlier version
Follow the How to uninstall section.
If you had the old proxy installed, also delete dxgi.dll.
Follow the installation instructions.

How to uninstall
Delete the following files:
winmm.dll
winmm.ini
lfz.sl.dlss.dll
fsr2fsr3.config.toml
fsr2fsr3.log
fsr2fsr3.asi
nvngx.dll


Extract both archives next to your game executable.
Depending on your GPU vendor, this game requires additional config tweaks.
Start the game once, then open up the newly-created fsr2fsr3.config.toml file in a text editor.
Change these settings if you have an AMD GPU:
- enable_fake_gpu -> true
- amd_unreal_engine_dlss_workaround -> true (if you select DLSS ingame)
Change these settings if you have an Intel GPU:
- enable_fake_gpu -> true



Depending on which mods you have installed, you need to install the mod differently.

No mods installed:

Extract all files from the latest version of FSR2FSR3_220 into Cyberpunk 2077/bin/x64
Cyber Engine Tweaks (and Red4Ext) installed:

Extract FSR2FSR3.asi into Cyberpunk 2077/bin/x64/plugins
Red4Ext installed:

Extract FSR2FSR3.asi into Cyberpunk 2077/bin/x64
Extract and rename winmm.dll and winmm.ini to version.dll and version.ini into Cyberpunk 2077/bin/x64
