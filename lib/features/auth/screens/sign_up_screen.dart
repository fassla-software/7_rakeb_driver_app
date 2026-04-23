import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/screens/additional_sign_up_screen_1.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/signup_appbar_widget.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
          children: [
            // Blue Header
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
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
                          '1_of_3'.tr,
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                            vertical: Dimensions.paddingSizeOver),
                        child: Column(
                          children: [
                            Center(
                                child: Image.asset(Images.signUpScreenLogo,
                                    width: 150)),
                            const SizedBox(height: Dimensions.paddingSizeSignUp),
                            Text('choose_service'.tr,
                                style: textBold.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22)),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'select_your_preferable_service'.tr,
                                style: textRegular.copyWith(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeSmall),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSignUp),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: authController.isRideShare
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5)
                                      : Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5),
                                ),
                                color: authController.isRideShare
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.05)
                                    : null,
                              ),
                              child: CheckboxListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall),
                                title: Text('ride_share'.tr,
                                    style: textBold.copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color)),
                                value: authController.isRideShare,
                                onChanged: (value) {
                                  authController.updateServiceType(true);
                                },
                                activeColor: Theme.of(context).primaryColor,
                                checkColor: Colors.white,
                                subtitle: Text('service_provide_text1'.tr,
                                    style: textRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 10,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                      child: ButtonWidget(
                        radius: 50,
                        buttonText: 'next'.tr,
                        onPressed: () {
                          if (!authController.isRideShare &&
                              !authController.isParcelShare) {
                            showCustomSnackBar('required_to_select_service'.tr);
                          } else {
                            Get.to(() => const AdditionalSignUpScreen1());
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
        );
      }),
    );
  }
}

