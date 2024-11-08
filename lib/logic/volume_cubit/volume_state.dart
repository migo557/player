part of 'volume_cubit.dart';

class VolumeState extends Equatable {
  VolumeState({required this.audioPlayerVolume, required this.showVolumeBar, required this.systemVolume});

  double audioPlayerVolume;
  double systemVolume;

  bool showVolumeBar;

  VolumeState copyWith({
    double? audioPlayerVolume,
    double? systemVolume,

    bool? showVolumeBox,
  }) {
    return VolumeState(
      audioPlayerVolume: audioPlayerVolume ?? this.audioPlayerVolume,
      showVolumeBar: showVolumeBox ?? this.showVolumeBar,
      systemVolume: systemVolume?? this.systemVolume
    );
  }

  factory VolumeState.initial() =>
      VolumeState(audioPlayerVolume: 0.5, showVolumeBar: false, systemVolume: 0.3);

  @override
  List<Object> get props => [audioPlayerVolume, showVolumeBar, systemVolume];
}
