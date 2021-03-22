import 'package:get/get.dart';

class HomeTitleModel {
  /// Titulo do dia da semana
  RxString title = 'HOJE'.obs;

  /// Define se o botão de dia anterior do titulo estará ou não desabilitado
  RxBool previewBtnDisabled = true.obs;

  /// Define se o botão de dia seguinte do titulo estará ou não desabilitado
  RxBool nextBtnDisabled = false.obs; //Renomear

}
