import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:login_register_template/register.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FirebaseAuth _auth = FirebaseAuth.instance; // firebase instance

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var user_email;
  var user_pwd;

  bool _success;
  String _userEmail;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    /////////////// loader until data processed //////////////

    // LoadingFlipping.circle(
    //   borderColor: Colors.teal,
    //   borderSize: 3.0,
    //   size: 30.0,
    //   backgroundColor: Colors.transparent,
    //   duration: Duration(milliseconds: 500),
    // );

    print("Details entered by user for login ...");

    //// we could have directly used text editing controllers for each text inputs alternatively

    print(user_email);
    print(user_pwd);
    emailController.clear();
    passwordController.clear();


    /////////////////////// code to initiate post successful login ////////////////////////

    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //////////////////////// code for signing out //////////////////////////////

        // appBar: AppBar(
        //   actions: <Widget>[
        //     Builder(builder: (BuildContext context) {
        //
        //       return FlatButton(
        //         child: const Text('Sign out'),
        //         textColor: Theme
        //             .of(context)
        //             .buttonColor,
        //         onPressed: () async {
        //           final FirebaseUser user = await _auth.currentUser();
        //           if (user == null) {
        //
        //             Scaffold.of(context).showSnackBar(const SnackBar(
        //               content: Text('No one has signed in.'),
        //             ));
        //             return;
        //           }
        //           await _auth.signOut();
        //           final String uid = user.uid;
        //           Scaffold.of(context).showSnackBar(SnackBar(
        //             content: Text(uid + ' has successfully signed out.'),
        //           ));
        //         },
        //       );
        //     })
        //   ],
        // ),

        body: Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: FittedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'back',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '!',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'How do people contact you?',
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some valid value';
                        }
                        user_email = emailController.text.trim();
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: 'Sshh ...',
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some valid value';
                        }
                        user_pwd = passwordController.text.trim();
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          login();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New member? ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }));
  }
}
