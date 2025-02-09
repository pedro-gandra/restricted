import '../database.dart';

class SmsReceivedTable extends SupabaseTable<SmsReceivedRow> {
  @override
  String get tableName => 'sms_received';

  @override
  SmsReceivedRow createRow(Map<String, dynamic> data) => SmsReceivedRow(data);
}

class SmsReceivedRow extends SupabaseDataRow {
  SmsReceivedRow(super.data);

  @override
  SupabaseTable get table => SmsReceivedTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get idDevice => getField<int>('id_device');
  set idDevice(int? value) => setField<int>('id_device', value);

  String? get message => getField<String>('message');
  set message(String? value) => setField<String>('message', value);
}
