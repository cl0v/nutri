import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/home_controller.dart';

main() {
  group('', () {});
  group('Title | ', () {
    late IHomeTitleController titleController;

    setUp(() {
      titleController = HomeTitleController()..init();
    });

    group('Date as String | ', () {
      test('TodayAsString behavior', () {
        var date = DateTime.now();
        expect(
          titleController.todayAsString,
          equals(
            '${date.day}/${date.month}/${date.year}',
          ),
        );
      });

      test('DateAsString', () {
        var date = DateTime.now();
        expect(
          titleController.dateAsString,
          equals(
            '${date.day}/${date.month}/${date.year}',
          ),
        );
      });
      test('DateAsString after pressing nextDay', () {
        titleController.nextButton.onPressed();
        var date = DateTime.now().add(Duration(days: 1));
        expect(
          titleController.dateAsString,
          equals(
            '${date.day}/${date.month}/${date.year}',
          ),
        );
      });
    });

    test('Title behavior after pressing nextDay HOJE > AMANHÃ', () {
      expect(titleController.title, 'HOJE');
      titleController.nextButton.onPressed();
      expect(titleController.title, 'AMANHÃ');
    });
  });
}
