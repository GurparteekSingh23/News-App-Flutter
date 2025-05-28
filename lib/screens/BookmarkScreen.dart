import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'WebViewScreen.dart';


class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key, required String title});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('bookmarks') ?? [];

    setState(() {
      bookmarks = saved.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();
    });
  }

  Future<void> removeBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('bookmarks') ?? [];

    saved.removeWhere((item) => jsonDecode(item)['url'] == url);
    await prefs.setStringList('bookmarks', saved);

    loadBookmarks();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from bookmarks')),
    );
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMMM, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks yet.'))
          : ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (_, index) {
          final article = bookmarks[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: article['urlToImage'] != null
                  ? Image.network(
                article['urlToImage'],
                width: 100,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.image_not_supported, size: 100),
              title: Text(
                article['title'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['description'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${article['source']?['name'] ?? ''} • ${formatDate(article['publishedAt'] ?? '')}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => removeBookmark(article['url']),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WebViewScreen(url: article['url'] ?? ''),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
