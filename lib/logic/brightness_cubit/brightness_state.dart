part of 'brightness_cubit.dart';

class BrightnessState extends Equatable {
  const BrightnessState({required this.videoPlayerBrightness, required this.showBrightnessBox});

  final double videoPlayerBrightness;
 final  bool showBrightnessBox;

  factory BrightnessState.initialState() =>
      BrightnessState(videoPlayerBrightness: 0,showBrightnessBox: false);

  BrightnessState copyWith({double? videoPlayerBrightness, bool? showBrightnessBox}) {
    return BrightnessState(
        videoPlayerBrightness:
            videoPlayerBrightness ?? this.videoPlayerBrightness,
            
            showBrightnessBox: showBrightnessBox?? this.showBrightnessBox
            );
  }

  @override
  List<Object> get props => [videoPlayerBrightness, showBrightnessBox];
}
