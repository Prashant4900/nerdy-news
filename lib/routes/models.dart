part of 'routes.dart';

class NewsDetailArguments {
  NewsDetailArguments({required this.newsModel});

  final NewsModel newsModel;
}

class ShareNewsArguments {
  ShareNewsArguments({required this.newsModel});

  final NewsModel newsModel;
}

class PublisherArguments {
  PublisherArguments({required this.model});

  final PublisherModel model;
}

class ErrorMessageArguments {
  ErrorMessageArguments({required this.details});

  final String details;
}
