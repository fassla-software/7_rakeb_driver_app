import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ride_sharing_user_app/features/schedule/controllers/schedule_controller.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/models/schedule_model.dart';
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
                  child: Text(
                    schedule.pickupAddress ?? 'No pickup address',
                    style: textRegular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                  child: Text(
                    schedule.destinationAddress ?? 'No destination address',
                    style: textRegular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                      'Distance: ${schedule.actualDistance ?? 0} km',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.loadingTripId == schedule.id
                      ? SpinKitCircle(
                          color: Theme.of(context).primaryColor, size: 40.0)
                      : ElevatedButton.icon(
                          onPressed: () {
                            controller.acceptTrip(schedule.id!);
                          },
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white),
                          label: Text('accept'.tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.map, color: Colors.white),
                    label: Text('View Map'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
