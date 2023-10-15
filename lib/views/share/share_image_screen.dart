import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:analytics/analytics.dart';
import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/views/share/news_cards.dart';
import 'package:mobile/widgets/buttons.dart';
import 'package:news/news.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class MyShareImageScreen extends StatefulWidget {
  const MyShareImageScreen({required this.news, super.key});

  final NewsModel news;

  @override
  State<MyShareImageScreen> createState() => _MyShareImageScreenState();
}

class _MyShareImageScreenState extends State<MyShareImageScreen> {
  final _pageController = PageController();

  final firstGlobalKey = GlobalKey();
  final secondGlobalKey = GlobalKey();
  final thirdGlobalKey = GlobalKey();
  final fourthGlobalKey = GlobalKey();

  AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  int _currentPage = 0;

  bool _isInstagramInstall = false;
  bool _isTwitterInstall = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _checkIfInstall();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIfInstall();
  }

  Future<void> _checkIfInstall() async {
    final installApps = await appinioSocialShare.getInstalledApps();

    _isInstagramInstall = installApps['instagram_stories'] as bool;
    _isTwitterInstall = installApps['twitter'] as bool;
    setState(() {});
  }

  Future<File> _generateImageFile(String downloadLocation) async {
    try {
      RenderRepaintBoundary boundary;

      if (_currentPage == 0) {
        boundary = firstGlobalKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
      } else if (_currentPage == 1) {
        boundary = secondGlobalKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
      } else if (_currentPage == 2) {
        boundary = thirdGlobalKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
      } else {
        boundary = fourthGlobalKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
      }

      final image = await boundary.toImage(pixelRatio: 5);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final file = File('$downloadLocation/Nerdy News - ${DateTime.now()}.png');
      await file.writeAsBytes(pngBytes);

      return file;
    } catch (e) {
      throw Exception(e);
    }
  }

  // --------------------------------------------------------

  final MethodChannel platform = const MethodChannel(
    'your_unique_channel_name',
  ); // Change this channel name

  Future<void> shareBySMS(String text, String filePath) async {
    try {
      await platform.invokeMethod(
        'shareBySMS',
        {'message': text, 'filePath': filePath},
      );
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
    }
  }

  // --------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 4,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemBuilder: (context, index) => Center(
              child: [
                RepaintBoundary(
                  key: firstGlobalKey,
                  child: FirstNewsCard(news: widget.news),
                ),
                RepaintBoundary(
                  key: secondGlobalKey,
                  child: SecondNewsCard(news: widget.news),
                ),
                RepaintBoundary(
                  key: thirdGlobalKey,
                  child: ThirdNewsCard(news: widget.news),
                ),
                RepaintBoundary(
                  key: fourthGlobalKey,
                  child: FourthNewsCard(news: widget.news),
                ),
              ].elementAt(index),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _currentPage == index
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_isTwitterInstall)
              ShareButtonWidget(
                icon: Assets.svg.xTwitter.svg(
                  height: 26,
                  color: Colors.black.withOpacity(.6),
                ),
                message: 'Tweet',
                onTap: () async {
                  final downloadLocation = await getDownloadsDirectory();
                  final file = await _generateImageFile(downloadLocation!.path);
                  final response = await appinioSocialShare.shareToTwitter(
                    'Check this one.',
                    filePath: file.path,
                  );
                  if (response != 'SUCCESS') {
                    scaffoldMessengerState.showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong.'),
                      ),
                    );
                  } else {
                    await appAnalytics.log(
                      LogEvent.share,
                      shareType: ShareType.twitter,
                      newsID: widget.news.id,
                      newsTitle: widget.news.title,
                    );
                  }
                },
              )
            else
              ShareButtonWidget(
                iconData: AkarIcons.envelope,
                message: 'SMS',
                onTap: () async {
                  final downloadLocation = await getDownloadsDirectory();
                  final file = await _generateImageFile(downloadLocation!.path);
                  log('content:/${file.path}');
                  await Clipboard.setData(
                    ClipboardData(text: 'content:/${file.path}'),
                  );
                  // final response = await appinioSocialShare.shareToSMS(
                  //   // 'Nerdy News',
                  //   'Check this one.',
                  //   filePath: file.path,
                  // );
                  // if (response != 'SUCCESS') {
                  //   scaffoldMessengerState.showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Something went wrong.'),
                  //     ),
                  //   );
                  // } else {
                  //   await appAnalytics.log(
                  //     LogEvent.share,
                  //     shareType: ShareType.sms,
                  //     newsID: widget.news.id,
                  //     newsTitle: widget.news.title,
                  //   );
                  // }
                },
              ),
            if (_isInstagramInstall)
              ShareButtonWidget(
                iconData: AkarIcons.instagram_fill,
                message: 'Story',
                onTap: () async {
                  final downloadLocation = await getDownloadsDirectory();
                  final file = await _generateImageFile(downloadLocation!.path);

                  final response =
                      await appinioSocialShare.shareToInstagramStory(
                    '594456182698345',
                    stickerImage: file.path,
                  );
                  setState(() {});
                  if (response != 'SUCCESS') {
                    scaffoldMessengerState.showSnackBar(
                      const SnackBar(
                        padding: allPadding16,
                        content: Text('Something went wrong.'),
                      ),
                    );
                  } else {
                    await appAnalytics.log(
                      LogEvent.share,
                      shareType: ShareType.instagram,
                      newsID: widget.news.id,
                      newsTitle: widget.news.title,
                    );
                  }
                },
              )
            else
              nilWidget,
            ShareButtonWidget(
              iconData: AkarIcons.image,
              message: 'Save',
              onTap: () async {
                try {
                  final state = await Permission.manageExternalStorage.status;
                  final state2 = await Permission.storage.status;

                  if ((state2.isGranted) || (state.isGranted)) {
                    log('permission given');
                    final downloadDirectory = await getDownloadsDirectory();
                    final downloadPath1 = downloadDirectory!.path;
                    final dir = Directory(
                      '$downloadPath1/Starland/Images Downloader/',
                    );
                    log('dir: $dir');

                    final directory = Directory('/storage/emulated/0/Download');
                    // final directory = await getExternalStorageDirectory();
                    log(directory.path);
                    final file = await _generateImageFile(directory.path);
                    final regex = RegExp(r'(/[^/]+/\d/)(.*)');
                    final match = regex.firstMatch(file.path);
                    final downloadPath = 'Phone/${match!.group(2)}';

                    scaffoldMessengerState.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Image save Successfully at: $downloadPath',
                        ),
                      ),
                    );

                    await appAnalytics.log(
                      LogEvent.share,
                      shareType: ShareType.download,
                      newsID: widget.news.id,
                      newsTitle: widget.news.title,
                    );
                  } else {
                    await Permission.storage.request();
                    await Permission.manageExternalStorage.request();
                  }
                } catch (e) {
                  log(e.toString());
                  scaffoldMessengerState.showSnackBar(
                    SnackBar(
                      content: Text('Something went wrong: $e'),
                    ),
                  );
                }
              },
            ),
            ShareButtonWidget(
              iconData: AkarIcons.network,
              message: 'Share',
              onTap: () async {
                try {
                  final downloadLocation = await getTemporaryDirectory();
                  final file = await _generateImageFile(downloadLocation.path);

                  await file.create();
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    text: 'Hey check this out.',
                  );
                  await appAnalytics.log(
                    LogEvent.share,
                    shareType: ShareType.image,
                    newsID: widget.news.id,
                    newsTitle: widget.news.title,
                  );
                } catch (e) {
                  log(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
