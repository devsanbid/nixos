# Flutter & Android Development Environment
{ pkgs, config, ... }: 

let
  # Android SDK configuration
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    # Command line tools version
    cmdLineToolsVersion = "11.0";
    
    # Build tools versions - include 28.0.3 required by Flutter
    buildToolsVersions = [ "36.0.0" "34.0.0" "33.0.1" "28.0.3" ];
    
    # Platform versions (API levels) - include 36 required by Flutter
    platformVersions = [ "36" "34" "33" ];
    
    # Additional packages
    includeEmulator = true;
    emulatorVersion = "35.1.4";
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" ];
    
    # NDK for native development
    includeNDK = true;
    ndkVersions = [ "26.1.10909125" ];
    
    # Additional tools
    includeSources = false;
    includeExtras = [
      "extras;google;gcm"
    ];
  };

  androidSdk = androidComposition.androidsdk;
in
{
  # Accept Android SDK licenses
  nixpkgs.config.android_sdk.accept_license = true;
  
  # Flutter and Android packages
  environment.systemPackages = with pkgs; [
    # Flutter SDK
    flutter
    
    # Android SDK
    androidSdk
    android-tools  # adb, fastboot
    
    # Java (required for Android)
    jdk17
    
    # Chrome for web development
    google-chrome
    
    # Additional useful tools
    scrcpy  # Screen mirroring for Android devices
    
    # For Linux desktop development
    mesa
  ];

  # Environment variables for Flutter/Android
  environment.sessionVariables = {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };

  # Add user to required groups for Android development
  users.users.sanbid.extraGroups = [ "kvm" ];
}
