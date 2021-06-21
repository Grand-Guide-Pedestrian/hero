class Config {
  static const String webSocketServerURLKey = 'webSocketServerURL';
  static const String gameIDKey = 'gameID';

  final String webSocketServerURL;
  final String gameID;

  const Config(this.webSocketServerURL, this.gameID);
}
