// To parse this JSON data, do
//
//     final scheduleResponse = scheduleResponseFromJson(jsonString);

import 'dart:convert';

ScheduleResponse scheduleResponseFromJson(String str) => ScheduleResponse.fromJson(json.decode(str));

String scheduleResponseToJson(ScheduleResponse data) => json.encode(data.toJson());

class ScheduleResponse {
    final String? responseCode;
    final String? message;
    final int? totalSize;
    final String? limit;
    final String? offset;
    final Data? data;
    final List<dynamic>? errors;

    ScheduleResponse({
        this.responseCode,
        this.message,
        this.totalSize,
        this.limit,
        this.offset,
        this.data,
        this.errors,
    });

    ScheduleResponse copyWith({
        String? responseCode,
        String? message,
        int? totalSize,
        String? limit,
        String? offset,
        Data? data,
        List<dynamic>? errors,
    }) => 
        ScheduleResponse(
            responseCode: responseCode ?? this.responseCode,
            message: message ?? this.message,
            totalSize: totalSize ?? this.totalSize,
            limit: limit ?? this.limit,
            offset: offset ?? this.offset,
            data: data ?? this.data,
            errors: errors ?? this.errors,
        );

    factory ScheduleResponse.fromJson(Map<String, dynamic> json) => ScheduleResponse(
        responseCode: json["response_code"],
        message: json["message"],
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "data": data?.toJson(),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

class Data {
    final int? currentPage;
    final List<ScheduleTrip>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    Data copyWith({
        int? currentPage,
        List<ScheduleTrip>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<Link>? links,
        dynamic nextPageUrl,
        String? path,
        int? perPage,
        dynamic prevPageUrl,
        int? to,
        int? total,
    }) => 
        Data(
            currentPage: currentPage ?? this.currentPage,
            data: data ?? this.data,
            firstPageUrl: firstPageUrl ?? this.firstPageUrl,
            from: from ?? this.from,
            lastPage: lastPage ?? this.lastPage,
            lastPageUrl: lastPageUrl ?? this.lastPageUrl,
            links: links ?? this.links,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            path: path ?? this.path,
            perPage: perPage ?? this.perPage,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
            to: to ?? this.to,
            total: total ?? this.total,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ScheduleTrip>.from(json["data"]!.map((x) => ScheduleTrip.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class ScheduleTrip {
    final String? id;
    final String? refId;
    final String? customerId;
    final dynamic driverId;
    final String? vehicleCategoryId;
    final dynamic vehicleId;
    final String? zoneId;
    final dynamic areaId;
    final int? estimatedFare;
    final int? actualFare;
    final double? estimatedDistance;
    final int? paidFare;
    final int? returnFee;
    final int? cancellationFee;
    final int? extraFareFee;
    final int? extraFareAmount;
    final dynamic returnTime;
    final int? dueAmount;
    final dynamic actualDistance;
    final String? encodedPolyline;
    final dynamic acceptedBy;
    final String? paymentMethod;
    final String? paymentStatus;
    final dynamic couponId;
    final dynamic couponAmount;
    final dynamic discountId;
    final dynamic discountAmount;
    final dynamic note;
    final dynamic entrance;
    final dynamic otp;
    final int? riseRequestCount;
    final String? type;
    final String? currentStatus;
    final int? checked;
    final int? tips;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isPaused;
    final bool? isScheduled;
    final dynamic mapScreenshot;
    final dynamic tripCancellationReason;
    final Coordinate? coordinate;

    ScheduleTrip({
        this.id,
        this.refId,
        this.customerId,
        this.driverId,
        this.vehicleCategoryId,
        this.vehicleId,
        this.zoneId,
        this.areaId,
        this.estimatedFare,
        this.actualFare,
        this.estimatedDistance,
        this.paidFare,
        this.returnFee,
        this.cancellationFee,
        this.extraFareFee,
        this.extraFareAmount,
        this.returnTime,
        this.dueAmount,
        this.actualDistance,
        this.encodedPolyline,
        this.acceptedBy,
        this.paymentMethod,
        this.paymentStatus,
        this.couponId,
        this.couponAmount,
        this.discountId,
        this.discountAmount,
        this.note,
        this.entrance,
        this.otp,
        this.riseRequestCount,
        this.type,
        this.currentStatus,
        this.checked,
        this.tips,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.isPaused,
        this.isScheduled,
        this.mapScreenshot,
        this.tripCancellationReason,
        this.coordinate,
    });

    ScheduleTrip copyWith({
        String? id,
        String? refId,
        String? customerId,
        dynamic driverId,
        String? vehicleCategoryId,
        dynamic vehicleId,
        String? zoneId,
        dynamic areaId,
        int? estimatedFare,
        int? actualFare,
        double? estimatedDistance,
        int? paidFare,
        int? returnFee,
        int? cancellationFee,
        int? extraFareFee,
        int? extraFareAmount,
        dynamic returnTime,
        int? dueAmount,
        dynamic actualDistance,
        String? encodedPolyline,
        dynamic acceptedBy,
        String? paymentMethod,
        String? paymentStatus,
        dynamic couponId,
        dynamic couponAmount,
        dynamic discountId,
        dynamic discountAmount,
        dynamic note,
        dynamic entrance,
        dynamic otp,
        int? riseRequestCount,
        String? type,
        String? currentStatus,
        int? checked,
        int? tips,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? isPaused,
        bool? isScheduled,
        dynamic mapScreenshot,
        dynamic tripCancellationReason,
        Coordinate? coordinate,
    }) => 
        ScheduleTrip(
            id: id ?? this.id,
            refId: refId ?? this.refId,
            customerId: customerId ?? this.customerId,
            driverId: driverId ?? this.driverId,
            vehicleCategoryId: vehicleCategoryId ?? this.vehicleCategoryId,
            vehicleId: vehicleId ?? this.vehicleId,
            zoneId: zoneId ?? this.zoneId,
            areaId: areaId ?? this.areaId,
            estimatedFare: estimatedFare ?? this.estimatedFare,
            actualFare: actualFare ?? this.actualFare,
            estimatedDistance: estimatedDistance ?? this.estimatedDistance,
            paidFare: paidFare ?? this.paidFare,
            returnFee: returnFee ?? this.returnFee,
            cancellationFee: cancellationFee ?? this.cancellationFee,
            extraFareFee: extraFareFee ?? this.extraFareFee,
            extraFareAmount: extraFareAmount ?? this.extraFareAmount,
            returnTime: returnTime ?? this.returnTime,
            dueAmount: dueAmount ?? this.dueAmount,
            actualDistance: actualDistance ?? this.actualDistance,
            encodedPolyline: encodedPolyline ?? this.encodedPolyline,
            acceptedBy: acceptedBy ?? this.acceptedBy,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            paymentStatus: paymentStatus ?? this.paymentStatus,
            couponId: couponId ?? this.couponId,
            couponAmount: couponAmount ?? this.couponAmount,
            discountId: discountId ?? this.discountId,
            discountAmount: discountAmount ?? this.discountAmount,
            note: note ?? this.note,
            entrance: entrance ?? this.entrance,
            otp: otp ?? this.otp,
            riseRequestCount: riseRequestCount ?? this.riseRequestCount,
            type: type ?? this.type,
            currentStatus: currentStatus ?? this.currentStatus,
            checked: checked ?? this.checked,
            tips: tips ?? this.tips,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            isPaused: isPaused ?? this.isPaused,
            isScheduled: isScheduled ?? this.isScheduled,
            mapScreenshot: mapScreenshot ?? this.mapScreenshot,
            tripCancellationReason: tripCancellationReason ?? this.tripCancellationReason,
            coordinate: coordinate ?? this.coordinate,
        );

    factory ScheduleTrip.fromJson(Map<String, dynamic> json) => ScheduleTrip(
        id: json["id"],
        refId: json["ref_id"],
        customerId: json["customer_id"],
        driverId: json["driver_id"],
        vehicleCategoryId: json["vehicle_category_id"],
        vehicleId: json["vehicle_id"],
        zoneId: json["zone_id"],
        areaId: json["area_id"],
        estimatedFare: json["estimated_fare"],
        actualFare: json["actual_fare"],
        estimatedDistance: json["estimated_distance"]?.toDouble(),
        paidFare: json["paid_fare"],
        returnFee: json["return_fee"],
        cancellationFee: json["cancellation_fee"],
        extraFareFee: json["extra_fare_fee"],
        extraFareAmount: json["extra_fare_amount"],
        returnTime: json["return_time"],
        dueAmount: json["due_amount"],
        actualDistance: json["actual_distance"],
        encodedPolyline: json["encoded_polyline"],
        acceptedBy: json["accepted_by"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        couponId: json["coupon_id"],
        couponAmount: json["coupon_amount"],
        discountId: json["discount_id"],
        discountAmount: json["discount_amount"],
        note: json["note"],
        entrance: json["entrance"],
        otp: json["otp"],
        riseRequestCount: json["rise_request_count"],
        type: json["type"],
        currentStatus: json["current_status"],
        checked: json["checked"],
        tips: json["tips"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isPaused: json["is_paused"],
        isScheduled: json["is_scheduled"],
        mapScreenshot: json["map_screenshot"],
        tripCancellationReason: json["trip_cancellation_reason"],
        coordinate: json["coordinate"] == null ? null : Coordinate.fromJson(json["coordinate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ref_id": refId,
        "customer_id": customerId,
        "driver_id": driverId,
        "vehicle_category_id": vehicleCategoryId,
        "vehicle_id": vehicleId,
        "zone_id": zoneId,
        "area_id": areaId,
        "estimated_fare": estimatedFare,
        "actual_fare": actualFare,
        "estimated_distance": estimatedDistance,
        "paid_fare": paidFare,
        "return_fee": returnFee,
        "cancellation_fee": cancellationFee,
        "extra_fare_fee": extraFareFee,
        "extra_fare_amount": extraFareAmount,
        "return_time": returnTime,
        "due_amount": dueAmount,
        "actual_distance": actualDistance,
        "encoded_polyline": encodedPolyline,
        "accepted_by": acceptedBy,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "coupon_id": couponId,
        "coupon_amount": couponAmount,
        "discount_id": discountId,
        "discount_amount": discountAmount,
        "note": note,
        "entrance": entrance,
        "otp": otp,
        "rise_request_count": riseRequestCount,
        "type": type,
        "current_status": currentStatus,
        "checked": checked,
        "tips": tips,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_paused": isPaused,
        "is_scheduled": isScheduled,
        "map_screenshot": mapScreenshot,
        "trip_cancellation_reason": tripCancellationReason,
        "coordinate": coordinate?.toJson(),
    };
}

class Coordinate {
    final int? id;
    final String? tripRequestId;
    final Coordinates? pickupCoordinates;
    final String? pickupAddress;
    final Coordinates? destinationCoordinates;
    final bool? isReachedDestination;
    final String? destinationAddress;
    final dynamic intermediateCoordinates;
    final dynamic intCoordinate1;
    final bool? isReached1;
    final dynamic intCoordinate2;
    final bool? isReached2;
    final String? intermediateAddresses;
    final Coordinates? startCoordinates;
    final dynamic dropCoordinates;
    final dynamic driverAcceptCoordinates;
    final Coordinates? customerRequestCoordinates;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Coordinate({
        this.id,
        this.tripRequestId,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.isReachedDestination,
        this.destinationAddress,
        this.intermediateCoordinates,
        this.intCoordinate1,
        this.isReached1,
        this.intCoordinate2,
        this.isReached2,
        this.intermediateAddresses,
        this.startCoordinates,
        this.dropCoordinates,
        this.driverAcceptCoordinates,
        this.customerRequestCoordinates,
        this.createdAt,
        this.updatedAt,
    });

    Coordinate copyWith({
        int? id,
        String? tripRequestId,
        Coordinates? pickupCoordinates,
        String? pickupAddress,
        Coordinates? destinationCoordinates,
        bool? isReachedDestination,
        String? destinationAddress,
        dynamic intermediateCoordinates,
        dynamic intCoordinate1,
        bool? isReached1,
        dynamic intCoordinate2,
        bool? isReached2,
        String? intermediateAddresses,
        Coordinates? startCoordinates,
        dynamic dropCoordinates,
        dynamic driverAcceptCoordinates,
        Coordinates? customerRequestCoordinates,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Coordinate(
            id: id ?? this.id,
            tripRequestId: tripRequestId ?? this.tripRequestId,
            pickupCoordinates: pickupCoordinates ?? this.pickupCoordinates,
            pickupAddress: pickupAddress ?? this.pickupAddress,
            destinationCoordinates: destinationCoordinates ?? this.destinationCoordinates,
            isReachedDestination: isReachedDestination ?? this.isReachedDestination,
            destinationAddress: destinationAddress ?? this.destinationAddress,
            intermediateCoordinates: intermediateCoordinates ?? this.intermediateCoordinates,
            intCoordinate1: intCoordinate1 ?? this.intCoordinate1,
            isReached1: isReached1 ?? this.isReached1,
            intCoordinate2: intCoordinate2 ?? this.intCoordinate2,
            isReached2: isReached2 ?? this.isReached2,
            intermediateAddresses: intermediateAddresses ?? this.intermediateAddresses,
            startCoordinates: startCoordinates ?? this.startCoordinates,
            dropCoordinates: dropCoordinates ?? this.dropCoordinates,
            driverAcceptCoordinates: driverAcceptCoordinates ?? this.driverAcceptCoordinates,
            customerRequestCoordinates: customerRequestCoordinates ?? this.customerRequestCoordinates,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        id: json["id"],
        tripRequestId: json["trip_request_id"],
        pickupCoordinates: json["pickup_coordinates"] == null ? null : Coordinates.fromJson(json["pickup_coordinates"]),
        pickupAddress: json["pickup_address"],
        destinationCoordinates: json["destination_coordinates"] == null ? null : Coordinates.fromJson(json["destination_coordinates"]),
        isReachedDestination: json["is_reached_destination"],
        destinationAddress: json["destination_address"],
        intermediateCoordinates: json["intermediate_coordinates"],
        intCoordinate1: json["int_coordinate_1"],
        isReached1: json["is_reached_1"],
        intCoordinate2: json["int_coordinate_2"],
        isReached2: json["is_reached_2"],
        intermediateAddresses: json["intermediate_addresses"],
        startCoordinates: json["start_coordinates"] == null ? null : Coordinates.fromJson(json["start_coordinates"]),
        dropCoordinates: json["drop_coordinates"],
        driverAcceptCoordinates: json["driver_accept_coordinates"],
        customerRequestCoordinates: json["customer_request_coordinates"] == null ? null : Coordinates.fromJson(json["customer_request_coordinates"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "trip_request_id": tripRequestId,
        "pickup_coordinates": pickupCoordinates?.toJson(),
        "pickup_address": pickupAddress,
        "destination_coordinates": destinationCoordinates?.toJson(),
        "is_reached_destination": isReachedDestination,
        "destination_address": destinationAddress,
        "intermediate_coordinates": intermediateCoordinates,
        "int_coordinate_1": intCoordinate1,
        "is_reached_1": isReached1,
        "int_coordinate_2": intCoordinate2,
        "is_reached_2": isReached2,
        "intermediate_addresses": intermediateAddresses,
        "start_coordinates": startCoordinates?.toJson(),
        "drop_coordinates": dropCoordinates,
        "driver_accept_coordinates": driverAcceptCoordinates,
        "customer_request_coordinates": customerRequestCoordinates?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Coordinates {
    final String? type;
    final List<double>? coordinates;

    Coordinates({
        this.type,
        this.coordinates,
    });

    Coordinates copyWith({
        String? type,
        List<double>? coordinates,
    }) => 
        Coordinates(
            type: type ?? this.type,
            coordinates: coordinates ?? this.coordinates,
        );

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class Link {
    final String? url;
    final String? label;
    final bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    Link copyWith({
        String? url,
        String? label,
        bool? active,
    }) => 
        Link(
            url: url ?? this.url,
            label: label ?? this.label,
            active: active ?? this.active,
        );

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
