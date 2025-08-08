import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service.dart';
import '../domain/models/schedule_model.dart';

class ScheduleController extends GetxController {
  List<ScheduleTrip> _schedules = [];
  List<ScheduleTrip> _acceptedSchedules = [];
  bool _isLoading = false;
  bool _isAcceptingLoading = false;
  String? _loadingTripId;
  final ScheduleService service;
  ScheduleController({required this.service});
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

    final response = await service.getAllScheduleTrips();

    if (response.statusCode == 200) {
      final scheduleResponse = ScheduleResponse.fromJson(response.body);
      _acceptedSchedules = scheduleResponse.data ?? [];
    } else {
      _acceptedSchedules = [];
    }

    _isLoading = false;
    update();
  }

  Future<void> getAAcceptedSchedules() async {
    _isAcceptingLoading = true;
    update();

    final response = await service.getAllAcceptSchedule();

    if (response.statusCode == 200) {
      final scheduleResponse = ScheduleResponse.fromJson(response.body);
      _schedules = scheduleResponse.data ?? [];
    } else {
      _schedules = [];
    }

    _isAcceptingLoading = false;
    update();
  }

  Future<void> acceptTrip(String tripId) async {
    _loadingTripId = tripId;
    update();

    final response = await service.acceptScheduleTrip(tripId);

    if (response.statusCode == 200) {
      await getSchedules();
    }

    _loadingTripId = null;
    update();
  }
}
