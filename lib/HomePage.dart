import 'package:flutter/material.dart';
import 'Authentication.dart';
class HomePage extends StatefulWidget{
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  const HomePage({
    Key key,
    this.auth,
    this.onSignedOut}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  void _logoutUser() async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),

      ),
      body: Container(

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          margin: EdgeInsets.only(right: 50.0, left: 50.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                iconSize: 30,
                color: Colors.white,
                onPressed: _logoutUser,
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 20,
                color: Colors.grey,
                onPressed: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
  
}