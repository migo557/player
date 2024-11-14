// video_player/presentation/widgets/subtitles/subtitles_selector_widget.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/router/router.dart';

import '../../../../../logic/video_player_bloc/video_player_bloc.dart';

/// A modern iOS-style subtitles selector widget that manages subtitle tracks
/// for video playback using VLC Player.
class VideoPlayerSubtitlesSelector extends HookWidget {
  const VideoPlayerSubtitlesSelector({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    // State management using hooks
    final subtitleTracks = useState<Map<int, String>>({});
    final activeTrackId = useState<int?>(-1);
    final trackCount = useState<int>(0);
    final isLoading = useState<bool>(true);

    // Load subtitle tracks on widget initialization
    useEffect(() {
      Future.wait([
        _loadSubtitleTracks(subtitleTracks),
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
          const Gap(8),
          _buildActionButtons(context),
          const Gap(16),
          if (isLoading.value)
            const CupertinoActivityIndicator()
          else
            _buildSubtitlesList(
              context,
              subtitleTracks.value,
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
              'Subtitles',
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

  // Action buttons for adding subtitles
  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: CupertinoIcons.cloud_download,
              label: 'Add from URL',
              onPressed: () => _handleAddFromUrl(context),
            ),
          ),
          const Gap(8),
          Expanded(
            child: _ActionButton(
              icon: CupertinoIcons.doc,
              label: 'Add from File',
              onPressed: () => _handleAddFromFile(context),
            ),
          ),
        ],
      ),
    );
  }

  // Subtitles list with active track indicator
  Widget _buildSubtitlesList(
    BuildContext context,
    Map<int, String> tracks,
    int? activeTrackId,
    int trackCount,
  ) {
    return Expanded(
      child: ListView(
        children: [
          _SubtitleOption(
            title: 'Off',
            isSelected: activeTrackId == -1,
            onTap: () {
              _handleTrackSelection(-1);
              context.pop();
            },
            leading: Icon(Icons.subtitles_off),
          ),
          ...tracks.entries.map(
            (entry) => _SubtitleOption(
              title: entry.value,
              subtitle: 'Track ${entry.key}',
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

  // Helper methods for loading subtitle data
  Future<void> _loadSubtitleTracks(
      ValueNotifier<Map<int, String>> tracks) async {
    final value = await state.vlcPlayerController.getSpuTracks();
    tracks.value = Map<int, String>.from(value);
  }

  Future<void> _loadActiveTrack(ValueNotifier<int?> activeTrack) async {
    final value = await state.vlcPlayerController.getSpuTrack();
    activeTrack.value = value;
  }

  Future<void> _loadTrackCount(ValueNotifier<int> count) async {
    final value = await state.vlcPlayerController.getSpuTracksCount();
    count.value = value ?? 0;
  }

  // Handler methods
  void _handleTrackSelection(int trackId) {
    state.vlcPlayerController.setSpuTrack(trackId);
  }

  Future<void> _handleAddFromUrl(BuildContext context) async {
    // TODO: Implement URL subtitle addition
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Add Subtitles from URL'),
        content: const Text('This feature is coming soon'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddFromFile(BuildContext context) async {
    // TODO: Implement file subtitle addition
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Add Subtitles from File'),
        content: const Text('This feature is coming soon'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// Helper Widgets

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 12),
      borderRadius: BorderRadius.circular(10),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const Gap(8),
          Text(label),
        ],
      ),
    );
  }
}

class _SubtitleOption extends StatelessWidget {
  const _SubtitleOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
    this.leading,
  });

  final String title;
  final String? subtitle;
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
      subtitle: subtitle != null ? Text(subtitle!) : null,
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
