import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymemories/Apis/google_signin_api.dart';
import 'package:mymemories/features/Form/screens/FormPage.dart';
import 'package:mymemories/features/authentication/screens/loginscreen.dart';

class Homepage extends StatefulWidget {
  final GoogleSignInAccount user;

  const Homepage({super.key, required this.user});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? profileImage;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Formpage()));
          },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        splashColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        shadowColor: Colors.white,
        title: const Image(
          height: 30,
            image: AssetImage(
                "assets/small_logo.png",
            ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              GoogleSigninApi.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text("Happy Birthday"),
                      subtitle: const Text('8-05-2023'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                  );
                },
            ),
          ),
        ],
      ),

    );
  }

  displayImage() {
    profileImage = widget.user.photoUrl;
    if (profileImage == null) {
      return const AssetImage('assets/default_user.png');
    } else {
      return NetworkImage(profileImage!);
    }
  }
}
