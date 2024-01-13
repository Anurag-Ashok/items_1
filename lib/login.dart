import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:items_1/home.dart';
import 'package:items_1/signUpPage.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class logInPage extends StatefulWidget {
  logInPage({super.key});

  @override
  State<logInPage> createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: mq.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Text(
                    'Log In Here',
                    style: TextStyle(
                        fontSize: 40,
                        color: const Color.fromARGB(255, 163, 237, 166),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: mq.width * 0.7,
                  child: Column(
                    children: [
                      TextField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 43, 17, 247),
                                    width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: ' email',
                            hintText: 'Enter Your Email'),
                      ),
                      SizedBox(
                        height: mq.height * .03,
                      ),
                      TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Password',
                            hintText: 'Enter Your password'),
                      ),
                      SizedBox(
                        height: mq.height * .03,
                      ),
                      Container(
                        width: mq.width * 0.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600]),
                          child: const Text(
                            'LogIn ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            signin();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => homePage(),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Sign up "),
                    InkWell(
                        child: Text(" Here "),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => signupPage(),
                              ));
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
    SnackBar(content: Text(' Succes '));
    Navigator.pop(context);
  }
}
