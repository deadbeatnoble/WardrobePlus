import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseWardrobeDatasource {
  final FirebaseFirestore fireStore;

  FirebaseWardrobeDatasource(this.fireStore);

  Future<void> saveWardrobeItem(String userId, WardrobeItem item) async {
    await fireStore
        .collection('users')
        .doc(userId)
        .collection('wardrobeItems')
        .add({
          'imagePath': item.imagePath,
          'category': item.category,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  Future<List<WardrobeItem>> loadWardrobeItems(String userId) async {
    final snapshot =
        await fireStore
            .collection('users')
            .doc(userId)
            .collection('wardrobeItems')
            .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return WardrobeItem(
        imagePath: data['imagePath'],
        category: data['category'],
      );
    }).toList();
  }
}
