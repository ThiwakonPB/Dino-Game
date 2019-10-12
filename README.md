# Sound Manager Plugin
## Version 1.10
## Created by Celeste Privitera (@Xecestel) & Simón Olivo (@Sarturo)
## Licensed Under MPL 2.0 (see below)

Find the plugin on [itch.io](https://xecestel.itch.io/sound-manager-plugin)!

## Overview

The Sound Manager gives the users a better control over the audio of their games. Using this plugin, it is possible to play every sound of the game using just simple method calls. No more long AudioStreamPlayer lists inside your scenes nor long methods to handle the audio inside every script.
It also gives you a better control over the Background Music.  The sounds will not stop between scenes anymore, giving you the power to stop it and play it whenever and however you want.

This is a plugin designed to facilitate the Sound Manager Module configuration process, by offering an UI in the editor that makes its configuration easier.

This plugin was created for:
- Automatically set the Sound Manager module scene as an autoload.
- Create a dock in the editor to make the configuration easier of the sound manager.


You can download this plugin 

## Configuration

1.  Copy & paste the folder `sound_manager` in the `res://addons/` path from your project (this is the standard path for plugins in Godot).
2.  To activate/deactivate the plugin, go to `Project/Project Settings/Plugins`, locate the plugin entry and change its status.
3.  Once the plugin is activated, a dock called `SoundManager` will appear in the editor. There you need to set the paths where the sound files are located, the sound manager handles 4 types of sounds: BGM, BGS, SFX, MFX. (It is not necessary to set all the paths). You can also set the AudioBuses from here too by writing the wanted bus name on the name field ("Master" is the fallback).
4.   Save the current scene (presss the shortcut CTRL + S ).

The UI consists of three sections to facilitate the configuration and use of the sound manager, this UI:
- Allows you to set the paths where the sound files are located in your project.
- Allows you to set the audiobuses available in your project.
- Displays the sound files available in each path. 
- Allows you to easily build and edit the Audio FIles Dictionary.

Once set up, you can play/stop the sound files in any scene. To play the sounds you can use the "Audio_Files_Dictionary" ,  it allows you to use different strings (keys) for method calls and for the file names. This way, even if your audio file is called "*sfx_audio_jump.ogg*", you can set it in the dictionary to call it as a simple "Jump", adding a simple entry `"Jump" : "sfx_audio_jump.ogg"`.  The dictionary is located inside the "SoundManager_config.gd" file, but you can use the UI to edit it. You can place it wherever you want inside your project directory.
Another way is to use the names of the sound files, for example `SoundManager.play_bgm("brackground_music.ogg")`, or the absolute path that leads to the path, like `SoundManager.play_bgm("res://Audio/BGM/background_music.ogg")`.

The dock also comes with an additional button: `Advanced Options` to access some more options. The ones currently available are:
- `Preload resources`: setting this true will make the SoundManager load every audio file located on the given paths at its `_ready()`. Note that this may slow down game start, especially in projects with a long list of audio files, but will make sound playing faster.
- `Preinstantiate nodes`: you can tell the plugin to instantiate every node at startup. This will work in synergy with the "multiple sounds at once" feature for BGS, SFX and MFX. Note that this will make playing multiple sounds faster but may slow down games start and even the game itself, especially in bigger projects.

## Methods
The main methods of this script are just 12, three for each section of the script (Background Music, Background Sounds, Sound Effects and Music Effecs), plus some useful setters and getters.
**All methods of the Sound Manager are accessed from the singleton called "SoundManager".**

### Main Methods
#### Background Music
The main methods are basically the same but with some differents for background musics (see below), the only difference between them in the method calls is the suffix on the name (`play_bgm` instead of `play_me` for example, or `is_bgm_playing` instead of `is_me_playing`). They can be summarized in three categories:

- `func play(audio : String, reset_to_defaults : bool = true) -> void`: this method lets you play the selected audio, passed as a string. If the audio is already playing, it won't do anything to avoid weird outcomes (or it will replace the previous one for BGMs). The `reset_to_defaults` argument lets you decide if you want the default values for the player property or not. It's useful if you often change volume and pitch (default value: `true`). Note that you can't use `play_bgm` to play a sound effect or music effect and vice versa.

- `func stop(audio : String = "") -> void`: this method lets you stop the stream from playing. The argument (default value: `""`) gives you the ability to tell the stream to stop only if a specific sound is playing. Note that you can't use `stop_bgm` to stop a sound effect or music effect and vice versa.

- `func is_playing(audio : String = "") -> bool`: this method returns `true` if the selected stream is plaing and `false` if not. The argument (default value: `""`) gives you the ability to check if is playing a specific audio file by passing its name. Note that you can't use `is_bgm_playing` to check on a sound effect or music effect and vice versa.

#### Music Effects, Sound Effects and Background Sounds
You can also play multiple music effects, multiple sound effects and multiple background sounds at once! This means that the methods to work with them are a little bit different in the method calls and require some more words:

- `func play(sound : String, reset_to_defaults : bool = true, override_current_sound : bool = true, sound_to_override : String = "") -> void`: this method is basically the same as the other `play` methods, but comes with some more arguments. `override_current_sound` is an optional boolean variable that allows you to tell the Sound Manager to just replace an already playing sound with a new one. The default value is `true`, but if you go with a `false` the Sound Manager will play the sound without stopping the others, simultaneously. If you go with `true`, however, you can also decide which sound you want to override, by adding the sound name in the optional `sound_to_override` argument. If you don't do that, the Sound Manager automatically overrides the main stream (the one that is already on the scene).

- `stop` and `is_playing` are basically te same as the other sections, they just work differently internally. Note that whenever a Sound Effect or a Background Sound stream player stops (besides the main one), it's deleted from the scene.

- All the getters and setters now require the sound name in order to work. This argument is however always optional: if you don't put any argument in the method call, they'll just assume you are referring to the main AudioStreamPlayer.

- The `get_playing` method now returns an Array of all the currently playing sounds.

### Getters and Setters
- `func set_volume_db(volume_db : float) -> void`: this method allows you to change the selected stream volume via script. `volume_db` is the volume in decibels. (`set_bgm_volume_db` for bgm)

- `func get_volume_db() -> float`: this method return the volume of the given stream. (`get_bgm_volume_db` for bgm)

- `func set_pitch_scale(pitch : float) -> void`: this method allows you to set the pitch scale of the selected stream via script. (`set_bgm_pitch_scale` for bgm)

- `func get_pitch_scale() -> float`: this method returns the pitch scale of the given stream. (`get_bgm_pitch_scale` for bgm)

- `func pause(paused : bool) -> void`: this method allows you to pause or unpause the selected stream. (`pause_bgm` for bgm)

- `func is_paused() -> bool)`: this method returns `true` if the selected stream is paused. (`is_bgm_paused` for bgm)

- `func get_playing() -> String`: this methods (one for each type of audio) return a String contaning the currently playing or last played bgm, bgs, se, or me. (`get_playing_bgm` for bgm)

- `func get_configuration_dictionary() -> Dictionary`: this method returns the configuration dictionary as the user configured it.

- `func get_config_value(stream_name : String) -> String`: this method returns the file name of the given stream name. Returns `null` if an error occured.

- `func set_config_key(new_stream_name : String, new_stream_file : String) -> void`: this method allows the user to edit an existng value on the configuration dictionary, or add a new one in runtime. `new_stream_name` is the name of your choice for the stream (the key in the dictionary), while `new_stream_file` is the name of the file linked to it (the value in the dictionary).

### Resource Preloading
There are also some useful methods to manage resource preloading:

- `func preload_resources_from_list(files_list : Array) -> void`: this method allows you to preload only a specific list of audio files. The content of the `files_list` array must be a recognizable sound name String, such as an absolute path, a file name, a sound name stored on the `Audio_Files_Dictionary` or even an already loaded sound `Resource`. This method is especially useful when you want to preload only certain sounds and not all of them, maybe because you know you will need them on the specific scene you're programming. Note that if the `Preload Resources` variable is enabled, this method will do nothing.

- `func preload_resources_from_dir(path : String) -> void`: this method lets you preload every audio file located in a specific directory (passed via the `path` string argument). This is especially useful if you are using a different folder from the standard directory that you set on the dock for some audio files and want to preload them too without having to write a full list of files. This can be used alongside the automatic preload process.

- `func preload_resource(file : Resource) -> void`: this is mainly an internal method, but in any case you can still use it to preload a specific file. The `file` argument must be an already loaded sound `Resource`. You can basically see this method as a way to store a loaded resource to use it on the Sound Manager as you please. The module will store this variable linking it to the file name as it would do with any other preloaded resource, so to play the sound you just have to use the file name or the sound name you used on the Audio Files Dictionary.

- `func preload_resource_from_string(file : String) -> void`: this is mainly an internal method, but in any case you can still use it to preload a specific file. For the `file` string argument rules, read the above rules about `files_list` array rules. Although this method exists and can be used, it's probably better to use the `preload_resources_from_list` method for almost any uses of this feature.

- `func unload_all_resources(force_unload : bool = false) -> void`: this method allows you to unload every previously preloaded audio file. It's especially useful when used in combo with the `preload_resources_from_list` to unload at the end of a scene any resource you loaded at the start of the scene. The `force_unload` argument (default: `false`) will let you unload preloaded resources even if the `Preload Resources` variable is set to on. Note that this will unload **all** preloaded resources, so it basically overrides the `Preload Resources` feature. If the `force_unload` argument is set to off, however, the method will do nothing if called while `Preload Resources` is on.

- `func unload_resources_from_list(files_list : Array) -> void`: this method allows you to pass a list of preloaded resources you want to unload. The files have to be Strings, but can be passed in any format (absolute path, file name, sound name). Note that thay can't be loaded Resources (why are you passing a loaded Resource if you want to unload it in the first place?)

- `func unload_resource_from_string(file : String) -> void`: this method allows you to unload a previously loaded resource passed by a string. The string can be passed in any format (absolute path, sound name, file name).

- `func unload_resources_from_dir(path : String) -> void`: this method lets you unload every audio file located in a specific directory (passed via the `path` string argument). This is especially useful if you preloaded a different folder from the standard directory that you set on the dock for some audio files and want to unload them too without having to write a full list of files. This can be used alongside the automatic preload process. 

- `func is_preload_resources_enabled() -> bool`: this method returns true if the module has been set to preload resources. This method will also return false if you preload specific files from a list, as that doesn't ovveride the `Preload Resources` variable.

### Nodes Preinstantiation
There are also some useful methods to manage nodes preinstantiation (to play multiple sounds of the same type at once):

- `func preinstantiate_nodes_from_dir(path : String, type : String) -> void`: this method lets you preinstantiate every needed node based on a directory content (given its `path`). This is especially useful if you are using a different folder from the standard directory that you set on the dock for some audio files and want to preinstantiate them too without having to write a full list of files. This can be used alongside the automatic preinstantiation process. The only catch is that every sound located in the given directory must be of the same sound type (BGM, BGS, SFX or MFX).

- `func preinstantiate_nodes_from_list(files_list : Array, type_list : Array, all_same_type : bool = false) -> void`: this method allows you to pass a list of files you want to preinstantiate a node for. The files have to be Strings, but can be passed in any format (absolute path, file name, sound name). Pay attention: the `type_list` argument is used to tell the module which type does any sound you passed have. The indexes of the `type_list` must coincide with the indexes of the `files_list`.  If the `all_same_type` argument is passed as true, you can pass a single element array for the `type_list` implying that all the files you're passing are of the same sound type.

- `func preinstantiate_node_from_string(file : String, type : String) -> void`: this method allows you to instantiate a node for a specific audio file passed by a string. The string can be passed in any format (absolute path, sound name, file name). The `type` string is the type of the audio and must be either `BGS`, `SFX` or `MFX`.

- `func preinstantiate_node(stream : Resource, type : String) -> void`: this method allows you to instantiate a node for a specific audio file passed as an already loaded Resource. The file can be accessed afterwards with a sound name or a file name. The `type` string is the type of the audio and must be either `BGS`, `SFX` or `MFX`.

- `func uninstantiate_all_nodes(force_uninstantiation : bool = false) -> void`: this method allows you to uninstantiate every previously instantiated node. It's especially useful when used in combo with the `preinstantiate_nodes_from_list` to uninstantiate at the end of a scene any node you instantiated at the start of the scene. The `force_uninstantiation` argument (default: `false`) will let you uninstantiate nodes even if the `Preinstantiate Nodes` variable is set to on. Note that this will uninstantiate **all** instantiated resources, so it basically overrides the `Preinstantiate Nodes` feature. If the `force_uninstantiation` argument is set to off, however, the method will do nothing if called while `Preinstantiate Nodes` is on.

- `func uninstantiate_nodes_from_list(files_list : Array, type_list : Array, all_same_type : bool = false) -> void)`: this method allows you to pass a list of preinstantiated nodes you want to uninstantiate. The nodes have to be Strings, but can be passed in any format (absolute path, file name, sound name). Pay attention: the `type_list` argument is used to tell the module which type does any sound you passed have. The indexes of the `type_list` must coincide with the indexes of the `files_list`.  If the `all_same_type` argument is passed as true, you can pass a single element array for the `type_list` implying that all the files you're passing are of the same sound type.

- `func uninstantiate_node_from_string(file : String, type : String) -> void`: this method allows you to uninstantiate a previously instantiated node passed by a string. The string can be passed in any format (absolute path, sound name, file name). The `type` string is the type of the audio and must be either `BGS`, `SFX` or `MFX`.

- `func uninstantiate_nodes_from_dir(path : String, type : String) -> void`: this method lets you uninstantiate every instantiated node based on a directory content (given its path). This is especially useful if you are using a different folder from the standard directory that you set on the dock for some audio files and want to uninstantiate them too without having to write a full list of files. This can be used alongside the automatic preinstantiation process. The only catch is that every sound located in the given directory must be of the same sound type (BGM, BGS, SFX or MFX).

- `func is_preinstantiate_nodes_enabled() -> bool`: this method returns true if the module has been set to preinstantiate nodes. This method will also return false if you instantiate specific nodes from a list, as that doesn't ovveride the `Preinstantiate Nodes` variable.


## IMPORTANT NOTES:
For more information about how the Sound Manager Module works, read the [README](./addons/sound_manager/module/README.md) file inside the `module` directory.

**Remember to add `*.json` files as to be exported on your export template, otherwhise the plugin may not work on the exported games.**

## Credits
The plugin was developed by Simón Olivo (@Sarturo) and Celeste Privitera (@Xecestel) as a derivative work from the [Sound Manager Module](./addons/sound_manager/module) originally developed by Celeste Privitera.

## Licenses
### Sound Manager Module
Copyright © 2019 Celeste Privitera  

The Sound Manager Module is subject to the terms of the Mozilla Public License, v. 2.0.  
If a copy of the MPL was not distributed with this file, You can obtain one at [https://mozilla.org/MPL/2.0/](https://mozilla.org/MPL/2.0/).

### Sound Manager Plugin
Copyright © 2019 Simón Olivo & Celeste Privitera  

The Sound Manager Plugin is subject to the terms of the Mozilla Public License, v. 2.0.  
If a copy of the MPL was not distributed with this file, You can obtain one at [https://mozilla.org/MPL/2.0/](https://mozilla.org/MPL/2.0/).

## Changelog
### Version 1.3
- Now the plugin only loads audio files on the sound tabs
- Improved code readability a little bit

### Version 1.3.1
- Bug fixes

### Version 1.4
- Added advanced option button and resource preloading button.

### Version 1.5
- The resource preloading doesn't require the Audio File Dictionary anymore

### Version 1.6
- Added nodes preinstanting feature.

### Version 1.7
- Now the config file will not be reset at every update anymore.
- Bug fix

### Version 1.8
- Sound Manager Module has been updated to 2.3: now you can pass absolute paths to play sounds.
- Fixed bug that made the dock difficult to see on smaller screens.

### Version 1.8.1
- Bug fixes

### Version 1.9
- Improved preloading feature
- Improved absolute path passing feature
- Updated docs

### Version 1.9.1
- Improved manual preloading: now you can pass already loaded resources

### Version 1.9.2
- Bug fixes

### Version 1.9.3
- Bug fixes

### Version 1.9.4
- Bug fixes

### Version 1.10
- Added manual preinstantiation: now you can preinstantiate selected nodes
- Improved manual preloading
- Bug fixes and general improvements
