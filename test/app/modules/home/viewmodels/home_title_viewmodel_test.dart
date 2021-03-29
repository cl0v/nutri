import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';

main() {
  test('Title behavior after pressing nextDay HOJE > AMANHÃ', () {
    final homeTitleViewModel = HomeTitleViewModel();
    expect(homeTitleViewModel.model.title.value, equals('HOJE'));
    expect(
        homeTitleViewModel.model.title.stream,
        emitsInOrder([
          equals('AMANHÃ'),
        ]));
    homeTitleViewModel.nextDay();
  });

  test('Title behavior after pressing nextDay 7 times with today beeing 1', () {
    final homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 1;
    expect(homeTitleViewModel.model.title.value, equals('HOJE'));
    expect(
        homeTitleViewModel.model.title.stream,
        emitsInOrder([
          equals('AMANHÃ'),
          equals('QUARTA'),
          equals('QUINTA'),
          equals('SEXTA'),
          equals('SÁBADO'),
          equals('DOMINGO'),
          equals('SEGUNDA'),
        ]));

    for (var i = 0; i <= 6; i += 1) {
      homeTitleViewModel.nextDay();
    }
  });

  test('Title behavior after pressing previewDay HOJE > ONTEM', () {
    final homeTitleViewModel = HomeTitleViewModel();
    expect(homeTitleViewModel.model.title.value, equals('HOJE'));
    expect(
        homeTitleViewModel.model.title.stream,
        emitsInOrder([
          equals('ONTEM'),
        ]));
    homeTitleViewModel.previewDay();
  });

  group('dayIndex |', () {
    test(
        'For today beeing 1, if nextDay was pressed 6 times, the day should be 7',
        () {
      final homeTitleViewModel = HomeTitleViewModel();
      homeTitleViewModel.model.todayIndex = 1;
      expect(homeTitleViewModel.model.showingDay.stream,
          emitsInOrder([2, 3, 4, 5, 6, 7]));

      for (var i = 0; i <= 6; i += 1) {
        homeTitleViewModel.nextDay();
      }
    });

    test(
        'For today beeing 2, if nextDay was pressed 7 times, the last day should be 2',
        () {
      final homeTitleViewModel = HomeTitleViewModel();
      homeTitleViewModel.model.todayIndex = 2;
      expect(homeTitleViewModel.model.showingDay.stream,
          emitsInOrder([3, 4, 5, 6, 7, 1, 2]));

      for (var i = 0; i <= 6; i += 1) {
        homeTitleViewModel.nextDay();
      }
    });
    test(
        'For today beeing 3, if nextDay was pressed 7 times, the last day should be 3',
        () {
      final homeTitleViewModel = HomeTitleViewModel();
      homeTitleViewModel.model.todayIndex = 3;
      expect(
          homeTitleViewModel.model.showingDay.stream,
          emitsInOrder([
            4,
            5,
            6,
            7,
            1,
            2,
            3,
          ]));

      for (var i = 0; i <= 6; i += 1) {
        homeTitleViewModel.nextDay();
      }
    });
    test(
        'For today beeing 7, if nextDay was pressed 7 times, the last day should be 7',
        () {
      final homeTitleViewModel = HomeTitleViewModel();
      homeTitleViewModel.model.todayIndex = 7;
      expect(
          homeTitleViewModel.model.showingDay.stream,
          emitsInOrder([
            1,
            2,
            3,
            4,
            5,
            6,
            7,
          ]));

      for (var i = 0; i <= 6; i += 1) {
        homeTitleViewModel.nextDay();
      }
    });
  });

  test('Testing backToToday method', () {
    HomeTitleViewModel homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 1;
    homeTitleViewModel.nextDay();
    homeTitleViewModel.nextDay();
    expect(homeTitleViewModel.model.title.value, equals('QUARTA'));
    expect(homeTitleViewModel.model.showingDay.value, 3);
    homeTitleViewModel.backToToday();
    expect(homeTitleViewModel.model.title.value, equals('HOJE'));
    expect(homeTitleViewModel.model.showingDay.value, 1);
  });

  test('O botao de nextDay deve acrescentar um ao dia', () {
    final homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 1;
    homeTitleViewModel.nextDay();
    expect(homeTitleViewModel.model.showingDay.value, 2);
  }, skip: true);
  test('O dia nunca deve ser maior que 7, quando chega a 8, vira 1', () {
    final homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 7;
    homeTitleViewModel.nextDay();
    expect(homeTitleViewModel.model.showingDay.value, 1);
  }, skip: true);
  test('O botao de previewDay deve subtrair um ao dia', () {
    final homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 2;
    // homeTitleViewModel.previewDay()();
    expect(homeTitleViewModel.model.showingDay.value, 1);
  }, skip: true);
  test('O dia nunca deve ser menor que 1, quando chega a 1, vira 7', () {
    final homeTitleViewModel = HomeTitleViewModel();
    homeTitleViewModel.model.todayIndex = 1;
    // homeTitleViewModel.previewDay()();
    expect(homeTitleViewModel.model.showingDay.value, 7);
  }, skip: true);
}
