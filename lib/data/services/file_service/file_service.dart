// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart' as pth;

abstract class FileServiceBase {
  Future<void> deleteFile(String path);
  Future<void> renameFile(String oldFilePath, String newFileName);
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
      rethrow;
    }
  }

  //-- Rename a file at the specific path
  @override
  Future<void> renameFile(String oldFilePath, String newFileName) async {
    try {
      final oldFile = File(oldFilePath);
      if (await oldFile.exists()) {
        final ext = pth.extension(oldFilePath);
        final newFilePath = '${oldFile.parent.path}/$newFileName$ext';
        await oldFile.rename(newFilePath);
      }
    } catch (e) {
      rethrow;
    }
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
      rethrow;
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
      rethrow;
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
