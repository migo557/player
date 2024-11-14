part of 'controls_visibility_cubit.dart';

class ControlsVisibilityState extends Equatable {
  const ControlsVisibilityState(
      {required this.showVideoControls, required this.lockScreenTapping});

  final bool showVideoControls;
  final bool lockScreenTapping;

  ControlsVisibilityState copyWith(
      {bool? showVideoControls, bool? lockScreenTapping}) {
    return ControlsVisibilityState(
        showVideoControls: showVideoControls ?? this.showVideoControls,
        lockScreenTapping: lockScreenTapping ?? this.lockScreenTapping);
  }

  @override
  List<Object> get props => [showVideoControls, lockScreenTapping];
}
