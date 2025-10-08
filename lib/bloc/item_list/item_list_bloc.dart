import 'package:app_base_gestao_estado/bloc/item_list/item_list_event.dart';
import 'package:app_base_gestao_estado/bloc/item_list/item_list_state.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  final ItemRepository repository;

  ItemListBloc({required this.repository}) : super(ItemListInitial()) {
    on<LoadItemList>((event, emit) async {
      emit(ItemListLoading());
      try {
        final items = await repository.fetchItems(limit: event.limit);

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

    on<ToggleItemStyle>((event, emit) {
      if (state is ItemListLoaded) {
        final currentState = state as ItemListLoaded;
        final itemsWithStyle = List<Map<String, dynamic>>.from(currentState.itemsWithStyle);
        
        if (event.index < itemsWithStyle.length) {
          // Captura o tempo do tap
          final tapStartTime = event.tapStartTime ?? DateTime.now();
          
          // Atualiza o estilo do item específico
          final currentStyle = itemsWithStyle[event.index]['style'] as ItemCardStyle;
          final newStyle = currentStyle.toggleSelectedAttribute(event.attribute);
          itemsWithStyle[event.index]['style'] = newStyle;
          
          emit(ItemListLoaded(itemsWithStyle: itemsWithStyle));
          
          // Mede o tempo end-to-end após a renderização
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _measureEndToEndTime(tapStartTime);
          });
        }
      }
    });
  }
  
  void _measureEndToEndTime(DateTime tapStartTime) {
    final endTime = DateTime.now();
    final totalDuration = endTime.difference(tapStartTime);
    
    // Converte para milissegundos (mais fácil de ler)
    final totalMs = totalDuration.inMicroseconds / 1000.0;
    
    final message = 'Tempo end-to-end (Bloc): ${totalMs.toStringAsFixed(1)}ms';
    print(message);
    developer.log(message, name: 'Performance');
  }
}