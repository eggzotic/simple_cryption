//
// simple_cryption - 2-way encryption/decryption
//
// Richard Shepherd
// December 2019
//
import 'package:encrypt/encrypt.dart';
import 'package:args/args.dart';

// final plainText = 'bob';
// bool encrypt = true; // false means decrypt
final encryptKey = 'encrypt';
final decryptKey = 'decrypt';
final usage = '''
Usage: dart simple_cryption [ -e | -d ] <string> ...
''';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag(encryptKey, negatable: false, abbr: 'e', defaultsTo: true, help: 'encrypt strings')
    ..addFlag(decryptKey, negatable: false, abbr: 'd', defaultsTo: false, help: 'decrypt strings');
  final argResults = parser.parse(arguments);
  //
  if (argResults.rest.isEmpty) {
    print(usage + parser.usage);
    return;
  }
  //
  // the actual string we're asking to encrypt/decrypt
  final source = argResults.rest.first;

  // boiler-plate code for both encrypt/decrypt
  //  alter these for more variation in your encryptions
  //  and of course be sure to use the same values when decrypting to actually get
  //  your orignal plain-text values back ;-)
  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  //
  if (argResults[decryptKey]) {
    //
    // Decryption
    final decrypted = encrypter.decrypt16(source, iv: iv);
    print('decrypted: $decrypted');
    return;
  }
  // Encryption
  final encrypted = encrypter.encrypt(source, iv: iv);
  print('encrypted: ${encrypted.base16}');
}
