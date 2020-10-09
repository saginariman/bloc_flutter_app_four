import 'package:bloc_flutter_app_four/Authentication.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  const LoginRegisterPage({
    Key key,
    this.auth,
      this.onSignedIn}) : super(key: key);


  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType{
  login,
  register
}
class _LoginRegisterPageState extends State<LoginRegisterPage>{
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  //methods
  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async{

    if(validateAndSave()){

      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.signIn(_email, _password);
          print("login userId = " + userId);
        }else{
          String userId = await widget.auth.signUp(_email, _password);
          print("Register userId = " + userId);
        }

        widget.onSignedIn();
      }catch(e){
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }


  //design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Flutter Block App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),

    );
  }

  List<Widget> createInputs(){
    return [
      SizedBox(height:10.0),
      logo(),
      SizedBox(height:20.0),

      TextFormField(
        validator: (value){
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value){
          return _email = value;
        },
        decoration: InputDecoration(labelText: "Email"),
      ),
      SizedBox(height:10.0),
      TextFormField(
        decoration:  InputDecoration(labelText: "Password"),
        validator: (value){
          return value.isEmpty ? 'Password is required' : null;
        },
        obscureText: true,
        onSaved: (value){
          return _password = value;
        },
      ),

      SizedBox(height:20.0),
    ];
  }
    Widget logo (){
      return Hero(
        tag: "Hero",
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 110.0,
          child: Container(
            height: 500,
            child:Image.asset('images/avatar.jpg',),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

  List<Widget> createButtons(){
    if(_formType == FormType.login){
      return [
        RaisedButton(
          child: Text("Login", style: TextStyle(fontSize: 20.0),),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),

        FlatButton(
          child: Text("Not have an account? Create Account", style: TextStyle(fontSize: 20.0),),
          textColor: Colors.red,
          onPressed: moveToRegister,

        ),
      ];
    }else{
      return [
        RaisedButton(
          child: Text("Sign Up", style: TextStyle(fontSize: 20.0),),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),

        FlatButton(
          child: Text("Already have account? Login", style: TextStyle(fontSize: 20.0),),
          textColor: Colors.red,
          onPressed: moveToLogin,

        ),
      ];
    }
  }
}