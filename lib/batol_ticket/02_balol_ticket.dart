import 'package:flutter/material.dart';
import 'package:futsal_develop/setting/02_my_account.dart';
import '02_myBatol_ticket.dart';
import '02_reservedBatol_ticket.dart';

class BatolTicket extends StatefulWidget {
  @override
  _BatolTicketState createState() => _BatolTicketState();
}


class _BatolTicketState extends State<BatolTicket> {
  final _tab = <Tab> [
    Tab( text:'自分開催'),
    Tab( text:'参加予定'),
  ];

  @override
  int _screen = 0;
  TabPage(int curPage){
    this._screen = curPage;
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _screen,
      length: _tab.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0),
          child:
          AppBar(
              title: Text("対戦チケット管理",
                  style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 18,)),
              iconTheme: const IconThemeData(
                color: const Color(0xFFFFFFFF),
              ),
              backgroundColor: const Color(0xFF3CB371),
              bottom: TabBar(
                tabs: _tab,
                labelColor: const Color(0xFFFFFFFF),
                unselectedLabelColor: const Color(0xFFFFFFFF),
                indicatorColor: const Color(0xFFFFFFFF),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings,color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyAccount()));
                    }
                )]
          ),),
        drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 60.0,
                  child: DrawerHeader(
                    child: Text("メニュー"),
                    decoration: BoxDecoration(
                    ),
                  ),
                ),
                ListTile(
                  title: Text('操作手順書',style: TextStyle(color: const Color(
                      0xFF737373),)),
                  // onTap: _manualURL,
                ),
                ListTile(
                  title: Text('問い合わせ',style: TextStyle(color: const Color(
                      0xFF737373),)),
                  // onTap: _FAQURL,
                )
              ],
            )
        ),
        body: TabBarView(
          children: <Widget>[
            myBatolTicket(),
            reservedBatolTicket(),
          ],
        ),
      ),
    );
  }
}
