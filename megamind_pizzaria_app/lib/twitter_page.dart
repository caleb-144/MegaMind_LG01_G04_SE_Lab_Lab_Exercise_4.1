import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class TwitterPage extends StatefulWidget {
  const TwitterPage({super.key});

  @override
  State<TwitterPage> createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  // Replace this with your X OAuth 2.0 Client ID.
  static const String clientId = 'YOUR_X_CLIENT_ID';

  // OAuth callback configuration.
  static const String callbackScheme = 'myapp';
  static const String redirectUri = 'myapp://callback';

  bool isLoading = false;

  String? accessToken;
  String? userId;
  String? username;
  String? displayName;
  String? profileImage;
  String? errorMessage;

  // Generate a secure random PKCE verifier.
  String generateCodeVerifier() {
    final random = Random.secure();

    final bytes = List<int>.generate(
      32,
      (_) => random.nextInt(256),
    );

    return base64Url.encode(bytes).replaceAll('=', '');
  }

  // Generate the SHA256 PKCE challenge.
  String generateCodeChallenge(String verifier) {
    final digest = sha256.convert(utf8.encode(verifier));

    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  // Generate OAuth state.
  String generateState() {
    final random = Random.secure();

    final bytes = List<int>.generate(
      32,
      (_) => random.nextInt(256),
    );

    return base64Url.encode(bytes).replaceAll('=', '');
  }

  // Login with X.
  Future<void> loginWithX() async {
    if (clientId == 'YOUR_X_CLIENT_ID' ||
        clientId.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please configure your X Client ID.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Generate PKCE values.
      final codeVerifier = generateCodeVerifier();
      final codeChallenge = generateCodeChallenge(codeVerifier);
      final state = generateState();

      // Create X authorization URL.
      final authorizationUrl = Uri.https(
        'x.com',
        '/i/oauth2/authorize',
        {
          'response_type': 'code',
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'scope': 'users.read tweet.read offline.access',
          'state': state,
          'code_challenge': codeChallenge,
          'code_challenge_method': 'S256',
        },
      );

      // Open the X authentication page.
      final result = await FlutterWebAuth2.authenticate(
        url: authorizationUrl.toString(),
        callbackUrlScheme: callbackScheme,
      );

      final callbackUri = Uri.parse(result);

      // Check OAuth errors.
      if (callbackUri.queryParameters.containsKey('error')) {
        throw Exception(
          callbackUri.queryParameters['error_description'] ??
              callbackUri.queryParameters['error'],
        );
      }

      // Validate returned state.
      final returnedState =
          callbackUri.queryParameters['state'];

      if (returnedState != state) {
        throw Exception('Invalid OAuth state. Please try again.');
      }

      // Get authorization code.
      final code = callbackUri.queryParameters['code'];

      if (code == null || code.isEmpty) {
        throw Exception('Authorization code was not received.');
      }

      // Exchange authorization code for access token.
      final tokenResponse = await http.post(
        Uri.https('api.x.com', '/2/oauth2/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: {
          'grant_type': 'authorization_code',
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'code': code,
          'code_verifier': codeVerifier,
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception(
          'Token request failed (${tokenResponse.statusCode}): '
          '${tokenResponse.body}',
        );
      }

      final tokenData = jsonDecode(tokenResponse.body);

      final token = tokenData['access_token'] as String?;

      if (token == null || token.isEmpty) {
        throw Exception('Access token was not received.');
      }

      // Retrieve authenticated X user profile.
      final userResponse = await http.get(
        Uri.https(
          'api.x.com',
          '/2/users/me',
          {
            'user.fields': 'profile_image_url,description',
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (userResponse.statusCode != 200) {
        throw Exception(
          'Unable to retrieve X profile '
          '(${userResponse.statusCode}): ${userResponse.body}',
        );
      }

      final userData = jsonDecode(userResponse.body);
      final user = userData['data'];

      if (user == null) {
        throw Exception('X user information is unavailable.');
      }

      if (!mounted) return;

      setState(() {
        accessToken = token;
        userId = user['id']?.toString();
        username = user['username']?.toString();
        displayName = user['name']?.toString();
        profileImage = user['profile_image_url']?.toString();
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Logout.
  void logout() {
    setState(() {
      accessToken = null;
      userId = null;
      username = null;
      displayName = null;
      profileImage = null;
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = accessToken != null;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'X Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // X logo.
              const Icon(
                Icons.close,
                size: 75,
                color: Colors.black,
              ),

              const SizedBox(height: 20),

              Text(
                isLoggedIn
                    ? 'Welcome to X'
                    : 'Sign in with X',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                isLoggedIn
                    ? 'You have successfully connected your account.'
                    : 'Connect your X account to continue.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              if (isLoggedIn) ...[
                // User profile picture.
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      profileImage != null &&
                              profileImage!.isNotEmpty
                          ? NetworkImage(profileImage!)
                          : null,
                  child: profileImage == null ||
                          profileImage!.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 55,
                        )
                      : null,
                ),

                const SizedBox(height: 20),

                // Display name.
                Text(
                  displayName ?? 'X User',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Username.
                Text(
                  '@${username ?? 'unknown'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                // User ID.
                Text(
                  'User ID: ${userId ?? 'Unavailable'}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 35),

                // Logout button.
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                // Login with X button.
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : loginWithX,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Continue with X',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                if (isLoading) ...[
                  const SizedBox(height: 25),
                  const CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Connecting to X...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ],

              // Error message.
              if (errorMessage != null) ...[
                const SizedBox(height: 20),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
