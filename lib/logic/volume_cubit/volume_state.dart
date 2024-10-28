part of 'volume_cubit.dart';

class VolumeState extends Equatable {
  VolumeState({required this.audioPlayerVolume, required this.showVolumeBar});

  double audioPlayerVolume;
  bool showVolumeBar;

  VolumeState copyWith({
    double? audioPlayerVolume,
    bool? showVolumeBox,
  }) {
    return VolumeState(
      audioPlayerVolume: audioPlayerVolume ?? this.audioPlayerVolume,
      showVolumeBar: showVolumeBox ?? this.showVolumeBar,
    );
  }

  factory VolumeState.initial() =>
      VolumeState(audioPlayerVolume: 0.5, showVolumeBar: false);

  @override
  List<Object> get props => [audioPlayerVolume, showVolumeBar];
}
