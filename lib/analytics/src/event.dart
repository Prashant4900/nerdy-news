enum LogEvent {
  logIn,
  logOut,
  screenView,
  share,
  appOpen;
}

enum ShareType {
  image('image'),
  link('link'),
  instagram('instagram'),
  download('download'),
  share('share'),
  sms('sms'),
  twitter('twitter');

  const ShareType(this.label);

  final String label;
}
