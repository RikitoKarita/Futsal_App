import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './../signin/02_signin.dart';

class SearchModel extends ChangeNotifier {
  late FirebaseAuth auth;
  late String userId;
  late int loadLimit;
  late bool canReload;

  // QuerySnapshot favoriteQuerySnapshot;
  // List<String> favoriteDocIdList;
  late String errorText = '';
  late bool isLoading = false;
  late bool isLoadingMore = false;
  late List FootsalBatol = [];
  late List filteredFootsalBatol = [];
  late QueryDocumentSnapshot lastVisible;
  late QueryDocumentSnapshot filteredLastVisible;
  late bool canLoadMore = false;
  late bool canLoadMoreFiltered = false;
  late bool existsBatol = false;
  late bool existsFilteredBatol = false;
  late bool isFiltering = false;
  late Query filterQuery;
  late bool showFilteredBatol;
  late bool showReloadWidget;
  late TextEditingController textController = TextEditingController();

  SearchModel() {
    this.auth = FirebaseAuth.instance;
    this.userId = '';
    this.loadLimit = 10;
    this.canReload = true;
    this.errorText = '';
    this.isLoading = false;
    this.isLoadingMore = false;
    this.FootsalBatol = [];
    // this.filteredFootsalBatol = [];
    //  this.lastVisible = null;
    //  this.filteredLastVisible = null;
    this.canLoadMore = false;
    this.canLoadMoreFiltered = false;
    this.existsBatol = false;
    this.existsFilteredBatol = false;
    this.isFiltering = false;
    this.showFilteredBatol = false;
    // this.filterQuery = null;
    this.showReloadWidget = false;
    this.textController = TextEditingController();
  }

