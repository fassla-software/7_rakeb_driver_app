import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/app_bar_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/no_data_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/type_button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/zoom_drawer_context_widget.dart';
import 'package:ride_sharing_user_app/features/profile/screens/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/features/schedule/widgets/accept_schedule_card.dart';
import 'package:ride_sharing_user_app/features/schedule/widgets/schedule_card.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import '../controllers/schedule_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

import 'package:ride_sharing_user_app/features/profile/controllers/profile_controller.dart';

class ScheduleScreenMenu extends GetView<ScheduleController> {
  final int? initialIndex;
  const ScheduleScreenMenu({this.initialIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) => ZoomDrawer(
        controller: profileController.zoomDrawerController,
        menuScreen: const ProfileMenuScreen(),
        mainScreen: ScheduleScreen(initialIndex: initialIndex),
        borderRadius: 24.0,
        angle: -5.0,
        isRtl: !Get.find<LocalizationController>().isLtr,
        menuBackgroundColor: Theme.of(context).primaryColor,
        slideWidth: MediaQuery.of(context).size.width * 0.85,
        mainScreenScale: .4,
        mainScreenTapClose: true,
      ),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  final int? initialIndex;
  const ScheduleScreen({this.initialIndex, super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex != null) {
        Get.find<ScheduleController>().setWalletTypeIndex(widget.initialIndex!);
      }
      if (widget.initialIndex == 1) {
        Get.find<ScheduleController>().getAcceptedSchedules();
      } else {
        Get.find<ScheduleController>().getSchedules();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      builder: (controller) {
        print(
            "schedule: ${controller.schedules}   accepts: ${controller.acceptedSchedules}");
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      centerTitle: false,
                      toolbarHeight: 80,
                      automaticallyImplyLeading: false,
                      backgroundColor: Theme.of(context).highlightColor,
                      flexibleSpace: GetBuilder<ScheduleController>(
                          builder: (scheduleController) {
                        return AppBarWidget(
                          title: 'schedule_trips'.tr,
                          showBackButton: false,
                          onTap: () {
                            Get.find<ProfileController>().toggleDrawer();
                          },
                        );
                      })),
                  controller.scheduleTypeIndex == 0
                      ? SliverFillRemaining(
                          child: controller.isLoading
                              ? SpinKitCircle(
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0)
                              : controller.schedules.isEmpty
                                  ? const NoDataWidget(title: 'no_trip_found')
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(
                                                Dimensions.paddingSizeDefault),
                                            itemCount:
                                                controller.schedules.length,
                                            itemBuilder: (context, index) {
                                              final schedule =
                                                  controller.schedules[index];
                                              return ScheduleCard(
                                                  schedule: schedule);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.paddingSizeOver,
                                        )
                                      ],
                                    ),
                        )
                      : SliverFillRemaining(
                          child: controller.isAcceptingLoading
                              ? SpinKitCircle(
                                  color: Theme.of(context).primaryColor,
                                  size: 40.0)
                              : controller.acceptedSchedules.isEmpty
                                  ? const NoDataWidget(title: 'no_trip_found')
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(
                                                Dimensions.paddingSizeDefault),
                                            itemCount: controller
                                                .acceptedSchedules.length,
                                            itemBuilder: (context, index) {
                                              final acceptingSchedule =
                                                  controller
                                                      .acceptedSchedules[index];
                                              return AcceptScheduleCard(
                                                  schedule: acceptingSchedule);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.paddingSizeOver,
                                        )
                                      ],
                                    ),
                        ),
                ],
              ),
            ),
            Positioned(
              top: Get.height * (GetPlatform.isIOS ? 0.13 : 0.06),
              child:
                  GetBuilder<ScheduleController>(builder: (scheduleController) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: SizedBox(
                    height: Get.find<LocalizationController>().isLtr ? 45 : 50,
                    width: Get.width - Dimensions.paddingSizeDefault,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: scheduleController.scheduleTypeList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 200,
                          child: TypeButtonWidget(
                            index: index,
                            name: scheduleController.scheduleTypeList[index].tr,
                            selectedIndex: scheduleController.scheduleTypeIndex,
                            onTap: () {
                              scheduleController.setWalletTypeIndex(index);
                              if (index == 0) {
                                scheduleController.getSchedules();
                              } else {
                                scheduleController.getAcceptedSchedules();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
