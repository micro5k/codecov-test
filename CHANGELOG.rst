..
   SPDX-FileCopyrightText: (c) 2016 ale5000
   SPDX-License-Identifier: GPL-3.0-or-later
   SPDX-FileType: DOCUMENTATION

=========
Changelog
=========

All notable changes to this project will be documented in this file.


`Unreleased`_
-------------
- Click above to see all the changes.

`1.3.2-beta`_ - 2025-03-22
--------------------------
- The zip now include :code:`setprop-settings-list.csv` that contains all settings that can be changed via setprop
- Improved the input event parsing code, now it check for a pair of key press / key release events before accepting the action
- Added 64-bit support in the input event parsing code
- Improved compatibility of :code:`zip-install.sh` with legacy Android versions
- Added the possibility to reset battery in the MinUtil script
- Now it only delete app updates during uninstallation or first-time installation
- Automatically rollback optional apps to reclaim space when there isn't enough free space on the system partition
- Improved rollback handling
- Possibly fixed bootloops even in case of complete failure by changing the installation order
- Added a working version of Gmail (only needed on Android 5.0 - 7.1.2)
- Reduced permissions granted to Play Store
- Updated microG Services Framework Proxy (signed by ale5000) to 0.1.0-7-gff1b9aa
- Improved the free space change detection
- Now it will use the last selected choice for all options when not using live setup
- Added an option, disabled by default, that allow the installation of microG signed by ale5000: :code:`USE_GMSCORE_SIGNED_BY_ALE5000`
- Allow to control the setting :code:`USE_GMSCORE_SIGNED_BY_ALE5000` via setprop
- Renamed the option :code:`USE_GMSCORE_SIGNED_BY_ALE5000` to :code:`USE_MICROG_BY_ALE5000` (example: :code:`adb shell "setprop zip.microg-unofficial-installer.USE_MICROG_BY_ALE5000 1"`)
- Added a separate microG Companion for legacy Android versions => microG Companion Legacy to 0.3.0.37524-42 (a00b36f)
- Updated microG Services (signed by ale5000) to 0.3.0.240615-154 (fc1ef64)
- Updated microG Companion (signed by ale5000) to 0.3.0.37524-106 (7c92307)
- Added privacy mode to Android device info extractor
- Improved compatibility of random number generation with old Android versions (used by the setup)
- Added support for resetting GMS data of all apps inside MinUtil
- Allow the project to be built with VS Code
- Allow the project to be built with make / pdpmake
- Display disk space required and available free space during installation
- Warn about lack of free space
- Replaced NewPipe old and NewPipe Legacy with NewPipe Legacy Revo which is still supported
- Removed Mozilla UnifiedNlp Backend (it was only used on very old devices, and now the Mozilla Location Service has been shut down)
- Added the app My Location (optional)
- Updated microG Services to 0.3.6.244735 and microG Companion to 0.3.6.40226
- Major overhaul of the mounting code
- Improved mounting of all extra partitions
- Do not allow flashing if the battery level is too low
- Added :code:`DRY_RUN` setting to allow flashing the zip without modifying anything on the device (to enable: :code:`adb shell "setprop zip.microg-unofficial-installer.DRY_RUN 1"`)
- Added support for :code:`DRY_RUN` env variable in :code:`zip-install.sh`
- Added :code:`KEY_TEST_ONLY` setting to allow testing the recognition of key presses (to enable: :code:`adb shell "setprop zip.microg-unofficial-installer.KEY_TEST_ONLY 1"`)
- Renamed :code:`FORCE_HW_BUTTONS` to :code:`FORCE_HW_KEYS`
- Added support for :code:`KEY_TEST_ONLY` env variable in :code:`zip-install.sh`
- Updated NewPipe Legacy Revo to 0.19.9.8
- Updated NewPipe to 0.27.6
- Rewritten input event parsing to handle more than one event source at a time (it fix the issue of volume down key ignored)
- Changed prefix of app install settings from :code:`INSTALL_` to :code:`APP_` (compatibility with old :code:`INSTALL` settings via setprop is kept)
- Increased default timeout for live setup to 4 seconds

