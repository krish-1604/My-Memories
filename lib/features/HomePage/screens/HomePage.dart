import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/Form/screens/FormPage.dart';
import 'package:mymemories/features/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? profileImage;
  late DirectoryData directoryData;
  final FormProvider formProvider = FormProvider();

  @override
  void initState() {
    super.initState();
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    formProvider.fetchMemories();
    directoryData = DirectoryData(formProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FormProvider, AuthenticationProvider>(
      builder: (context, form, auth, child) => Scaffold(
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
                // onChanged: (query){
                //   form.searchMemories(query);
                // },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: form.allMemories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = form.allMemories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(form.allMemories[index].title),
                      subtitle: Text(
                          "${form.allMemories[index].fromDate} to ${form.allMemories[index].toDate}"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () async {
                        directoryData.navigateToImages(
                          context,
                          data,
                        );
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
}
