
export 'background_isolate_binary_messenger_web.dart'
  if (dart.library.js_interop) 'background_isolate_binary_messenger_web.dart' // Browser
  if (dart.library.io) 'background_isolate_binary_messenger_mobile.dart'; // VM