`1.3.1-beta`_ - 2023-05-01
--------------------------
- Improve compatibility of the MinUtil script with old Android versions
- The MinUtil script is now installed under KitKat and higher
- Add FORCE_HW_BUTTONS env variable to force using hardware buttons even when using :code:`zip-install.sh`
- Improve error handling of :code:`zip-install.sh`
- Add support for uninstallation
- Add `Android device profile generator <https://github.com/micro5k/microg-unofficial-installer/blob/main/utils/profile-generator.sh>`_ (it automatically generate a device profile, usable by microG, from a device connected via adb)
- Add `Android device info extractor <https://github.com/micro5k/microg-unofficial-installer/blob/main/utils/device-info.sh>`_ (it automatically extract device information from a device connected via adb)
- Add support for very limited "su" binaries in :code:`zip-install.sh`
- Allow to configure all options before flashing the zip (example: :code:`adb shell "setprop zip.microg-unofficial-installer.LIVE_SETUP_TIMEOUT 8"`)
- Support the timeout also for the manual input parsing, fix `#59 <https://github.com/micro5k/microg-unofficial-installer/issues/59>`_
- Add Aurora Services 1.1.1
- Update NewPipe to 0.25.1
- Remount all extra partitions as read-write if necessary

`1.3.0-beta`_ - 2023-02-19
--------------------------
- Add support for mounting system partition at /mnt/system (`@mjenny <https://github.com/mjenny>`_)
- Improve compatibility with legacy shells
- Fix remounting system as read-write
- Rewrite system mounting code
- Fix debug log path when sideloading (thanks `@mjenny <https://github.com/mjenny>`_ for the help)
- Auto-root if needed in :code:`zip-install.sh`
- Update microG Service Core to 0.2.27.223616 (now using MapLibre)
- Add full support for automounting A/B slot partitions (thanks `@mjenny <https://github.com/mjenny>`_ for the help)
- Add full support for automounting dynamic partitions (thanks `@mjenny <https://github.com/mjenny>`_ for the help)
- Support DEBUG_LOG and FORCE_ROOT env variables in :code:`zip-install.sh`
- Fallback to manual parsing of key events when keycheck fails, fix `#5 <https://github.com/micro5k/microg-unofficial-installer/issues/5>`_
- Support live setup under :code:`zip-install.sh`
- Update NewPipe to 0.25.0
- Support and enable live setup on all devices

`1.2.0-beta`_ - 2022-12-30
--------------------------
- Update Mozilla UnifiedNlp Backend to 1.5.0
- Grant the ACCESS_BACKGROUND_LOCATION permission to Mozilla UnifiedNlp Backend by default
- Improve temp folder handling
- Improve priv-app folder detection
- Add Android Auto 1.2.512930-stub (disabled by default, not tested)
- Improve GApps cleaning
- Auto mount / unmount extra partitions
- Install MinUtil script on the device (can be used from terminal if rooted or via ADB)
- Added function to reinstall packages as if they were installed from Play Store in the MinUtil script
- Added function to remove all accounts of the device in the MinUtil script
- Update NewPipe to 0.23.3
- Refactor some code, now most apps can be enabled/disabled directly in the Live setup
- Improve installation performance by verifying only the files that are really installed
- Preset microG settings
- Update FakeStore to 0.1.0
- Add back the F-Droid Privileged Extension
- Enable installation under API 8 although only F-Droid Privileged Extension is installed there
- Add NewPipe 0.24.0 for Android 5+ devices
- Update Android Auto stub to 1.2.520120-stub
- Improved uninstaller
- Vastly improve compatibility with legacy devices
- Add function to rescan storage in the MinUtil script
- Update microG Service Core to 0.2.26.223616
- Update NewPipe to 0.24.1 for Android 5+ devices
- Add an helper script (:code:`zip-install.sh`) for the installation of the flashable zip via terminal or via ADB (recovery not needed)
- Add function to force GCM reconnection in the MinUtil script
- Remount /system as read-write if needed
- Add support for addon.d also on legacy Android versions

