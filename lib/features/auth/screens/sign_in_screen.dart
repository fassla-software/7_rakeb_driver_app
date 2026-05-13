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
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        backgroundColor: Theme.of(context).cardColor,
        body: GetBuilder<AuthController>(builder: (authController) {
          return GetBuilder<ProfileController>(builder: (profileController) {
            return GetBuilder<RideController>(builder: (rideController) {
              return GetBuilder<LocationController>(
                  builder: (locationController) {
                return SizedBox.expand(
                  child: Stack(
                    children: [
                      // Dark Blue Header
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context)
                            .primaryColor, // Using primary color for header
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.logoNameWhite, height: 60),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                            Text(
                              '${'welcome_to'.tr} ${AppConstants.appName}',
                              style: textBold.copyWith(
                                color: Colors.white,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // White Card
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.35 - 40,
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
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeLarge,
                                vertical: Dimensions.paddingSizeOver),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'log_in'.tr,
                                          style: textBold.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge,
                                          ),
                                        ),
                                        Text(
                                          'log_in_message'.tr,
                                          style: textRegular.copyWith(
                                              color:
                                                  Theme.of(context).hintColor),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Theme.of(context).primaryColor,
                                          size: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeOver),
                                Form(
                                  key: _formKeySignIn,
                                  child: Column(
                                    children: [
                                      TextFieldWidget(
                                        hintText: 'phone'.tr,
                                        inputType: TextInputType.number,
                                        countryDialCode:
                                            authController.countryDialCode,
                                        controller: phoneController,
                                        focusNode: phoneNode,
                                        nextFocus: passwordNode,
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
                                            return 'phone_number_is_not_valid'
                                                .tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeLarge),
                                      TextFieldWidget(
                                        hintText: 'password'.tr,
                                        inputType: TextInputType.text,
                                        prefixIcon: Images.lock,
                                        inputAction: TextInputAction.done,
                                        focusNode: passwordNode,
                                        borderRadius: 15,
                                        showBorder: true,
                                        isPassword: true,
                                        controller: passwordController,
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
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          authController.toggleRememberMe(),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20.0,
                                            height: 20.0,
                                            child: Checkbox(
                                              checkColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              value: authController
                                                  .isActiveRememberMe,
                                              onChanged: (bool? isChecked) =>
                                                  authController
                                                      .toggleRememberMe(),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Text(
                                            'remember'.tr,
                                            style: textRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          // Determine message based on current GetX locale
                                          bool isArabic =
                                              Get.locale?.languageCode == 'ar';
                                          String message = isArabic
                                              ? 'لقد نسيت كلمة المرور الخاصة بي'
                                              : 'I forgot my password';

                                          // WhatsApp URL format: https://wa.me/number?text=urlencodedmessage
                                          final Uri whatsappUrl = Uri.parse(
                                              "https://wa.me/201034892158?text=${Uri.encodeComponent(message)}");

                                          // if (await canLaunchUrl(whatsappUrl)) {
                                          await launchUrl(whatsappUrl,
                                              mode: LaunchMode
                                                  .externalApplication);
                                          // } else {
                                          //   showCustomSnackBar('could_not_launch_whatsapp'.tr);
                                          // }
                                        },
                                        child: Text(
                                          'forgot_password'.tr,
                                          style: textRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeOver),
                                (authController.isLoading ||
                                        authController.updateFcm ||
                                        profileController.isLoading ||
                                        rideController.isLoading ||
                                        locationController.lastLocationLoading)
                                    ? Center(
                                        child: SpinKitCircle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 40.0))
                                    : ButtonWidget(
                                        buttonText: 'log_in'.tr,
                                        onPressed: () {
                                          if (_formKeySignIn.currentState!
                                              .validate()) {
                                            authController.login(
                                                authController.countryDialCode,
                                                phoneController.text,
                                                passwordController.text);
                                          }
                                        },
                                        radius: 50,
                                      ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                if (Get.find<SplashController>()
                                            .config!
                                            .selfRegistration !=
                                        null &&
                                    Get.find<SplashController>()
                                        .config!
                                        .selfRegistration!)
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${'do_not_have_an_account'.tr} ',
                                          style: textRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.to(
                                              () => const SignUpScreen()),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: const Size(50, 30),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: Text(
                                            'sign_up'.tr,
                                            style: textRegular.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              decorationColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ])
                                else
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("${'to_create_account'.tr} "),
                                        InkWell(
                                          onTap: () =>
                                              Get.find<SplashController>()
                                                  .sendMailOrCall(
                                            "tel:${Get.find<SplashController>().config?.businessContactPhone}",
                                            false,
                                          ),
                                          child: Text(
                                            "${'contact_support'.tr} ",
                                            style: textRegular.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ]),
                                const SizedBox(
                                    height: Dimensions.paddingSizeOver),
                                Center(
                                  child: InkWell(
                                    onTap: () => Get.to(() =>
                                        const PolicyViewerScreen(
                                            htmlType:
                                                HtmlType.termsAndConditions)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      child: Text(
                                        "terms_and_condition".tr,
                                        style: textMedium.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: Theme.of(context).primaryColor,
                                          decorationColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
          });
        }),
      ),
    );
  }
}
