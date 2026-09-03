import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class HtmlIframeWidget extends StatelessWidget {
  const HtmlIframeWidget({
    super.key,
    this.onIframeCreated,
    this.width,
    this.height,
    this.borderRadius,
    this.src,
    this.srcdoc,
  });

  final void Function(web.HTMLIFrameElement iframe)? onIframeCreated;
  final String? width, height, src, srcdoc;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      key: key,
      tagName: 'iframe',
      onElementCreated: (element) {
        final iframe = element as web.HTMLIFrameElement;
        onIframeCreated?.call(iframe);
        // width/height are legacy presentational attributes, not typed
        // properties on HTMLIFrameElement (package:web only exposes what
        // the modern IDL defines), hence setAttribute rather than a
        // property setter.
        if (width != null) iframe.setAttribute('width', width!);
        if (height != null) iframe.setAttribute('height', height!);
        iframe.style
          ..border = 'none'
          ..overflow = 'hidden'
          ..width = '100%'
          ..height = '100%';

        if (borderRadius != null) {
          iframe.style.borderRadius = '${borderRadius}px';
        }

        if (src != null) {
          iframe.src = src!;
        } else if (srcdoc != null) {
          iframe.srcdoc = srcdoc!.toJS;
        }
      },
    );
  }
}
