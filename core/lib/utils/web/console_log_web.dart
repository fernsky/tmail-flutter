import 'dart:js_interop';

import 'package:web/web.dart' as web;

void printToWebConsole(String level, String value) {
  switch (level) {
    case 'error':
      web.console.error(value.toJS);
    case 'warn':
      web.console.warn(value.toJS);
    case 'info':
      web.console.info(value.toJS);
    default:
      web.console.debug(value.toJS);
  }
}
