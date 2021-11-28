import 'package:flutter/material.dart';
import 'package:futsal_develop/signin/02_signin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../00_admob_baner.dart';
import '../02_home.dart';
import './../common/01_will_pop_scope.dart';
import './../common/01_convert_weekday_name.dart';
import 'package:provider/provider.dart';
import '01_search_level_model.dart';

class SearchLevel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // デバイスの画面サイズを取得
    final Size _size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SearchModel>(
      create: (_) => SearchModel()..fetchFootsalBatol(context),
      child: Consumer<SearchModel>(
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: willPopCallback,
              child: Stack(
              children: [
              DefaultTabController(
              length: 3,
              initialIndex: 1,
            child: Scaffold(
              backgroundColor: const Color(0xFFF2FFE4),
              appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
          child:AppBar(
                title: Text('対戦相手を探す'),
              ),),
              // drawer: Drawer(
              //     child: ListView(
              //   children: <Widget>[
              //     Container(
              //       height: 60.0,
              //       child: DrawerHeader(
              //         child: Text("メニュー"),
              //         decoration: BoxDecoration(),
              //       ),
              //     ),
              //     ListTile(
              //       title: Text('利用規約同意書',
              //           style: TextStyle(color: Colors.black54)),
              //       // onTap: _manualURL,
              //     ),
              //     ListTile(
              //       title: Text('アプリ操作手順書',
              //           style: TextStyle(color: Colors.black54)),
              //       // onTap: _FAQURL,
              //     )
              //   ],
              // )),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              left: 8.0,
                              right: 8.0,
                              bottom: 16.0,
                            ),
                            child: TextFormField(
                              controller: model.textController,
                              textInputAction: TextInputAction.done,
                              onChanged: (text) async {
                                 // model.changePublicSearchWords(text);
                                if (text.isNotEmpty) {
                                  model.showFilteredBatol = true;
                                  model.startPublicBatolFiltering();
                                  await model.filterPublicBatol(text);
                                } else {
                                  model.showFilteredBatol = false;
                                  model.endPublicBatolFiltering();
                                }
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                errorText: model.errorText == ''
                                    ? null
                                    : model.errorText,
                                labelText: '対戦相手の希望レベルで検索する',
                                border: OutlineInputBorder(),
                                suffixIcon: model.textController.text.isEmpty
                                    ? SizedBox()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          model.textController.clear();
                                          model.showFilteredBatol = false;
                                          model.errorText = '';
                                          model.endPublicBatolFiltering();
                                        },
                                      ),
                              ),
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1.0,
                              ),
                            ),
                          ),
                  Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification:
                                  (ScrollNotification _notification) {
                                /// Load more:
                                if (_notification.metrics.pixels ==
                                    _notification.metrics.maxScrollExtent) {
                                  // 前のクエリを取得中の場合は待つ
                                  if (model.isLoadingMore) {
                                    return false;
                                  }
                                  // 前のクエリの取得が済んでいる場合はロードする
                                  else {
                                    // さらに読み込める状態の場合
                                    if (model.canLoadMore) {
                                      // 絞り込み中の場合
                                      if (model.canLoadMoreFiltered) {
                                        model
                                            .loadMoreFilteredPublicFootsalBatol();
                                      }
                                      // 絞り込み中でない場合
                                      else {
                                        model.loadMorePublicFootsalBatol();
                                      }
                                    }
                                    // もう読み込めない状態の場合
                                    else {
                                      return false;
                                    }
                                  }
                                }

                                /// Reload:
                                if (_notification.metrics.pixels == 0) {
                                  model.canReload = true;
                                }
                                if (_notification.metrics.pixels < -100) {
                                  if (!model.showFilteredBatol &&
                                      model.canReload &&
                                      !model.isLoading) {
                                    model.canReload = false;
                                    model.showReloadWidget = true;
                                     // Vibrate.feedback(FeedbackType.medium);
                                    model.loadPublicFootsalBatol();
                                  }
                                }
                                return false;
                              },
                              child: ListView(
                                key: PageStorageKey(2), // スクロール位置の保存に必要
                                children: [
                                  Column(
                                    children: [
                                      model.showReloadWidget
                                          ? Container(
                                              padding: const EdgeInsets.all(
                                                4.0,
                                              ),
                                              width: 30,
                                              height: 30,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SizedBox(),
                                      model.showFilteredBatol
                                          ? _BatolCards(
                                              model.filteredFootsalBatol,
                                              _size,
                                              model.userId,
                                              'public_tab',
                                              context)
                                          : _BatolCards(
                                              model.FootsalBatol,
                                              _size,
                                              model.userId,
                                              'public_tab',
                                              context),
                                      FlatButton(
                                        onPressed: model.showFilteredBatol
                                            ? model.canLoadMoreFiltered
                                                ? () async {
                                                    await model
                                                        .loadMoreFilteredPublicFootsalBatol();
                                                  }
                                                : null
                                            : model.canLoadMore
                                                ? () async {
                                                    await model
                                                        .loadMorePublicFootsalBatol();
                                                  }
                                                : null,
                                        child: model.isFiltering
                                            ? Text('検索中...')
                                            : model.isLoading
                                                ? SizedBox()
                                                : model.showFilteredBatol
                                                    ? model.canLoadMoreFiltered
                                                        ? Text('検索結果をさらに読み込む')
                                                        : model
                                                                .existsFilteredBatol
                                                            ? Text('検索結果は以上です')
                                                            : Text(
                                                                '検索結果が見つかりません')
                                                    : model.canLoadMore
                                                        ? Text('さらに読み込む')
                                                        : model.existsBatol
                                                            ? Text('以上です')
                                                            : Text(
                                                                '開催予定のフットサルがありません'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      model.isLoading && !model.showReloadWidget
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
              ],
          )
          );
        },
      ),
    );
  }
}

