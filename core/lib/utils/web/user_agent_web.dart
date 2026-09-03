import 'package:web/web.dart' as web;

/// Raw (not lowercased) user agent string -- callers that want a
/// case-insensitive comparison lowercase it themselves; html_utils.dart's
/// `isSafariBelow17` needs the original case ('Safari', 'Chrome',
/// 'Version/').
String get userAgent => web.window.navigator.userAgent;
