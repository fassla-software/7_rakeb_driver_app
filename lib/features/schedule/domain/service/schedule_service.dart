import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/repositories/schedule_repositories.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/service/schedule_service_interface.dart';

class ScheduleService implements ScheduleServiceInterface {
  final ScheduleRepositories repository;
  ScheduleService(this.repository);
  @override
  Future<Response> getAllScheduleTrips() async {
    return await repository.getAllScheduleTrips();
  }
}
