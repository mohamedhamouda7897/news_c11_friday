import 'package:news_c11_friday/cache_helper/cache_helper.dart';
import 'package:news_c11_friday/models/NewsData.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';
import 'package:news_c11_friday/repo/home_repo.dart';

class HomeLocalRepoImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(String sourceId) {
    // TODO: implement getNewsData
    throw UnimplementedError();
  }

  @override
  Future<SourceResponse> getSources(String id) async {
    SourceResponse? sourceResponse = await CacheHelper.getSourcesData();
    return sourceResponse!;
  }
}
