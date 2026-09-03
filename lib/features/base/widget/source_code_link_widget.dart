import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/utils/theme_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:tmail_ui_user/main/utils/app_config.dart';
import 'package:tmail_ui_user/main/utils/app_utils.dart';

/// AGPL-3.0 section 13: anyone who interacts with a modified version of this
/// program over a network must be offered its Corresponding Source, and
/// publishing the fork is not by itself that offer -- it has to be reachable
/// from the running app. This is that offer.
///
/// It sat on the sign-in screen precisely because that is the one surface
/// every user passes through; it now lives in Settings instead, which is a
/// weaker position for section 13 (someone who never signs in never reaches
/// it). Recorded here so the tradeoff is visible to whoever revisits this.
///
/// Not a localized string: adding a key would mean regenerating
/// app_localizations.dart across all 17 catalogues, and "Source code" is the
/// same in the languages this ships in. Worth revisiting if that stops
/// holding.
class SourceCodeLinkWidget extends StatelessWidget {
  const SourceCodeLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Source code',
        style: ThemeUtils.defaultTextStyleInterFont.copyWith(
          color: AppColor.colorTextBody,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => AppUtils.launchLink(AppConfig.sourceCodeUrl),
      ),
    );
  }
}
