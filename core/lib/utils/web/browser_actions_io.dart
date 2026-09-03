import 'dart:async';
import 'dart:typed_data';

/// Non-web platforms never call any of these (every call site is already
/// behind `PlatformInfo.isWeb`), so they just satisfy the conditional-export
/// contract without pulling in a web-only package.

void openBlobInNewTab(String content, String mimeType) {}

void openFileBlobInNewTab(Uint8List bytes, String fileName, String? mimeType) {}

void windowOpen(String url, String target, [String? features]) {}

int? get screenWidth => null;

int? get screenHeight => null;

void setWindowBrowserTitle(String title) {}

void downloadBytesAsFile(Uint8List bytes, String filename, String? mimeType) {}

int get windowInnerWidth => 0;

int get windowInnerHeight => 0;

StreamSubscription<void> listenWindowResize(void Function() onResize) {
  return const Stream<void>.empty().listen((_) => onResize());
}

void historyReplaceState(String title, String url) {}

String? get locationHostname => null;

/// [dragEvent] is `html.DragEvent` (universal_html's own, with `.dataTransfer`
/// typed as `DataTransfer?` whose `.types` is already `List<String>?`) on
/// this branch -- `dynamic` here is only for the web branch's differently
/// shaped `DataTransfer.types` (`JSArray<JSString>`), see
/// browser_actions_web.dart.
List<String> dragEventFileTypes(dynamic dragEvent) {
  final types = dragEvent?.dataTransfer?.types;
  if (types == null) return const [];
  return List<String>.from(types as List);
}
