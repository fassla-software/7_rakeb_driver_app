import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/repositories/schedule_repositories_interface.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class ScheduleRepositories implements ScheduleRepositoriesInterface {
  final ApiClient apiClient;
  ScheduleRepositories({required this.apiClient});

  @override
  Future<Response> getAllScheduleTrips({int limit = 10, int offset = 1}) async {
    return await apiClient.getData(
      AppConstants.scheduleTrips,
      query: {"limit": 10, "offset": 1, "scheduled": 1},
    );
  }

  @override
  Future<Response> acceptScheduleTrip(String scheduleTripId) async {
    return await apiClient.postData(
      AppConstants.acceptScheduleTrips,
      {"trip_request_id": scheduleTripId},
    );
  }

  @override
  Future<Response> getAllAcceptSchedule() async {
    return await apiClient.getData(AppConstants.scheduleTrips, query: {
      "limit": 10,
      "offset": 1,
      "scheduled": 1,
      "driver_status": "driver_schedule_accept"
    });
  }
}
