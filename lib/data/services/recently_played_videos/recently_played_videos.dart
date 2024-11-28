import '../../../base/db/hive_service.dart';

class RecentlyPlayedVideosServices {
  // The Hive box that stores the recently played videos
  final _box = MyHiveBoxes.recentlyPlayedVideos;
  final String _key =
      'recentlyPlayedList'; // Key for the list of recently played videos

  // Helper method to fetch the current list of recently played videos from Hive
  List _getRecentVideos() {
    return _box.get(_key, defaultValue: []);
  }

  // Helper method to save the list of recently played videos to Hive
  Future<void> _saveRecentVideos(List videos) async {
    try {
      await _box.put(_key, videos);
    } catch (e) {
      throw Exception("Failed to save recently played videos: $e");
    }
  }

  // Update the list by adding the accessed video to the front (newest first)
  Future<void> update(String path) async {
    try {
      // Fetch the current list of recently played videos
      List recentVideos = _getRecentVideos();

      // Remove the video if it already exists in the list to avoid duplicates
      recentVideos.remove(path);

      // Add the video to the front of the list (newest first)
      recentVideos.insert(0, path);

      // Save the updated list to Hive only if it's changed
      await _saveRecentVideos(recentVideos);
    } catch (e) {
      throw Exception("Error updating recently played videos: $e");
    }
  }

  // Retrieve the list of recently played videos (newest first)
  List getRecentlyPlayed() {
    return _getRecentVideos();
  }

  // Limit the list to a maximum size (e.g., most recent 'n' videos)
  Future<void> limitListSize(int maxSize) async {
    try {
      // Fetch the current list
      List recentVideos = _getRecentVideos();

      // Trim the list to the maximum size if necessary
      if (recentVideos.length > maxSize) {
        recentVideos = recentVideos.sublist(0, maxSize);
        await _saveRecentVideos(recentVideos);
      }
    } catch (e) {
      throw Exception("Error limiting the list size: $e");
    }
  }

  // Check if a video is in the recently played list
  bool isRecentlyPlayed(String path) {
    List recentVideos = _getRecentVideos();
    return recentVideos.contains(path);
  }
}
