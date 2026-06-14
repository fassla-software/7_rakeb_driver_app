import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ride_sharing_user_app/common_widgets/image_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/snackbar_widget.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/chat/controllers/chat_controller.dart';
import 'package:ride_sharing_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/map/screens/map_screen.dart';
import 'package:ride_sharing_user_app/features/map/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/controllers/schedule_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/models/accept_schedule_%20model.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/splash_controller.dart';
import 'package:ride_sharing_user_app/helper/pusher_helper.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:intl/intl.dart';

class AcceptScheduleCard extends StatelessWidget {
  final ScheduleTrip schedule;

  const AcceptScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${"trip".tr}  ${schedule.refId ?? ''}',
                style: textMedium.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${schedule.paymentMethod ?? ''}',
                style: textRegular.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),

          // Created At
          if (schedule.createdAt != null) ...[
            const SizedBox(height: 8),
            Text(
              '${"Scheduled_to".tr}: ${_formatDateTime(schedule.createdAt!)}',
              style: textRegular.copyWith(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Route
          _buildLocationRow(
            icon: Icons.radio_button_checked,
            iconColor: Colors.green,
            address: schedule.coordinate?.pickupAddress ?? 'No pickup address',
            label: 'from'.tr,
            coords: schedule.coordinate?.pickupCoordinates?.coordinates,
          ),

          const SizedBox(height: 8),

          _buildLocationRow(
            icon: Icons.location_on,
            iconColor: Colors.red,
            address: schedule.coordinate?.destinationAddress ??
                'No destination address',
            label: 'to'.tr,
            coords: schedule.coordinate?.destinationCoordinates?.coordinates,
          ),

          const SizedBox(height: 16),

          // Trip Info
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'distance'.tr,
                  '${schedule.estimatedDistance ?? 0} km',
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  'fare'.tr,
                  '\$${schedule.actualFare ?? 0}',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          GetBuilder<RideController>(builder: (rideController) {
            return Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeSmall),
                border: Border.all(
                    width: .75,
                    color: Theme.of(context).hintColor.withOpacity(0.25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Stack(children: [
                          Container(
                            transform: Matrix4.translationValues(
                                Get.find<LocalizationController>().isLtr
                                    ? -3
                                    : 3,
                                -3,
                                0),
                            child: CircularPercentIndicator(
                              radius: 28,
                              percent: .75,
                              lineWidth: 1,
                              backgroundColor: Colors.transparent,
                              progressColor:
                                  Theme.of(Get.context!).primaryColor,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ImageWidget(
                              width: 50,
                              height: 50,
                              image: schedule.customer?.profileImage ?? "",
                            ),
                          ),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (schedule.customer!.firstName != null &&
                                  schedule.customer!.lastName != null)
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${schedule.customer!.firstName!} ${schedule.customer!.lastName!}',
                                    )),
                              if (schedule.customer != null)
                                Row(children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Theme.of(Get.context!).primaryColor,
                                    size: Dimensions.iconSizeMedium,
                                  ),
                                  Text(
                                    "0",
                                    style: textRegular.copyWith(),
                                  ),
                                ]),
                            ]),
                      ]),
                      Container(
                          width: 1,
                          height: 25,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.15)),
                      InkWell(
                        onTap: () => Get.find<ChatController>().createChannel(
                          schedule.customerId!,
                          tripId: schedule.id,
                        ),
                        child: SizedBox(
                          width: Dimensions.iconSizeLarge,
                          child: Image.asset(Images.customerMessage),
                        ),
                      ),
                      Container(
                          width: 1,
                          height: 25,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.15)),
                      InkWell(
                        onTap: () =>
                            Get.find<SplashController>().sendMailOrCall(
                          "tel:${rideController.tripDetail!.customer!.phone}",
                          false,
                        ),
                        child: SizedBox(
                          width: Dimensions.iconSizeLarge,
                          child: Image.asset(Images.customerCall),
                        ),
                      ),
                      const SizedBox()
                    ]),
              ),
            );
          }),
          SizedBox(
            height: 16,
          ),
          // Action ButtonsSized
          GetBuilder<ScheduleController>(
            builder: (controller) => controller.loadingTripId == schedule.id
                ? Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context: context,
                          onPressed: () {
                            // Check if scheduled time is within 1 hour from now
                            if (schedule.createdAt != null) {
                              final now = DateTime.now();
                              final scheduledTime = schedule.createdAt!;
                              final timeDifference =
                                  scheduledTime.difference(now);

                              // If scheduled time is more than 1 hour in the future
                              if (timeDifference.inHours >= 1) {
                                SnackBarWidget(
                                  'not_at_time'.tr,
                                  isError: true,
                                );
                                return;
                              }
                            }

                            controller
                                .acceptOrRejectTrip(schedule.id!, "accepted")
                                .then((value) async {
                              if (value.statusCode == 200) {
                                await controller.getAcceptedSchedules();
                                Get.find<AuthController>()
                                    .saveRideCreatedTime();
                                Get.find<RiderMapController>()
                                    .setRideCurrentState(RideState.accepted);
                                Get.find<RideController>()
                                    .updateRoute(false, notify: true);
                                Get.find<RideController>().remainingDistance(
                                    schedule.id!,
                                    mapBound: true);
                                Get.to(() => const MapScreen());
                                PusherHelper().customerCouponAppliedOrRemoved(
                                    schedule.id!);
                              }
                            });
                          },
                          label: 'start'.tr,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: controller.loadingTripId == schedule.id
                            ? SpinKitCircle(
                                color: Theme.of(context).primaryColor,
                                size: 40.0)
                            : _buildActionButton(
                                context: context,
                                onPressed: () {
                                  controller
                                      .cancelScheduleTrip(
                                    schedule.id!,
                                  )
                                      .then((value) async {
                                    if (value.statusCode == 200) {
                                      await controller.getAcceptedSchedules();
                                      SnackBarWidget(
                                          "schedule_trip_canceled".tr,
                                          isError: false);
                                    }
                                  });
                                },
                                label: 'cancel'.tr,
                                backgroundColor: Colors.red,
                              ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == today) {
      return 'Today ${DateFormat('HH:mm').format(dateTime)}';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday ${DateFormat('HH:mm').format(dateTime)}';
    } else {
      return DateFormat('MMM dd, HH:mm').format(dateTime);
    }
  }

  Widget _buildLocationRow({
    required IconData icon,
    required Color iconColor,
    required String address,
    required String label,
    List<double>? coords,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textRegular.copyWith(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              FutureBuilder<String>(
                future: RouteWidget.getAreaName(coords, address),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? address,
                    style: textRegular.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textRegular.copyWith(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textMedium.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    required Color backgroundColor,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: textMedium.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
