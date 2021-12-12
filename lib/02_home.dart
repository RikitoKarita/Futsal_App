import 'package:flutter/material.dart';
import 'subscription/02_subscription.dart';
import 'search/02_search.dart';
import '02_history.dart';
import 'setting/02_my_account.dart';


class HomePage extends StatefulWidget {
  final String user_id;
  HomePage({Key? key,required this.user_id}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}


class _HomePage extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late String user_id;
  late PageController _pageController;
  int _screen = 0;

  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.sports_soccer ), label: "作成"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "検索"),
      BottomNavigationBarItem(icon: Icon(Icons.folder), label: "履歴"),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: "設定"),
    ];
  }

  @override
  void initState() {
    super.initState();
    this.user_id = widget.user_id;
    _pageController = PageController(
      initialPage: _screen,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FFE4),
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _screen = index;
            });
          },

          children: [
            Subscription(),
            Search(),
            History(),
            MyAccount(),

          ]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screen,
        onTap: (index) {
          setState(() {
            _screen = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeOut);
          });
        },
        items: myBottomNavBarItems(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}