import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Whether the CanvasKit renderer is being used on web.
///
/// Always returns `false` on non-web.
///
/// `globalContext` (dart:js_interop) plus `.has` (dart:js_interop_unsafe)
/// replace universal_html's `js.context`/dart:js `context` -- the old
/// dart:js global-object accessor does not exist under dart2wasm.
bool get isRendererCanvasKit => globalContext.has('flutterCanvasKit');
