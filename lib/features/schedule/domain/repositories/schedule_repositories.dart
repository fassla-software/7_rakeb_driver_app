import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/features/schedule/domain/repositories/schedule_repositories_interface.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class ScheduleRepositories implements ScheduleRepositoriesInterface {
  final ApiClient apiClient;
  ScheduleRepositories(this.apiClient);

  @override
  Future<Response> getAllScheduleTrips() async {
    return await apiClient.getData(AppConstants.baseUrl);
  }
}
