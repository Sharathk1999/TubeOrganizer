import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicesMethods {
  

  Future createNewFolder(Map<String, dynamic> folderInfo, String id)async{
    return await FirebaseFirestore.instance
         .collection("folder")
         .doc(id)
         .set(folderInfo);
  }

  Future<Stream<QuerySnapshot>> getAllFolders()async{
    return await FirebaseFirestore.instance.collection("folder").snapshots();
  }
}