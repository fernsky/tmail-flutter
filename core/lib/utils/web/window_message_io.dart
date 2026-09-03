import 'dart:async';

/// Stand-in for `package:web`'s `MessageEvent` on non-web platforms, where
/// this widget is never actually instantiated (every caller already gates
/// on `PlatformInfo.isWeb`) but the file is still compiled, so the type
/// needs to exist.
class MessageEvent {
  dynamic get data => null;
}

StreamSubscription<MessageEvent> listenWindowMessage(
  void Function(MessageEvent event) onMessage,
) {
  return const Stream<MessageEvent>.empty().listen(onMessage);
}
