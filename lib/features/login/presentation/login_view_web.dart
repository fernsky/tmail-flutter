import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/state/success.dart';
import 'package:core/presentation/utils/theme_utils.dart';
import 'package:core/presentation/views/login/wave_hero_widget.dart';
import 'package:core/presentation/views/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tmail_ui_user/features/base/widget/application_logo_with_text_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/base_login_view.dart';
import 'package:tmail_ui_user/features/login/presentation/login_form_type.dart';
import 'package:tmail_ui_user/features/login/presentation/privacy_link_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/widgets/login_message_widget.dart';
import 'package:tmail_ui_user/features/login/presentation/widgets/try_again_button.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';

class LoginView extends BaseLoginView {

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLightColor,
      body: Stack(
        children: [
          Center(child: SingleChildScrollView(
              child: ResponsiveWidget(
                responsiveUtils: controller.responsiveUtils,
                mobile: _buildMobileForm(context),
                desktop: _buildWebForm(context),
              ))),
          const Positioned(
            bottom: 12,
            right: 16,
            child: SourceCodeLinkWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const WaveHeroWidget(height: 160),
        Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 720, minHeight: 720),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ApplicationLogoWidthTextWidget()
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                    AppLocalizations.of(context).signIn,
                    style: ThemeUtils.defaultTextStyleInterFont.copyWith(fontSize: 32, color: AppColor.colorNameEmail, fontWeight: FontWeight.w900)
                )
              ),
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
          )
        ),
      ],
        ),
      ],
    );
  }

  Widget _buildWebForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 86),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Not a localized string: replaces the JMAP-focused headline
                // with bodhimail's own tagline (see also the AGPL rebrand
                // notes on PrivacyLinkWidget's "Source code" string).
                Text(
                  'Email for your needs',
                  style: ThemeUtils.defaultTextStyleInterFont.copyWith(
                    fontSize: 36,
                    color: AppColor.colorNameEmail,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44),
                  child: SvgPicture.asset(
                    controller.imagePaths.icLoginGraphic,
                    fit: BoxFit.fill,
                    alignment: Alignment.center
                  )
                )
              ],
            )
          ),
          Column(
            children: [
              Container(
                height: 684,
                width: 458,
                clipBehavior: Clip.antiAlias,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const WaveHeroWidget(height: 140),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ApplicationLogoWidthTextWidget()
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 31).copyWith(top: 24),
                      child: Text(
                        AppLocalizations.of(context).signIn,
                        style: ThemeUtils.defaultTextStyleInterFont.copyWith(fontSize: 32, color: AppColor.colorNameEmail, fontWeight: FontWeight.w900)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 31),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: PrivacyLinkWidget()
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ]
          )
        ],
      )
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    return Obx(() => controller.viewState.value.fold(
      (failure) {
        switch (controller.loginFormType.value) {
          case LoginFormType.credentialForm:
            return buildLoginButton(context);
          default:
            return const SizedBox.shrink();
        }
      },
      (success) {
        if (success is LoadingState) {
          return buildLoadingCircularProgress();
        } else {
          switch (controller.loginFormType.value) {
            case LoginFormType.credentialForm:
              return buildLoginButton(context);
            default:
              return const SizedBox.shrink();
          }
        }
      }
    ));
  }
}