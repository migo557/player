import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../logic/video_player_bloc/video_player_bloc.dart';

/// A modern iOS-style audios selector widget that manages audios tracks
/// for video playback using VLC Player.
class VideoPlayerAudiosSelector extends HookWidget {
  const VideoPlayerAudiosSelector({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    // State management using hooks
    final audioTracks = useState<Map<int, String>>({});
    final activeTrackId = useState<int?>(-1);
    final trackCount = useState<int>(0);
    final isLoading = useState<bool>(true);

    // Load audio tracks on widget initialization
    useEffect(() {
      Future.wait([
        _loadAudiosTracks(audioTracks),
        _loadActiveTrack(activeTrackId),
        _loadTrackCount(trackCount),
      ]).then((_) => isLoading.value = false);
      return null;
    }, []);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          _buildHeader(context),
          const Gap(16),
          if (isLoading.value)
            const CupertinoActivityIndicator()
          else
            _buildAudiosList(
              context,
              audioTracks.value,
              activeTrackId.value,
              trackCount.value,
            ),
        ],
      ),
    );
  }

  // Header section with title and close button
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Audios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              context.pop();
            },
            child: const Icon(CupertinoIcons.xmark_circle_fill),
          ),
        ],
      ),
    );
  }

  // Audios list with active track indicator
  Widget _buildAudiosList(
    BuildContext context,
    Map<int, String> tracks,
    int? activeTrackId,
    int trackCount,
  ) {
    return Expanded(
      child: ListView(
        children: [
          _AudioOption(
            title: 'Off',
            isSelected: activeTrackId == -1,
            onTap: () {
              _handleTrackSelection(-1);
              context.pop();
            },
            leading: Icon(Icons.spatial_audio_off),
          ),
          ...tracks.entries.map(
            (entry) => _AudioOption(
              title: entry.value,
              audio: 'Track ${entry.key}',
              isSelected: activeTrackId == entry.key,
              onTap: () {
                _handleTrackSelection(entry.key);
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for loading audio data
  Future<void> _loadAudiosTracks(ValueNotifier<Map<int, String>> tracks) async {
    final value = await state.vlcPlayerController.getAudioTracks();

    tracks.value = Map<int, String>.from(value);
  }

  Future<void> _loadActiveTrack(ValueNotifier<int?> activeTrack) async {
    final value = await state.vlcPlayerController.getAudioTrack();

    activeTrack.value = value;
  }

  Future<void> _loadTrackCount(ValueNotifier<int> count) async {
    final value = await state.vlcPlayerController.getAudioTracksCount();

    count.value = value ?? 0;
  }

  // Handler methods
  void _handleTrackSelection(int trackId) {
    state.vlcPlayerController.setAudioTrack(trackId);
  }
}

class _AudioOption extends StatelessWidget {
  const _AudioOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.audio,
    this.leading,
  });

  final String title;
  final String? audio;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
      ),
      subtitle: audio != null ? Text(audio!) : null,
      trailing: isSelected
          ? const Icon(
              CupertinoIcons.check_mark,
              color: CupertinoColors.activeBlue,
            )
          : null,
      onTap: onTap,
    );
  }
}
