import 'package:nutri/app/pages/home/models/home_title_model.dart';

class HomeTitleViewModel {
  final HomeTitleModel model = HomeTitleModel();

  int _dayIndex = 0;

  nextDay() {
    _showDay(_dayIndex++);
  }

  Function? previewDay() {
    _showDay(_dayIndex--);
  }

  Function? backToToday() {
    _showDay(_dayIndex = 0);
  }

  _showDay(_) async {
    _setShowingDayIndex();
    if (_dayIndex <= 0) {
      model.previewBtnDisabled = true;
    } else {
      model.previewBtnDisabled = false;
    }
    if (_dayIndex >= 6) {
      model.nextBtnDisabled = true;
    } else {
      model.nextBtnDisabled = false;
    }
    model.title.value = _getDayTitle(model.todayIndex);
  }

  _setShowingDayIndex() {
    model.showingDay.value = (model.todayIndex + _dayIndex - 1) % 7 + 1;
  }

  String _getDayTitle(int todayIndex) {
    if (_dayIndex == 1) {
      return 'AMANHÃ';
    } else if (_dayIndex == -1) {
      return 'ONTEM';
    } else if (_dayIndex == 0) {
      return 'HOJE';
    } else
      return _getDayOfTheWeekString(
          _dayOnTheWeekToString(todayIndex + _dayIndex));
  }

  int _dayOnTheWeekToString(int dayNum) {
    if (dayNum > 7) {
      dayNum = (dayNum % 7);
    } else if (dayNum < 1) {
      dayNum = (dayNum % 7);
    }
    if (dayNum == 0) dayNum = 7;

    return dayNum;
  }

  String _getDayOfTheWeekString(int day) {
    switch (day) {
      case 1:
        return 'SEGUNDA';
      case 2:
        return 'TERÇA';
      case 3:
        return 'QUARTA';
      case 4:
        return 'QUINTA';
      case 5:
        return 'SEXTA';
      case 6:
        return 'SÁBADO';
      case 7:
        return 'DOMINGO';
      default:
        return 'HOJE';
    }
  }
}
