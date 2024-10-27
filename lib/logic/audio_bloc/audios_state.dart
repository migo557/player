part of 'audios_bloc.dart';

sealed class AudiosState extends Equatable {
  const AudiosState();

  @override
  List<Object> get props => [];
}

class AudiosInitial extends AudiosState {}

class AudiosLoading extends AudiosState {}

class AudiosSuccess extends AudiosState {
  final List<AudioModel> songs;

  const AudiosSuccess({required this.songs});

  @override
  List<Object> get props => [songs];
}

class AudiosFailure extends AudiosState {
  final String message;

  const AudiosFailure(this.message);

  @override
  List<Object> get props => [message];
}
