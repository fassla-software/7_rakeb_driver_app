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
    final List<ScheduleTrip>? data;
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
        List<ScheduleTrip>? data,
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
        data: json["data"] == null ? [] : List<ScheduleTrip>.from(json["data"]!.map((x) => ScheduleTrip.fromJson(x))),
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

class ScheduleTrip {
    final String? id;
    final String? refId;
    final Customer? customer;
    final dynamic driver;
    final int? estimatedFare;
    final int? actualFare;
    final int? returnFee;
    final dynamic returnTime;
    final int? dueAmount;
    final int? discountActualFare;
    final double? estimatedDistance;
    final int? paidFare;
    final int? actualDistance;
    final dynamic acceptedBy;
    final String? paymentStatus;
    final String? paymentMethod;
    final int? couponAmount;
    final dynamic discount;
    final dynamic discountAmount;
    final dynamic note;
    final dynamic otp;
    final int? riseRequestCount;
    final String? type;
    final DateTime? createdAt;
    final dynamic entrance;
    final String? encodedPolyline;
    final bool? customerReview;
    final bool? driverReview;
    final dynamic customerAvgRating;
    final dynamic driverAvgRating;
    final String? currentStatus;
    final bool? isPaused;
    final List<dynamic>? fareBiddings;
    final dynamic parcelInformation;
    final dynamic coupon;
    final dynamic screenshot;
    final dynamic parcelCompleteTime;
    final dynamic parcelRefund;
    final Coordinates? pickupCoordinates;
    final String? pickupAddress;
    final Coordinates? destinationCoordinates;
    final String? destinationAddress;
    final Coordinates? startCoordinates;
    final dynamic dropCoordinates;
    final dynamic driverAcceptCoordinates;
    final Coordinates? customerRequestCoordinates;
    final String? intermediateCoordinates;
    final String? intermediateAddresses;
    final bool? isReachedDestination;
    final bool? isReached1;
    final bool? isReached2;
    final int? waitingFee;
    final dynamic waitedBy;
    final int? idleFee;
    final int? delayFee;
    final dynamic delayedBy;
    final int? cancellationFee;
    final dynamic cancelledBy;
    final int? vatTax;
    final int? adminCommission;
    final int? tips;
    final int? waitingTime;
    final int? delayTime;
    final int? idleTime;
    final int? actualTime;
    final double? estimatedTime;

    ScheduleTrip({
        this.id,
        this.refId,
        this.customer,
        this.driver,
        this.estimatedFare,
        this.actualFare,
        this.returnFee,
        this.returnTime,
        this.dueAmount,
        this.discountActualFare,
        this.estimatedDistance,
        this.paidFare,
        this.actualDistance,
        this.acceptedBy,
        this.paymentStatus,
        this.paymentMethod,
        this.couponAmount,
        this.discount,
        this.discountAmount,
        this.note,
        this.otp,
        this.riseRequestCount,
        this.type,
        this.createdAt,
        this.entrance,
        this.encodedPolyline,
        this.customerReview,
        this.driverReview,
        this.customerAvgRating,
        this.driverAvgRating,
        this.currentStatus,
        this.isPaused,
        this.fareBiddings,
        this.parcelInformation,
        this.coupon,
        this.screenshot,
        this.parcelCompleteTime,
        this.parcelRefund,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
        this.startCoordinates,
        this.dropCoordinates,
        this.driverAcceptCoordinates,
        this.customerRequestCoordinates,
        this.intermediateCoordinates,
        this.intermediateAddresses,
        this.isReachedDestination,
        this.isReached1,
        this.isReached2,
        this.waitingFee,
        this.waitedBy,
        this.idleFee,
        this.delayFee,
        this.delayedBy,
        this.cancellationFee,
        this.cancelledBy,
        this.vatTax,
        this.adminCommission,
        this.tips,
        this.waitingTime,
        this.delayTime,
        this.idleTime,
        this.actualTime,
        this.estimatedTime,
    });

