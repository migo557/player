part of 'audio_page_tab_bar_cubit.dart';

class AudioPageTabBarState extends Equatable {
  AudioPageTabBarState({required this.tabIndex});

  int tabIndex;

  copyWith(index) {
    return AudioPageTabBarState(tabIndex: index ?? this.tabIndex);
  }

  @override
  List<Object> get props => [tabIndex];
}
