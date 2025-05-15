import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';

abstract class WardrobeState {}

class Wardrobeinitial extends WardrobeState{}

class WardrobeLoading extends WardrobeState {}

class WardrobeItemSaved extends WardrobeState {
  final String message;

  WardrobeItemSaved({required this.message});
}

class WardrobeItemsLoaded extends WardrobeState {
  final List<WardrobeItem> items;

  WardrobeItemsLoaded({required this.items});
}

class WardrobeFailure extends WardrobeState {
  final String message;

  WardrobeFailure({required this.message});
}
