import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _numberReached = prefs.getBool('ff_numberReached') ?? _numberReached;
    });
    _safeInit(() {
      _sofia = prefs.getBool('ff_sofia') ?? _sofia;
    });
    _safeInit(() {
      _deviceId = prefs.getInt('ff_deviceId') ?? _deviceId;
    });
    _safeInit(() {
      _endReached = prefs.getBool('ff_endReached') ?? _endReached;
    });
    _safeInit(() {
      _signUp = prefs.getBool('ff_signUp') ?? _signUp;
    });
    _safeInit(() {
      _nome = prefs.getString('ff_nome') ?? _nome;
    });
    _safeInit(() {
      _available = prefs.containsKey('ff_available')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_available')!)
          : _available;
    });
    _safeInit(() {
      _isJohn = prefs.getBool('ff_isJohn') ?? _isJohn;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _numberReached = false;
  bool get numberReached => _numberReached;
  set numberReached(bool value) {
    _numberReached = value;
    prefs.setBool('ff_numberReached', value);
  }

  bool _sofia = false;
  bool get sofia => _sofia;
  set sofia(bool value) {
    _sofia = value;
    prefs.setBool('ff_sofia', value);
  }

  bool _confirmPhoneRes = false;
  bool get confirmPhoneRes => _confirmPhoneRes;
  set confirmPhoneRes(bool value) {
    _confirmPhoneRes = value;
  }

  int _deviceId = 0;
  int get deviceId => _deviceId;
  set deviceId(int value) {
    _deviceId = value;
    prefs.setInt('ff_deviceId', value);
  }

  bool _endReached = false;
  bool get endReached => _endReached;
  set endReached(bool value) {
    _endReached = value;
    prefs.setBool('ff_endReached', value);
  }

  bool _signUp = false;
  bool get signUp => _signUp;
  set signUp(bool value) {
    _signUp = value;
    prefs.setBool('ff_signUp', value);
  }

  String _nome = '';
  String get nome => _nome;
  set nome(String value) {
    _nome = value;
    prefs.setString('ff_nome', value);
  }

  DateTime? _available = DateTime.fromMillisecondsSinceEpoch(1740769800000);
  DateTime? get available => _available;
  set available(DateTime? value) {
    _available = value;
    value != null
        ? prefs.setInt('ff_available', value.millisecondsSinceEpoch)
        : prefs.remove('ff_available');
  }

  bool _isJohn = false;
  bool get isJohn => _isJohn;
  set isJohn(bool value) {
    _isJohn = value;
    prefs.setBool('ff_isJohn', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
