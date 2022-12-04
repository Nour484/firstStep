import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFormFieldLoginWidget extends StatefulWidget {
  IconButton? sufIcon;
  Icon preIcon;
  String pattern;
  String hintText;
  bool obscuretext = false;
  double widthSizeTextField;
  Color outLinedBorderTextfieldColor;
  TextEditingController controllerTextField;
  TextInputType textInputTypeTextField;
  Iterable<String>? autofillHints;
  Function()? onEditingComplete;
  TextInputAction? textInputAction;

  TextFormFieldLoginWidget(
      {this.sufIcon,
      this.textInputAction,
      this.onEditingComplete,
      required this.autofillHints,
      required this.textInputTypeTextField,
      required this.controllerTextField,
      required this.pattern,
      required this.preIcon,
      required this.hintText,
      required this.obscuretext,
      required this.widthSizeTextField,
      required this.outLinedBorderTextfieldColor,
      super.key});

  @override
  State<TextFormFieldLoginWidget> createState() =>
      _TextFormFieldLoginWidgetState();
}

class _TextFormFieldLoginWidgetState extends State<TextFormFieldLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        onEditingComplete: widget.onEditingComplete,
        keyboardType: widget.textInputTypeTextField,
        controller: widget.controllerTextField,
        validator: (value) => validationMethod(widget.pattern, value),
        cursorColor: Colors.brown,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2),
          ),

          filled: true,
          //  focusColor: Colors.brown,
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width / widget.widthSizeTextField,
            // maxHeight: 100,
          ),
          prefixIcon: widget.preIcon,

          suffixIcon: widget.sufIcon,
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.outLinedBorderTextfieldColor, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
        obscureText: widget.obscuretext,
      ),
      const SizedBox(
        height: 15,
      )
    ]);
  }

  dynamic validationMethod(String pattern, var value) {
    final paten = pattern;

    final Exp = RegExp(paten);

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyTextField;
    } else if (!Exp.hasMatch(value!)) {
      return AppLocalizations.of(context)!.correctValue;
    }
    return null;
  }
}
