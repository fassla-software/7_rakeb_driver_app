import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/repositories/schedule_repositories.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/repositories/schedule_repositories_interface.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service_interface.dart';

class ScheduleService implements ScheduleServiceInterface {
  final ScheduleRepositoriesInterface repository;
  ScheduleService({required this.repository});
  @override
  Future<Response> getAllScheduleTrips() async {
    return await repository.getAllScheduleTrips();
  }

  @override
  Future<Response> acceptScheduleTrip(String scheduleTripId) async {
    return await repository.acceptScheduleTrip(scheduleTripId);
  }

  @override
  Future<Response> getAllAcceptSchedule() async {
    return await repository.getAllAcceptSchedule();
  }

  @override
  Future<Response> cancelScheduleTrip(String scheduleTripId) async {
    return await repository.cancelScheduleTrip(scheduleTripId);
  }
}
