import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Wraps `package:web`'s `MessageEvent`, converting `.data` (`JSAny?`) back
/// to a plain Dart value via `dartify()` -- the old dart:html `MessageEvent`
/// this replaces returned `.data` as `dynamic`, already Dart-side, and
/// `html_content_viewer_on_web_widget.dart` calls `json.decode` on it
/// expecting a Dart String.
class MessageEvent {
  MessageEvent(this._event);

  final web.MessageEvent _event;

  dynamic get data => _event.data.dartify();
}

StreamSubscription<MessageEvent> listenWindowMessage(
  void Function(MessageEvent event) onMessage,
) {
  return web.window.onMessage
      .map((event) => MessageEvent(event))
      .listen(onMessage);
}
