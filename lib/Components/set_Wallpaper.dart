import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';


class SetWallpaper {
  final BuildContext context;
  String _platformVersion = 'Unknown';
  String _wallpaperFile = 'Unknown';
  String _wallpaperFileWithCrop = 'Unknown';
  String _wallpaperAsset = 'Unknown';
  String _wallpaperAssetWithCrop = 'Unknown';
  SetWallpaper({@required this.context});


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await WallpaperManager.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    print('Platform'+platformVersion);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setHomeScreenWallpaper(String url) async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    print('result'+result);
    Toast.show('Wallpaper Set',context,gravity: 1);
  }

  Future<void> setLockScreenWallpaper(String url) async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.LOCK_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    print('result'+result);
    Toast.show('Wallpaper Set',context,gravity: 1);
  }

  Future<void> setBothScreenWallpaper(String url) async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.BOTH_SCREENS,);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    print('result'+result);
    Toast.show('Wallpaper Set',context,gravity: 1);
  }
}
