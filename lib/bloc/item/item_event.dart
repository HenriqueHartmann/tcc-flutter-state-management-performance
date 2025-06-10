import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';

abstract class ItemEvent {}

class InitializeItem extends ItemEvent {
  final Item item;
  final ItemCardStyle style;

  InitializeItem({required this.item, required this.style});
}

class ToggleStyle extends ItemEvent {
  final ItemCardAttribute attribute;

  ToggleStyle({required this.attribute});
}
