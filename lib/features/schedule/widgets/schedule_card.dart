import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/snackbar_widget.dart';
import 'package:ride_sharing_user_app/features/map/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/features/schedule/controllers/schedule_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/models/accept_schedule_%20model.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleTrip schedule;

  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          bottom: Dimensions.paddingSizeSmall,
          top: Dimensions.paddingSizeSmall),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trip #${schedule.refId ?? ''}',
                  style: textMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${schedule.paymentStatus ?? ''} • ${schedule.paymentMethod ?? ''}',
                  style: textRegular.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: FutureBuilder<String>(
                    future: RouteWidget.getAreaName(
                      schedule.coordinate?.pickupCoordinates?.coordinates,
                      schedule.coordinate?.pickupAddress ?? 'No pickup address',
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? schedule.coordinate?.pickupAddress ?? 'No pickup address',
                        style: textRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: FutureBuilder<String>(
                    future: RouteWidget.getAreaName(
                      schedule.coordinate?.destinationCoordinates?.coordinates,
                      schedule.coordinate?.destinationAddress ?? 'No destination address',
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? schedule.coordinate?.destinationAddress ?? 'No destination address',
                        style: textRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distance: ${schedule.estimatedDistance ?? 0} km',
                      style: textRegular,
                    ),
                    Text(
                      'Fare: \$${schedule.actualFare ?? 0}',
                      style: textRegular,
                    ),
                  ],
                ),
              ],
            ),
            GetBuilder<ScheduleController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  controller.loadingTripId == schedule.id
                      ? SpinKitCircle(
                          color: Theme.of(context).primaryColor, size: 40.0)
                      : ElevatedButton.icon(
                          onPressed: () {
                            controller
                                .acceptScheduleTrip(schedule.id!)
                                .then((value) {
                              if (value.statusCode == 200) {
                                SnackBarWidget(
                                    "schedule_trip_accepted_and_added_to_your_list"
                                        .tr,
                                    isError: false);
                              }
                            });
                          },
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white),
                          label: Text('accept'.tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
