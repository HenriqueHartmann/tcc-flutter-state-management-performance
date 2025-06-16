import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter/foundation.dart';

class ItemWithStyleNotifier extends ChangeNotifier {
  final Item item;
  ItemCardStyle style;

  ItemWithStyleNotifier({
    required this.item,
    required this.style,
  });

  void toggleStyle(ItemCardAttribute attribute) {
    style = style.toggleSelectedAttribute(attribute);
    notifyListeners();
  }
}
