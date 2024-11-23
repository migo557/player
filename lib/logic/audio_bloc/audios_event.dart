part of 'audios_bloc.dart';

// Events
sealed class AudiosEvent extends Equatable {
  const AudiosEvent();

  @override
  List<Object> get props => [];
}

class AudiosLoadEvent extends AudiosEvent {}


