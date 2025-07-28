import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';
import '../domain/models/schedule_model.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('schedule'.tr, style: textBold),
            elevation: 0,
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.schedules.isEmpty
                  ? Center(child: Text('no_schedules'.tr))
                  : ListView.builder(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      itemCount: controller.schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = controller.schedules[index];
                        return ScheduleCard(schedule: schedule);
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddScheduleDialog(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('add_schedule'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'title'.tr),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'description'.tr),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  selectedDate = picked;
                }
              },
              child: Text('select_date'.tr),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final schedule = ScheduleModel(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  dateTime: selectedDate,
                );
                Get.find<ScheduleController>().addSchedule(schedule);
                Get.back();
              }
            },
            child: Text('save'.tr),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: ListTile(
        title: Text(
          schedule.title,
          style: textMedium.copyWith(
            decoration: schedule.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schedule.description),
            Text(
              schedule.dateTime.toString().split('.')[0],
              style: textRegular.copyWith(color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: schedule.isCompleted,
              onChanged: (value) {
                Get.find<ScheduleController>().toggleScheduleCompletion(schedule.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Get.find<ScheduleController>().removeSchedule(schedule.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}