/// レシピのカード一覧のウィジェトを返す関数
Widget _BatolCards(
    List batol, Size size, String userId, String tab, context) {
  // bool _isMyRecipe;
  // 画面に表示するカードのリスト
  List<Widget> list = <Widget>[];
  print(batol.length);
  for (int i = 0; i < batol.length; i++) {
    // _isMyRecipe = batol[i].userId == userId;
    // Card ウィジェットをループの個数だけリストに追加する
    list.add(
      Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Color(0xFFDADADA),
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(), //変更予定
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: size.width - 148,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 26,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width - 184,
                                child: Text(
                                  '${batol[i].teamName}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 4.0,
                                ),
                                child: Text('${batol[i].desiredLevel}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),)
                                    // ? Icon(
                                    //     Icons.favorite,
                                    //     size: 18.0,
                                    //     color: Color(0xFFF39800),
                                    //   )
                                    // : Icon(
                                    //     Icons.favorite_border,
                                    //     size: 18.0,
                                    //     color: Colors.grey,
                                    //   ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            '${batol[i].location}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        // Container(
                        //   height: 16,
                        //   child: tab == 'my_tab' || tab == 'public_tab'
                        //       ? batol[i].updatedAt == null
                        //           ? SizedBox()
                        //           : Text(
                        //               '更新：${'${batol[i].updatedAt.toDate()}'.substring(0, 10)} '
                        //               '${convertWeekdayName(batol[i].updatedAt.toDate().weekday)}',
                        //               maxLines: 1,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(
                        //                 fontSize: 12,
                        //                 color: Color(0xFF777777),
                        //               ),
                        //             )
                        //       : batol[i].likedAt == null
                        //           ? SizedBox()
                        //           : Text(
                        //               'お気に入り：${'${batol[i].likedAt.toDate()}'.substring(0, 10)} '
                        //               '${convertWeekdayName(batol[i].likedAt.toDate().weekday)}',
                        //               maxLines: 1,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(
                        //                 fontSize: 12,
                        //                 color: Color(0xFF777777),
                        //               ),
                        //             ),
                        // )
                      ],
                    ),
                  ),
                ),
                // ),
                //   tab == 'my_tab' && _isMyRecipe && recipes[i].isPublic
                //       ? Positioned(
                //     top: 0.0,
                //     right: 0.0,
                //     child: Container(
                //       padding: const EdgeInsets.all(2.0),
                //       color: Color(0xFFF39800),
                //       child: Center(
                //         child: Text(
                //           '公開中',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 10.0,
                //           ),
                //         ),
                //       ),
                //     ),
                //   )
                //       : SizedBox(),
                //   tab == 'my_tab' &&
                //       _isMyRecipe &&
                //       recipes[i].isPublic == false
                //       ? Positioned(
                //     top: 0.0,
                //     right: 0.0,
                //     child: Container(
                //       padding: const EdgeInsets.all(2.0),
                //       color: Colors.grey,
                //       child: Center(
                //         child: Text(
                //           '非公開',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 10.0,
                //           ),
                //         ),
                //       ),
                //     ),
                //   )
                //       : SizedBox(),
                //   tab == 'public_tab' &&
                //       _isMyRecipe &&
                //       recipes[i].isPublic
                //       ? Positioned(
                //     top: 0.0,
                //     right: 0.0,
                //     child: Container(
                //       padding: const EdgeInsets.all(2.0),
                //       color: Color(0xFFF39800),
                //       child: Center(
                //         child: Text(
                //           'わたし',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 10,
                //           ),
                //         ),
                //       ),
                //     ),
                //   )
                //       : SizedBox(),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  return Column(
    children: list,
  );
}
