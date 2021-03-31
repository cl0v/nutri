import 'package:get/get.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';

class HomeTitleController {
  final HomeTitleHelper titleHelper = HomeTitleHelper();

  HomeTitleController();

  RxString _title = 'HOJE'.obs;
  String get title => _title.value ?? 'Carregando';

  //TODO: Ta faltando um init


  bool  previewBtnDisabled = true;
  bool  nextBtnDisabled = false;

  RxInt showingDayIndex = DateTime.now().weekday.obs;

  int todayIndex = DateTime.now().weekday;

  int _dayIndex = 0;

  Function? onPreviewDayPressed() {
    _showDay(_dayIndex--);
  }

  Function? onNextDayPressed() {
    _showDay(_dayIndex++);
  }

  Function? onBackToTodayPressed() {
    _showDay(_dayIndex = 0);
  }

  _showDay(_) async {
    _setShowingDayIndex();
    if (_dayIndex <= 0) {
      previewBtnDisabled = true;
    } else {
      previewBtnDisabled = false;
    }
    if (_dayIndex >= 6) {
      nextBtnDisabled = true;
    } else {
      nextBtnDisabled = false;
    }
    _title.value = titleHelper.getDayTitle(todayIndex, _dayIndex);
  }

  _setShowingDayIndex() {
    showingDayIndex.value = (todayIndex + _dayIndex - 1) % 7 + 1;
  }
}
