import 'package:flutter/material.dart';
import 'package:p_lyric/servies/melon_lyric_scraper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Text('Headline', style: Theme.of(context).textTheme.headline1,),
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
