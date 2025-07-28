import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service.dart';
import '../domain/models/schedule_model.dart';

class ScheduleController extends GetxController {
  List<ScheduleModel> _schedules = [];
  bool _isLoading = false;
  final ScheduleService service;
  ScheduleController(this.service);
  List<ScheduleModel> get schedules => _schedules;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    getSchedules();
  }
  Future<void> getSchedules() async {
    _isLoading = true;
    update();

    final response = await service.getAllScheduleTrips();
    
    if (response.statusCode == 200) {
      _schedules = response.body;
    } else {
      _schedules = [];
    }
    
    _isLoading = false;
    update();
  }

  void addSchedule(ScheduleModel schedule) {
    _schedules.add(schedule);
    update();
  }

  void removeSchedule(String id) {
    _schedules.removeWhere((schedule) => schedule.id == id);
    update();
  }

  void updateSchedule(ScheduleModel updatedSchedule) {
    final index =
        _schedules.indexWhere((schedule) => schedule.id == updatedSchedule.id);
    if (index != -1) {
      _schedules[index] = updatedSchedule;
      update();
    }
  }

  void toggleScheduleCompletion(String id) {
    final index = _schedules.indexWhere((schedule) => schedule.id == id);
    if (index != -1) {
      final schedule = _schedules[index];
      _schedules[index] = schedule.copyWith(isCompleted: !schedule.isCompleted);
      update();
    }
  }
}
