import 'package:hive/hive.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/data/models/audio_playlist_model.dart';
import 'package:open_player/data/models/audio_model.dart';

class AudioPlaylistService {
  final Box _playlistBox = MyHiveBoxes.audioPlaylist;

  /// Creates a new playlist
  ///
  /// Throws an [ArgumentError] if a playlist with the same name already exists
  Future<void> createPlaylist(AudioPlaylistModel playlist) async {
    if (_playlistBox.containsKey(playlist.name)) {
      throw ArgumentError(
          'A playlist with name ${playlist.name} already exists');
    }
    await _playlistBox.put(playlist.name, playlist);
  }

  /// Retrieves all playlists
  ///
  /// Returns an empty list if no playlists exist
  Future<List<AudioPlaylistModel>> getAllPlaylists() async {
    // Use .values.toList() which creates an empty list if no values
    // Use cast to ensure type safety
    return _playlistBox.values.cast<AudioPlaylistModel>().toList();
  }

  /// Updates an existing playlist
  ///
  /// Throws an [ArgumentError] if the playlist doesn't exist
  Future<void> updatePlaylist(AudioPlaylistModel playlist) async {
    if (!_playlistBox.containsKey(playlist.name)) {
      throw ArgumentError('Playlist ${playlist.name} does not exist');
    }
    await _playlistBox.put(playlist.name, playlist);
  }

  /// Deletes a specific playlist
  ///
  /// Throws an [ArgumentError] if the playlist doesn't exist
  Future<void> deletePlaylist(AudioPlaylistModel playlist) async {
    if (!_playlistBox.containsKey(playlist.name)) {
      throw ArgumentError('Playlist ${playlist.name} does not exist');
    }
    await _playlistBox.delete(playlist.name);
  }

  /// Clears all playlists
  Future<void> clearAllPlaylists() async {
    await _playlistBox.clear();
  }

  /// Adds an audio to a playlist
  ///
  /// Prevents duplicate audio entries
  /// Throws an [ArgumentError] if the playlist doesn't exist
  Future<AudioPlaylistModel> addAudio(
      AudioPlaylistModel playlist, AudioModel audio) async {
    // Validate playlist exists
    if (!_playlistBox.containsKey(playlist.name)) {
      throw ArgumentError('Playlist ${playlist.name} does not exist');
    }

    // Prevent duplicate audio entries
    if (!_checkIfPlaylistAlreadyHaveAudio(playlist, audio)) {
      // Create a new list to avoid modifying the original
      final updatedAudios = List<AudioModel>.from(playlist.audios)..add(audio);

      // Create an updated playlist model
      final updatedPlaylist = AudioPlaylistModel(
          name: playlist.name,
          audios: updatedAudios,
          created: playlist.created,
          modified: DateTime.now());

      // Save the updated playlist
      await _playlistBox.put(playlist.name, updatedPlaylist);

      return updatedPlaylist;
    }

    // Return the original playlist if no changes were made
    return playlist;
  }

  /// Removes an audio from a playlist
  ///
  /// Throws an [ArgumentError] if the playlist doesn't exist
  Future<AudioPlaylistModel> removeAudio(
      AudioPlaylistModel playlist, AudioModel audio) async {
    // Validate playlist exists
    if (!_playlistBox.containsKey(playlist.name)) {
      throw ArgumentError('Playlist ${playlist.name} does not exist');
    }

    // Check if audio exists in playlist
    if (_checkIfPlaylistAlreadyHaveAudio(playlist, audio)) {
      // Create a new list to avoid modifying the original
      final updatedAudios = List<AudioModel>.from(playlist.audios)
        ..remove(audio);

      // Create an updated playlist model
      final updatedPlaylist = AudioPlaylistModel(
          name: playlist.name,
          audios: updatedAudios,
          created: playlist.created,
          modified: DateTime.now());

      // Save the updated playlist
      await _playlistBox.put(playlist.name, updatedPlaylist);

      return updatedPlaylist;
    }

    // Return the original playlist if no changes were made
    return playlist;
  }

  /// Checks if an audio is already in the playlist
  ///
  /// Uses path as a unique identifier to prevent duplicates
  bool _checkIfPlaylistAlreadyHaveAudio(
      AudioPlaylistModel playlist, AudioModel audio) {
    return playlist.audios
        .any((existingAudio) => existingAudio.path == audio.path);
  }

  /// Find a playlist by its name
  ///
  /// Returns null if the playlist doesn't exist
  AudioPlaylistModel? findPlaylistByName(String name) {
    return _playlistBox.get(name);
  }
}
