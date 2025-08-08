import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ride_sharing_user_app/common_widgets/snackbar_widget.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/map/screens/map_screen.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/controllers/schedule_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/models/accept_schedule_%20model.dart';
import 'package:ride_sharing_user_app/helper/pusher_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
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
          ),

          const SizedBox(height: 8),

          _buildLocationRow(
            icon: Icons.location_on,
            iconColor: Colors.red,
            address: schedule.coordinate?.destinationAddress ??
                'No destination address',
            label: 'to'.tr,
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

          // Action Buttons
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
              Text(
                address,
                style: textRegular.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
