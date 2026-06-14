// To parse this JSON data, do
//
//     final scheduleResponse = scheduleResponseFromJson(jsonString);

import 'dart:convert';

ScheduleResponse scheduleResponseFromJson(String str) =>
    ScheduleResponse.fromJson(json.decode(str));

String scheduleResponseToJson(ScheduleResponse data) =>
    json.encode(data.toJson());

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

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      ScheduleResponse(
        responseCode: json["response_code"]?.toString(),
        message: json["message"],
        totalSize: json["total_size"] is int
            ? json["total_size"]
            : int.tryParse(json["total_size"]?.toString() ?? ''),
        limit: json["limit"]?.toString(),
        offset: json["offset"]?.toString(),
        data: json["data"] == null
            ? null
            : json["data"] is List
                ? Data(
                    data: List<ScheduleTrip>.from(
                      (json["data"] as List).map(
                        (x) => ScheduleTrip.fromJson(x as Map<String, dynamic>),
                      ),
                    ),
                  )
                : Data.fromJson(json["data"]),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "data": data?.toJson(),
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
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
        data: json["data"] == null
            ? []
            : List<ScheduleTrip>.from(
                json["data"]!.map((x) => ScheduleTrip.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
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
  final Customer? customer;

  ScheduleTrip(
      {this.id,
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
      this.customer});

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
    Customer? customer,
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
        tripCancellationReason:
            tripCancellationReason ?? this.tripCancellationReason,
        coordinate: coordinate ?? this.coordinate,
        customer: customer ?? this.customer,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isPaused: json["is_paused"],
        isScheduled: json["is_scheduled"],
        mapScreenshot: json["map_screenshot"],
        tripCancellationReason: json["trip_cancellation_reason"],
        coordinate: json["coordinate"] != null
            ? Coordinate.fromJson(json["coordinate"])
            : (json["pickup_address"] != null || json["destination_address"] != null)
                ? Coordinate.fromJson(json)
                : null,
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
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
        "customer": customer?.toJson(),
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
        destinationCoordinates:
            destinationCoordinates ?? this.destinationCoordinates,
        isReachedDestination: isReachedDestination ?? this.isReachedDestination,
        destinationAddress: destinationAddress ?? this.destinationAddress,
        intermediateCoordinates:
            intermediateCoordinates ?? this.intermediateCoordinates,
        intCoordinate1: intCoordinate1 ?? this.intCoordinate1,
        isReached1: isReached1 ?? this.isReached1,
        intCoordinate2: intCoordinate2 ?? this.intCoordinate2,
        isReached2: isReached2 ?? this.isReached2,
        intermediateAddresses:
            intermediateAddresses ?? this.intermediateAddresses,
        startCoordinates: startCoordinates ?? this.startCoordinates,
        dropCoordinates: dropCoordinates ?? this.dropCoordinates,
        driverAcceptCoordinates:
            driverAcceptCoordinates ?? this.driverAcceptCoordinates,
        customerRequestCoordinates:
            customerRequestCoordinates ?? this.customerRequestCoordinates,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        id: json["id"] is int ? json["id"] : int.tryParse(json["id"]?.toString() ?? ''),
        tripRequestId: json["trip_request_id"],
        pickupCoordinates: json["pickup_coordinates"] == null
            ? null
            : Coordinates.fromJson(json["pickup_coordinates"]),
        pickupAddress: json["pickup_address"],
        destinationCoordinates: json["destination_coordinates"] == null
            ? null
            : Coordinates.fromJson(json["destination_coordinates"]),
        isReachedDestination: json["is_reached_destination"],
        destinationAddress: json["destination_address"],
        intermediateCoordinates: json["intermediate_coordinates"],
        intCoordinate1: json["int_coordinate_1"],
        isReached1: json["is_reached_1"],
        intCoordinate2: json["int_coordinate_2"],
        isReached2: json["is_reached_2"],
        intermediateAddresses: json["intermediate_addresses"],
        startCoordinates: json["start_coordinates"] == null
            ? null
            : Coordinates.fromJson(json["start_coordinates"]),
        dropCoordinates: json["drop_coordinates"],
        driverAcceptCoordinates: json["driver_accept_coordinates"],
        customerRequestCoordinates: json["customer_request_coordinates"] == null
            ? null
            : Coordinates.fromJson(json["customer_request_coordinates"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
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

class Customer {
  final String? id;
  final String? fullName;
  final String? userLevelId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? identificationNumber;
  final String? identificationType;
  final List<String>? identificationImage;
  final String? oldIdentificationImage;
  final dynamic otherDocuments;
  final String? profileImage;
  final String? fcmToken;
  final String? phoneVerifiedAt;
  final String? emailVerifiedAt;
  final int? loyaltyPoints;
  final String? password;
  final String? refCode;
  final String? userType;
  final String? roleId;
  final String? rememberToken;
  final int? isActive;
  final String? currentLanguageKey;
  final String? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? failedAttempt;
  final int? isTempBlocked;
  final String? blockedAt;

  Customer({
    this.id,
    this.fullName,
    this.userLevelId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.identificationNumber,
    this.identificationType,
    this.identificationImage,
    this.oldIdentificationImage,
    this.otherDocuments,
    this.profileImage,
    this.fcmToken,
    this.phoneVerifiedAt,
    this.emailVerifiedAt,
    this.loyaltyPoints,
    this.password,
    this.refCode,
    this.userType,
    this.roleId,
    this.rememberToken,
    this.isActive,
    this.currentLanguageKey,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.failedAttempt,
    this.isTempBlocked,
    this.blockedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        fullName: json["full_name"],
        userLevelId: json["user_level_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        identificationNumber: json["identification_number"],
        identificationType: json["identification_type"],
        identificationImage: json["identification_image"] == null
            ? []
            : List<String>.from(json["identification_image"]!.map((x) => x)),
        oldIdentificationImage: json["old_identification_image"],
        otherDocuments: json["other_documents"],
        profileImage: json["profile_image"],
        fcmToken: json["fcm_token"],
        phoneVerifiedAt: json["phone_verified_at"],
        emailVerifiedAt: json["email_verified_at"],
        loyaltyPoints: json["loyalty_points"],
        password: json["password"],
        refCode: json["ref_code"],
        userType: json["user_type"],
        roleId: json["role_id"],
        rememberToken: json["remember_token"],
        isActive: json["is_active"],
        currentLanguageKey: json["current_language_key"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        failedAttempt: json["failed_attempt"],
        isTempBlocked: json["is_temp_blocked"],
        blockedAt: json["blocked_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "user_level_id": userLevelId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "identification_number": identificationNumber,
        "identification_type": identificationType,
        "identification_image": identificationImage == null
            ? []
            : List<dynamic>.from(identificationImage!.map((x) => x)),
        "old_identification_image": oldIdentificationImage,
        "other_documents": otherDocuments,
        "profile_image": profileImage,
        "fcm_token": fcmToken,
        "phone_verified_at": phoneVerifiedAt,
        "email_verified_at": emailVerifiedAt,
        "loyalty_points": loyaltyPoints,
        "password": password,
        "ref_code": refCode,
        "user_type": userType,
        "role_id": roleId,
        "remember_token": rememberToken,
        "is_active": isActive,
        "current_language_key": currentLanguageKey,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "failed_attempt": failedAttempt,
        "is_temp_blocked": isTempBlocked,
        "blocked_at": blockedAt,
      };
}
