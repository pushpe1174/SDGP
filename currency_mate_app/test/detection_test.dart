import 'dart:io';
import 'package:currency_mate_app/Api/detection_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('DetectionApi', () {
    final mockHttpClient = MockHttpClient();

    test('uploadImage sends a multipart request', () async {
      final selectedImage = File('test.png');

      when(mockHttpClient.send(anyOf(isA<http.Request>(), isNull) as http.BaseRequest))
          .thenAnswer((realInvocation) async {
        return http.StreamedResponse(
          const Stream.empty(),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final result = await DetectionApi.uploadImage(selectedImage);

      expect(result, isNotNull);

      final capturedRequest =
      verify(mockHttpClient.send(captureAnyNamed('multipartRequest') as http.BaseRequest))
          .captured
          .first as http.MultipartRequest;

      expect(capturedRequest.method, equals('POST'));
      expect(
          capturedRequest.url,
          equals(Uri.parse(
              'https://1395-112-134-156-143.in.ngrok.io/upload')));

      final headers = capturedRequest.headers;
      expect(headers['Content-Type'], equals('multipart/form-data'));

      final files = capturedRequest.files;
      expect(files.length, equals(1));

      final imageFile = files.first;
      expect(imageFile.field, equals('image'));
      expect(imageFile.filename, equals(selectedImage.path.split("/").last));
    });
  });
}