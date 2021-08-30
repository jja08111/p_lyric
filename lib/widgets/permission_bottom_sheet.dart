import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_lyric/provider/permission_provider.dart';

import 'default_bottom_sheet.dart';
import 'default_snack_bar.dart';

class PermissionBottomSheet extends StatefulWidget {
  const PermissionBottomSheet({Key? key}) : super(key: key);

  @override
  _PermissionBottomSheetState createState() => _PermissionBottomSheetState();
}

class _PermissionBottomSheetState extends State<PermissionBottomSheet>
    with WidgetsBindingObserver {
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_inProgress) {
          if (await Get.find<PermissionProvider>().haveAllPermissions()) {
            Get.back();
            showSnackBar('권한 허용됨');
          }
          _inProgress = false;
        }
        break;
      default:
    }
  }

  void _onPressedSkip() async {
    Get.back();
    showSnackBar('설정에서 권한을 설정할 수 있습니다.');
  }

  void _onPressedOk() async {
    _inProgress = true;
    final permissionHandler = Get.find<PermissionProvider>();

    await permissionHandler.requestSystemOverlayPermission();
    permissionHandler.requestNotificationAccessPermission();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final colorScheme = Get.theme.colorScheme;
    final bodyStyle = textTheme.bodyText2!.copyWith(
      height: 1.6,
      color: context.isDarkMode ? Colors.white70 : const Color(0xb3000000),
    );
    final accentColor =
        context.isDarkMode ? colorScheme.primary : colorScheme.primaryVariant;

    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: DefaultBottomSheet(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PLyric 앱의 권한들을 허용해주세요.',
              style: textTheme.headline5!.copyWith(height: 1.4),
            ),
            const SizedBox(height: 8.0),
            Text(
              '•다른 앱 위에 표시: 가사 창을 다른 앱 위에 띄우기 위해 필요합니다.',
              style: bodyStyle,
            ),
            const SizedBox(height: 8.0),
            Text(
              '•알림 접근 허용: 현재 재생중인 음악 정보를 얻기 위해 필요합니다.',
              style: bodyStyle,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _onPressedSkip,
                  child: Text(
                    '건너뛰기',
                    style: textTheme.button!.copyWith(color: accentColor),
                  ),
                ),
                const SizedBox(width: 16.0),
                TextButton(
                  onPressed: _onPressedOk,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accentColor),
                  ),
                  child: Text(
                    '설정하기',
                    style: textTheme.button!.copyWith(
                      color: context.isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
