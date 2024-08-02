import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class AddPost extends StatefulWidget {
  AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  XFile? _image;
  final _postTitleController = TextEditingController();
  final _postDescriptionController = TextEditingController();

  @override
  void dispose() {
    _postTitleController.dispose();
    _postDescriptionController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context,String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(text)));
    }
  }

  Future<void> postData() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://mind-matters-tb.us-east-1.elasticbeanstalk.com/rooms/createRoom"));
    request.fields['RoomName'] = _postTitleController.text;
    // request.fields['description'] = _postDescriptionController.text;
    request.headers['Authorization'] =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjJlNGQ4NDU1NTdmZTMwY2JiODI1MDQiLCJ0eXBlIjoiTGF5bWVuIiwiaWF0IjoxNzE0NDg3NTQwLCJleHAiOjE3MTUwOTIzNDB9.D-tIdQS3f6vXS_aL7JOQIdY0iMdgEWy5Y4kUhDHYVgs';
    request.headers['Content-Type'] = 'multipart/form-data';
     if(_image!=null &&_image!.path!=null){
    var image = io.File(_image!.path);
    var imageStream = http.ByteStream(image.openRead());

    var length = await image.length();
    var multipart = http.MultipartFile("ThumbNail", imageStream, length,
        filename: "image.jpg");
    request.files.add(multipart);
      }
    final response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      _showSnackBar(context,"Room Saved");
    } else {
      print(response.statusCode);
    }
  }

  Future<void> getImage(bool isCamera) async {
    final picker = ImagePicker();
    XFile? pickedFile;
    if (isCamera) {
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        showDialog(
            context: context,
            builder: (context) => TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text("Please Allow Gallery permission")));
      } else {
        pickedFile = await picker.pickImage(source: ImageSource.camera);
      }
    } else {
      final status;
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
      if (status != PermissionStatus.granted) {
      } else {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      }
    }
    setState(() {
      _image = pickedFile;
    });
  }

  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height * 0.8;
    double image_height = MediaQuery.of(context).size.height * 0.3;
    return Padding(
      padding: EdgeInsets.only(
          left: 18,
          top: 25,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Theme.of(context).colorScheme.background,
        height: screen_height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SingleChildScrollView(
                child: SizedBox(
                  height: screen_height * 0.1,
                  child: TextField(
                    controller: _postTitleController,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Title", border: UnderlineInputBorder()),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: screen_height * 0.3,
                  child: TextField(
                    controller: _postDescriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.secondary))),
                  ),
                ),
              ),
              _image == null
                  ? const Spacer()
                  : Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        child: Image.file(
                          io.File(_image!.path),
                          height: image_height,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              Spacer(),
              Row(children: <Widget>[
                IconButton(
                  color: Colors.black,
                  onPressed: () {
                    getImage(true);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
                const SizedBox(width: 10),
                IconButton(
                  color: Colors.black,
                  onPressed: () {
                    getImage(false);
                  },
                  icon: const Icon(Icons.photo_library_outlined),
                ),
                const Spacer(),
                OutlinedButton(
                    onPressed: () {
                      postData();
                      Navigator.pop(context);
                    },
                    child: Text("Submit")),
              ])
            ]),
      ),
    );
  }
}
