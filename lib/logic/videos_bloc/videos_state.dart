part of 'videos_bloc.dart';

sealed class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosSuccess extends VideosState {
  final List<VideoModel> videos;

  const VideosSuccess(this.videos);

  @override
  List<Object> get props => [videos];
}

class VideosFailure extends VideosState {
  final String message;

  const VideosFailure(this.message);

  @override
  List<Object> get props => [message];
}
