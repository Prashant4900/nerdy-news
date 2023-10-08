import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/utils/utils.dart';
import 'package:news/news.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String url) async {
  final url0 = Uri.parse(url);

  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

Future<dynamic> newsButtonSheet(BuildContext context, NewsModel news) {
  return showModalBottomSheet<dynamic>(
    context: context,
    builder: (context) {
      return ListView(
        shrinkWrap: true,
        children: [
          verticalMargin16,
          ListTile(
            leading: const Icon(AkarIcons.image),
            title: const Text('Share with Image'),
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.shareImageScreen,
                arguments: ShareNewsArguments(newsModel: news),
              );
            },
          ),
          ListTile(
            leading: const Icon(AkarIcons.link_chain),
            title: const Text('Copy Link'),
            onTap: () async {
              await copyToClipboard(
                context,
                text: news.source!,
              ).whenComplete(() => Navigator.pop(context));
            },
          ),
          ListTile(
            leading: const Icon(AkarIcons.share_box),
            title: const Text('Open in Browser'),
            onTap: () async {
              await _launchUrl(news.source!)
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
          ListTile(
            leading: const Icon(AkarIcons.chat_edit),
            title: const Text('Leave Feedback'),
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.feedbackScreen)
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
        ],
      );
    },
  );
}
