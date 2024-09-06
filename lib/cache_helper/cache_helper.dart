import 'dart:io';

import 'package:hive/hive.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheHelper {
  static Future<void> saveSources(SourceResponse source) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'NewsData',
      {'sources'},
      path: appDocDirectory
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    final sourcesBox = await collection.openBox<Map>('sources');

    await sourcesBox.put("sourcesData", source.toJson());
  }

  static Future<SourceResponse?> getSourcesData() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'NewsData',
      {'sources'},
      path: appDocDirectory
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    final sourcesBox = await collection.openBox<Map>('sources');

    final sources = await sourcesBox.get('sourcesData');

    SourceResponse sourceResponse = SourceResponse.fromJson(sources!);
    return sourceResponse;
  }
}
