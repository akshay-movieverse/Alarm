import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_app/pages/loading.dart';
import 'package:new_app/pages/signup.dart';
import 'package:new_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  //TextEditingController emailController_signin = new TextEditingController();
  //TextEditingController passwordController_signin = new TextEditingController();

  bool passwordVisibleSignIn;

  @override
  void initState() {
    passwordVisibleSignIn = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset(
                      'assets/applogo.png',
                      width: size.width * 0.5,
                      height: size.height * 0.15,
                    ),
                    Text(error,
                      style: TextStyle(
                        color: Colors.red[600],
                      ),
                    ),
                    Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1E6FF),
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        validator: (val) => EmailValidator.validate(val)
                            ? null
                            : "Invalid email address",
                        //onSaved: (email) => _email = email,
                        //validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        //controller: emailController_signin,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Color(0xFF6F35A5),
                          ),
                          hintText: "Your Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1E6FF),
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        validator: (val) {
                          Pattern pattern =
                              r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(val))
                            return 'Password must contain atleast one letter,number and six digit long';
                          else
                            return null;
                        },
                        //onSaved: (val) => password = val,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        //controller: passwordController_signin,
                        obscureText: passwordVisibleSignIn,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xFF6F35A5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Color(0xFF6F35A5),
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisibleSignIn = !passwordVisibleSignIn;
                              });
                            },
                          ),
                          hintText: "Password",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ButtonTheme(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        minWidth: size.width * 0.8,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xFF6F35A5))),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                print(_auth.z);
                                if (_auth.z.toString().contains("wrong-password")){
                                  setState(() {
                                    error = 'Wrong Password';
                                    loading = false;
                                  });
                                }
                                else if (_auth.z.toString().contains("user-not-found")) {
                                  setState(() {
                                    error = 'User not found';
                                    loading = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    error = "Something wrong! Can't SignIn";
                                    loading = false;
                                  });
                                }
                              }
                            }
                          },
                          color: Color(0xFF6F35A5),
                          textColor: Colors.white,
                          child: Text("LOGIN", style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account ? ",
                          style: TextStyle(
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign UP',
                            style: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
