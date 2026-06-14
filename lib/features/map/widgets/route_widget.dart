import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/common_widgets/divider_widget.dart';

class RouteWidget extends StatefulWidget {
  final String pickupAddress;
  final String destinationAddress;
  final List<double>? pickupCoords;
  final List<double>? destinationCoords;
  final String? extraOne;
  final String? extraTwo;
  final String? entrance;
  final bool fromCard;
  const RouteWidget(
      {super.key,
      required this.pickupAddress,
      required this.destinationAddress,
      this.pickupCoords,
      this.destinationCoords,
      this.extraOne,
      this.extraTwo,
      this.entrance,
      this.fromCard = false});

  static Future<String> getAreaName(
      List<double>? coords, String fallbackAddress) async {
    if (coords == null ||
        coords.length < 2 ||
        (coords[0] == 0 && coords[1] == 0)) {
      return fallbackAddress;
    }
    try {
      final String languageCode =
          Get.find<LocalizationController>().locale.languageCode;
      await setLocaleIdentifier(languageCode);
      // coords[1] is latitude, coords[0] is longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(coords[1], coords[0]);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        return [
          place.street,
          place.thoroughfare,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((e) => e != null && e.trim().isNotEmpty).join('، ');
      }
    } catch (e) {
      debugPrint('Error reverse geocoding coordinates $coords: $e');
    }
    return fallbackAddress;
  }

  @override
  State<RouteWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  late Future<String> _pickupAreaFuture;
  late Future<String> _destinationAreaFuture;

  @override
  void initState() {
    super.initState();
    _pickupAreaFuture =
        RouteWidget.getAreaName(widget.pickupCoords, widget.pickupAddress);
    _destinationAreaFuture = RouteWidget.getAreaName(
        widget.destinationCoords, widget.destinationAddress);
  }

  @override
  void didUpdateWidget(RouteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pickupAddress != oldWidget.pickupAddress ||
        widget.pickupCoords != oldWidget.pickupCoords) {
      _pickupAreaFuture =
          RouteWidget.getAreaName(widget.pickupCoords, widget.pickupAddress);
    }
    if (widget.destinationAddress != oldWidget.destinationAddress ||
        widget.destinationCoords != oldWidget.destinationCoords) {
      _destinationAreaFuture = RouteWidget.getAreaName(
          widget.destinationCoords, widget.destinationAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (riderController) {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraSmall),
          child: Column(children: [
            SizedBox(
                width: Dimensions.iconSizeMedium,
                child: Image.asset(Images.currentLocation)),
            if ((widget.extraOne != null && widget.extraOne!.isNotEmpty) ||
                (widget.extraTwo != null && widget.extraTwo!.isNotEmpty))
              SizedBox(
                  height: 65,
                  width: 10,
                  child: DividerWidget(
                    height: 2,
                    dashWidth: 1,
                    axis: Axis.vertical,
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                  )),
            if ((widget.extraOne != null && widget.extraOne!.isNotEmpty) ||
                (widget.extraTwo != null && widget.extraTwo!.isNotEmpty))
              SizedBox(
                  width: Dimensions.iconSizeMedium,
                  child: Image.asset(Images.customerRouteIcon)),
            SizedBox(
                height: 65,
                width: 10,
                child: DividerWidget(
                  height: 2,
                  dashWidth: 1,
                  axis: Axis.vertical,
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                )),
            SizedBox(
                width: Dimensions.iconSizeMedium,
                child: Image.asset(Images.customerDestinationIcon)),
          ]),
        ),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              height: 40,
              child: FutureBuilder<String>(
                future: _pickupAreaFuture,
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? widget.pickupAddress,
                    style: textRegular.copyWith(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              )),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          if (widget.extraOne != null && widget.extraOne!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
              child: Text(widget.extraOne!,
                  style: textRegular.copyWith(
                    color: Theme.of(Get.context!).primaryColor.withOpacity(.75),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                  overflow: TextOverflow.ellipsis),
            ),
          if ((widget.extraOne != null && widget.extraOne!.isNotEmpty) ||
              (widget.extraTwo != null && widget.extraTwo!.isNotEmpty))
            const Padding(
              padding: EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
              child: SizedBox(
                height: 20,
                width: 10,
                child:
                    DividerWidget(height: 2, dashWidth: 1, axis: Axis.vertical),
              ),
            ),
          if (widget.extraTwo != null && widget.extraOne!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
              child: Text(widget.extraTwo!,
                  style: textRegular.copyWith(
                    color: Theme.of(Get.context!).primaryColor.withOpacity(.75),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                  overflow: TextOverflow.ellipsis),
            ),
          if (widget.extraOne != null || widget.extraTwo != null)
            const SizedBox(height: Dimensions.paddingSizeSmall),
          Padding(
            padding: EdgeInsets.only(
              top: widget.fromCard
                  ? Dimensions.paddingSizeSmall
                  : Dimensions.paddingSizeLarge,
            ),
            child: FutureBuilder<String>(
              future: _destinationAreaFuture,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? widget.destinationAddress,
                  style: textRegular.copyWith(),
                );
              },
            ),
          ),
          if (widget.entrance != null && widget.entrance!.isNotEmpty)
            Divider(color: Theme.of(context).hintColor),
          if (widget.entrance != null && widget.entrance!.isNotEmpty)
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              SizedBox(height: 25, child: Image.asset(Images.curvedArrow)),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Container(
                transform: Matrix4.translationValues(0, 10, 0),
                child: Text(widget.entrance!,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault)),
              ),
            ]),
        ])),
      ]);
    });
  }
}
