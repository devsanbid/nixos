# Flutter + Android SDK
{ pkgs, config, ... }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "11.0";
    buildToolsVersions = [ "36.0.0" "34.0.0" "33.0.1" "28.0.3" ];
    platformVersions = [ "36" "34" "33" ];
    includeEmulator = true;
    emulatorVersion = "35.1.4";
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" ];
    includeNDK = true;
    ndkVersions = [ "26.1.10909125" ];
    includeSources = false;
    includeExtras = [ "extras;google;gcm" ];
  };
  androidSdk = androidComposition.androidsdk;
in
{
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    flutter
    androidSdk
    android-tools
    jdk17
    google-chrome
    scrcpy
    mesa
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };

  users.users.sanbid.extraGroups = [ "kvm" ];
}
