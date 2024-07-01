import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profilepage extends StatefulWidget {
  final GoogleSignInAccount user;

  const Profilepage({super.key, required this.user});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String? profileImage;
  displayImage() {
    profileImage = widget.user.photoUrl;
    if (profileImage == null) {
      return const AssetImage('assets/default_user.png');
    } else {
      return NetworkImage(profileImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Image(
          height: 30,
          image: AssetImage(
            "assets/small_logo.png",
          ),
        ),
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              // height: 100,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: displayImage(),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.user.displayName}",
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.user.email}",
                        style: GoogleFonts.abel(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){}, child: Text("Log Out")),
          ElevatedButton(onPressed: (){}, child: Text("Log Out")),
          ElevatedButton(onPressed: (){}, child: Text("Log Out")),
        ],
      ),
    );
  }
}
