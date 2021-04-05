import 'package:get/get.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';

class HomeTitleController {
  final HomeTitleHelper titleHelper = HomeTitleHelper();

  HomeTitleController();

  RxString _title = 'HOJE'.obs;
  String get title => _title.value ?? 'Carregando';

  String get todayDate =>
      '${_todayDate.day}/${_todayDate.month}/${_todayDate.year}';
  String get showingDayDate =>
      '${_showingDayDate.day}/${_showingDayDate.month}/${_showingDayDate.year}';

  DateTime _todayDate = DateTime.now();
  late DateTime _showingDayDate;

  bool previewBtnEnabled = false; // Trocar para enabled
  bool nextBtnEnabled = true; // Trocar para enabled

  RxInt showingDayIndex = DateTime.now().weekday.obs;

  int todayIndex = DateTime.now().weekday;

  int _dayIndex = 0;

  init() {
    _showingDayDate = DateTime.now();
  }

  Function? onPreviewDayPressed() {
    _showingDayDate = _showingDayDate.subtract(Duration(days: 1));
    _showDay(_dayIndex--);
  }

  Function? onNextDayPressed() {
    _showingDayDate = _showingDayDate.add(Duration(days: 1));
    _showDay(_dayIndex++);
  }

  Function? onBackToTodayPressed() {
    _showingDayDate = _todayDate;
    _showDay(_dayIndex = 0);
  }

  _showDay(_) async {
    _setShowingDayIndex();
    if (_dayIndex <= 0) {
      previewBtnEnabled = false;
    } else {
      previewBtnEnabled = true;
    }
    if (_dayIndex >= 6) {
      nextBtnEnabled = false;
    } else {
      nextBtnEnabled = true;
    }
    _title.value = titleHelper.getDayTitle(todayIndex, _dayIndex);
  }

  _setShowingDayIndex() {
    showingDayIndex.value = (todayIndex + _dayIndex - 1) % 7 + 1;
  }
}
