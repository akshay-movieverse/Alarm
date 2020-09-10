import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_app/pages/loading.dart';
import 'package:new_app/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  //TextEditingController emailController_signup = new TextEditingController();
  //TextEditingController passwordController_signup = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool passwordVisibleSignup;

  @override
  void initState() {
    passwordVisibleSignup = true;
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
                      'SIGNUP',
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
                        //controller: emailController_signup,
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
                          if (val.isEmpty)
                            return 'Please Enter Password';
                          else if (val.length < 6) {
                            return 'Must be more than 6 digit';
                          } else if (!regex.hasMatch(val)) {
                            return 'Password must contain atleast one letter,number and six digit long';
                          } else
                            return null;
                        },
                        //onSaved: (val) => password = val,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        //controller: passwordController_signup,
                        obscureText: passwordVisibleSignup,
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
                                passwordVisibleSignup = !passwordVisibleSignup;
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
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                print(_auth.z);
                                if (_auth.z.toString().contains("email-already-in-use")){
                                  setState(() {
                                    error = 'Account already exist!';
                                    loading = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    error = "Something wrong! Can't SignUp";
                                    loading = false;
                                  });
                                }
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                          color: Color(0xFF6F35A5),
                          textColor: Colors.white,
                          child: Text("SIGNUP", style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                   
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account ? ",
                          style: TextStyle(
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
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
