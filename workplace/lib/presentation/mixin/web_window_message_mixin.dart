import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Mixin for [State] subclasses that need to listen to `window.onmessage`
/// events. Guards for a String or Map [web.MessageEvent.data] before
/// forwarding.
///
/// Only ever imported by drive_intent_web_view_modal_web.dart, which is
/// itself reached solely through a `dart.library.js_interop` conditional import
/// -- i.e. compiled for a web target only (dart2js or dart2wasm alike), so
/// this can use package:web directly rather than needing its own
/// io/web stub split.
mixin WebWindowMessageMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<web.MessageEvent>? _windowSubscription;

  void startWindowMessageListener(
    void Function(String data, String? origin) onMessage,
  ) {
    _windowSubscription = web.EventStreamProviders.messageEvent
        .forTarget(web.window)
        .listen((event) {
      dynamic data = event.data.dartify();
      if (data is Map) {
        data = jsonEncode(data);
      }
      if (data is! String) return;
      onMessage(data, event.origin);
    });
  }

  void stopWindowMessageListener() {
    _windowSubscription?.cancel();
    _windowSubscription = null;
  }
}
