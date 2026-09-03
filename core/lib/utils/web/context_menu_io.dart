import 'dart:async';

/// Stand-in for a browser `contextmenu` MouseEvent on non-web platforms,
/// where this listener is never actually installed (guarded by
/// `PlatformInfo.isWeb`) but the file is still compiled, so the type needs
/// to exist.
class ContextMenuEvent {
  double get pageX => 0;
  double get pageY => 0;
  void preventDefault() {}
}

StreamSubscription<ContextMenuEvent> listenDocumentContextMenu(
  void Function(ContextMenuEvent event) onContextMenu,
) {
  return const Stream<ContextMenuEvent>.empty().listen(onContextMenu);
}
