part of 'controls_visibility_cubit.dart';

class ControlsVisibilityState extends Equatable {
   const ControlsVisibilityState({required this.showVideoControls});

final  bool showVideoControls;

  @override
  List<Object> get props => [showVideoControls];
}
