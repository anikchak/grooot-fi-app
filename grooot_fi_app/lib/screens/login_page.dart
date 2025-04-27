import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  Future<void> _loginWithGoogle() async {
    print('login clicked');
    setState(() {
      _isGoogleLoading = true;
    });
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile', 'openid'],
      serverClientId:
          '1064920344841-l1cfu2auhm2lkvlgs63u9muan9arjg5n.apps.googleusercontent.com',
    );
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        String? idToken = auth.idToken; // For direct validation
        String? authCode = auth.accessToken; // For exchanging on backend

        print("ID Token: $idToken");
        print("Auth Code: $authCode");
        print('account info $account');
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

  Future<void> _loginWithFacebook() async {
    print('facebook login clicked');
    setState(() {
      _isFacebookLoading = true;
    });
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // Handle successful login
        print('Facebook Access Token: ${accessToken.tokenString}');
        final userData = await FacebookAuth.instance.getUserData();
        print('Facebook User ID: ${userData}');
      } else {
        print('Facebook login failed: ${result.status} and ${result.message}');
      }
    } catch (error) {
      print('Facebook login failed: $error');
    } finally {
      setState(() {
        _isFacebookLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Name
            Text(
              'grooot',
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 80,
                  color: Color(0xFFCDEB3F),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Tagline
            Text(
              'discuss. learn. grow',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 50),
            // Google Button
            _buildLoginButton(
              text: 'Connect with Google',
              icon: Image.asset(
                'images/login-google-logo.png',
                width: 30,
                height: 30,
              ),
              isLoading: _isGoogleLoading,
              onPressed: _isGoogleLoading ? null : _loginWithGoogle,
            ),
            SizedBox(height: 20),
            // Facebook Button
            _buildLoginButton(
              text: 'Connect with Facebook',
              icon: Image.asset(
                'images/login-facebook-logo.png',
                width: 30,
                height: 30,
              ),
              isLoading: _isFacebookLoading,
              onPressed: _isFacebookLoading ? null : _loginWithFacebook,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required String text,
    required Widget icon,
    required bool isLoading,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 300,
      height: 50,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        splashColor: Color(0xFFCDEB3F).withOpacity(0.3),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xFFCDEB3F), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.black,
          ),
          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator(
                  color: Color(0xFFCDEB3F),
                  strokeWidth: 2,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(width: 10),
                    Text(
                      text,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
