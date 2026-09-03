// package:web + dart:js_interop, not universal_html: dart2wasm cannot
// compile universal_html's web implementation (it is built on dart:html),
// so this conditional export is what makes the app buildable under
// --wasm. Type names (Event, MouseEvent, BeforeUnloadEvent, window,
// document, ...) are kept the same as dart:html's own, which is what lets
// every `html.` call site below stay unchanged on the web side; only
// html_io.dart (the non-web branch) still uses universal_html, for
// platforms package:web does not target.
export 'package:web/web.dart';
export 'package:core/utils/web/window_events.dart';
