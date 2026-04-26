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
        backgroundColor: Theme.of(context).cardColor,
        body: GetBuilder<AuthController>(builder: (authController) {
          return SizedBox.expand(
            child: Stack(
              children: [
                // Blue Header
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.logoNameWhite, height: 40),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'signup_as_a_driver'.tr,
                            style: textBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '2_of_3'.tr,
                              style: textRegular.copyWith(
                                color: Colors.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // White Card
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3 - 40,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeLarge,
                                vertical: Dimensions.paddingSizeOver),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Text('driver_registration'.tr,
                                          style: textBold.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 22))),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Center(
                                    child: Text('this_information_will_help'.tr,
                                        style: textRegular.copyWith(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          fontSize: Dimensions.fontSizeSmall,
                                        )),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeOver),
                                  TextFieldTitleWidget(
                                      title: '${'first_name'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'first_name'.tr,
                                    capitalization: TextCapitalization.words,
                                    inputType: TextInputType.name,
                                    prefixIcon: Images.person,
                                    controller: authController.fNameController,
                                    focusNode: authController.fNameNode,
                                    nextFocus: authController.lNameNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'first_name_is_required'.tr;
                                      } else if (value.length < 3) {
                                        return 'name_is_too_short'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'last_name'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'last_name'.tr,
                                    capitalization: TextCapitalization.words,
                                    inputType: TextInputType.name,
                                    prefixIcon: Images.person,
                                    controller: authController.lNameController,
                                    focusNode: authController.lNameNode,
                                    nextFocus: authController.phoneNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'last_name_is_required'.tr;
                                      } else if (value.length < 3) {
                                        return 'name_is_too_short'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(title: '${'phone'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'phone'.tr,
                                    inputType: TextInputType.number,
                                    countryDialCode:
                                        authController.countryDialCode,
                                    controller: authController.phoneController,
                                    focusNode: authController.phoneNode,
                                    nextFocus: authController.passwordNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    onCountryChanged:
                                        (CountryCode countryCode) {
                                      authController.countryDialCode =
                                          countryCode.dialCode!;
                                      authController.setCountryCode(
                                          countryCode.dialCode!);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'phone_is_required'.tr;
                                      } else if (!GetUtils.isPhoneNumber(
                                          authController.countryDialCode +
                                              value)) {
                                        return 'phone_number_is_not_valid'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'password'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'password'.tr,
                                    inputType: TextInputType.text,
                                    prefixIcon: Images.lock,
                                    controller:
                                        authController.passwordController,
                                    focusNode: authController.passwordNode,
                                    nextFocus:
                                        authController.confirmPasswordNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'password_is_required'.tr;
                                      } else if (value.length < 8) {
                                        return 'minimum_password_length_is_8'
                                            .tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'confirm_password'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'confirm_password'.tr,
                                    inputType: TextInputType.text,
                                    prefixIcon: Images.lock,
                                    controller: authController
                                        .confirmPasswordController,
                                    focusNode:
                                        authController.confirmPasswordNode,
                                    nextFocus: authController.referralNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'confirm_password_is_required'
                                            .tr;
                                      } else if (value !=
                                          authController
                                              .passwordController.text) {
                                        return 'password_not_match'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  if (Get.find<SplashController>()
                                          .config
                                          ?.referralEarningStatus ??
                                      false) ...[
                                    TextFieldTitleWidget(
                                        title: 'referral_code'.tr),
                                    TextFieldWidget(
                                      hintText: 'referral_code'.tr,
                                      capitalization: TextCapitalization.words,
                                      inputType: TextInputType.text,
                                      prefixIcon: Images.referralIcon1,
                                      controller:
                                          authController.referralCodeController,
                                      focusNode: authController.referralNode,
                                      inputAction: TextInputAction.done,
                                      borderRadius: 15,
                                      showBorder: true,
                                    ),
                                  ],
                                  TextFieldTitleWidget(
                                      title: '${'gender'.tr}*'),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: .5,
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.7)),
                                    ),
                                    child: DropdownButton<String>(
                                      hint: authController.selectedGender == ''
                                          ? Text('gender'.tr,
                                              style: textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color))
                                          : Text(
                                              authController.selectedGender.tr,
                                              style: textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color),
                                            ),
                                      items: authController.genderList
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value.tr,
                                                style: textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color)));
                                      }).toList(),
                                      onChanged: (val) {
                                        authController.setSelectedGender(val!);
                                      },
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeLarge),
                          child: ButtonWidget(
                            radius: 50,
                            buttonText: 'next'.tr,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (authController.selectedGender == '') {
                                  showCustomSnackBar('gender_is_required'.tr);
                                } else {
                                  Get.to(() => const AdditionalSignUpScreen2());
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
