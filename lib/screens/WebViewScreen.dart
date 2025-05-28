import 'package:flutter/material.dart';


class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  // late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // _controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(NavigationDelegate(
    //     onPageFinished: (_) => setState(() => _isLoading = false),
    //   ))
    //   ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _reloadPage() async {
    setState(() => _isLoading = true);
    // _controller.reload();
  }

  // Future<bool> _onWillPop() async {
  //   // if (await _controller.canGoBack()) {
  //   //   _controller.goBack();
  //   //   return false;
  //   // }
  //   // return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full Article")),
      // body: Stack(
      //   children: [
      //     RefreshIndicator(
      //       onRefresh: _reloadPage,
      //       child: WebViewWidget(controller: _controller),
      //     ),
      //     if (_isLoading)
      //       const Center(child: CircularProgressIndicator()),
      //   ],
      // ),
      body: Column(
        children: [
          Text("Article")
        ],
      ),
    );
  }
}
