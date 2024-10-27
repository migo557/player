part of 'audio_page_tab_bar_cubit.dart';

class AudioPageTabBarState extends Equatable {
  const AudioPageTabBarState({required this.tabIndex});

  final int tabIndex;

  copyWith({index}) {
    return AudioPageTabBarState(tabIndex: index);
  }

  @override
  List<Object> get props => [tabIndex];
}
