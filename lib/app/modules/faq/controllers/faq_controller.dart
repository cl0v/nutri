import 'package:get/get.dart';
import 'package:nutri/app/data/model/faq_model.dart';
import 'package:nutri/app/data/repositories/faq_repository.dart';

class FaqController extends GetxController {
  final FAQRepository faqRepository;

  FaqController({required this.faqRepository});

  final faqList = <FAQModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchFaqList();
  }

  _fetchFaqList() async {
    faqList.assignAll(await faqRepository.getFaqList());
    print(faqList);
  }
}
