import 'package:WardrobePlus/features/wardrobe/data/datasource/supabase_wardrobe_datasource.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';

class WardrobeRepositoryImpl extends WardrobeRepository {
  final SupabaseWardrobeDatasource supabaseWardrobeDatasource;

  WardrobeRepositoryImpl(this.supabaseWardrobeDatasource);

  @override
  Future<void> saveWardrobeItem(String userId, WardrobeItem item) async {
    await supabaseWardrobeDatasource.saveWardrobeItem(userId, item);
  }

  @override
  Future<List<WardrobeItem>> loadWardrobeItems(String userId) async {
    return await supabaseWardrobeDatasource.loadWardrobeItems(userId);
  }
}