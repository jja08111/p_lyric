import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final Text title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Get.theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              const Color(0xFF8C6988),
              const Color(0xFF5A5172),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 0.66, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DefaultTextStyle(
                  style: Get.theme.primaryTextTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xCCFFFFFF),
                  ),
                  child: title,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