`1.1.0-beta`_ - 2022-04-28
--------------------------
- Improve Dalvik cache cleaning
- Fix the detection of system partition on some devices
- Rewritten architecture detection to improve compatibility
- Update NewPipe Legacy to 0.20.8
- Switch NewPipe from the F-Droid version to the official version
- Improved compatibility with various apps
- Remove microG DroidGuard Helper as it is no longer needed
- Update Déjà Vu Location Service to 1.1.12
- Update XML files for newer Android versions
- Update microG Service Core (VTM) to 0.2.13.203915-vtm
- Update microG Service Core (Mapbox) to 0.2.24.214816
- Remove apps that break GCM
- Improve location updates
- Insert the android.permission.ACCESS_BACKGROUND_LOCATION in XML files only if needed
- Zip builds are now reproducible (with Java 11 or later)
- Made some changes for future Magisk support
- You can now test the zip installation on PC using "gradlew installTest" (tested on Linux and Windows)
- Mount / unmount partitions only if they weren't already mounted
- Update NewPipe to 0.22.2
- Improve system partition mounting / unmounting
- Added support for Android up to 13

`1.0.34-beta`_ - 2019-07-07
---------------------------
- Rewritten the uninstaller
- Improved microG / GApps removal
- Only insert the fake signature permission in priv-app permissions whitelist if the ROM support it
- Added Play Store permissions to priv-app permissions whitelist
- Added option to reset GMS data of all apps
- Include the option to reset GMS data of all apps in live setup
- Improved sysconfig
- Properly uninstall Maps APIv1 on odexed ROMs
- Update microG Service Core for legacy devices to 0.2.6.13280
- Update microG Service Core to 0.2.8.17785-2-vtm-8a0010a
- Add the Mapbox version of microG GmsCore and make it default on supported devices
- Update Déjà Vu Location Service to 1.1.11
- Update NewPipe to 0.16.2
- Add NewPipe Legacy for legacy devices

`1.0.33-beta`_ - 2018-12-04
---------------------------
- Fixed architecture detection error on some recoveries
- Fixed empty ABI list on some recoveries
- Allow building through Gradle
- Added the possibility to build a zip with only open-source components
- Test the integrity of the generated zip after build

`1.0.32-beta`_ - 2018-11-01
---------------------------
- Updated microG Service Core to 0.2.6.13280
- Updated Déjà Vu Location Service to 1.1.9
- Switched to a custom build of microG DroidGuard Helper to fix SafetyNet Attestation
- Preset F-Droid repositories
- Updated NewPipe to 0.14.2
- Install default permissions xml files only if needed
- Install priv-app permissions whitelist on Android 8 and higher

`1.0.31-beta`_ - 2018-08-28
---------------------------
- Initial work regarding reproducible builds of the installer zip file
- Updated BusyBox for Android to 1.29.1-YDS-201807291348
- Added an option to skip the installation of NewPipe, ref #8
- Switched to using a 64-bit BusyBox on a 64-bit devices
- Switched to a more error proof method for creating the file list, ref: #9
- Check also armeabi-v7a in the CPU detection for BusyBox
- Switched from vendor/lib to system/lib for lib installation on old devices so it is easier to setup
- Updated microG Service Core to 0.2.5.12879

`1.0.30-alpha`_ - Unreleased
----------------------------
- Add support for building the installer under macOS (untested)
- Auto-grant signature spoofing permission to microG, thanks to @lazerl0rd
- Auto-grant signature spoofing permission also to FakeStore
- Updated zipsigner to 2.2
- Grant additional rights to microG GmsCore
- Declared support for Addon.d-v2
- Updated BusyBox for Windows to 1.30.0-FRP-2294-gf72845d93 (2018-07-25)
- Updated NewPipe to 0.13.7
- Updated Mozilla UnifiedNlp Backend to 1.4.0
- Updated Déjà Vu Location Service to 1.1.8

