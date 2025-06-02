import 'package:encrypt/encrypt.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

extension SharedExtensionsAESEncryption on String {
  static final _key = Key.fromUtf8(const String.fromEnvironment('PUBLIC_KEY'));
  static final _iv = IV.fromUtf8(const String.fromEnvironment('PUBLIC_KEY'));
  static final encrypter = Encrypter(RSA(
    publicKey: RsaKeyHelper().parsePublicKeyFromPem(_key),
    encoding: RSAEncoding.OAEP,
  ));

  String encodeRSA() {
    return encrypter.encrypt(this, iv: _iv).base64;
  }

  String decodeRSA(String value) {
    return encrypter.decrypt64(value, iv: _iv);
  }
}
