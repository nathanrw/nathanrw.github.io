+++
title = "MonoGame on Mac"
date = "2023-04-08"
sorted_by = "date"
+++

I have been migrating my game project from Unity to MonoGame because of various
issues I had with Unity. Mostly I use a Windows PC but sometimes I use a
Macbook. So I need my project to build on both. MonoGame works fine on Windows,
but the process of getting it to work on Mac has not been smooth.

# Content Builder

This was the most serious, though not the first, problem. So I will start here.

## Shaders

MonoGame comes with [official instructions][docs] for setting up your
development environment on Mac. These contain instructions to run a
[script][script_master] in order for shader compilation to work. MonoGame uses a
tool [mojoshader][mojoshader] to transate HLSL shaders into GLSL in the
`Desktop.GL` backend, which is the default cross-platform desktop backend.

This tool only works on Windows. On Linux and Mac, shader compilation requires
Wine. When the environment variable `MGFXC_WINE_PATH` is detected, the MonoGame
effect compiler will re-invoke itself via a `dotnet` installed in the Wine
prefix at that path.

The setup script creates this Wine prefix and adds a line to `.profile` and
`.zprofile` to create that environment variable. The MonoGame project template
creates a configuration file in the project directory which points to particular
versions of the `dotnet-mgcb*` tools, so running `dotnet mgcb-editor` in your
project directory will run the correct version of the editor and (provided you
ran it from an environment with the `MGFXC_WINE_PATH` variable set) it will be
able to compile effects.

The first problem is that Visual Studio does _not_ (of course) have that
environment variable set as a consequence of changing `.profile`. So starting
the content editor from within Visual Studio results in a content editor that
cannot build shaders. OK, fine, I will start it from the terminal.

Starting the content builder from the terminal, I was able to get it to find
Wine. Hurrah! But effect compilation failed with no error message.

I think the Wine prefix configured by the script was suppressing error
messages, but I could be wrong:

```Bash
# disable wine crash dialog
cat > "$SCRIPT_DIR"/crashdialog.reg <<_EOF_
REGEDIT4
[HKEY_CURRENT_USER\\Software\\Wine\\WineDbg]
"ShowCrashDialog"=dword:00000000
_EOF_
```

Anyway, I read the source code of the effect compiler to figure out what
it was trying to do, and wrote a script to do the same thing. It was
something like

```Bash
export WINEARCH=win64
export WINEDLLOVERRIDES=d3dcompiler_47=n
export WINEPREFIX=/Users/nathan/.winemonogame

assembly="/Users/nathan/.nuget/packages/dotnet-mgcb/3.8.1.303/tools/net6.0/any/mgfxc.dll"

wine64 dotnet "$assembly" "$@"
```

At this point I did a lot of googling, tried various Wine versions, and got a
bunch of different error messages. But nothing actually worked. After some time,
and after stumbling across the correct answer in a forum post, it turns out the
problem was that the [script][script_now] linked in the official instructions at
time of writing installed the 32-bit .NET SDK to the Wine prefix. Recent macs
have no support for 32-bit applications. So it did not work. The fix, as
mentioned in [this forum thread][fix_thread], is to install the 64-bit .NET SDK
instead. Indeed, this has already been done in the `develop` branch of MonoGame.
But it has not reached `master`, and the docs link to the script from `master`.
This meant I had originally dismissed this as the cause of the problem, since I
had seen that it had been fixed. It was not until I carefully re-read the setup
script I noticed it still had the problem.

### What is the Wine prefix setup script doing?

If you boil it down to the essentials, it's not doing all that much.

```Bash
export WINEARCH=win64
export WINEPREFIX=$HOME/.winemonogame
wine64 wineboot

7z x "/Users/nathan/Downloads/dotnet-sdk.zip" -o"$WINEPREFIX/drive_c/windows/system32/"
cp -f "/Users/nathan/Downloads/d3dcompiler_47.dll" "$WINEPREFIX/drive_c/windows/system32/d3dcompiler_47.dll"
```

The actual script downloads the .NET SDK. It also downloads Firefox in order to
extract `d3dcompiler_47.dll`.

## Textures

I got errors compiling a texture. Thankfully I was not using it, so I deleted
it. I will probably end up needing to deal with this at some point

## Fonts

SharpFont fails to load freetype. This is a binary compatibility issue.

```
lipo -info dotnet-mgcb/3.8.1.303/tools/net6.0/any/libfreetype6.dylib 
Non-fat file: dotnet-mgcb/3.8.1.303/tools/net6.0/any/libfreetype6.dylib is architecture: x86_64
```

```
lipo -info /usr/local/share/dotnet/dotnet
Non-fat file: /usr/local/share/dotnet/dotnet is architecture: arm64
```

This is an arm64 mac. The .NET SDK is arm64. The freetype bundled with MonoGame is x64.

I installed freetype using homebrew. Then I copied the `.dylib` to a temporary directory using
the expected name.

```Bash
#!/bin/bash

export DYLD_LIBRARY_PATH=/Users/nathan/Projects/NGLBuild/NGLMonoGame/libs

dotnet mgcb Content/Fonts/File.spritefont
```

This worked!

## VS Plugin

Does not install successfully. Need to debug this some more. Thankfully everything
seems to work without it more or less, so not as urgent.


[docs]: https://docs.monogame.net/articles/getting_started/1_setting_up_your_development_environment_macos.html
[script_master]: https://raw.githubusercontent.com/MonoGame/MonoGame/master/Tools/MonoGame.Effect.Compiler/mgfxc_wine_setup.sh
[script_now]: https://github.com/MonoGame/MonoGame/blob/15fd99a8189bfc9f4319ac39f5eb1c0bbe2ec66b/Tools/MonoGame.Effect.Compiler/mgfxc_wine_setup.sh
[mojoshader]: https://icculus.org/mojoshader/
[fix_thread]: https://community.monogame.net/t/mgfxc-8-3-1-wine/17809