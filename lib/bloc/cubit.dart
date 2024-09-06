import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c11_friday/models/NewsData.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';

import 'package:news_c11_friday/bloc/states.dart';
import 'package:news_c11_friday/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitState());

  NewsDataResponse? newsDataResponse;
  SourceResponse? sourceResponse;
  int selectedSourceIndex = 0;

  static HomeCubit get(context) => BlocProvider.of(context);

  changeSources(int index) async {
    selectedSourceIndex = index;
    newsDataResponse = null;
    sourceResponse = null;
    await Future.delayed(Duration(milliseconds: 500));
    emit(ChangeSourceState());
  }

  Future<void> getSources(String id) async {
    emit(HomeGetSourceLoadingState());
    try {
      SourceResponse sourceResponse = await repo.getSources(id);

      this.sourceResponse = sourceResponse;
      getNewsData(sourceResponse.sources![selectedSourceIndex].id!);
      emit(HomeGetSourceSuccessState(sourceResponse));
    } catch (e) {
      emit(HomeGetSourceErrorState("Something went Wrong"));
    }
  }

  Future<void> getNewsData(String sourceId) async {
    try {
      emit(HomeGetNewsDataLoadingState());

      NewsDataResponse newsDataResponse = await repo.getNewsData(sourceId);

      this.newsDataResponse = newsDataResponse;
      emit(HomeGetNewsDataSuccessState(newsDataResponse));
    } catch (e) {
      emit(HomeGetNewsDataErrorState("something went wrong"));
    }
  }
}
