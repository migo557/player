part of 'brightness_cubit.dart';

class BrightnessState extends Equatable {
  BrightnessState({required this.videoPlayerBrightness, required this.showBrightnessBox});

  double videoPlayerBrightness;
  bool showBrightnessBox;

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
