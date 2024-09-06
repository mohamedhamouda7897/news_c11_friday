import 'package:news_c11_friday/models/NewsData.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeGetSourceLoadingState extends HomeState {}

class HomeGetSourceErrorState extends HomeState {
  String error;

  HomeGetSourceErrorState(this.error);
}

class HomeGetSourceSuccessState extends HomeState {
  SourceResponse sourceResponse;

  HomeGetSourceSuccessState(this.sourceResponse);
}

class HomeGetNewsDataLoadingState extends HomeState {}

class HomeGetNewsDataErrorState extends HomeState {
  String error;

  HomeGetNewsDataErrorState(this.error);
}

class HomeGetNewsDataSuccessState extends HomeState {
  NewsDataResponse newsDataResponse;

  HomeGetNewsDataSuccessState(this.newsDataResponse);
}

class ChangeSourceState extends HomeState {}
