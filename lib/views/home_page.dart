import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowplaying/nowplaying.dart';
import 'package:p_lyric/provider/playing_music_provider.dart';
import 'package:p_lyric/views/setting_page.dart';
import 'package:p_lyric/widgets/default_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _scrollTolerance = 4.0;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isReachedEnd = ValueNotifier(false);
  final ValueNotifier<bool> _showButton = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_updateScrollButton);

    // TODO(민성): 설정 화면 혹은 다이어로그 띄워서 사용자에게 권한에 대해 설명하기
    NowPlaying.instance.isEnabled().then((bool isEnabled) async {
      if (!isEnabled) {
        final granted = await NowPlaying.instance.requestPermissions();

        Get.showSnackbar(GetBar(
          message: granted ? '권한이 허용됨' : '권한이 허용되지 않음',
          duration: const Duration(seconds: 3),
        ));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButton() {
    if (!_scrollController.hasClients) {
      _isReachedEnd.value = false;
      _showButton.value = false;
      return;
    }

    _isReachedEnd.value = (_scrollController.offset + _scrollTolerance >=
            _scrollController.position.maxScrollExtent)
        ? true
        : false;
    _showButton.value =
        _scrollController.position.maxScrollExtent == 0.0 ? false : true;
  }

  void _handleScrollButtonTap({bool toBottom = true}) {
    _scrollController.animateTo(
      toBottom ? _scrollController.position.maxScrollExtent : 0.0,
      duration: kThemeChangeDuration,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return DefaultContainer(
      title: const Text('PLyric'),
      actions: [
        PopupMenuButton<Widget>(
          onSelected: (widget) {
            Get.to(widget);
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: const SettingPage(),
              child: const Text('설정'),
            ),
          ],
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const _CardView(),
          ),
          const SizedBox(height: 22),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 16.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: DefaultTextStyle(
                    style: textTheme.bodyText1!.copyWith(
                      color: Color(0xE6FFFFFF),
                      height: 1.8,
                    ),
                    child: GetBuilder<PlayingMusicProvider>(
                      init: PlayingMusicProvider(),
                      builder: (musicProvider) {
                        if (musicProvider.track != null) {
                          final title = musicProvider.track!.title;

                          if (title == null) return Text("검색 결과가 없습니다.");

                          if (musicProvider.lyric.isNotEmpty) {
                            _scrollController.jumpTo(0.0);
                            return Text(musicProvider.lyric);
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                        return Text("검색어를 입력하세요.");
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _showButton,
        child: ValueListenableBuilder<bool>(
          valueListenable: _isReachedEnd,
          builder: (_, isReachedEnd, button) {
            return FloatingActionButton(
              mini: true,
              onPressed: () => _handleScrollButtonTap(toBottom: !isReachedEnd),
              child: AnimatedSwitcher(
                duration: kThemeChangeDuration,
                child: Icon(
                  isReachedEnd ? Icons.arrow_upward : Icons.arrow_downward,
                  key: ValueKey(isReachedEnd),
                  color: Colors.black87,
                ),
              ),
            );
          },
        ),
        builder: (_, showButton, child) =>
            showButton ? child! : const SizedBox(),
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return Card(
      child: GetBuilder<PlayingMusicProvider>(
        init: PlayingMusicProvider(),
        builder: (musicProvider) {
          final track = musicProvider.track;
          final icon = track?.image;
          final title = track?.title ?? '재생중인 음악 없음';
          final artist = track?.artist ?? '노래를 재생하면 가사가 업데이트됩니다.';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.0),
                    child: icon == null
                        ? const SizedBox(height: 88, width: 88)
                        : Image(image: icon, height: 88, width: 88),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        title,
                        style: textTheme.subtitle1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        artist,
                        style: textTheme.subtitle2!.copyWith(
                          color:
                              Get.isDarkMode ? Colors.white54 : Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconTheme(
                        data: IconThemeData(
                          color: Get.isDarkMode ? Colors.white : Colors.black87,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 32,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.skip_previous),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 40,
                              padding: EdgeInsets.zero,
                              // TODO: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: progress)
                              icon: Icon(Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 32,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.skip_next),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
