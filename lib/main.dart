import 'package:flutter/material.dart';

import 'melon_lyric_scraper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  String? lyrics;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  void _handleSearchButton() async {
    final result =
    await MelonLyricScraper.searchLyric(_textEditingController.text);
    setState(() {
      lyrics = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('가사 찾기 데모'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      onSubmitted: (_) => _handleSearchButton(),
                    ),
                  ),
                  TextButton(
                    onPressed: _textEditingController.text.isEmpty
                        ? null
                        : _handleSearchButton,
                    child: Text('검색'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(lyrics ?? "검색어를 입력하세요."),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
