import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/auth/auth_service.dart';

class LoginFormPage extends StatefulWidget {
  LoginFormPage ({this.authService, this.onLoggedIn});
  AuthService authService;
  final VoidCallback onLoggedIn;
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478ED0),
              Color(0xFF398AE5),
            ],
                stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ])),
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            children: [
              Spacer(),
              Material(
                color: Color(0xFF73AEF5),
                elevation: 18.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, left: 10.0, right: 10.0, bottom: 4.0),
                  child: TextFormField(
                    controller: _cEmail,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.person,
                        color: Color(0xffFFFFFF),
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Material(
                color: Color(0xFF73AEF5),
                elevation: 18.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, left: 10.0, right: 10.0, bottom: 4.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _cPassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.lock_rounded,
                        color: Color(0xffFFFFFF),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                    ),
                  ),
                ),
                
              ),
              SizedBox(
                height: 50.0,
              ),
              Column(children: [
                Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 40,
                      width: 360,
                      child: TextButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          // child: Icon(widget.contactModel.key != null ? Icons.person : Icons.person_add_alt_1),
                        ),
                        label: Text("Iniciar Sesión"),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.indigo[900],
                            shadowColor: Colors.black,
                            elevation: 15.0,
                            textStyle: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                           var uid = await widget.authService.signIn(_cEmail.text, _cPassword.text);
                           print (uid);
                           widget.onLoggedIn();
                  //        Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //   return HomePage();
                  // }));
                        },
                      ),
                    ),
                  ),
                SizedBox(height: 20.0,),
                Text("Sing with", style: TextStyle(color: Colors.white)),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  
                  Container(
                    height: 40,
                    width: 360,
                    child: TextButton.icon(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.mail),
                      ),
                      label: Text("Ingresar con google"),
                      style: TextButton.styleFrom(
                          primary: Colors.grey[800],
                          backgroundColor: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 15.0,
                          textStyle: TextStyle(
                              letterSpacing: 2.0, fontWeight: FontWeight.bold)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}