    ScheduleTrip copyWith({
        String? id,
        String? refId,
        Customer? customer,
        dynamic driver,
        int? estimatedFare,
        int? actualFare,
        int? returnFee,
        dynamic returnTime,
        int? dueAmount,
        int? discountActualFare,
        double? estimatedDistance,
        int? paidFare,
        int? actualDistance,
        dynamic acceptedBy,
        String? paymentStatus,
        String? paymentMethod,
        int? couponAmount,
        dynamic discount,
        dynamic discountAmount,
        dynamic note,
        dynamic otp,
        int? riseRequestCount,
        String? type,
        DateTime? createdAt,
        dynamic entrance,
        String? encodedPolyline,
        bool? customerReview,
        bool? driverReview,
        dynamic customerAvgRating,
        dynamic driverAvgRating,
        String? currentStatus,
        bool? isPaused,
        List<dynamic>? fareBiddings,
        dynamic parcelInformation,
        dynamic coupon,
        dynamic screenshot,
        dynamic parcelCompleteTime,
        dynamic parcelRefund,
        Coordinates? pickupCoordinates,
        String? pickupAddress,
        Coordinates? destinationCoordinates,
        String? destinationAddress,
        Coordinates? startCoordinates,
        dynamic dropCoordinates,
        dynamic driverAcceptCoordinates,
        Coordinates? customerRequestCoordinates,
        String? intermediateCoordinates,
        String? intermediateAddresses,
        bool? isReachedDestination,
        bool? isReached1,
        bool? isReached2,
        int? waitingFee,
        dynamic waitedBy,
        int? idleFee,
        int? delayFee,
        dynamic delayedBy,
        int? cancellationFee,
        dynamic cancelledBy,
        int? vatTax,
        int? adminCommission,
        int? tips,
        int? waitingTime,
        int? delayTime,
        int? idleTime,
        int? actualTime,
        double? estimatedTime,
    }) => 
        ScheduleTrip(
            id: id ?? this.id,
            refId: refId ?? this.refId,
            customer: customer ?? this.customer,
            driver: driver ?? this.driver,
            estimatedFare: estimatedFare ?? this.estimatedFare,
            actualFare: actualFare ?? this.actualFare,
            returnFee: returnFee ?? this.returnFee,
            returnTime: returnTime ?? this.returnTime,
            dueAmount: dueAmount ?? this.dueAmount,
            discountActualFare: discountActualFare ?? this.discountActualFare,
            estimatedDistance: estimatedDistance ?? this.estimatedDistance,
            paidFare: paidFare ?? this.paidFare,
            actualDistance: actualDistance ?? this.actualDistance,
            acceptedBy: acceptedBy ?? this.acceptedBy,
            paymentStatus: paymentStatus ?? this.paymentStatus,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            couponAmount: couponAmount ?? this.couponAmount,
            discount: discount ?? this.discount,
            discountAmount: discountAmount ?? this.discountAmount,
            note: note ?? this.note,
            otp: otp ?? this.otp,
            riseRequestCount: riseRequestCount ?? this.riseRequestCount,
            type: type ?? this.type,
            createdAt: createdAt ?? this.createdAt,
            entrance: entrance ?? this.entrance,
            encodedPolyline: encodedPolyline ?? this.encodedPolyline,
            customerReview: customerReview ?? this.customerReview,
            driverReview: driverReview ?? this.driverReview,
            customerAvgRating: customerAvgRating ?? this.customerAvgRating,
            driverAvgRating: driverAvgRating ?? this.driverAvgRating,
            currentStatus: currentStatus ?? this.currentStatus,
            isPaused: isPaused ?? this.isPaused,
            fareBiddings: fareBiddings ?? this.fareBiddings,
            parcelInformation: parcelInformation ?? this.parcelInformation,
            coupon: coupon ?? this.coupon,
            screenshot: screenshot ?? this.screenshot,
            parcelCompleteTime: parcelCompleteTime ?? this.parcelCompleteTime,
            parcelRefund: parcelRefund ?? this.parcelRefund,
            pickupCoordinates: pickupCoordinates ?? this.pickupCoordinates,
            pickupAddress: pickupAddress ?? this.pickupAddress,
            destinationCoordinates: destinationCoordinates ?? this.destinationCoordinates,
            destinationAddress: destinationAddress ?? this.destinationAddress,
            startCoordinates: startCoordinates ?? this.startCoordinates,
            dropCoordinates: dropCoordinates ?? this.dropCoordinates,
            driverAcceptCoordinates: driverAcceptCoordinates ?? this.driverAcceptCoordinates,
            customerRequestCoordinates: customerRequestCoordinates ?? this.customerRequestCoordinates,
            intermediateCoordinates: intermediateCoordinates ?? this.intermediateCoordinates,
            intermediateAddresses: intermediateAddresses ?? this.intermediateAddresses,
            isReachedDestination: isReachedDestination ?? this.isReachedDestination,
            isReached1: isReached1 ?? this.isReached1,
            isReached2: isReached2 ?? this.isReached2,
            waitingFee: waitingFee ?? this.waitingFee,
            waitedBy: waitedBy ?? this.waitedBy,
            idleFee: idleFee ?? this.idleFee,
            delayFee: delayFee ?? this.delayFee,
            delayedBy: delayedBy ?? this.delayedBy,
            cancellationFee: cancellationFee ?? this.cancellationFee,
            cancelledBy: cancelledBy ?? this.cancelledBy,
            vatTax: vatTax ?? this.vatTax,
            adminCommission: adminCommission ?? this.adminCommission,
            tips: tips ?? this.tips,
            waitingTime: waitingTime ?? this.waitingTime,
            delayTime: delayTime ?? this.delayTime,
            idleTime: idleTime ?? this.idleTime,
            actualTime: actualTime ?? this.actualTime,
            estimatedTime: estimatedTime ?? this.estimatedTime,
        );

