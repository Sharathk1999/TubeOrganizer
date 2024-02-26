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

   Future updateVideoCount(String id, String count)async{
    return await FirebaseFirestore.instance
         .collection("folder")
         .doc(id)
         .update({
          "video_count":count,
         });
  }

  Future addVideoLinks(Map<String, dynamic> linkInfo, String id)async{
    return await FirebaseFirestore.instance
         .collection("folder")
         .doc(id)
         .collection("video_link")
         .add(linkInfo);
  }

  Future<Stream<QuerySnapshot>> getAllVideos(String id)async{
    return await FirebaseFirestore.instance.collection("folder").doc(id).collection("video_link").snapshots();
  }
}