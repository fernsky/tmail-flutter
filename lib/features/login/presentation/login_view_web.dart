import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/state/success.dart';
import 'package:core/presentation/views/login/wave_hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/base_login_view.dart';
import 'package:tmail_ui_user/features/login/presentation/login_form_type.dart';
import 'package:tmail_ui_user/features/login/presentation/privacy_link_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/widgets/login_message_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/widgets/try_again_button.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';

/// Sign-in screen, laid out like bodhimail's: a brand-green wave hero across
/// the top and a single centred column below it, capped at
/// [authContentMaxWidth]. Deliberately not the old two-column split (a
/// promo panel beside a floating 458x684 card) -- that layout carried the
/// JMAP feature pitch this product does not make, and the card's own width
/// meant the form never shared a measurement with anything else.
class LoginView extends BaseLoginView {

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLightColor,
      body: Stack(
        children: [
          SingleChildScrollView(child: _buildForm(context)),
          const Positioned(
            bottom: 12,
            right: 16,
            child: SourceCodeLinkWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return WaveHeroScaffold(
      title: AppLocalizations.of(context).signIn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => LoginMessageWidget(
            formType: controller.loginFormType.value,
            viewState: controller.viewState.value,
          )),
          Obx(() {
            switch (controller.loginFormType.value) {
              case LoginFormType.credentialForm:
                return buildInputCredentialForm(context);
              case LoginFormType.retry:
                return TryAgainButton(
                  onRetry: controller.retryCheckOidc,
                  responsiveUtils: controller.responsiveUtils,
                  viewState: controller.viewState.value,
                );
              default:
                return const SizedBox.shrink();
            }
          }),
          _buildLoadingProgress(context),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: PrivacyLinkWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    return Obx(() => controller.viewState.value.fold(
      (failure) => buildLoginButton(context),
      (success) {
        if (success is LoadingState) {
          return const Padding(
            padding: EdgeInsets.only(top: 8),
            child: SizedBox(
              height: authButtonHeight,
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          );
        }
        return buildLoginButton(context);
      }
    ));
  }
}
