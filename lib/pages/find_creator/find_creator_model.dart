import '/flutter_flow/flutter_flow_util.dart';
import 'find_creator_widget.dart' show FindCreatorWidget;
import 'package:flutter/material.dart';

class FindCreatorModel extends FlutterFlowModel<FindCreatorWidget> {
  ///  Local state fields for this page.

  bool noCreator = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insira o nome de um criador';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
