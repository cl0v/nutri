import 'package:nutri/app/pages/home/models/home_title_model.dart';

class HomeTitleViewModel {
  final HomeTitleModel model = HomeTitleModel();

  int _todayIndex = DateTime.now().weekday;
  int _dayIndex = 0; 
  
  // TODO: Expor o dia que eu quero olhar
  //TODO:  RxInt day = 1.obs; Jogar no model


  nextDay() {
    _dayIndex++;
    _showDayOverView(); //Estou repetindo codigo
  }

  previewDay() {
    _dayIndex--;
    _showDayOverView();
  }

  //TODO: Refatorar

  _showDayOverView() async {
    if (_dayIndex <= 0) {
      model.previewBtnDisabled.value = true;
    } else {
      model.previewBtnDisabled.value = false;
    }
    if (_dayIndex >= 6) {
      model.nextBtnDisabled.value = true;
    } else {
      model.nextBtnDisabled.value = false;
    }
    model.title.value = _getDayTitle(_dayIndex, _todayIndex);
  }


  String _getDayTitle(int dayIndex, int todayIndex) {
    if (dayIndex == 1) {
      return 'AMANHÃ';
    } else if (dayIndex == -1) {
      return 'ONTEM';
    } else if (dayIndex == 0) {
      return 'HOJE';
    } else
      return _getDayOfTheWeekString(
          _dayOnTheWeekToString(todayIndex + dayIndex));
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
  //BOTOES TAMBEM PASSAM PRAK

}
