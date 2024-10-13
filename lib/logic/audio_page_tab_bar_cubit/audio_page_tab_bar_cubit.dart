import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_page_tab_bar_state.dart';

class AudioPageTabBarCubit extends Cubit<AudioPageTabBarState> {
  AudioPageTabBarCubit() : super(AudioPageTabBarState(tabIndex: 0));

  changeIndex({required int tabIndex}) {
    emit(state.copyWith(index: tabIndex));
  }
}
