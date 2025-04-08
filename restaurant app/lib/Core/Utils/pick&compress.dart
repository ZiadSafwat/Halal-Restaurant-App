import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File?>getImageAndCompress ()async{

  var saveimg =
  await ImagePicker().pickImage(source: ImageSource.gallery);
  if (saveimg == null) {
    return null ;
  }

  if (File(saveimg.path) != null) {
    File file = File(saveimg!.path);
    String compressedPath =await testCompressAndGetFile(file);
    File compressedImage =File(compressedPath);


   return compressedImage;

}}



Future<String> testCompressAndGetFile(File file,) async {
  final dir = await getApplicationDocumentsDirectory();
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, dir.path+'image.jpg',
    quality: 88,

  );

 // print(file.lengthSync());
  //print(result!.lengthSync()!);

  return result!.path??'';
}