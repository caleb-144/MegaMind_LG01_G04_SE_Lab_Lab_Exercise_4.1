
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookPage extends StatefulWidget {
  const FacebookPage({super.key});

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  bool _isLoading = false;
  Map<String, dynamic>? _userData;

  Future<void> _loginWithFacebook() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final LoginResult result =
          await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (!mounted) return;

      if (result.status == LoginStatus.success) {
        final userData =
            await FacebookAuth.instance.getUserData(
          fields: 'name,email,picture.width(200)',
        );

        if (!mounted) return;

        setState(() {
          _userData = userData;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facebook login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (result.status == LoginStatus.cancelled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facebook login cancelled.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.message ?? 'Facebook login failed.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    await FacebookAuth.instance.logOut();

    if (!mounted) return;

    setState(() {
      _userData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = _userData != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
        backgroundColor: const Color(0xFF1877F2),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: isLoggedIn
              ? _buildProfile()
              : _buildLogin(),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.facebook,
          size: 90,
          color: Color(0xFF1877F2),
        ),
        const SizedBox(height: 24),

        const Text(
          'Welcome to Facebook',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Sign in with your Facebook account '
          'to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed:
                _isLoading ? null : _loginWithFacebook,
            icon: const Icon(Icons.facebook),
            label: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1877F2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    final name = _userData?['name'] ?? 'Facebook User';
    final email = _userData?['email'] ?? 'Email unavailable';

    final picture = _userData?['picture']
        ?['data']?['url'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (picture != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(picture),
          )
        else
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),

        const SizedBox(height: 20),

        Text(
          'Welcome, $name!',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        Text(email),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
