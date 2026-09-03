import 'dart:async';

import 'package:core/utils/web/window_events.dart';
import 'package:web/web.dart' as web;

class ContextMenuEvent {
  ContextMenuEvent(this._event);

  final web.MouseEvent _event;

  double get pageX => _event.pageX;
  double get pageY => _event.pageY;
  void preventDefault() => _event.preventDefault();
}

StreamSubscription<ContextMenuEvent> listenDocumentContextMenu(
  void Function(ContextMenuEvent event) onContextMenu,
) {
  return web.document.onContextMenu
      .map((event) => ContextMenuEvent(event))
      .listen(onContextMenu);
}
