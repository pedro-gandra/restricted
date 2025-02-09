import '/flutter_flow/flutter_flow_util.dart';
import 'phone_number_widget.dart' show PhoneNumberWidget;
import 'package:flutter/material.dart';

class PhoneNumberModel extends FlutterFlowModel<PhoneNumberWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!RegExp('^[\\d]{8,15}([-\\s\\(\\)]?[\\d]{1,4})*\$').hasMatch(val)) {
      return 'Insira um telefone válido';
    }
    return null;
  }

  // Stores action output result for [Custom Action - requestPermissions] action in Button widget.
  int? permissionResult;
  // Stores action output result for [Custom Action - requestPermissions] action in Button widget.
  int? permissionResult2;

  @override
  void initState(BuildContext context) {
    phoneTextControllerValidator = _phoneTextControllerValidator;
  }

  @override
  void dispose() {
    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }
}
