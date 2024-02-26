import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayScreen extends StatefulWidget {
  final String name;
  final String link;
  const VideoPlayScreen({
    super.key,
    required this.name,
    required this.link,
  });

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.link,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          Visibility(
            visible: _isLoading,
              child:  Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ))
        ],
      ),
    );
  }
}
