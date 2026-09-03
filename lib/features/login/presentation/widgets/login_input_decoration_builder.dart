
import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Auth-screen input decoration, matching bodhimail's: stock Material 3.
///
/// bodhimail's auth fields are a plain `InputDecoration(labelText: ...)` and
/// nothing else -- the seeded M3 theme supplies the fill, the border and the
/// floating label, so a focused field picks up the brand green on its own.
/// What used to be here instead was a pale `#F2F4F2` fill inside an equally
/// pale outline, with `floatingLabelBehavior: never` pinning the label down
/// as a low-contrast placeholder. That combination is what read as washed
/// out: three near-white greys stacked on each other with nothing to
/// anchor them.
///
/// Overrides still apply when a caller sets them ([enabledBorder],
/// [labelStyle], ...), so callers that genuinely need a different field are
/// unaffected; they simply are not the default any more.
class LoginInputDecorationBuilder extends InputDecorationBuilder {

  @override
  InputDecoration build() {
    return InputDecoration(
      enabledBorder: enabledBorder,
      focusedBorder: focusBorder,
      prefixText: prefixText,
      labelText: labelText,
      labelStyle: labelStyle,
      hintText: hintText,
      hintStyle: hintStyle,
      contentPadding: contentPadding,
      suffixIcon: suffixIcon,
    );
  }
}
