import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/auth/components/login_button.dart';
import './components/auth_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key, required this.isLogin}) : super(key: key);
  static const routeName = '/auth-screen';
  bool isLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  BuildContext? ctx;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      UserCredential authResult;
      try {
        setState(() {
          _isLoading = true;
        });
        if (widget.isLogin) {
          authResult = await _auth.signInWithEmailAndPassword(
              email: _userEmail.trim(), password: _userPassword.trim());
        } else {
          authResult = await _auth.createUserWithEmailAndPassword(
              email: _userEmail.trim(), password: _userPassword.trim());
        }
      } on PlatformException catch (error) {
        var message = 'An error occurred, please check your details.';
        if (error.message != null) {
          message = error.message!;
        }
        Scaffold.of(ctx!).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ));
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    fieldKey: ValueKey('email'),
                    text: 'email',
                    inputType: TextInputType.emailAddress,
                    onSubmitted: (value) {
                      _userEmail = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please ente a valid email.';
                      }
                      return null;
                    },
                    icon: Icons.person,
                    obscure: false,
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  AuthTextField(
                    fieldKey: ValueKey('password'),
                    text: 'password',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters.';
                      }
                      return null;
                    },
                    onSubmitted: (value) {
                      _userPassword = value;
                    },
                    icon: Icons.lock,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure
                          ? Icon(Icons.visibility_off, color: kSecondaryColor)
                          : Icon(Icons.visibility, color: kSecondaryColor),
                    ),
                    obscure: isObscure,
                  ),
                  if (widget.isLogin == false)
                    AuthTextField(
                      fieldKey: ValueKey('comfirm'),
                      text: 'confirm password',
                      validator: (value) {
                        if (value!.isEmpty || value != _userPassword) {
                          return 'Passwords don\'t match';
                        }
                        return null;
                      },
                      icon: Icons.lock,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: isObscure
                            ? Icon(Icons.visibility_off, color: kSecondaryColor)
                            : Icon(Icons.visibility, color: kSecondaryColor),
                      ),
                      obscure: isObscure,
                    ),
                  if (_isLoading) CircularProgressIndicator(),
                  if (!_isLoading)
                    loginButton(
                        text: widget.isLogin ? 'Login' : 'Sign Up',
                        press: _trySubmit,
                        color: kSecondaryColor,
                        textColor: Colors.white),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.isLogin
                          ? 'Don\'t have an account? '
                          : 'Already have an account? '),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ctx = context;
                              if (widget.isLogin == true) {
                                widget.isLogin = false;
                              } else if (widget.isLogin == false) {
                                widget.isLogin = true;
                              }
                            });
                          },
                          child: Text(
                            widget.isLogin ? 'Sign Up' : 'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kSecondaryColor),
                          )),
                    ],
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
