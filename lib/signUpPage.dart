import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:items_1/home.dart';
import 'package:items_1/login.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class signupPage extends StatefulWidget {
  signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
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
                            signup();
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
                    Text("Login "),
                    InkWell(
                        child: Text(" Here "),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => logInPage(),
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

  signup() async {
    final auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
    SnackBar(content: Text(' Succes '));
    Navigator.pop(context);
  }
}
