import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'WebViewScreen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen(String title, {super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> articles = [];
  List<dynamic> filteredArticles = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const apiKey = '1e90b0adc8104b7f829ca881ed9bfef8';
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          articles = response.data['articles'];
          filteredArticles = articles;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to load news: $e');
    }
  }

  Future<void> saveBookmark(Map<String, dynamic> article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.add(jsonEncode(article));
    await prefs.setStringList('bookmarks', bookmarks.toSet().toList());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bookmarked')),
    );
  }

  void filterArticles(String query) {
    if (query.isEmpty) {
      setState(() => filteredArticles = articles);
    } else {
      final filtered = articles.where((article) {
        final title = (article['title'] ?? '').toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
      setState(() => filteredArticles = filtered);
    }
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchNews,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search news...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: filterArticles,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (_, index) {
                  final article = filteredArticles[index];
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
                          : const Icon(Icons.image_not_supported,
                          size: 100),
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
                        icon: const Icon(Icons.bookmark_add),
                        onPressed: () => saveBookmark(article),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewScreen(url: article['url'] ?? ''),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
