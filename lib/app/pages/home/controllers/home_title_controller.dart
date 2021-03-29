import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';

class HomeTitleController {
  final HomeTitleViewModel titleViewModel;

  HomeTitleController({required this.titleViewModel});

  String get title => titleViewModel.model.title.value ?? 'Carregando';
  bool get previewBtnDisabled => titleViewModel.model.previewBtnDisabled;
  bool get nextBtnDisabled => titleViewModel.model.nextBtnDisabled;
  RxInt get showingDayIndex => titleViewModel.model.showingDay;
  int get todayIndex => titleViewModel.model.todayIndex;

  void onPreviewDayPressed() => titleViewModel.previewDay();
  void onNextDayPressed() => titleViewModel.nextDay();
  void onBackToTodayPressed() => titleViewModel.backToToday();
}