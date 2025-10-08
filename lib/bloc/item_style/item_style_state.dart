import 'package:app_base_gestao_estado/models/item_card_style.dart';

abstract class ItemStyleState {}

class ItemStyleInitial extends ItemStyleState {}

class ItemStyleLoaded extends ItemStyleState {
  final ItemCardStyle style;

  ItemStyleLoaded({required this.style});
}
