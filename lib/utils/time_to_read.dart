import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

String timeToRead(String htmlText) {
  late int totalTime;
  // Define an assumed reading speed in words per minute (WPM)
  const wordsPerMinute = 200;

  // Split the text into words by whitespace
  final words = extractText(htmlText).split(RegExp(r'\s+'));

  // Calculate the number of words in the text
  final wordCount = words.length;

  /// Calculate the estimated reading time in minutes
  /// and round it to the nearest integer
  final readingTimeInMinutes = (wordCount / wordsPerMinute).ceil();

  // Ensure that the minimum reading time is 1 minute
  if (readingTimeInMinutes == 0) {
    totalTime = 1;
  } else {
    totalTime = readingTimeInMinutes;
  }

  return '$totalTime min read';
}

String extractText(String htmlString) {
  final document = parse(htmlString);
  final buffer = StringBuffer();

  void extract(Node node) {
    if (node is Text) {
      buffer.write(node.text);
    } else if (node is Element) {
      for (final child in node.nodes) {
        extract(child);
      }
    }
  }

  for (final node in document.nodes) {
    extract(node);
  }

  return buffer.toString();
}
