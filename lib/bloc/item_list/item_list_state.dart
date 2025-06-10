abstract class ItemListState {}

class ItemListInitial extends ItemListState {}

class ItemListLoading extends ItemListState {}

class ItemListLoaded extends ItemListState {
  final List<Map<String, dynamic>> itemsWithStyle;

  ItemListLoaded({required this.itemsWithStyle});
}

class ItemListError extends ItemListState {
  final String message;

  ItemListError({required this.message});
}
