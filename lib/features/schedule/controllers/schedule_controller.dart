import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/snackbar_widget.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/map/controllers/otp_time_count_Controller.dart';
import 'package:ride_sharing_user_app/features/map/screens/map_screen.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/ride/domain/services/ride_service_interface.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/models/accept_schedule_%20model.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service_interface.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/helper/pusher_helper.dart';

class ScheduleController extends GetxController {
  ScheduleController({required this.scheduleService});

  List<ScheduleTrip> _schedules = [];
  List<ScheduleTrip> _acceptedSchedules = [];
  bool _isLoading = false;
  bool _isAcceptingLoading = false;
  String? _loadingTripId;
  final ScheduleServiceInterface scheduleService;
  List<ScheduleTrip> get schedules => _schedules;
  List<ScheduleTrip> get acceptedSchedules => _acceptedSchedules;
  bool get isLoading => _isLoading;
  bool get isAcceptingLoading => _isAcceptingLoading;
  String? get loadingTripId => _loadingTripId;
  List<String> scheduleTypeList = ['all_schedules', 'accepted_schedules'];
  int get scheduleTypeIndex => _scheduleTypeIndex;
  int _scheduleTypeIndex = 0;

  void setWalletTypeIndex(int index) {
    _scheduleTypeIndex = index;
    update();
  }

  Future<void> getSchedules() async {
    _isLoading = true;
    update();

    final response = await scheduleService.getAllScheduleTrips();

    if (response.statusCode == 200) {
      final scheduleResponse = ScheduleResponse.fromJson(response.body);
      print(scheduleResponse.totalSize);
      _schedules = scheduleResponse.data?.data ?? [];
    } else {
      _schedules = [];
    }

    _isLoading = false;
    update();
  }

  Future<void> getAcceptedSchedules() async {
    _isAcceptingLoading = true;
    update();

    final response = await scheduleService.getAllAcceptSchedule();

    if (response.statusCode == 200) {
      final scheduleResponse = ScheduleResponse.fromJson(response.body);
      _acceptedSchedules = scheduleResponse.data?.data ?? [];
    } else {
      _acceptedSchedules = [];
    }

    _isAcceptingLoading = false;
    update();
  }

  Future<Response> acceptScheduleTrip(String tripId) async {
    _loadingTripId = tripId;
    update();

    final response = await scheduleService.acceptScheduleTrip(tripId);

    if (response.statusCode == 200) {
      await getSchedules();
    }

    _loadingTripId = null;
    update();
    return response;
  }

  Future<Response> cancelScheduleTrip(String tripId) async {
    _loadingTripId = tripId;
    update();

    final response = await scheduleService.cancelScheduleTrip(tripId);

    _loadingTripId = null;
    update();
    return response;
  }

  final RideController rideController = Get.find<RideController>();
  String? onTapType;

  Future<Response> acceptOrRejectTrip(String tripId, String type) async {
    _loadingTripId = tripId;
    update();

    final response = await rideController.tripAcceptOrRejected(tripId, type,
        fromList: false);
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      SnackBarWidget("trip_not_accepted".tr, isError: true);
    }
    _loadingTripId = null;
    update();
    return response;
  }
}
