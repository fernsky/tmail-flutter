import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/utils/theme_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';
import 'package:tmail_ui_user/main/utils/app_config.dart';
import 'package:tmail_ui_user/main/utils/app_utils.dart';

class PrivacyLinkWidget extends StatelessWidget {
  final String privacyUrlString;

  const PrivacyLinkWidget({Key? key, this.privacyUrlString = AppConfig.privacyUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context).byContinuingYouAreAgreeingToOur,
          style: ThemeUtils.defaultTextStyleInterFont.copyWith(
            color: AppColor.colorTextBody,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        RichText(
          text: TextSpan(
            text: AppLocalizations.of(context).privacyPolicy,
            style: ThemeUtils.defaultTextStyleInterFont.copyWith(
              color: AppColor.loginTextFieldFocusedBorder,
              fontSize: 14),
            recognizer: TapGestureRecognizer()..onTap = () => AppUtils.launchLink(privacyUrlString)
          )
        ),
      ],
    );
  }
}

/// AGPL-3.0 section 13: anyone who interacts with a modified version of this
/// program over a network must be offered its Corresponding Source.
/// Publishing the fork is not by itself that offer -- it has to be reachable
/// from the running app, which is why this sits on the sign-in screen, the
/// one surface every user passes through -- kept as a small, unobtrusive
/// corner link rather than inline with the rest of the form.
///
/// Not a localized string: adding a key would mean regenerating
/// app_localizations.dart, and "Source code" is the same in the languages
/// this ships in. Worth revisiting if that stops holding.
class SourceCodeLinkWidget extends StatelessWidget {
  const SourceCodeLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Source code',
        style: ThemeUtils.defaultTextStyleInterFont.copyWith(
          color: AppColor.colorTextBody,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => AppUtils.launchLink(AppConfig.sourceCodeUrl),
      ),
    );
  }
}
