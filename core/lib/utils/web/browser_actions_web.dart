import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:core/utils/web/window_events.dart';
import 'package:web/web.dart' as web;

void openBlobInNewTab(String content, String mimeType) {
  final blob = web.Blob(
    [content.toJS].toJS,
    web.BlobPropertyBag(type: mimeType),
  );
  final url = web.URL.createObjectURL(blob);
  web.window.open(url, '_blank');
  web.URL.revokeObjectURL(url);
}

void openFileBlobInNewTab(Uint8List bytes, String fileName, String? mimeType) {
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: mimeType ?? ''),
  );
  final file = web.File(
    [blob].toJS,
    fileName,
    web.FilePropertyBag(type: mimeType ?? ''),
  );
  final url = web.URL.createObjectURL(file);
  web.window.open(url, '_blank');
  web.URL.revokeObjectURL(url);
}

void windowOpen(String url, String target, [String? features]) {
  if (features != null) {
    web.window.open(url, target, features);
  } else {
    web.window.open(url, target);
  }
}

int? get screenWidth => web.window.screen.width;

int? get screenHeight => web.window.screen.height;

void setWindowBrowserTitle(String title) {
  web.document.title = title;
}

void downloadBytesAsFile(Uint8List bytes, String filename, String? mimeType) {
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: mimeType ?? ''),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..style.display = 'none'
    ..download = filename;
  web.document.body?.append(anchor);

  anchor.click();

  anchor.remove();
  web.URL.revokeObjectURL(url);
}

int get windowInnerWidth => web.window.innerWidth;

int get windowInnerHeight => web.window.innerHeight;

StreamSubscription<void> listenWindowResize(void Function() onResize) {
  return web.window.onResize.listen((_) => onResize());
}

void historyReplaceState(String title, String url) {
  web.window.history.replaceState(null, title, url);
}

String? get locationHostname => web.window.location.hostname;

/// [dragEvent] is `web.DragEvent`. `DataTransfer.types` is `JSArray<JSString>`
/// in package:web, unlike universal_html's `List<String>` -- converted here
/// so callers get a plain Dart `List<String>` on both conditional branches.
List<String> dragEventFileTypes(dynamic dragEvent) {
  final event = dragEvent as web.DragEvent;
  final types = event.dataTransfer?.types;
  if (types == null) return const [];
  return types.toDart.map((jsString) => jsString.toDart).toList();
}
