import 'package:WardrobePlus/features/wardrobe/data/datasource/firebase_wardrobe_datasource.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';

class WardrobeRepositoryImpl extends WardrobeRepository {
  final FirebaseWardrobeDatasource firebaseWardrobeDatasource;

  WardrobeRepositoryImpl(this.firebaseWardrobeDatasource);

  @override
  Future<void> saveWardrobeItem(String userId, WardrobeItem item) async {
    await firebaseWardrobeDatasource.saveWardrobeItem(userId, item);
  }

  @override
  Future<List<WardrobeItem>> loadWardrobeItems(String userId) async {
    return await firebaseWardrobeDatasource.loadWardrobeItems(userId);
  }
}