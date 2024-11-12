import 'package:objectbox/objectbox.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:path_provider/path_provider.dart';
class ObjectBoxDB {
  //  The Store of this app.
  late final Store store;

  ObjectBoxDB._create(this.store);

  //  Create an instance of ObjectBox to use throughout the app.
  // static Future<ObjectBoxDB> create() async {
  //   try {
  //     final docsDir = await getApplicationDocumentsDirectory();
  //     final store = await openStore(directory: docsDir.path);
  //     return ObjectBoxDB._create(store);
  //     clog.debug('ObjectBox Created');
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}

class MyObjectBoxes {
  static late final Box<VideoModel> videos;
  

  static void init(ObjectBoxDB objectBox) {
    videos = objectBox.store.box<VideoModel>();
    
  }
}