1.0.29-beta - 2018-04-11
------------------------
- Switched signing tool to zipsigner (thanks to `@topjohnwu <https://github.com/topjohnwu>`_)
- Highly improved debug logging
- Improved compatibility of the build script
- Check the presence of the ROM before installing
- Fixed error logging from the subshell
- Updated BusyBox for Android to 1.28.3-YDS-201804091805
- Updated BusyBox for Windows to 1.29.0-FRP-2121-ga316078ad (2018-04-09)
- Always grant network access to microG GmsCore
- Removed F-Droid Privileged Extension, it will be in a separate package in the future

1.0.28-alpha - Unreleased
-------------------------
- Improved debug logging
- Updated BusyBox for Android to 1.28.0-YDS-201801031253
- Updated BusyBox for Windows to 1.29.0-FRP-2001-gd9c5d3c61 (2018-03-27)
- Improved GApps / microG removal
- Added dalvik-cache cleaning
- Updated microG Service Core to 0.2.4-111
- Updated Déjà Vu Location Service to 1.1.5
- Updated NewPipe to 0.11.6

1.0.27-beta
-----------
- Updated microG Service Core to 0.2.4-108
- Updated Déjà Vu Location Service to 1.0.7
- Updated NewPipe to 0.11.4
- Updated permissions list
- Added removal of Baidu location service
- Improved removal of AMAP location service
- Improved GApps / microG removal
- Automatically create folders on the device if missing

1.0.26-alpha
------------
- Added NewPipe 0.11.1 (as replacement for YouTube)
- Automatically disable battery optimizations for microG GmsCore
- Updated Mozilla UnifiedNlp Backend to 1.3.3
- Updated Déjà Vu Location Service to 1.0.4
- Install Déjà Vu Location Service only on supported Android versions
- Almost fully rewritten the GApps / microG uninstaller
- Now it also clean app updates

1.0.24-alpha
------------
- Updated microG Service Core to 0.2.4-107

1.0.23-alpha
------------
- Added Déjà Vu Location Service 1.0.2
- Now the list of files to backup for the survival script are generated dynamically so all files are preserved in all cases
- Refactored code

1.0.22-beta
-----------
- Updated microG Service Core to 0.2.4-105
- Updated F-Droid Privileged Extension to 0.2.7
- Install recent market app on Android 5+
- Improved debug logging
- Allow to configure the live setup timeout
- Allow to configure the version of the market app to install

1.0.21-beta
-----------
- Added FakeStore 0.0.2
- Added support for live setup (currently limited to ARM phones)
- Added selection of the market app to install in the live setup
- Improved robustness

1.0.20-alpha
------------
- Added default permissions
- Reset permissions on dirty installations
- Remove conflicting location providers

1.0.19-alpha
------------
- Released sources on GitHub
- Changed signing process to fix a problem with Dingdong Recovery and maybe other old recoveries
- More consistency checks and improved error handling

1.0.18-alpha
------------
- Updated microG Service Core to 0.2.4-103
- Updated Nominatim Geocoder Backend to 1.2.2
- Switched BusyBox binaries to the `ones <https://xdaforums.com/t/3348543/>`_ compiled by @YashdSaraf (BusyBox is used only during the installation, nothing on the device is altered)
- Completely removed the disabler code for Play Store self update since it wasn't a clean method
- Improved the internal GApps remover
- GApps remover now also remove MIUI specific files

1.0.17-beta
-----------
- Downgraded microG Service Core to 0.2.4-81 on Android < 5 (workaround for bug `#379 <https://github.com/microg/GmsCore/issues/379>`_)
- Added a workaround for recoveries without /tmp
- Updated microG DroidGuard Helper to 0.1.0-10
- Updated F-Droid Privileged Extension to 0.2.5

1.0.16-alpha
------------
- Updated microG Service Core to 0.2.4-92
- Validate some return codes and show proper error if needed
- The lib folder is now created automatically if missing

