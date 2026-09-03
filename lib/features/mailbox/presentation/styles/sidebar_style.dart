import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

/// The sidebar's proportions.
///
/// The design system's own default is built for a dense rail: 36px rows,
/// 8px of horizontal padding, 16px glyphs and a 14px label -- cramped next
/// to bodhimail's stock `ListTile` rows (16px padding, 24px glyphs, 15/w500
/// label). A first pass matched bodhimail's numbers directly, which turned
/// out to overshoot the other way once it was actually on screen: 24px
/// glyphs and a 15px label read as oversized for a folder list this dense
/// (Inbox/Sent/Drafts/Trash sitting right above a nested tree of custom
/// folders). These values split the difference -- roomier than the design
/// system default, well short of bodhimail's own numbers, sized for a list
/// of many short rows rather than a five-item nav.
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
    itemMinHeight: 40,
    itemBorderRadius: base.itemBorderRadius,
    itemIconSize: 18,
    itemHorizontalPadding: 12,
    chevronSize: base.chevronSize,
    itemSpacing: 10,
    hoverBackground: base.hoverBackground,
    selectedBackground: base.selectedBackground,
    badgeBackground: base.badgeBackground,
    badgeHeight: base.badgeHeight,
    badgeHorizontalPadding: base.badgeHorizontalPadding,
    badgeForeground: base.badgeForeground,
    foreground: base.foreground,
    activeForeground: base.activeForeground,
    trailingForeground: base.trailingForeground,
    // The line height is respecified because the default carries a ratio
    // computed against a 14px size, and a ratio is not size-independent --
    // left alone it would drift as the size changed.
    labelTextStyle: base.labelTextStyle.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
      height: 18 / 13,
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