  Future<void> fetchFootsalBatol(context) async {
    startPublicTabLoading();
    if (auth.currentUser == null) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
      );
    } else {
      this.userId = auth.currentUser!.uid;
    }
    await loadPublicFootsalBatol();
    notifyListeners();
  }


  Future<void> loadPublicFootsalBatol() async {
    startPublicTabLoading();

    /// 他社開催予定
    QuerySnapshot _publicSnap = await FirebaseFirestore.instance
        .collection('BATOL_TBL')
        // .where('isPublic', isEqualTo: true)
        // .orderBy('updatedAt', descending: true)
        .limit(this.loadLimit)
        .get();

    /// 取得するレシピが1件以上あるか確認
    if (_publicSnap.docs.length == 0) {
      /// 1件も存在しない場合
      this.existsBatol = false;
      this.canLoadMore = false;
      this.FootsalBatol = [];
    } else if (_publicSnap.docs.length < this.loadLimit) {
      /// 1件以上10件未満存在する場合
      this.existsBatol = true;
      this.canLoadMore = false;
      this.lastVisible = _publicSnap.docs[_publicSnap.docs.length - 1];
      final _publicFootsalBatol =
          _publicSnap.docs.map((doc) => Batol(doc)).toList();
      this.FootsalBatol = _publicFootsalBatol;
    } else {
      /// 10件以上存在する場合
      this.existsBatol = true;
      this.canLoadMore = true;
      this.lastVisible = _publicSnap.docs[_publicSnap.docs.length - 1];
      final _publicFootsalBatol =
          _publicSnap.docs.map((doc) => Batol(doc)).toList();
      this.FootsalBatol = _publicFootsalBatol;
    }

    endPublicTabLoading();
    hidePublicLoadingWidget();
    notifyListeners();
  }

  /// みんなのレシピをさらに10件取得
  Future loadMorePublicFootsalBatol() async {
    startLoadingMorePublicBatol();

    QuerySnapshot _snap = await FirebaseFirestore.instance
        .collection('BATOL_TBL')
        // .where('isPublic', isEqualTo: true)
        // .orderBy('updatedAt', descending: true)
        .startAfterDocument(this.lastVisible)
        .limit(this.loadLimit)
        .get();

    /// 新たに取得するレシピが残っているか確認
    if (_snap.docs.length == 0) {
      this.canLoadMore = false;
    } else if (_snap.docs.length < this.loadLimit) {
      this.canLoadMore = false;
      this.lastVisible = _snap.docs[_snap.docs.length - 1];
      final _moreFootsalBatol = _snap.docs.map((doc) => Batol(doc)).toList();
      this.FootsalBatol.addAll(_moreFootsalBatol);
    } else {
      this.canLoadMore = true;
      this.lastVisible = _snap.docs[_snap.docs.length - 1];
      final _moreFootsalBatol = _snap.docs.map((doc) => Batol(doc)).toList();
      this.FootsalBatol.addAll(_moreFootsalBatol);
    }

    // await checkPublicBatolFavoriteState();

    endLoadingMorePublicBatol();
    notifyListeners();
  }

  Future<void> filterPublicBatol(String word) async {
    /// ステイタスを検索中に更新
    startPublicBatolFiltering();

    // /// 検索文字数が2文字に満たない場合は検索を行わず、検索結果のリストを空にする
    // if (input.length < 2) {
    //   this.publicBatolTab.filteredBatols = [];
    //   endPublicBatolFiltering();
    //   return;
    // }

    // /// 検索用フィールドに入力された文字列の前処理
    // List<String> _words = input.trim().split(' ');
    //
    // /// 文字列のリストを渡して、bi-gram を実行
    // List tokens = tokenize(_words);

    /// クエリの生成（bi-gram の結果のトークンマップを where 句に反映）
    Query _query = await FirebaseFirestore.instance
        .collection('BATOL_TBL')
        .where('DESIRED_LEVEL', isEqualTo: '$word').limit(this.loadLimit);
    // .where('isPublic', isEqualTo: true);
    /// 検索に用いたクエリをクラス変数に保存
    this.filterQuery = _query;

    QuerySnapshot _snap = await _query.get();

    /// 絞り込んだレシピが1件以上あるか確認
    if (_snap.docs.length == 0) {
      this.existsFilteredBatol = false;
      this.canLoadMoreFiltered = false;
      this.filteredFootsalBatol = [];
    } else if (_snap.docs.length < this.loadLimit) {
      this.existsFilteredBatol = true;
      this.canLoadMoreFiltered = false;
      this.filteredLastVisible =
      _snap.docs[_snap.docs.length - 1];
      final _filteredBatols = _snap.docs.map((doc) => Batol(doc)).toList();
      print(_filteredBatols);
      this.filteredFootsalBatol = _filteredBatols;
    } else {
      this.existsFilteredBatol = true;
      this.canLoadMoreFiltered = true;
      this.filteredLastVisible =
      _snap.docs[_snap.docs.length - 1];
      final _filteredBatols = _snap.docs.map((doc) => Batol(doc)).toList();
      this.filteredFootsalBatol = _filteredBatols;
    }

    // await checkPublicFilteredBatolFavoriteState();

    /// ステイタスを検索終了に更新
    endPublicBatolFiltering();
    notifyListeners();
  }
  

  Future<void> loadMoreFilteredPublicFootsalBatol() async {
    startLoadingMorePublicBatol();

    /// 前回の検索クエリを元にスナップショットを取得
    QuerySnapshot _snap = await this
        .filterQuery
        .startAfterDocument(this.filteredLastVisible)
        .get();

    /// 新たに取得するレシピが残っているか確認
    if (_snap.docs.length == 0) {
      this.canLoadMoreFiltered = false;
    } else if (_snap.docs.length < this.loadLimit) {
      this.canLoadMoreFiltered = false;
      this.filteredLastVisible = _snap.docs[_snap.docs.length - 1];
      final _filteredFootsalBatol = _snap.docs.map((doc) => Batol(doc)).toList();
      this.filteredFootsalBatol.addAll(_filteredFootsalBatol);
    } else {
      this.canLoadMoreFiltered = true;
      this.filteredLastVisible = _snap.docs[_snap.docs.length - 1];
      final _filteredFootsalBatol = _snap.docs.map((doc) => Batol(doc)).toList();
      this.filteredFootsalBatol.addAll(_filteredFootsalBatol);
    }

    // await checkPublicFilteredBatolFavoriteState();

    endLoadingMorePublicBatol();
    notifyListeners();
  }

  // void startMyTabLoading() {
  //   this.myBatolTab.isLoading = true;
  //   notifyListeners();
  // }
  //
  // void endMyTabLoading() {
  //   this.myBatolTab.isLoading = false;
  //   notifyListeners();
  // }

  void startPublicTabLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endPublicTabLoading() {
    this.isLoading = false;
    notifyListeners();
  }
  
  void startLoadingMorePublicBatol() {
    this.isLoadingMore = true;
    notifyListeners();
  }

  void endLoadingMorePublicBatol() {
    this.isLoadingMore = false;
    notifyListeners();
  }
  
  void startPublicBatolFiltering() {
    this.isFiltering = true;
    notifyListeners();
  }

  void endPublicBatolFiltering() {
    this.isFiltering = false;
    notifyListeners();
  }
  
  void hidePublicLoadingWidget() {
    this.showReloadWidget = false;
    notifyListeners();
  }
}

class Batol {
  Batol(DocumentSnapshot doc) {
    this.batolDate = doc.get('BATOL_DATE');
    this.desiredLevel = doc.get('DESIRED_LEVEL');
    this.freespace = doc.get('FREESPACE');
    this.location = doc.get('LOCATION');
    this.reservedFlg = doc.get('RESERVED_FLG');
    this.teamName = doc.get('TEAM_NAME');
  }

  // late Timestamp createdAt;
  // late Timestamp updatedAt;
  late String batolDate;
  late String desiredLevel;
  late String freespace;
  late String location;
  String reservedFlg = '0';
  late String teamName;
  }
