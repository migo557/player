// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as pth;
import 'package:velocity_x/velocity_x.dart';

abstract class FileServiceBase {
  Future<void> deleteFile(String path);
  Future<void> renameFile(String oldFilePath, String newFileName, BuildContext context);
  String getFileNameWithExtension(String path);
  Future<void> hideFile(String filePath);
  Future<void> unhideFile(String filePath);
  bool isFileHidden(String filePath);
  Future<void> toggleHideFile(String filePath);
}

class FileService implements FileServiceBase {
  //-- Delete a file at the specific path
  @override
  Future<void> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      clog.error(e.toString());
    }
  }

/// Renames a file at the specified path, handling potential issues like invalid characters or permissions.
  @override
  Future<void> renameFile(String oldFilePath, String newFileName, BuildContext context) async {
    try {
      final oldFile = File(oldFilePath);

      // Check if the old file exists
      if (await oldFile.exists()) {
        // Sanitize the new filename to avoid issues with special characters
        final sanitizedFileName = _sanitizeFileName(newFileName);

        // Ensure the file extension is preserved
        final ext = pth.extension(oldFilePath);
        final newFilePath = '${oldFile.parent.path}/$sanitizedFileName$ext';

        // Rename the file
        await oldFile.rename(newFilePath);

        // Optionally, trigger any necessary UI updates after renaming the file
 
      } else {
        throw ("The file does not exist.");
      }
    } catch (e) {
      // Catching any errors and displaying a message to the user
      clog.error("Error renaming file: ${e.toString()}");

      VxToast.show(
        context,
        msg: "Failed to rename the file: ${e.toString()}",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  /// Helper method to sanitize the new file name by removing invalid characters.
  String _sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }

  @override
  String getFileNameWithExtension(String path) {
    return pth.basenameWithoutExtension(path);
  }

  //-- Hide a file by adding a dot prefix
  @override
  Future<void> hideFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final directory = file.parent.path;
        final fileName = pth.basename(filePath);
        if (!fileName.startsWith('.')) {
          final newPath = '$directory/.$fileName';
          await file.rename(newPath);
        }
      }
    } catch (e) {
      clog.error(e.toString());
    }
  }

  //-- Unhide a file by removing the dot prefix
  @override
  Future<void> unhideFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final directory = file.parent.path;
        final fileName = pth.basename(filePath);
        if (fileName.startsWith('.')) {
          final newPath = '$directory/${fileName.substring(1)}';
          await file.rename(newPath);
        }
      }
    } catch (e) {
      clog.error(e.toString());
    }
  }

  //-- Check if a file is hidden
  @override
  bool isFileHidden(String filePath) {
    return pth.basename(filePath).startsWith('.');
  }

  //-- Toggle hide/unhide a file
  @override
  Future<void> toggleHideFile(String filePath) async {
    if (isFileHidden(filePath)) {
      await unhideFile(filePath);
    } else {
      await hideFile(filePath);
    }
  }
}
