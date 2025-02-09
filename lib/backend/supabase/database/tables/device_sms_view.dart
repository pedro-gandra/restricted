import '../database.dart';

class DeviceSmsViewTable extends SupabaseTable<DeviceSmsViewRow> {
  @override
  String get tableName => 'device_sms_view';

  @override
  DeviceSmsViewRow createRow(Map<String, dynamic> data) =>
      DeviceSmsViewRow(data);
}

class DeviceSmsViewRow extends SupabaseDataRow {
  DeviceSmsViewRow(super.data);

  @override
  SupabaseTable get table => DeviceSmsViewTable();

  int? get deviceId => getField<int>('device_id');
  set deviceId(int? value) => setField<int>('device_id', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  List<String> get smsMessages => getListField<String>('sms_messages');
  set smsMessages(List<String>? value) =>
      setListField<String>('sms_messages', value);
}
