import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';

abstract class WardrobeRepository {
  Future<void> saveWardrobeItem(String userId, WardrobeItem item);
  Future<List<WardrobeItem>> loadWardrobeItems(String userId);
}