import 'package:flutter/material.dart';
import 'package:newsappflutter/screens/SettingsScreen.dart';
import 'BookmarkScreen.dart';
import 'NewsScreen.dart';



class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) =>
                        SettingsScreen()
                     ),
                   );
                 },
                 child: Icon(Icons.settings)),
           )
          ],
          centerTitle: true,
          title: const Text('Flutter News App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.article), text: 'News'),
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewsScreen( 'News Feed'),
            BookmarksScreen(title: 'Bookmarks'),
          ],
        ),
      ),
    );
  }
}
