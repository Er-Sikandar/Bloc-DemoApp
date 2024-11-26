import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncyAesData{
  static final key = Key.fromUtf8('#\$&*%&@#\\x&*@\$#%\$#%P#%@X#8\$%&*');

  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    print(encrypted);
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encrypter.decrypt(text, iv: iv);
    print(decrypted);
    return decrypted;
  }
}