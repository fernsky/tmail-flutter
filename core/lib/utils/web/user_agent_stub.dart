// dart.library.js_interop, not dart.library.html: dart.library.html
// resolves FALSE under dart2wasm (dart:html genuinely does not exist there),
// so a conditional keyed on it silently picks the "io" branch even for a
// `flutter build web --wasm` build -- the opposite of what every such
// conditional in this codebase intends. dart.library.js_interop is true for
// a web target under both dart2js and dart2wasm, since dart:js_interop
// compiles under both; that is what user_agent_web.dart uses.
export 'user_agent_io.dart' if (dart.library.js_interop) 'user_agent_web.dart';
