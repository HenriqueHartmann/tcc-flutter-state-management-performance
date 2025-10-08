import 'package:app_base_gestao_estado/models/item_card_style.dart';

abstract class ItemStyleEvent {}

class ToggleItemStyle extends ItemStyleEvent {
  final ItemCardAttribute attribute;
  final DateTime? tapStartTime;

  ToggleItemStyle({
    required this.attribute,
    this.tapStartTime,
  });
}
