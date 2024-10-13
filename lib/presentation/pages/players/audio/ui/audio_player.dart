import 'dart:io';

import 'package:flutter/material.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  TextEditingController textEditingController = TextEditingController();

  List<FileSystemEntity> fetchMusicData() {
    List<FileSystemEntity> files = [];
    final dir = Directory.fromUri(Uri.file("/home/liony/Downloads/"));
    final data = dir.listSync(recursive: true);
    for (final i in data) {
      files.add(i);
    }
    return files;
  }

  getFileName(String filePath) {
    int lastSeparatorIndex = filePath.lastIndexOf("/");
    return lastSeparatorIndex == -1
        ? filePath
        : filePath.substring(lastSeparatorIndex + 1);
  }

  deleteFile(FileSystemEntity fileEntity) async {
    final file = File(fileEntity.path);
    await file.delete();
    setState(() {});
  }

  renameFile(FileSystemEntity fileEntity) async {
    final file = File(fileEntity.path);
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = "${path.substring(0, lastSeparator + 1)}Hello";
    await file.rename(newPath);
    setState(() {});
  }

  createFile(contents) async {
    final File file = File('/home/liony/Downloads/helloooooooooooooooooo.txt');
    final sink = file.openWrite(mode: FileMode.append);

    sink.write(contents);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player "),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              fetchMusicData();
              setState(() {});
              
            },
            child: const Text("Fetch Data"),
          ),
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
            onPressed: () {
              createFile(textEditingController.text);
              textEditingController.clear();
            },
            child: const Text("Save File"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: fetchMusicData().length,
                itemBuilder: (context, index) {
                  final FileSystemEntity file = fetchMusicData()[index];

                  final String fileName = getFileName(file.path);
                  return ListTile(
                    onTap: () {
                      // deleteFile(file);
                      renameFile(file);
                    },
                    leading: !fileName.contains(".")
                        ? const Icon(Icons.folder)
                        : const Icon(Icons.file_open),
                    title: Text(fileName),
                    subtitle: Text(file.path),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
