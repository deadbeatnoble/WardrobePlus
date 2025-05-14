import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';

class SaveWardrobeItem {
  final WardrobeRepository wardrobeRepository;

  SaveWardrobeItem(this.wardrobeRepository);

  Future<void> call(String userId, WardrobeItem item) async {
    await wardrobeRepository.saveWardrobeItem(userId, item);
  }
}