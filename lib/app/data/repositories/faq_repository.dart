import 'package:nutri/app/data/providers/faq_provider.dart';

class FAQRepository {
  final FAQProvider faqProvider;

  FAQRepository({this.faqProvider});

  getFaqList() => faqProvider.getFaqList();
}
