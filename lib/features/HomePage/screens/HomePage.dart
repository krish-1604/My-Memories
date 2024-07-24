import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/Form/screens/Multiple%20days/FormPage.dart';
import 'package:mymemories/features/Form/screens/single%20day/Formpage2.dart';
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
        floatingActionButton: SpeedDial(
          overlayColor: Colors.black,
          overlayOpacity: 0.7,
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          children: [
            SpeedDialChild(
              backgroundColor: Color(0xFF0F162F),
              child: Icon(color: Colors.white, Icons.today),
              label: '1-Day Memory',
              labelBackgroundColor: Color(0xFF0F162F),
              labelStyle: TextStyle(color: Colors.white),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Formpage2()),
              ),
            ),
            SpeedDialChild(
              backgroundColor: Color(0xFF0F162F),
              child: Icon(color: Colors.white, Icons.calendar_month),
              label: 'More than 1-Day Memories',
              labelBackgroundColor: Color(0xFF0F162F),
              labelStyle: TextStyle(color: Colors.white),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Formpage()),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          title: const Image(
            height: 76,
            image: AssetImage(
              "assets/dark_logo.png",
            ),
          ),
        ),
        body: Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.blue,
              selectionColor: Colors.blue,
              selectionHandleColor: Colors.blue,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextField(
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Color(0xFF0F162F),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    prefixIcon: Icon(
                      color: Colors.white,
                      Icons.search,
                    ),
                  ),
                  onChanged: (value){
                    form.setSearchQuery(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: form.filteredMemories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = form.filteredMemories[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 16.0, left: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0F162F),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF0F162F),
                            width: 3,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            data.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: data.toDate != null &&
                              data.toDate!.isNotEmpty
                              ? Text(
                                  "${data.fromDate} to ${data.toDate}",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "${data.fromDate}",
                                  style: TextStyle(color: Colors.white),
                                ),
                          trailing:
                              Icon(color: Colors.white, Icons.arrow_forward),
                          onTap: () async {
                            directoryData.navigateToImages(
                              context,
                              data,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
