import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/home_controller.dart';

main() {

  group('', () {
    
  });
  group('Title | ', () {
    late IHomeTitleController titleController;
    test('Title behavior after pressing nextDay HOJE > AMANHÃ', () {
      titleController = HomeTitleController();
      expect(titleController.title, 'HOJE');
      titleController.onNextDayPressed();
      expect(titleController.title, 'AMANHÃ');
    });

    test('Testing backToToday method', () {
      titleController = HomeTitleController();
      expect(titleController.title, 'HOJE');
      titleController.onNextDayPressed();
      expect(titleController.title, 'AMANHÃ');
      titleController.onBackToTodayPressed();
      expect(titleController.title, 'HOJE');
    });
  });
}
