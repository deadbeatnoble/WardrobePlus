import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';

abstract class WardrobeEvent {}

class SaveWardrobeItemEvent extends WardrobeEvent {
  final String userId;
  final WardrobeItem item;

  SaveWardrobeItemEvent({required this.userId, required this.item});
}

class LoadWardrobeItemEvent extends WardrobeEvent {
  final String userId;

  LoadWardrobeItemEvent({required this.userId});
}
