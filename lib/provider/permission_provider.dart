import 'package:get/get.dart';
import 'package:nowplaying/nowplaying.dart';
import 'package:p_lyric/widgets/permission_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider {
  static const String _alreadyRequestedKey = 'permission.alreadyRequested';

  PermissionProvider() {
    _initialize();
  }

  void _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyRequested = prefs.getBool(_alreadyRequestedKey) ?? false;
    final hasSystemOverlay = await hasSystemOverlayPermission();
    final hasNotificationAccess = await hasNotificationAccessPermission();

    if (!alreadyRequested && (!hasSystemOverlay || !hasNotificationAccess)) {
      await prefs.setBool(_alreadyRequestedKey, true);
      await Get.bottomSheet(
        const PermissionBottomSheet(),
        isDismissible: false,
      );
    }
  }

  Future<bool> haveAllPermissions() async {
    return (await hasSystemOverlayPermission()) &&
        (await hasNotificationAccessPermission());
  }

  Future<bool> hasSystemOverlayPermission() async {
    return Permission.systemAlertWindow.isGranted;
  }

  Future<bool> hasNotificationAccessPermission() async {
    return NowPlaying.instance.isEnabled();
  }

  Future<PermissionStatus> requestSystemOverlayPermission() async {
    return Permission.systemAlertWindow.request();
  }

  // nowPlaying 플러그인이 권한 요구 창을 성공적으로 띄웠을 때 바로 값을 반환하기 때문에 반환값이
  // `Future<void>`가 아닌 `void`이다.
  void requestNotificationAccessPermission() async {
    NowPlaying.instance.requestPermissions(force: true);
  }
}
