import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TwitterPage extends StatefulWidget {
  const TwitterPage({super.key});

  @override
  State<TwitterPage> createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  WebViewController? _controller;
  int _loadingProgress = 0;

  final Uri _twitterUrl = Uri.parse('https://twitter.com/login');

  @override
  void initState() {
    super.initState();

    // Only initialize WebView on Android/iOS native platforms.
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        // Enable DOM storage so Twitter can save login cookies & session data
        ..setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1')
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              if (mounted) {
                setState(() {
                  _loadingProgress = progress;
                });
              }
            },
            onPageStarted: (url) {},
            onPageFinished: (url) {},
          ),
        )
        ..loadRequest(_twitterUrl);
    }
  }

  Future<void> _openTwitter() async {
    if (!await launchUrl(
      _twitterUrl,
      mode: LaunchMode.platformDefault,
    )) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Twitter/X.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitter / X'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          if (!kIsWeb)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _controller?.reload(),
            ),
        ],
      ),
      body: kIsWeb
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat,
                    size: 80,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Connect with us on Twitter/X!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openTwitter,
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Visit Twitter/X'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                if (_loadingProgress < 100)
                  LinearProgressIndicator(
                    value: _loadingProgress / 100,
                    color: Colors.black,
                  ),
                Expanded(
                  child: WebViewWidget(
                    controller: _controller!,
                  ),
                ),
              ],
            ),
    );
  }
}