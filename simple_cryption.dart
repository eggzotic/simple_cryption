//
// simple_cryption - 2-way encryption/decryption
//
// Richard Shepherd
// December 2019
//

import 'package:encrypt/encrypt.dart';
import 'package:args/args.dart';

final encryptKey = 'encrypt';
final decryptKey = 'decrypt';
final keyKey = 'key';
//
final usage = '''
Usage: dart simple_cryption [ -e | -d ] [ -k <key> ] <string> ...
''';
// final cipherSize = 128;

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag(encryptKey, negatable: false, abbr: 'e', defaultsTo: true, help: 'encrypt strings')
    ..addFlag(decryptKey, negatable: false, abbr: 'd', defaultsTo: false, help: 'decrypt strings')
    ..addOption(keyKey, abbr: 'k', help: 'use a non-default key');
  final argResults = parser.parse(arguments);
  //
  if (argResults.rest.isEmpty || (argResults[decryptKey] && argResults.wasParsed(encryptKey))) {
    print(usage + parser.usage);
    return;
  }
  //
  // the actual string(s) we're asking to encrypt/decrypt
  final sourceStrings = argResults.rest;

  // boiler-plate code for both encrypt/decrypt
  //  use '-k <key>' on the cmd-line for more variation in your encryptions
  //  and be sure to use the same key when decrypting to get your original
  //  plain-text value(s) back ;-)

  String rawKey = argResults[keyKey] as String ?? '';
  if (rawKey.length < 32) rawKey = rawKey.padRight(32);
  if (rawKey.length > 32) rawKey = rawKey.substring(0, 32);

  final key = Key.fromUtf8(rawKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  //
  if (argResults[decryptKey]) {
    // Decryption
    sourceStrings.forEach((source) {
      final decrypted = encrypter.decrypt64(source, iv: iv);
      print('decrypt: $source --> $decrypted');
    });
    return;
  }
  // Encryption
  sourceStrings.forEach((source) {
    final encrypted = encrypter.encrypt(source, iv: iv);
    print('encrypt: $source --> ${encrypted.base64}');
  });
}
