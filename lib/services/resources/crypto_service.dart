import 'dart:convert';

import 'package:crypto/crypto.dart';

class CryptoService {
  CryptoService._();
  static String computeHmacSha256(String key, String message) {
    // Convert key and message to bytes
    final keyBytes = utf8.encode(key);
    final messageBytes = utf8.encode(message);

    // Create HMAC SHA256 digest
    final hmacSha256 = Hmac(sha256, keyBytes);
    final digest = hmacSha256.convert(messageBytes);

    // Convert digest to hex string
    return digest.toString();
  }
}
