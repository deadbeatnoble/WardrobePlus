import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';

class LoadWardrobeItems {
  final WardrobeRepository wardrobeRepository;

  LoadWardrobeItems(this.wardrobeRepository);

  Future<List<WardrobeItem>> call(String userId) async {
    return await wardrobeRepository.loadWardrobeItems(userId);
  }
}