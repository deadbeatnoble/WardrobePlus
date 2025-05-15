import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/load_wardrobe_items.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_event.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_state.dart';
import 'package:bloc/bloc.dart';

class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState>{
  final SaveWardrobeItem saveWardrobeItem;
  final LoadWardrobeItems loadWardrobeItems;
  
  WardrobeBloc(
    {required this.saveWardrobeItem, required this.loadWardrobeItems}
  ): super(Wardrobeinitial()) {
    on<SaveWardrobeItemEvent>(_onSaveWardrobeItemEvent);
    on<LoadWardrobeItemEvent>(_onLoadWardrobeItemsEvent);
  }

  Future<void> _onSaveWardrobeItemEvent(SaveWardrobeItemEvent event, Emitter<WardrobeState> emit) async {
    emit(WardrobeLoading());

    try {
      await saveWardrobeItem(event.userId, event.item);
      emit(WardrobeItemSaved(message: "Item saved successfully!"));
    } catch (e) {
      emit(WardrobeFailure(message: e.toString()));
    }
  }

  Future<void> _onLoadWardrobeItemsEvent(LoadWardrobeItemEvent event, Emitter<WardrobeState> emit) async {
    emit(WardrobeLoading());

    try {
      final items = await loadWardrobeItems(event.userId);
      emit(WardrobeItemsLoaded(items: items));
    } catch (e) {
      emit(WardrobeFailure(message: e.toString()));
    }
  }
}