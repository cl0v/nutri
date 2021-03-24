import 'package:get/get.dart';

class HomeTitleModel {
  // TODO: Estudar a possibilidade de tirar o getX daq, deixar tipos primarios
  /// Titulo do dia da semana
  RxString title = 'HOJE'.obs;

  RxInt showingDay = 1.obs;

  int todayIndex = DateTime.now().weekday;

  /// Define se o botão de dia anterior do titulo estará ou não desabilitado
  RxBool previewBtnDisabled = true.obs;

  /// Define se o botão de dia seguinte do titulo estará ou não desabilitado
  RxBool nextBtnDisabled = false.obs; //Renomear

}
