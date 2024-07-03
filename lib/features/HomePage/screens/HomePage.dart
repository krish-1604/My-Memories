import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymemories/Apis/google_signin_api.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/Form/screens/FormPage.dart';
import 'package:mymemories/features/HomePage/screens/MemoryPage.dart';
import 'package:mymemories/features/authentication/screens/loginscreen.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  GoogleSignInAccount? user;

  Homepage({super.key, this.user});

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
    return Consumer<FormProvider>(
      builder: (context, form, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Formpage()));
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
              onPressed: () {
                GoogleSigninApi.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: form.allMemories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: form.allMemories.length==0 ? Text('Nothing to show') : ListTile(
                      title: Text(form.allMemories[index].title),
                      subtitle: Text("${form.allMemories[index].fromDate} to ${form.allMemories[index].toDate}"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MemoryPage(
                          title: form.allMemories[index].title,
                          details: form.allMemories[index].details,
                          fromDate: form.allMemories[index].fromDate,
                          toDate: form.allMemories[index].toDate,
                          keywords: form.allMemories[index].keywords,
                        )));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // displayImage() {
  //   profileImage = widget.user?.photoUrl;
  //   if (profileImage == null) {
  //     return const AssetImage('assets/default_user.png');
  //   } else {
  //     return NetworkImage(profileImage!);
  //   }
  // }
}
