import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tube_organize/core/colors.dart';
import 'package:tube_organize/services/firebase_services.dart';
import 'package:tube_organize/views/create_folder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for folders
  Stream? folderStream;

  //load all folders on screen init
  loadAllFolders()async{
    folderStream = await FirebaseServicesMethods().getAllFolders();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAllFolders();
  }

  Widget allFolders() {
    return StreamBuilder(
      stream: folderStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                docSnap["image"],
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child:  Text(
                                    docSnap["folder_name"],
                                    style:const TextStyle(
                                      fontFamily: 'Raleway',
                                      color: txtBlackColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child:  Text(
                                    "videos (${docSnap["video_count"]})",
                                    style:const TextStyle(
                                      color: txtBlueGreyColor,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateFolderScreen(),
            ),
          );
        },
        child: Icon(
          CupertinoIcons.add_circled_solid,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 70,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TubeOrganize",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: txtBlackColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //! todo change the shape
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      CupertinoIcons.person_alt,
                      color: iconWhiteColor,
                    ),
                  )
                ],
              ),
            ),
            //Into container with user name and welcome note
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.350,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Hi, Sharath Kumar 🖐️",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: txtWhiteColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "TubeOrganize helps you to organize your YouTube videos in a structured way under your desired folder name. All you need to do is copy paste the links.",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: txtWhiteColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5.1),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    children: [
                      allFolders(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
