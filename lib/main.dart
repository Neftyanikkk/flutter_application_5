// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageView(
        children: [
          kIsWeb ? WebScreen1() : IosScreen1(),
          kIsWeb ? WebScreen2() : IosScreen2(),
        ],
      ),
      theme: ThemeData.dark(),
    );
  }
}

class IosScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page - iOS'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Добро пожаловать на iOS!',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Свайпните вправо, чтобы продолжить ->',
                  textDirection: TextDirection.ltr),
            ),
          ),
        ],
      ),
    );
  }
}

class WebScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page - Web'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Добро пожаловать на Web!',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Перелистните вправо, чтобы продолжить ->',
                  textDirection: TextDirection.ltr),
            ),
          ),
        ],
      ),
    );
  }
}

class IosScreen2 extends StatefulWidget {
  @override
  _IosScreen2State createState() => _IosScreen2State();
}

class _IosScreen2State extends State<IosScreen2> {
  final _formKey = GlobalKey<FormState>();
  String _cryptoName = '';
  String _cryptoAmount = '';
  Color _backgroundColor = Color.fromARGB(255, 29, 31, 42);

  void _buyCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'Куплено: $_cryptoName, Количество: $_cryptoAmount';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        _backgroundColor = Colors.green;
      });
      Timer(Duration(seconds: 1), () {
        setState(() {
          _backgroundColor = Color.fromARGB(255, 29, 31, 42);
        });
      });
    }
  }

  void _sellCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'Продано: $_cryptoName, Количество: $_cryptoAmount';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        _backgroundColor = Colors.red;
      });
      Timer(Duration(seconds: 1), () {
        setState(() {
          _backgroundColor = Color.fromARGB(255, 29, 31, 42);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text('Trade screen - iOS'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Название криптовалюты'),
              onSaved: (value) => _cryptoName = value!,
              validator: (value) => value!.isEmpty ? 'Введите название криптовалюты' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Количество'),
              onSaved: (value) => _cryptoAmount = value!,
              validator: (value) => value!.isEmpty ? 'Введите количество' : null,
            ),
            ElevatedButton(
              onPressed: _buyCrypto,
              child: Text('Купить'),
            ),
            ElevatedButton(
              onPressed: _sellCrypto,
              child: Text('Продать'),
            ),
          ],
        ),
      ),
    );
  }
}

class WebScreen2 extends StatefulWidget {
  @override
  _WebScreen2State createState() => _WebScreen2State();
}

class _WebScreen2State extends State<WebScreen2> {
  final _formKey = GlobalKey<FormState>();
  String _cryptoName = 'Биткойн';
  String _cryptoAmount = '';
  final List<String> _cryptos = ['Биткойн', 'Эфириум', 'Рипл'];

  void _buyCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'Куплено: $_cryptoName, Количество: $_cryptoAmount';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _sellCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'Продано: $_cryptoName, Количество: $_cryptoAmount';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добро пожаловать в веб версию!'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _cryptoName,
              items: _cryptos.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _cryptoName = newValue!;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Количество'),
              onSaved: (value) => _cryptoAmount = value!,
              validator: (value) => value!.isEmpty ? 'Введите количество' : null,
            ),
            ElevatedButton(
              onPressed: _buyCrypto,
              child: Text('Купить'),
            ),
            ElevatedButton(
              onPressed: _sellCrypto,
              child: Text('Продать'),
            ),
          ],
        ),
      ),
    );
  }
}