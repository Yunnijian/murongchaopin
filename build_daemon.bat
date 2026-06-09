@echo off
setlocal EnableExtensions
set "USER_NDK_ROOT=%NDK_ROOT%"
set "FOUND_NDK_ROOT="
if defined ANDROID_NDK_ROOT (
    if exist "%ANDROID_NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe" (
        set "FOUND_NDK_ROOT=%ANDROID_NDK_ROOT%"
    )
)
if not defined FOUND_NDK_ROOT (
    if defined USER_NDK_ROOT (
        if exist "%USER_NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe" (
            set "FOUND_NDK_ROOT=%USER_NDK_ROOT%"
        )
    )
)
if not defined FOUND_NDK_ROOT (
    if exist "C:\android-ndk-r27d-windows\huanjing\android-ndk-r30-beta1\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe" (
        set "FOUND_NDK_ROOT=C:\android-ndk-r27d-windows\huanjing\android-ndk-r30-beta1"
    )
)
if not defined FOUND_NDK_ROOT (
    if exist "C:\android-ndk-r27d-windows\huanjing\android-ndk-r30\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe" (
        set "FOUND_NDK_ROOT=C:\android-ndk-r27d-windows\huanjing\android-ndk-r30"
    )
)
if not defined FOUND_NDK_ROOT (
    if exist "C:\android-ndk-r27d-windows\android-ndk-r27d\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe" (
        set "FOUND_NDK_ROOT=C:\android-ndk-r27d-windows\android-ndk-r27d"
    )
)
if not defined FOUND_NDK_ROOT (
    echo Build failed! Android NDK not found.
    echo Hint: set ANDROID_NDK_ROOT or NDK_ROOT first.
    exit /b 1
)
set "NDK_ROOT=%FOUND_NDK_ROOT%"
set "CLANG=%NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe"

echo Compiling rate_daemon...

"%CLANG%" ^
    --target=aarch64-linux-android30 ^
    -O3 ^
    -static ^
    src\rate_daemon.c ^
    -o bin\rate_daemon

echo Compiling dts_tool...

"%CLANG%" ^
    --target=aarch64-linux-android30 ^
    -O3 ^
    -static ^
    src\dts_tool.c ^
    -o bin\dts_tool

if %ERRORLEVEL% EQU 0 (
    echo Build successful! Output: bin\rate_daemon, bin\dts_tool
) else (
    echo Build failed!
)
