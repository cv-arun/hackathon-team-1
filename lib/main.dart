import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_app_hackathon/editScreen.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:aws_s3_client/aws_s3_client.dart';
import 'package:photo_view/photo_view.dart';
import 'package:aws_s3/aws_s3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWS S3 Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AWS S3 Image Upload'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();
  final List <File> _images = [];

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }

    // Future.delayed(const Duration(seconds: 0)).then(
    //       (value) => Navigator.push(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => EditPhotoScreen(
    //         arguments: [..._images],
    //       ),
    //     ),
    //   ),
    // );
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }

    // Future.delayed(const Duration(seconds: 0)).then(
    //       (value) => Navigator.push(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => EditPhotoScreen(
    //         arguments: [..._images],
    //       ),
    //     ),
    //   ),
    // );
  }

  // Future compressAndUploadToS3(File file) async {
  //   final compressedFile =
  //   await FlutterImageCompress.compressAndGetFile(file.path, file.path);
  //   final s3Client = AwsS3Client(
  //     accessKey: 'YOUR_AWS_ACCESS_KEY',
  //     secretKey: 'YOUR_AWS_SECRET_KEY',
  //     bucketName: 'eqaim-hackathon-april-2023',
  //   );
  //   await s3Client.upload(
  //     file: compressedFile,
  //     fileName: 'team-1/${compressedFile.path.split('/').last}',
  //   );
  // }
  //
  // Future uploadImagesToS3() async {
  //   for (var image in _images) {
  //     await compressAndUploadToS3(image);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Expanded(
    child: GridView.count(
    crossAxisCount: 3,
    children: List.generate(_images.length, (index) {
    return Container(
    child: Image.file(
    _images[index],
    fit: BoxFit.cover,
    ),
    );
    }),
    ),
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: getImageFromCamera,
            child: Text('Take a photo'),
          ),
          ElevatedButton(
            onPressed: getImageFromGallery,
            child: Text('Choose from gallery'),
          ),
        ],
      ),
      // ElevatedButton(
      //   onPressed: uploadImagesToS3,
      //   child: Text('Upload to S3'),
      // ),
    ],
    ),
    ),
    );

  }
}
