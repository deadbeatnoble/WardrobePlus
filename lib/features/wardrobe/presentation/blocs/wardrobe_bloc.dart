import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_event.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_state.dart';
import 'package:bloc/bloc.dart';

class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState>{
  final SaveWardrobeItem saveWardrobeItem;
  
  WardrobeBloc(
    {required this.saveWardrobeItem}
  ): super(Wardrobeinitial()) {
    on<SaveWardrobeItemEvent>(_onSaveWardrobeItemEvent);
  }

  Future<void> _onSaveWardrobeItemEvent(SaveWardrobeItemEvent event, Emitter<WardrobeState> emit) async {
    emit(WardrobeLoading());

    try {
      await saveWardrobeItem(event.userId, event.item);
      emit(WardrobeSuccess(message: "Item saved successfully!"));
    } catch (e) {
      emit(WardrobeFailure(message: e.toString()));
    }
  }

}