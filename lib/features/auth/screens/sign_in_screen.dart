import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/text_field_widget.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/screens/forgot_password_screen.dart';
import 'package:ride_sharing_user_app/features/auth/screens/sign_up_screen.dart';
import 'package:ride_sharing_user_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/features/html/domain/html_enum_types.dart';
import 'package:ride_sharing_user_app/features/html/screens/policy_viewer_screen.dart';
import 'package:ride_sharing_user_app/features/location/controllers/location_controller.dart';
import 'package:ride_sharing_user_app/features/profile/controllers/profile_controller.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/splash_controller.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  final GlobalKey<FormState> _formKeySignIn = GlobalKey<FormState>();

  @override
  void initState() {
    if (Get.find<AuthController>().getUserNumber().isNotEmpty) {
      phoneController.text = Get.find<AuthController>().getUserNumber();
    }
    passwordController.text = Get.find<AuthController>().getUserPassword();
    if (passwordController.text != '') {
      Get.find<AuthController>().setRememberMe();
    }
    if (Get.find<AuthController>().getLoginCountryCode().isNotEmpty) {
      Get.find<AuthController>().countryDialCode =
          Get.find<AuthController>().getLoginCountryCode();
    } else if (Get.find<SplashController>().config!.countryCode != null) {
      Get.find<AuthController>().countryDialCode = CountryCode.fromCountryCode(
              Get.find<SplashController>().config!.countryCode!)
          .dialCode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (res, val) async {
        Get.find<BottomMenuController>().exitApp();
        return;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: GetBuilder<AuthController>(builder: (authController) {
          return GetBuilder<ProfileController>(builder: (profileController) {
            return GetBuilder<RideController>(builder: (rideController) {
              return GetBuilder<LocationController>(
                  builder: (locationController) {
                return Column(children: [
                  // Top Section
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeOverLarge),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeOverLarge),
                          Text(
                            'أهلاً بعودتك',
                            style: textBold.copyWith(
                              color: const Color(0xFFEBC16F),
                              fontSize: Dimensions.fontSizeOverLarge * 1.5,
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Text(
                            'سجل دخولك واستمتع بالخدمات',
                            style: textRegular.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeOverLarge),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'log_in'.tr,
                                style: textBold.copyWith(
                                  color: const Color(0xFFEBC16F),
                                  fontSize: Dimensions.fontSizeExtraLarge * 1.2,
                                ),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeSmall),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFEBC16F),
                                ),
                                child: Icon(Icons.arrow_forward,
                                    color: Theme.of(context).primaryColor,
                                    size: 20),
                              ),
                            ],
                          ),
                        ]),
                  ),

                  // Bottom Section (Form)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(40)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeOverLarge),
                          child: Column(children: [
                            Form(
                              key: _formKeySignIn,
                              child: Column(children: [
                                TextFieldWidget(
                                  hintText: 'أدخل هاتفك',
                                  inputType: TextInputType.number,
                                  countryDialCode:
                                      authController.countryDialCode,
                                  controller: phoneController,
                                  focusNode: phoneNode,
                                  nextFocus: passwordNode,
                                  borderRadius: 15,
                                  showBorder: true,
                                  showPrefix: false,
                                  onCountryChanged: (CountryCode countryCode) {
                                    authController.countryDialCode =
                                        countryCode.dialCode!;
                                    authController
                                        .setCountryCode(countryCode.dialCode!);
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
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                TextFieldWidget(
                                  hintText: 'أدخل كلمة المرور',
                                  inputType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                  focusNode: passwordNode,
                                  isPassword: true,
                                  controller: passwordController,
                                  borderRadius: 15,
                                  showBorder: true,
                                  showPrefix: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'password_is_required'.tr;
                                    } else if (value.length < 8) {
                                      return 'minimum_password_length_is_8'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => Get.to(
                                        () => const ForgotPasswordScreen()),
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: Text(
                                      'هل نسيت كلمة المرور؟',
                                      style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        authController.toggleRememberMe(),
                                    child: Row(children: [
                                      Text(
                                        'تذكرني',
                                        style: textRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall),
                                      ),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            checkColor:
                                                Theme.of(context).cardColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            value: authController
                                                .isActiveRememberMe,
                                            onChanged: (bool? isChecked) =>
                                                authController
                                                    .toggleRememberMe(),
                                          )),
                                    ]),
                                  ),
                                ]),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            (authController.isLoading ||
                                    authController.updateFcm ||
                                    profileController.isLoading ||
                                    rideController.isLoading ||
                                    locationController.lastLocationLoading)
                                ? Center(
                                    child: SpinKitCircle(
                                        color: Theme.of(context).primaryColor,
                                        size: 40.0))
                                : ButtonWidget(
                                    buttonText: 'log_in'.tr,
                                    transparent: true,
                                    showBorder: true,
                                    radius: 30,
                                    borderColor: Theme.of(context).primaryColor,
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      if (_formKeySignIn.currentState!
                                          .validate()) {
                                        authController.login(
                                            authController.countryDialCode,
                                            phoneController.text,
                                            passwordController.text);
                                      }
                                    },
                                  ),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            if (Get.find<SplashController>()
                                    .config!
                                    .selfRegistration !=
                                null &&
                                Get.find<SplashController>()
                                    .config!
                                    .selfRegistration!)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${'do_not_have_an_account'.tr} ',
                                      style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.to(() => const SignUpScreen()),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(50, 30),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        'sign_up'.tr,
                                        style: textRegular.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xFFEBC16F),
                                          decorationColor:
                                              const Color(0xFFEBC16F),
                                        ),
                                      ),
                                    ),
                                  ])
                            else
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${'to_create_account'.tr} "),
                                    InkWell(
                                      onTap: () => Get.find<SplashController>()
                                          .sendMailOrCall(
                                        "tel:${Get.find<SplashController>().config?.businessContactPhone}",
                                        false,
                                      ),
                                      child: Text(
                                        "${'contact_support'.tr} ",
                                        style: textRegular.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ]),

                            const SizedBox(height: Dimensions.paddingSizeOver),

                            InkWell(
                              onTap: () => Get.to(() =>
                                  const PolicyViewerScreen(
                                      htmlType: HtmlType.termsAndConditions)),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: Text(
                                  "terms_and_condition".tr,
                                  style: textMedium.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: const Color(0xFFEBC16F),
                                    decorationColor: const Color(0xFFEBC16F),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ]);
              });
            });
          });
        }),
      ),
    );
  }

}
