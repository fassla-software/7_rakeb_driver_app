import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/signup_appbar_widget.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/helper/email_checker.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/signup_body.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/text_field_title_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/image_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/text_field_widget.dart';

class AdditionalSignUpScreen2 extends StatefulWidget {
  const AdditionalSignUpScreen2({super.key});

  @override
  State<AdditionalSignUpScreen2> createState() => _AdditionalSignUpScreen2State();
}

class _AdditionalSignUpScreen2State extends State<AdditionalSignUpScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
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
                          '3_of_3'.tr,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text('provide_your_identity'.tr,
                                    style: textBold.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 22))),
                            Center(
                              child: Text('this_information_will_help'.tr,
                                  style: textRegular.copyWith(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeSmall,
                                  )),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeOver),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: Dimensions.paddingSizeSmall),
                                    child: Center(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                        ),
                                        child: Stack(
                                          alignment: AlignmentDirectional.center,
                                          clipBehavior: Clip.none,
                                          children: [
                                            authController.pickedProfileFile ==
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: const ImageWidget(
                                                      image: '',
                                                      height: 90,
                                                      width: 90,
                                                      placeholder: Images
                                                          .personPlaceholder,
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 45,
                                                    backgroundImage: FileImage(
                                                        File(authController
                                                            .pickedProfileFile!
                                                            .path)),
                                                  ),
                                            Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: InkWell(
                                                  onTap: () => authController
                                                      .pickImage(false, true),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: const Icon(
                                                        Icons
                                                            .camera_enhance_rounded,
                                                        color: Colors.white,
                                                        size: 16),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeLarge),
                                  TextFieldTitleWidget(title: '${'email'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'email'.tr,
                                    inputType: TextInputType.emailAddress,
                                    prefixIcon: Images.email,
                                    controller: authController.emailController,
                                    focusNode: authController.emailNode,
                                    nextFocus: authController.addressNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'email_is_required'.tr;
                                      } else if (EmailChecker.isNotValid(
                                          value)) {
                                        return 'enter_valid_email_address'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'address'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'address'.tr,
                                    capitalization: TextCapitalization.words,
                                    inputType: TextInputType.text,
                                    prefixIcon: Images.location,
                                    controller:
                                        authController.addressController,
                                    focusNode: authController.addressNode,
                                    nextFocus:
                                        authController.identityNumberNode,
                                    inputAction: TextInputAction.next,
                                    borderRadius: 15,
                                    showBorder: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'address_is_required'.tr;
                                      } else if (value.length < 5) {
                                        return 'address_is_too_short'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'identity_type'.tr}*'),
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
                                      hint: authController.identityType == ''
                                          ? Text('select_identity_type'.tr,
                                              style: textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color))
                                          : Text(
                                              authController.identityType.tr,
                                              style: textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color),
                                            ),
                                      items: authController.identityTypeList
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
                                        authController.setIdentityType(val!);
                                      },
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                    ),
                                  ),
                                  TextFieldTitleWidget(
                                      title: '${'identification_number'.tr}*'),
                                  TextFieldWidget(
                                    hintText: 'Ex: 12345',
                                    inputType: TextInputType.text,
                                    prefixIcon: Images.identity,
                                    controller: authController
                                        .identityNumberController,
                                    focusNode:
                                        authController.identityNumberNode,
                                    inputAction: TextInputAction.done,
                                    borderRadius: 15,
                                    showBorder: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'identity_number_is_required'.tr;
                                      } else if (value.length < 4) {
                                        return 'identity_number_is_too_short'
                                            .tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            TextFieldTitleWidget(
                                title: '${'identity_image'.tr}*'),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    authController.identityImages.length >= 2
                                        ? 2
                                        : authController.identityImages.length +
                                            1,
                                itemBuilder: (BuildContext context, index) {
                                  return index ==
                                          authController.identityImages.length
                                      ? GestureDetector(
                                          onTap: () => authController.pickImage(
                                              false, false),
                                          child: DottedBorder(
                                            strokeWidth: 2,
                                            dashPattern: const [10, 5],
                                            color: Theme.of(context).hintColor,
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(
                                                Dimensions.paddingSizeSmall),
                                            child: Stack(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .paddingSizeSmall),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.3,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Image.asset(
                                                      Images.cameraPlaceholder,
                                                      scale: 3),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(0.07),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .paddingSizeSmall),
                                                )),
                                              ),
                                            ]),
                                          ),
                                        )
                                      : Stack(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Dimensions
                                                    .paddingSizeSmall),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(Dimensions
                                                      .paddingSizeExtraSmall),
                                                ),
                                                child: Image.file(
                                                  File(authController
                                                      .identityImages[index]
                                                      .path),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.3,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () => authController
                                                  .removeImage(index),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    Dimensions
                                                        .paddingSizeDefault,
                                                  )),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.red,
                                                      size: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                      child: authController.isLoading
                          ? Center(
                              child: SpinKitCircle(
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0))
                          : ButtonWidget(
                              buttonText: 'submit'.tr,
                              onPressed: () async {
                                if (authController.pickedProfileFile == null) {
                                  showCustomSnackBar(
                                      'profile_image_is_required'.tr);
                                } else if (authController
                                    .identityImages.isEmpty) {
                                  showCustomSnackBar(
                                      'identity_image_is_required'.tr);
                                } else if (authController
                                    .identityType.isEmpty) {
                                  showCustomSnackBar(
                                      'identity_type_is_required'.tr);
                                } else if (_formKey.currentState!.validate()) {
                                  List<String> services = [];
                                  if (authController.isRideShare) {
                                    services.add('ride_request');
                                  }
                                  if (authController.isParcelShare) {
                                    services.add('parcel');
                                  }
                                  String? deviceToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  log("fcm token: $deviceToken");
                                  SignUpBody signUpBody = SignUpBody(
                                      email:
                                          authController.emailController.text,
                                      address:
                                          authController.addressController.text,
                                      identityNumber: authController
                                          .identityNumberController.text,
                                      identificationType: authController
                                          .identityType,
                                      fName:
                                          authController.fNameController.text,
                                      lName:
                                          authController.lNameController.text,
                                      phone: authController.countryDialCode +
                                          authController.phoneController.text,
                                      password: authController
                                          .passwordController.text,
                                      confirmPassword: authController
                                          .confirmPasswordController.text,
                                      deviceToken:
                                          authController.getDeviceToken(),
                                      services: services,
                                      referralCode: authController
                                          .referralCodeController.text
                                          .trim(),
                                      fcmToken: deviceToken,
                                      gender: authController.selectedGender);
                                  authController.register(
                                      authController.countryDialCode,
                                      signUpBody);
                                }
                              },
                              radius: 50),
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
