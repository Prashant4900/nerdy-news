extension StringTitleCaseExtension on String {
  String get getFirstFewWords {
    final words = split(' ');
    if (words.length > 50) {
      return '${words.sublist(0, 50).join(' ')} .....';
    } else {
      return this;
    }
  }
}
