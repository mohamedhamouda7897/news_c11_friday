import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_c11_friday/apis/api_manager.dart';
import 'package:news_c11_friday/bloc/cubit.dart';
import 'package:news_c11_friday/bloc/states.dart';
import 'package:news_c11_friday/main.dart';
import 'package:news_c11_friday/repo/home_local_repo_impl.dart';
import 'package:news_c11_friday/repo/home_remote_repo_impl.dart';
import 'package:news_c11_friday/screens/news_item.dart';
import 'package:news_c11_friday/screens/tab_item.dart';

class TabBarWidget extends StatelessWidget {
  String id;

  TabBarWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) =>
            HomeCubit(!hasInternet ? HomeRemoteRepoImpl() : HomeLocalRepoImpl())
              ..getSources(id),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeGetSourceLoadingState ||
                state is HomeGetNewsDataLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is ChangeSourceState) {
              HomeCubit.get(context).getSources(id);
            }

            if (state is HomeGetSourceErrorState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeGetSourceErrorState) {
              return Center(child: Text(state.error));
            }
            if (state is HomeGetSourceSuccessState ||
                state is HomeGetNewsDataSuccessState) {
              return Column(children: [
                DefaultTabController(
                    length: HomeCubit.get(context)
                            .sourceResponse
                            ?.sources
                            ?.length ??
                        0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          onTap: (value) {
                            HomeCubit.get(context).changeSources(value);
                          },
                          tabs: HomeCubit.get(context)
                              .sourceResponse!
                              .sources!
                              .map((e) => TabItem(
                                    source: e,
                                    isSelected: HomeCubit.get(context)
                                            .sourceResponse!
                                            .sources!
                                            .elementAt(HomeCubit.get(context)
                                                .selectedSourceIndex) ==
                                        e,
                                  ))
                              .toList()),
                    )),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                    itemBuilder: (context, index) {
                      return NewsItem(
                        article: HomeCubit.get(context)
                            .newsDataResponse!
                            .articles![index],
                      );
                    },
                    itemCount: HomeCubit.get(context)
                            .newsDataResponse
                            ?.articles
                            ?.length ??
                        0,
                  ),
                )
              ]);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
    // return FutureBuilder(
    //   future: ApiManager.getSources(id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //
    //     if (snapshot.hasError) {
    //       return Text("Somthing went wrong");
    //     }
    //
    //     var sources = snapshot.data?.sources ?? [];
    //     return Column(
    //       children: [
    //         DefaultTabController(
    //             length: sources.length,
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: TabBar(
    //                   isScrollable: true,
    //                   dividerColor: Colors.transparent,
    //                   indicatorColor: Colors.transparent,
    //                   onTap: (value) {
    //                     selectedTabIndex = value;
    //                     setState(() {});
    //                   },
    //                   tabs: sources
    //                       .map((e) => TabItem(
    //                             source: e,
    //                             isSelected:
    //                                 sources.elementAt(selectedTabIndex) == e,
    //                           ))
    //                       .toList()),
    //             )),
    //         FutureBuilder(
    //           future:
    //               ApiManager.getNewsData(sources[selectedTabIndex].id ?? ""),
    //           builder: (context, snapshot) {
    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //               return Center(child: CircularProgressIndicator());
    //             }
    //
    //             if (snapshot.hasError) {
    //               return Text("Somthing went wrong");
    //             }
    //
    //             var articles = snapshot.data?.articles ?? [];
    //             return Expanded(
    //               child: ListView.separated(
    //                 separatorBuilder: (context, index) => SizedBox(
    //                   height: 15,
    //                 ),
    //                 itemBuilder: (context, index) {
    //                   return NewsItem(
    //                     article: articles[index],
    //                   );
    //                 },
    //                 itemCount: articles.length,
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );
  }
}
