extension StringTitleCaseExtension on String {
  String get title {
    if (isEmpty) {
      return this; // Return the original string if it's empty
    }

    // Split the string into words by whitespace
    final words = split(RegExp(r'\s+'));

    // Capitalize the first letter of each word and join them back together
    final titleCaseString = words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');

    return titleCaseString;
  }

  int get getWordCount {
    final words = split(' ');
    return words.length;
  }

  String get getFirstFewWords {
    final words = split(' ');
    if (words.length > 50) {
      return '${words.sublist(0, 50).join(' ')} .....';
    } else {
      return this;
    }
  }

  String get descriptionText {
    if (length < 300) {
      final len = length;
      final subString = substring(0, len - 5);
      return subString;
    }

    final subString = substring(0, 300);

    return '$subString...';
  }
}
