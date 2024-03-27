import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:platform_wallet/platform_wallet.dart';
import '../method_channel.dart';

/// [PKPass] is the object to interact with Apple's wallet.
/// Only works on iOS, otherwise will throw an assertion error when created.
///
/// Call static functions PKPass.fromBytes or PKPass.fromUrl to build a new PKPass.
class PKPass {
  final Uint8List data;

  PKPass._({
    required this.data,
  }) : assert(Platform.isIOS);

  /// Creates a new PKPass object from a given [Uint8List].
  factory PKPass.fromBytes(Uint8List data) => PKPass._(data: data);

  /// Creates a new PKPass object from a given [Uri].
  /// Additional headers can be sent with the [headers] parameter.
  ///
  /// Will throw a [DioException] on network error
  ///
  /// Example:
  /// ```dart
  /// final Uri uri = Uri.parse("https://example.com/pass.pkpass");
  /// try {
  ///   final PKPass pass = await PKPass.fromUrl(
  ///     uri,
  ///     headers: {"Authorization": "Bearer ..."},
  ///   );
  ///   pass.save();
  /// } on DioException catch (e) {
  ///   print("Something went wrong...");
  ///   print(e);
  /// }
  /// ```
  static Future<PKPass> fromUrl(Uri url,
      {Map<String, String?>? headers}) async {
    final dio = Dio();
    final response = await dio.getUri(
      url,
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );
    return PKPass._(
      data: response.data,
    );
  }

  /// Saves a [PKPass], showing a modal preview of the pass.
  ///
  /// Throws a [PlatformWalletException] on error.
  Future<void> save() async {
    final result = await methodChannel.invokeMethod<String?>("addPkPass", data);
    if (result == null) {
      return;
    }
    if (result.startsWith("{")) {
      throw PlatformWalletException.fromJson(jsonDecode(result));
    }
  }
}
