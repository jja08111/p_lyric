import 'package:flutter/material.dart';
import 'package:p_lyric/widgets/default_container.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      title: Text('설정'),
      body: Text(''), // TODO(민성): 구현
    );
  }
}
