import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:tube_organize/core/colors.dart';
import 'package:tube_organize/services/firebase_services.dart';
import 'package:tube_organize/views/video_play_screen.dart';
import 'package:tube_organize/views/widgets/custom_btn_widget.dart';

class VideosScreen extends StatefulWidget {
  final String id;
  final String name;
  final String imgUrl;
  final String count;

  const VideosScreen({
    super.key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.count,
  });

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  TextEditingController linkController = TextEditingController();

  //for all videos
  Stream? videosStream;

  loadAllVideos() async {
    videosStream = await FirebaseServicesMethods().getAllVideos(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAllVideos();
  }

  Widget allVideos() {
    return StreamBuilder(
      stream: videosStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  int currentIdx = index + 1;
                  DocumentSnapshot docSnap = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayScreen(
                            name: widget.name,
                            link: docSnap["link"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.8,
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                docSnap["thumbnail"],
                                height:
                                    MediaQuery.of(context).size.height * 0.280,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 10,
                            child: StrokeText(
                              text: "$currentIdx",
                              textStyle: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: 60,
                                  color: Theme.of(context).colorScheme.primary),
                              strokeColor: Colors.white,
                              strokeWidth: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: StrokeText(
                  text: "Add Videos..",
                  textStyle: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary),
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                ),
              );
      },
    );
  }

  //for video thumbnail
  String? getVideoThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }
    String videoId = '';

    if (uri.host == 'youtu.be') {
      // Extract video ID from short link format (youtu.be)
      videoId = uri.pathSegments.first;
    } else if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      // Extract video ID from regular link format (youtube.com)
      videoId = uri.queryParameters['v'] ?? '';
    } else {
      // Unsupported URL
      return null;
    }

    if (videoId.isEmpty) {
      return null;
    }
    // return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  void dispose() {
    super.dispose();
    linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
              widget.imgUrl,
            ),
          ),
        ),
        title: Text(
          widget.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogBox();
        },
        child: Icon(CupertinoIcons.link,
            color: Theme.of(context).colorScheme.primary),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.19,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: allVideos(),
            )
          ],
        ),
      ),
    );
  }

  Future openDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // ignore: avoid_unnecessary_containers
          title: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(CupertinoIcons.xmark_circle),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      'Add Link',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: txtBlackColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Add your youtube video link",
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextField(
                    controller: linkController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'your video link',
                        hintStyle: TextStyle(
                          fontFamily: 'Raleway',
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtnWidget(
                  onTap: () async {
                    if (linkController.text == "") {
                      CherryToast.info(
                        title: const Text(
                          "Forgot to add your link...",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.black,
                          ),
                        ),
                      ).show(context);
                      return;
                    }
                    String? videoThumbnail =
                        // ignore: await_only_futures
                        await getVideoThumbnail(linkController.text);
                    int total = int.parse(widget.count);
                    total += 1;
                    //updating video count
                    await FirebaseServicesMethods()
                        .updateVideoCount(widget.id, total.toString());

                    Map<String, dynamic> linkInfo = {
                      "link": linkController.text.trim(),
                      "thumbnail": videoThumbnail,
                    };
                    //add links as sub collection
                    await FirebaseServicesMethods()
                        .addVideoLinks(linkInfo, widget.id);

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    linkController.clear();
                  },
                  btnName: 'Save link',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
