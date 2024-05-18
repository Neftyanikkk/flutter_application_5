import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class Crypto {
  final String name;
  final String price;

  Crypto({required this.name, required this.price});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'],
      price: json['market_data']['current_price']['usd'].toString(),
    );
  }
}


class CryptoService {
   // Import the Crypto class if it exists in a separate file

  Future<Crypto> fetchCryptoData() async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/ethereum'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return Crypto.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load coingecko');
    }
  }
}