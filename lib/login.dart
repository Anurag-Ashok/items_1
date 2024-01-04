import 'package:flutter/material.dart';
import 'package:items_1/home.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Log In Here',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: mq.width * 0.7,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
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
            ],
          ),
        ),
      ),
    );
  }

  // signup() async {
  //   final auth = FirebaseAuth.instance;
  //   auth.createUserWithEmailAndPassword(
  //       email: emailcontroller.text, password: passwordcontroller.text);
  //   SnackBar(content: Text(' Succes '));
  //   Navigator.pop(context);
  // }
}