1.0.15-pre-alpha
----------------
- Rewritten the update-binary as shell script to improve compatibility with all devices
- Updated F-Droid Privileged Extension to 0.2.4

1.0.14-alpha
------------
- Updated microG Service Core to 0.2.4-81
- file_getprop is no longer used
- Fixed support for system root image
- Minor changes

1.0.13-alpha
------------
- Added support for devices with system root image (untested)
- Updated F-Droid Privileged Extension to 0.2.2
- Switch the apk name of F-Droid Privileged Extension to the official one
- F-Droid Privileged Extension is now installed on all Android versions
- Minor changes

1.0.12-alpha
------------
- Added microG DroidGuard Helper 0.1.0-4
- Added more components to the survival script, not yet complete (only Android 5+)

1.0.11-alpha
------------
- Added a survival script (not complete)
- Updated microG Service Core to 0.2.4-79
- Updated Nominatim Geocoder Backend to 1.2.1

1.0.10-beta
-----------
- Reverted blocking of Play Store self update on Android 5+ since it is not reliable
- Updated microG Service Core to 0.2.4-64
- Updated Nominatim Geocoder Backend to 1.2.0
- Added F-Droid Privileged Extension 0.2 (only Android < 5)

1.0.9-beta
----------
- Play Store self update is now blocked on all Android versions
- Avoid possible problems that could happen if the Play Store was already updated before flashing the zip

1.0.8-beta
----------
- Play Store self update is now blocked (only Android 5+)

1.0.7-beta
----------
- Downgraded Play Store to 5.1.11 (this fix the crash when searching)

1.0.6-beta
----------
- Updated microG Service Core to 0.2.4-50
- Updated UnifiedNlp (legacy) to 1.6.8
- Added support for devices with x86_64 CPU (untested)

1.0.5-beta
----------
- Verify hash of extracted files before installing them
- Fixed installation of 64-bit libraries on old Android versions

1.0.4-alpha
-----------
- Total rewrite of the code for installing libraries
- Added support for 64-bit ARM
- Added UnifiedNlp (legacy) 1.6.7 (only for Android < 4.4)

1.0.3-alpha
-----------
- Major rewrite of the installation script to add support for newer Android versions (big thanks to `@JanJabko <https://xdaforums.com/m/janjabko.7275198/>`_ for the phone)
- Updated microG Service Core to 0.2.4-39
- Updated Play Store to 5.4.12
- Minimum API version back to 9

1.0.2-beta
----------
- Updated microG Service Core to 0.2.4-20
- Minimum API version bumped to 10

1.0.1-beta
----------
- Added support for x86
- Improved CPU detection
- Improved Android version checking
- Improved error reporting

1.0.0-alpha
-----------
- Initial release


.. _Unreleased: https://github.com/micro5k/microg-unofficial-installer/compare/v1.3.2-beta...HEAD
.. _1.3.2-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.3.1-beta...v1.3.2-beta
.. _1.3.1-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.3.0-beta...v1.3.1-beta
.. _1.3.0-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.2.0-beta...v1.3.0-beta
.. _1.2.0-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.1.0-beta...v1.2.0-beta
.. _1.1.0-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.0.34-beta...v1.1.0-beta
.. _1.0.34-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.0.33-beta...v1.0.34-beta
.. _1.0.33-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.0.32-beta...v1.0.33-beta
.. _1.0.32-beta: https://github.com/micro5k/microg-unofficial-installer/compare/v1.0.31-beta...v1.0.32-beta
.. _1.0.31-beta: https://github.com/micro5k/microg-unofficial-installer/compare/fd8c10cf26d51a2cbdfa48f9cc17d8f69a3af8e6...v1.0.31-beta
.. _1.0.30-alpha: https://github.com/micro5k/microg-unofficial-installer/compare/v1.0.29-beta...fd8c10cf26d51a2cbdfa48f9cc17d8f69a3af8e6
