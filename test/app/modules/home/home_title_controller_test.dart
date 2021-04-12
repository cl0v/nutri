@Skip('Equanto estou testando coisas mais importantes')
import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/home_controller.dart';

main() {
  group('Title | ', () {
    late HomeTitleController controller;
    test('Title behavior after pressing nextDay HOJE > AMANHÃ', () {
      controller = HomeTitleController();
      expect(controller.title, 'HOJE');
      controller.onNextDayPressed();
      expect(controller.title, 'AMANHÃ');
    });

    test('Title behavior after pressing previewDay HOJE > ONTEM', () {
      controller = HomeTitleController();
      expect(controller.title, equals('HOJE'));
      controller.onPreviewDayPressed();
      expect(controller.title, equals('ONTEM'));
    });

    group('BackToToday |', () {
      late HomeTitleController controller;

      test('Testing backToToday method', () {
        controller = HomeTitleController();
        expect(controller.title, 'HOJE');
        controller.onNextDayPressed();
        expect(controller.title, 'AMANHÃ');
        controller.onBackToTodayPressed();
        expect(controller.title, 'HOJE');
      });
    });
  });
}
