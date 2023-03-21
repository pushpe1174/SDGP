import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetectionApi{
  static Future<Map<int, int>> uploadImage(File selectedImage) async {
    final request = http.MultipartRequest("POST", Uri.parse("https://310a-112-134-156-4.in.ngrok.io/upload"));
    final headers = {'Content-Type': 'multipart/form-data'};

    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split("/").last,
      ),
    );

    request.headers.addAll(headers);
    final response = await request.send();
    final resString = await response.stream.bytesToString();
    final resJson = jsonDecode(resString);

    Map<int, int> resultMap = {};
    resJson.forEach((key, value) {
      resultMap[int.parse(key)] = int.parse(value.toString());
    });

    return resultMap;
  }
}
