import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/text_field_widget.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/screens/additional_sign_up_screen_2.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/signup_appbar_widget.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/text_field_title_widget.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/splash_controller.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class AdditionalSignUpScreen1 extends StatefulWidget {
  const AdditionalSignUpScreen1({super.key});

  @override
  State<AdditionalSignUpScreen1> createState() =>
      _AdditionalSignUpScreen1State();
}

class _AdditionalSignUpScreen1State extends State<AdditionalSignUpScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: GetBuilder<AuthController>(builder: (authController) {
        return Column(children: [
          const SignUpAppbarWidget(
              title: 'signup_as_a_driver',
              progressText: '2_of_3',
              enableBackButton: true),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            const SizedBox(height: Dimensions.paddingSizeSignUp),
            Text('provide_basic_info'.tr,
                style: textBold.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 22)),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Text('enter_your_information'.tr,
                style: textRegular.copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  fontSize: Dimensions.fontSizeSmall,
                )),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldTitleWidget(title: '${'first_name'.tr}*'),
                        TextFieldWidget(
                          hintText: 'first_name'.tr,
                          capitalization: TextCapitalization.words,
                          inputType: TextInputType.name,
                          prefixIcon: Images.person,
                          controller: authController.fNameController,
                          focusNode: authController.fNameNode,
                          nextFocus: authController.lNameNode,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'first_name_is_required'.tr;
                            } else if (value.length < 2) {
                              return 'first_name_is_too_short'.tr;
                            } else if (RegExp(r'\d').hasMatch(value)) {
                              return 'first_name_should_only_contain_letters'
                                  .tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(width: Dimensions.paddingSizeDefault),
                        TextFieldTitleWidget(title: '${'last_name'.tr}*'),
                        TextFieldWidget(
                          hintText: 'last_name'.tr,
                          capitalization: TextCapitalization.words,
                          inputType: TextInputType.name,
                          prefixIcon: Images.person,
                          controller: authController.lNameController,
                          focusNode: authController.lNameNode,
                          nextFocus: authController.phoneNode,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'last_name_is_required'.tr;
                            } else if (value.length < 2) {
                              return 'last_name_is_too_short'.tr;
                            } else if (RegExp(r'\d').hasMatch(value)) {
                              return 'last_name_should_only_contain_letters'.tr;
                            }
                            return null;
                          },
                        ),
                        TextFieldTitleWidget(title: '${'phone'.tr}*'),
                        TextFieldWidget(
                          hintText: 'phone'.tr,
                          inputType: TextInputType.number,
                          countryDialCode: authController.countryDialCode,
                          controller: authController.phoneController,
                          focusNode: authController.phoneNode,
                          nextFocus: authController.passwordNode,
                          inputAction: TextInputAction.next,
                          onCountryChanged: (CountryCode countryCode) {
                            authController.countryDialCode =
                                countryCode.dialCode!;
                            authController
                                .setCountryCode(countryCode.dialCode!);
                            FocusScope.of(context)
                                .requestFocus(authController.phoneNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'phone_is_required'.tr;
                            } else if (!PhoneNumber.parse(
                                    authController.countryDialCode + value)
                                .isValid(type: PhoneNumberType.mobile)) {
                              return 'phone_number_is_not_valid'.tr;
                            }
                            return null;
                          },
                        ),
                        TextFieldTitleWidget(title: '${'password'.tr}*'),
                        TextFieldWidget(
                          hintText: 'password_hint'.tr,
                          inputType: TextInputType.text,
                          prefixIcon: Images.password,
                          isPassword: true,
                          controller: authController.passwordController,
                          focusNode: authController.passwordNode,
                          nextFocus: authController.confirmPasswordNode,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password_is_required'.tr;
                            } else if (value.length < 8) {
                              return 'minimum_password_length_is_8'.tr;
                            }
                            // else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
                            //   return 'password_should_be_complex'.tr;
                            // }
                            return null;
                          },
                        ),
                        TextFieldTitleWidget(
                            title: '${'confirm_password'.tr}*'),
                        TextFieldWidget(
                          hintText: 'enter_confirm_password'.tr,
                          inputType: TextInputType.text,
                          prefixIcon: Images.password,
                          controller: authController.confirmPasswordController,
                          focusNode: authController.confirmPasswordNode,
                          nextFocus: authController.referralNode,
                          inputAction: TextInputAction.next,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'confirm_password_is_required'.tr;
                            } else if (value !=
                                authController.passwordController.text) {
                              return 'password_is_mismatch'.tr;
                            }
                            return null;
                          },
                        ),
                        if (Get.find<SplashController>()
                                .config
                                ?.referralEarningStatus ??
                            false) ...[
                          TextFieldTitleWidget(title: 'referral_code'.tr),
                          TextFieldWidget(
                            hintText: 'referral_code'.tr,
                            capitalization: TextCapitalization.words,
                            inputType: TextInputType.text,
                            prefixIcon: Images.referralIcon1,
                            controller: authController.referralCodeController,
                            focusNode: authController.referralNode,
                            inputAction: TextInputAction.done,
                          ),
                        ],
                      ])),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            ButtonWidget(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              radius: Dimensions.radiusExtraLarge,
              buttonText: 'next'.tr,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => const AdditionalSignUpScreen2());
                }
              },
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
          ])))
        ]);
      })),
    );
  }
}
