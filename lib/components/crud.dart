import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';



class Crud {
  postRequest(String url, Map data) async {
    try {
      var respone = await http.post(Uri.parse(url), body: data);
      if (respone.statusCode == 200) {
        var responsebody = jsonDecode(respone.body);
        return responsebody;
      } else {
        print("Error ${respone.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());

    var multipartFile = http.MultipartFile("file", stream, lenght,
        filename: basename(file.path));
    request.files.add(multipartFile);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}