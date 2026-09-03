import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

/// The sidebar's proportions, set to read like bodhimail's navigation rather
/// than the design system's default.
///
/// That default is built for a dense rail: 36px rows, 8px of horizontal
/// padding, 16px glyphs and a 14px label. Next to bodhimail's nav -- stock
/// `ListTile` rows, so 16px padding and 24px glyphs, with a 15/w500 label --
/// it reads as small type crowded into short rows, which is the complaint
/// this answers.
///
/// Rows land at 48 rather than `ListTile`'s 56. A folder tree is not a
/// five-item nav: 56 across a long, nested mailbox list pushes folders below
/// the fold, and vertical space bought at that price stops being generous
/// and starts being scrolling. 48 is the Material tap target, a third more
/// room than before, and still fits the tree.
///
/// Built with the full constructor rather than `copyWith`, whose override
/// classes deliberately expose only metrics and colours -- the label's type
/// scale is not reachable through them.
LinagoraSidebarStyle buildSidebarStyle(Brightness brightness) {
  final base = brightness == Brightness.dark
      ? LinagoraSidebarStyle.dark()
      : LinagoraSidebarStyle.light();

  return LinagoraSidebarStyle(
    brightness: base.brightness,
    itemMinHeight: 48,
    itemBorderRadius: base.itemBorderRadius,
    itemIconSize: 24,
    itemHorizontalPadding: 16,
    chevronSize: base.chevronSize,
    itemSpacing: 12,
    hoverBackground: base.hoverBackground,
    selectedBackground: base.selectedBackground,
    badgeBackground: base.badgeBackground,
    badgeHeight: base.badgeHeight,
    badgeHorizontalPadding: base.badgeHorizontalPadding,
    badgeForeground: base.badgeForeground,
    foreground: base.foreground,
    activeForeground: base.activeForeground,
    trailingForeground: base.trailingForeground,
    // bodhimail's nav label. The line height is respecified because the
    // default carries a ratio computed against a 14px size, and a ratio is
    // not size-independent -- left alone it would shrink the leading as the
    // size grew, which is the opposite of what is wanted here.
    labelTextStyle: base.labelTextStyle.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      height: 20 / 15,
    ),
    badgeTextStyle: base.badgeTextStyle,
    actionActiveBackground: base.actionActiveBackground,
    actionIconPadding: base.actionIconPadding,
    sectionHeaderMinHeight: base.sectionHeaderMinHeight,
    sectionHeaderForeground: base.sectionHeaderForeground,
    progressHeight: base.progressHeight,
    storageForeground: base.storageForeground,
    storageIconForeground: base.storageIconForeground,
    storageVersionForeground: base.storageVersionForeground,
    progressColor: base.progressColor,
    progressWarningColor: base.progressWarningColor,
    progressFullColor: base.progressFullColor,
    progressTrackColor: base.progressTrackColor,
    upsellBorderColor: base.upsellBorderColor,
    upsellForeground: base.upsellForeground,
    popoverBackground: base.popoverBackground,
    popoverShadowColor: base.popoverShadowColor,
    destructiveBackground: base.destructiveBackground,
    confirmForeground: base.confirmForeground,
    disabledOpacity: base.disabledOpacity,
  );
}
