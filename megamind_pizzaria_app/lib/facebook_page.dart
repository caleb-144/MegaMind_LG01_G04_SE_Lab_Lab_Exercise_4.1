
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookPage extends StatefulWidget {
  const FacebookPage({super.key});

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  WebViewController? _controller;
  int _loadingProgress = 0;

  final Uri _facebookUrl = Uri.parse('https://www.facebook.com/');

  @override
  void initState() {
    super.initState();

    // Only initialize WebView on Android/iOS.
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              if (mounted) {
                setState(() {
                  _loadingProgress = progress;
                });
              }
            },
          ),
        )
        ..loadRequest(_facebookUrl);
    }
  }

  Future<void> _openFacebook() async {
    if (!await launchUrl(
      _facebookUrl,
      mode: LaunchMode.platformDefault,
    )) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Facebook.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
        backgroundColor: const Color(0xFF1877F2),
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
                    Icons.facebook,
                    size: 80,
                    color: Color(0xFF1877F2),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Connect with us on Facebook!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openFacebook,
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Visit Facebook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
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
                    color: const Color(0xFF1877F2),
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
