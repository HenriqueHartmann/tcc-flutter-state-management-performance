import 'package:app_base_gestao_estado/bloc/item_list/item_list_event.dart';
import 'package:app_base_gestao_estado/bloc/item_list/item_list_state.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  final ItemRepository repository;

  ItemListBloc({required this.repository}) : super(ItemListInitial()) {
    on<LoadItemList>((event, emit) async {
      emit(ItemListLoading());
      try {
        final items = await repository.fetchItems(limit: event.limit.value);

        final itemsWithStyle = items.map((item) {
          return {
            'item': item,
            'style': const ItemCardStyle(),
          };
        }).toList();

        emit(ItemListLoaded(itemsWithStyle: itemsWithStyle));
      } catch (e) {
        emit(ItemListError(message: e.toString()));
      }
    });
  }
}