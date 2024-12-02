import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/pages/audio/sub/folders/widgets/folder_songs_page.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';

class AudioFoldersPage extends StatelessWidget {
  const AudioFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildFoldersList(context),
    );
  }

  /// Creates a custom AppBar for the Audio Folders page
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Audio Folders',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Builds the list of audio folders using BlocSelector
  ///
  /// Extracts unique directory paths from all songs and displays them
  /// with folder icon, name, and song count
  Widget _buildFoldersList(BuildContext context) {
    return BlocSelector<AudiosBloc, AudiosState, AudiosSuccess?>(
      selector: (state) => state is AudiosSuccess ? state : null,
      builder: (context, state) {
        // If no successful state, return a placeholder widget
        if (state == null) return nothing;

        // Extract unique folder paths
        final List<String> folders = _extractUniqueFolders(state);

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: folders.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Colors.grey.shade200,
          ),
          itemBuilder: (context, index) =>
              _buildFolderListTile(context, folders[index], state),
        );
      },
    );
  }

  /// Extracts unique folder paths from all songs
  List<String> _extractUniqueFolders(AudiosSuccess state) {
    final List<String> folders = [];
    state.allSongs.every((element) {
      final dirPath = element.file.parent.path;
      if (!folders.contains(dirPath)) {
        folders.add(dirPath);
      }
      return true;
    });
    return folders;
  }

  /// Builds a list tile for each audio folder
  ///
  /// Displays folder icon, name, and number of songs in the folder
  Widget _buildFolderListTile(
      BuildContext context, String dirPath, AudiosSuccess state) {
    final dirName = path.basename(dirPath);
    final songsInFolder =
        state.allSongs.where((song) => song.file.parent.path == dirPath).length;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => _navigateToFolderSongs(context, dirName, dirPath),
      leading: _buildFolderIcon(),
      title: _buildFolderTitle(dirName),
      trailing: _buildSongCountBadge(songsInFolder),
    );
  }

  /// Creates a folder icon container
  Widget _buildFolderIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Icon(
        HugeIcons.strokeRoundedFolder02,
        color: Colors.blue.shade400,
        size: 28,
      ),
    );
  }

  /// Creates the folder name text
  Widget _buildFolderTitle(String dirName) {
    return Text(
      dirName,
      style: TextStyle(
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  /// Creates a badge showing the number of songs in the folder
  Widget _buildSongCountBadge(int songsInFolder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '$songsInFolder Songs',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Navigates to the folder songs page and loads directory songs
  void _navigateToFolderSongs(
      BuildContext context, String dirName, String dirPath) {
    context
        .read<AudiosBloc>()
        .add(AudiosLoadFromDirectoryEvent(directory: Directory(dirPath)));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FolderSongsPage(
          dirName: dirName,
          dirPath: dirPath,
        ),
      ),
    );
  }
}
