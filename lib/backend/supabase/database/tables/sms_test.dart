import '../database.dart';

class SmsTestTable extends SupabaseTable<SmsTestRow> {
  @override
  String get tableName => 'sms_test';

  @override
  SmsTestRow createRow(Map<String, dynamic> data) => SmsTestRow(data);
}

class SmsTestRow extends SupabaseDataRow {
  SmsTestRow(super.data);

  @override
  SupabaseTable get table => SmsTestTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get sender => getField<String>('sender');
  set sender(String? value) => setField<String>('sender', value);

  String? get message => getField<String>('message');
  set message(String? value) => setField<String>('message', value);
}
