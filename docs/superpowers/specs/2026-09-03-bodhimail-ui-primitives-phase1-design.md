# Bodhimail UI primitive parity — Phase 1 (foundation + shared primitives)

## Context

tmail-flutter's brand colors were already retheme'd to bodhimail's green
(`0xFF357916`) in a prior pass. This phase goes one level deeper: match
bodhimail's *component-level* primitives (button radius, elevation,
typography weight, button height) — not just color — starting with the
foundational theme layer and the highest-visibility shared widgets.

Scope is visual/UX only: the JMAP backend and data layer are untouched.

Reference: `../bodhimail/app/lib/core/theme/app_theme.dart` — bodhimail's
54-line theme (`ColorScheme.fromSeed(brandGreen)`, `useMaterial3: true`,
`ElevatedButtonThemeData` with `elevation: 0`, `borderRadius: 8`,
`textStyle: fontSize 16, fontWeight w600`, button height `48`).

## Out of scope (later phases)

Text fields, cards, mailbox list, composer, and other feature screens.
Only the theme foundation and the login screen's primary button are
touched in this phase.

## Design

1. **New token file** `core/lib/presentation/utils/app_theme.dart`:
   mirrors bodhimail's constants — `authButtonHeight = 48`,
   `primitiveBorderRadius = 8`, and a `materialTheme` `ThemeData` built
   the same way (`useMaterial3: true`, `ColorScheme.fromSeed(seedColor:
   AppColor.primaryColor)`, `ElevatedButtonThemeData` with
   `elevation: 0`, `borderRadius: 8`, `fontWeight: w600`).

2. **Wire it into `GetMaterialApp`** in `lib/main.dart` — currently no
   `theme:` is set at all, so this is additive and brings any stock
   Material widget (dialogs, snackbars, default buttons) into parity for
   free, with no risk of clobbering an existing theme.

3. **`TMailButtonWidget` default radius**: `core/lib/presentation/views/button/tmail_button_widget.dart`
   — change the default `borderRadius` from `20` to `8` on the base
   widget and both factories. Call sites that pass an explicit
   `borderRadius` are unaffected; only ones relying on the default pick
   up the new look.

4. **Login screen primary button**: `lib/features/login/presentation/base_login_view.dart`,
   `buildLoginButton()` — already very close to bodhimail's (height 48,
   `AppColor.primaryColor` background, white text size 16). Adjust:
   `borderRadius` `10` → `8`, add `elevation: 0`, add
   `fontWeight: FontWeight.w600` to the button text style.

## Testing

- `flutter run -d chrome`, screenshot the login screen before/after,
  compare visually against bodhimail's auth screen.
- Run existing widget tests touching `TMailButtonWidget` and the login
  view to confirm no golden/test breakage from the radius change.
