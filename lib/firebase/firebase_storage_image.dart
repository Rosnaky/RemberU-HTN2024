import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageFromFirebaseStorage extends StatefulWidget {
  @override
  _ImageFromFirebaseStorageState createState() =>
      _ImageFromFirebaseStorageState();
}

class _ImageFromFirebaseStorageState extends State<ImageFromFirebaseStorage> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchImageUrl();
  }

  Future<void> fetchImageUrl() async {
    try {
      // Get the download URL from Firebase Storage
      String downloadURL = await FirebaseStorage.instance
          .ref(
              'photos/f35ea51f9-fcca-4b86-885d-931b18eb92cf.jpg') // Path to your image in Firebase Storage
          .getDownloadURL();

      setState(() {
        imageUrl = downloadURL; // Set the retrieved URL to the state
      });
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imageUrl == null
          ? Image.network(
              "https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg") // Show loading spinner while fetching the image
          : Image.network(imageUrl!), // Display the image from the URL
    );
  }
}
