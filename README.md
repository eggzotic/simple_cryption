# simple_cryption

A simple 2-way encryption/decryption cmd-line tool written in Dart.

Using the encrypt library from https://pub.dev/packages/encrypt we can conveniently encrypt and decrypt those sensitive strings such as API keys and static credentials. Handy for pre-encrypting such info and then embedding the encrypted values into local assets or remote databases. Use the decrypt option (-d) to confirm that the correct encrypted-values have been used. Remember to use the same key values for both directions for any given string(s) to be encrypted and subsequently decrypted.

## Getting Started

Ensure you have the dart cmd-line tool installed as per https://dart.dev/get-dart. Then update your dart package cache:

```
pub get
```

Here's how to run the code:

```
Usage: dart simple_cryption [ -e | -d ] [ -k <key> ] <string> ...
-e, --encrypt    encrypt strings
                 (defaults to on)

-d, --decrypt    decrypt strings
-k, --key        use a non-default key (max 32 chars)
```

Richard Shepherd  
December 2019
