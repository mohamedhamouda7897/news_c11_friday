import 'dart:convert';

import 'package:news_c11_friday/cache_helper/cache_helper.dart';
import 'package:news_c11_friday/models/NewsData.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';
import 'package:news_c11_friday/repo/home_repo.dart';
import 'package:http/http.dart' as http;

class HomeRemoteRepoImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(String sourceId) async {
    Uri url = Uri.https("newsapi.org", "/v2/everything", {
      "apiKey": "dc3d106e730c4256b8c275d9da58d090",
      "sources": sourceId,
    });
    http.Response response = await http.get(url);

    var jsonFormat = jsonDecode(response.body);

    NewsDataResponse newsDataResponse = NewsDataResponse.fromJson(jsonFormat);

    return newsDataResponse;
  }

  @override
  Future<SourceResponse> getSources(String id) async {
    Uri url = Uri.https("newsapi.org", "/v2/top-headlines/sources",
        {"apiKey": "dc3d106e730c4256b8c275d9da58d090", "category": id});

    http.Response response = await http.get(url);

    Map<String, dynamic> jsonFormat = jsonDecode(response.body);

    SourceResponse sourceResponse = SourceResponse.fromJson(jsonFormat);

    await CacheHelper.saveSources(sourceResponse);
    return sourceResponse;
  }
}
