import 'package:get/get.dart';
import 'package:nutri/app/data/providers/faq_provider.dart';
import 'package:nutri/app/data/repositories/faq_repository.dart';

import '../controllers/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(
      () => FaqController(
        faqRepository: FAQRepository(faqProvider: FAQProvider())
      ),
    );
  }
}
