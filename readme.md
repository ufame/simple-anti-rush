# Simple Anti Rush

The plugin freezes the CT, not allowing them to rush mindlessly.

## Features

1. Does not break the logic of the plugins working with freeze time (`mp_freezetime`);
2. Sets CT freeze timer, then returns the timer to the correct time before the end of the round;
3. Prevents aboot reconnect in order to bypass the freeze.

## Requirements

- [Amx Mod X](https://dev-cs.ru/resources/405/)
- [ReGameDLL](https://dev-cs.ru/resources/67/)
- [ReAPI](https://dev-cs.ru/resources/73/)

## Usage

1. Put the contents of the `addons/amxmodx/scripting` folder in the directory of your server (your_server_folder/cstrike/addons/amxmodx/scripting)
2. Compile `simple_anti_rush.sma` [how to compile?](https://dev-cs.ru/threads/246/)
4. Add `simple_anti_rush.amxx` into your `plugins.ini` file
5. Restart server or change map
6. Configure `addons/amxmodx/configs/plugins/plugin-simple_anti_rush.cfg`
7. Be happy!

## Config

### In `addons/amxmodx/configs/plugins/plugin-simple_anti_rush.cfg` file:

```Pawn
anti_rush_time - Anti rush (freeze) time for CT
```
