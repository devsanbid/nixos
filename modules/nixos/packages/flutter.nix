# Flutter + Android SDK
{ pkgs, config, ... }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "11.0";
    buildToolsVersions = [ "36.1.0" "36.0.0" "35.0.0" "34.0.0" "33.0.1" "28.0.3" ];
    platformVersions = [ "36" "35" "34" "33" ];
    includeEmulator = true;
    emulatorVersion = "35.1.4";
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" ];
    includeNDK = true;
    ndkVersions = [ "28.2.13676358" "29.0.14206865" ];
    includeCmake = true;
    cmakeVersions = [ "3.22.1" ];
    includeSources = false;
    includeExtras = [ "extras;google;gcm" ];
    extraLicenses = [
      "android-googletv-license"
      "android-googlexr-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "mips-android-sysimage-license"
    ];
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
    mesa-demos
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };

  # kvm group assignment consolidated in users/default.nix
}
