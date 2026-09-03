import 'package:web/web.dart';

/// `dart:html`-style `.onX` stream getters for [Window], backed by
/// `package:web`'s [EventStreamProviders].
///
/// `package:web` deliberately dropped these convenience getters in favour of
/// the explicit `EventStreamProviders.xEvent.forTarget(target)` form; this
/// restores just the handful this app actually listens for, so call sites
/// that used to read `window.onDragEnter.listen(...)` under `dart:html`
/// keep reading the same way under wasm.
extension WindowDomEvents on Window {
  Stream<BeforeUnloadEvent> get onBeforeUnload =>
      EventStreamProviders.beforeUnloadEvent.forTarget(this);

  Stream<Event> get onUnload => EventStreamProviders.unloadEvent.forTarget(this);

  Stream<Event> get onBlur => EventStreamProviders.blurEvent.forTarget(this);

  // package:web's own EventStreamProviders type these as MouseEvent -- the
  // dispatched object is actually a DragEvent (which implements MouseEvent),
  // so callers that need .dataTransfer get that type here instead.
  Stream<DragEvent> get onDragEnter =>
      EventStreamProviders.dragEnterEvent.forTarget(this).cast<DragEvent>();

  Stream<DragEvent> get onDragOver =>
      EventStreamProviders.dragOverEvent.forTarget(this).cast<DragEvent>();

  Stream<DragEvent> get onDragLeave =>
      EventStreamProviders.dragLeaveEvent.forTarget(this).cast<DragEvent>();

  Stream<DragEvent> get onDrop =>
      EventStreamProviders.dropEvent.forTarget(this).cast<DragEvent>();

  Stream<MessageEvent> get onMessage =>
      EventStreamProviders.messageEvent.forTarget(this);

  Stream<Event> get onResize => EventStreamProviders.resizeEvent.forTarget(this);
}

/// `dart:html`-style `.onX` stream getters for [Document], backed by
/// `package:web`'s [EventStreamProviders] -- see [WindowDomEvents].
extension DocumentDomEvents on Document {
  Stream<MouseEvent> get onContextMenu =>
      EventStreamProviders.contextMenuEvent.forTarget(this);
}
