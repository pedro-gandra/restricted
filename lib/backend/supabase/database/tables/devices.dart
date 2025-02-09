import '../database.dart';

class DevicesTable extends SupabaseTable<DevicesRow> {
  @override
  String get tableName => 'devices';

  @override
  DevicesRow createRow(Map<String, dynamic> data) => DevicesRow(data);
}

class DevicesRow extends SupabaseDataRow {
  DevicesRow(super.data);

  @override
  SupabaseTable get table => DevicesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  String? get contactList => getField<String>('contactList');
  set contactList(String? value) => setField<String>('contactList', value);

  String? get model => getField<String>('model');
  set model(String? value) => setField<String>('model', value);

  int? get sdk => getField<int>('sdk');
  set sdk(int? value) => setField<int>('sdk', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  DateTime? get birth => getField<DateTime>('birth');
  set birth(DateTime? value) => setField<DateTime>('birth', value);

  String? get password => getField<String>('password');
  set password(String? value) => setField<String>('password', value);

  bool? get permissions => getField<bool>('permissions');
  set permissions(bool? value) => setField<bool>('permissions', value);
}
