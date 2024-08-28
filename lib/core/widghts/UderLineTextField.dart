import 'package:flutter/material.dart';


class UnderLineTextField extends StatelessWidget {
  const UnderLineTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.onEditingComplete,
     this.onChanged,

  });
 final void Function()? onEditingComplete;
  final String hint;
  final TextEditingController controller;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:  TextStyle(fontFamily: 'El Messiri',color: Theme.of(context).colorScheme.tertiary),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
        validator: (value) {
          if (value==null||value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.surfaceTint,),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Theme.of(context).colorScheme.outlineVariant,))),
      controller: controller,
    );
  }
}
