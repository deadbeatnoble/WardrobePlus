abstract class WardrobeState {}

class Wardrobeinitial extends WardrobeState{}

class WardrobeLoading extends WardrobeState {}

class WardrobeSuccess extends WardrobeState {
  final String message;

  WardrobeSuccess({required this.message});
}

class WardrobeFailure extends WardrobeState {
  final String message;

  WardrobeFailure({required this.message});
}