    factory ScheduleTrip.fromJson(Map<String, dynamic> json) => ScheduleTrip(
        id: json["id"],
        refId: json["ref_id"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        driver: json["driver"],
        estimatedFare: json["estimated_fare"],
        actualFare: json["actual_fare"],
        returnFee: json["return_fee"],
        returnTime: json["return_time"],
        dueAmount: json["due_amount"],
        discountActualFare: json["discount_actual_fare"],
        estimatedDistance: json["estimated_distance"]?.toDouble(),
        paidFare: json["paid_fare"],
        actualDistance: json["actual_distance"],
        acceptedBy: json["accepted_by"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        couponAmount: json["coupon_amount"],
        discount: json["discount"],
        discountAmount: json["discount_amount"],
        note: json["note"],
        otp: json["otp"],
        riseRequestCount: json["rise_request_count"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        entrance: json["entrance"],
        encodedPolyline: json["encoded_polyline"],
        customerReview: json["customer_review"],
        driverReview: json["driver_review"],
        customerAvgRating: json["customer_avg_rating"],
        driverAvgRating: json["driver_avg_rating"],
        currentStatus: json["current_status"],
        isPaused: json["is_paused"],
        fareBiddings: json["fare_biddings"] == null ? [] : List<dynamic>.from(json["fare_biddings"]!.map((x) => x)),
        parcelInformation: json["parcel_information"],
        coupon: json["coupon"],
        screenshot: json["screenshot"],
        parcelCompleteTime: json["parcel_complete_time"],
        parcelRefund: json["parcel_refund"],
        pickupCoordinates: json["pickup_coordinates"] == null ? null : Coordinates.fromJson(json["pickup_coordinates"]),
        pickupAddress: json["pickup_address"],
        destinationCoordinates: json["destination_coordinates"] == null ? null : Coordinates.fromJson(json["destination_coordinates"]),
        destinationAddress: json["destination_address"],
        startCoordinates: json["start_coordinates"] == null ? null : Coordinates.fromJson(json["start_coordinates"]),
        dropCoordinates: json["drop_coordinates"],
        driverAcceptCoordinates: json["driver_accept_coordinates"],
        customerRequestCoordinates: json["customer_request_coordinates"] == null ? null : Coordinates.fromJson(json["customer_request_coordinates"]),
        intermediateCoordinates: json["intermediate_coordinates"],
        intermediateAddresses: json["intermediate_addresses"],
        isReachedDestination: json["is_reached_destination"],
        isReached1: json["is_reached_1"],
        isReached2: json["is_reached_2"],
        waitingFee: json["waiting_fee"],
        waitedBy: json["waited_by"],
        idleFee: json["idle_fee"],
        delayFee: json["delay_fee"],
        delayedBy: json["delayed_by"],
        cancellationFee: json["cancellation_fee"],
        cancelledBy: json["cancelled_by"],
        vatTax: json["vat_tax"],
        adminCommission: json["admin_commission"],
        tips: json["tips"],
        waitingTime: json["waiting_time"],
        delayTime: json["delay_time"],
        idleTime: json["idle_time"],
        actualTime: json["actual_time"],
        estimatedTime: json["estimated_time"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ref_id": refId,
        "customer": customer?.toJson(),
        "driver": driver,
        "estimated_fare": estimatedFare,
        "actual_fare": actualFare,
        "return_fee": returnFee,
        "return_time": returnTime,
        "due_amount": dueAmount,
        "discount_actual_fare": discountActualFare,
        "estimated_distance": estimatedDistance,
        "paid_fare": paidFare,
        "actual_distance": actualDistance,
        "accepted_by": acceptedBy,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "coupon_amount": couponAmount,
        "discount": discount,
        "discount_amount": discountAmount,
        "note": note,
        "otp": otp,
        "rise_request_count": riseRequestCount,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "entrance": entrance,
        "encoded_polyline": encodedPolyline,
        "customer_review": customerReview,
        "driver_review": driverReview,
        "customer_avg_rating": customerAvgRating,
        "driver_avg_rating": driverAvgRating,
        "current_status": currentStatus,
        "is_paused": isPaused,
        "fare_biddings": fareBiddings == null ? [] : List<dynamic>.from(fareBiddings!.map((x) => x)),
        "parcel_information": parcelInformation,
        "coupon": coupon,
        "screenshot": screenshot,
        "parcel_complete_time": parcelCompleteTime,
        "parcel_refund": parcelRefund,
        "pickup_coordinates": pickupCoordinates?.toJson(),
        "pickup_address": pickupAddress,
        "destination_coordinates": destinationCoordinates?.toJson(),
        "destination_address": destinationAddress,
        "start_coordinates": startCoordinates?.toJson(),
        "drop_coordinates": dropCoordinates,
        "driver_accept_coordinates": driverAcceptCoordinates,
        "customer_request_coordinates": customerRequestCoordinates?.toJson(),
        "intermediate_coordinates": intermediateCoordinates,
        "intermediate_addresses": intermediateAddresses,
        "is_reached_destination": isReachedDestination,
        "is_reached_1": isReached1,
        "is_reached_2": isReached2,
        "waiting_fee": waitingFee,
        "waited_by": waitedBy,
        "idle_fee": idleFee,
        "delay_fee": delayFee,
        "delayed_by": delayedBy,
        "cancellation_fee": cancellationFee,
        "cancelled_by": cancelledBy,
        "vat_tax": vatTax,
        "admin_commission": adminCommission,
        "tips": tips,
        "waiting_time": waitingTime,
        "delay_time": delayTime,
        "idle_time": idleTime,
        "actual_time": actualTime,
        "estimated_time": estimatedTime,
    };
}

class Customer {
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? phone;
    final dynamic gender;
    final String? identificationNumber;
    final String? identificationType;
    final List<String>? identificationImage;
    final dynamic otherDocuments;
    final dynamic dateOfBirth;
    final String? profileImage;
    final dynamic fcmToken;
    final dynamic phoneVerifiedAt;
    final dynamic emailVerifiedAt;
    final String? userType;
    final dynamic rememberToken;
    final int? isActive;
    final int? loyaltyPoints;
    final int? isProfileVerified;
    final int? userRating;
    final dynamic totalRideCount;
    final int? completionPercent;
    final dynamic coupon;

    Customer({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.gender,
        this.identificationNumber,
        this.identificationType,
        this.identificationImage,
        this.otherDocuments,
        this.dateOfBirth,
        this.profileImage,
        this.fcmToken,
        this.phoneVerifiedAt,
        this.emailVerifiedAt,
        this.userType,
        this.rememberToken,
        this.isActive,
        this.loyaltyPoints,
        this.isProfileVerified,
        this.userRating,
        this.totalRideCount,
        this.completionPercent,
        this.coupon,
    });

    Customer copyWith({
        String? id,
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        dynamic gender,
        String? identificationNumber,
        String? identificationType,
        List<String>? identificationImage,
        dynamic otherDocuments,
        dynamic dateOfBirth,
        String? profileImage,
        dynamic fcmToken,
        dynamic phoneVerifiedAt,
        dynamic emailVerifiedAt,
        String? userType,
        dynamic rememberToken,
        int? isActive,
        int? loyaltyPoints,
        int? isProfileVerified,
        int? userRating,
        dynamic totalRideCount,
        int? completionPercent,
        dynamic coupon,
    }) => 
        Customer(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            gender: gender ?? this.gender,
            identificationNumber: identificationNumber ?? this.identificationNumber,
            identificationType: identificationType ?? this.identificationType,
            identificationImage: identificationImage ?? this.identificationImage,
            otherDocuments: otherDocuments ?? this.otherDocuments,
            dateOfBirth: dateOfBirth ?? this.dateOfBirth,
            profileImage: profileImage ?? this.profileImage,
            fcmToken: fcmToken ?? this.fcmToken,
            phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            userType: userType ?? this.userType,
            rememberToken: rememberToken ?? this.rememberToken,
            isActive: isActive ?? this.isActive,
            loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
            isProfileVerified: isProfileVerified ?? this.isProfileVerified,
            userRating: userRating ?? this.userRating,
            totalRideCount: totalRideCount ?? this.totalRideCount,
            completionPercent: completionPercent ?? this.completionPercent,
            coupon: coupon ?? this.coupon,
        );

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        identificationNumber: json["identification_number"],
        identificationType: json["identification_type"],
        identificationImage: json["identification_image"] == null ? [] : List<String>.from(json["identification_image"]!.map((x) => x)),
        otherDocuments: json["other_documents"],
        dateOfBirth: json["date_of_birth"],
        profileImage: json["profile_image"],
        fcmToken: json["fcm_token"],
        phoneVerifiedAt: json["phone_verified_at"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        rememberToken: json["remember_token"],
        isActive: json["is_active"],
        loyaltyPoints: json["loyalty_points"],
        isProfileVerified: json["is_profile_verified"],
        userRating: json["user_rating"],
        totalRideCount: json["total_ride_count"],
        completionPercent: json["completion_percent"],
        coupon: json["coupon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "gender": gender,
        "identification_number": identificationNumber,
        "identification_type": identificationType,
        "identification_image": identificationImage == null ? [] : List<dynamic>.from(identificationImage!.map((x) => x)),
        "other_documents": otherDocuments,
        "date_of_birth": dateOfBirth,
        "profile_image": profileImage,
        "fcm_token": fcmToken,
        "phone_verified_at": phoneVerifiedAt,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "remember_token": rememberToken,
        "is_active": isActive,
        "loyalty_points": loyaltyPoints,
        "is_profile_verified": isProfileVerified,
        "user_rating": userRating,
        "total_ride_count": totalRideCount,
        "completion_percent": completionPercent,
        "coupon": coupon,
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
