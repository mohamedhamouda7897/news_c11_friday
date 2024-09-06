import 'package:news_c11_friday/models/NewsData.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';

abstract class HomeRepo {

  Future<SourceResponse> getSources(String id);

  Future<NewsDataResponse> getNewsData(String sourceId);
}