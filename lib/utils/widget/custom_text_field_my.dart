import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';

class CustomTextFieldMy extends StatefulWidget {
  CustomTextFieldMy({
    Key? key,
    this.inputType,
    this.label,
    this.hintText,
    this.obscureText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.height,
    this.enabled,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.errorText,
    this.keyboardType,
    this.onSuffixPressed,
    this.textStyle,
    this.customWidget,
    this.customIcon,
    this.icon,
    this.spaceCoverToComma = false,
    this.colorBorder = false,
    this.borderRadius = 0,
  }) : super(key: key) {
    if (this.textStyle == null) {
      this.textStyle = rbtMedium(color: AppColors.black, fontSize: 14);
    }
  }

  final InputType? inputType;
  final String? label;
  final String? hintText;
  final String? errorText;
  final double? height;
  final bool? obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final bool? enabled;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final VoidCallback? onSuffixPressed;
  TextStyle? textStyle;
  final bool spaceCoverToComma;
  final Widget? customWidget;
  final Widget? customIcon;
  final Widget?icon;
  final double borderRadius;
  final bool? colorBorder;

  @override
  _CustomTextFieldMyState createState() => _CustomTextFieldMyState();
}

class _CustomTextFieldMyState extends State<CustomTextFieldMy> {
  Color color = AppColors.green;
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  TextEditingController? controller;

  @override
  void initState() {
    obscureText = widget.obscureText ?? false;
    setType(widget.inputType);
    focusNode.addListener(() {
      if (widget.inputType != InputType.Error) {
        setState(() {
          setType(widget.inputType);
        });
      }
      // print('focus $color');
    });
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  void setType(InputType? inputType) {
    switch (inputType) {
      case InputType.Error:
        color = AppColors.colorRed1;
        break;
      default:
        color =
        focusNode.hasFocus ? AppColors.BG : AppColors.colorIndicator;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
      widget.validator != null ? widget.validator!(controller?.text) : null,
      builder: (FormFieldState<String> state) {
        if (state.errorText != null || widget.errorText != null)
          setType(InputType.Error);
        else
          setType(widget.inputType);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.label != null)
              Container(
                padding: EdgeInsets.only(
                    bottom: widget.colorBorder == true ? 6 : 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.label!,
                      textAlign: TextAlign.center,
                      style:rbtBold(color: AppColors.black, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    widget.customWidget ?? SizedBox()
                  ],
                ),
              ),
            Container(
              width: double.infinity,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.colorBorder == true ? AppColors.colorRed1 : color,
                  width: widget.colorBorder == true ? 1 : 2,
                ),
              ),
              child: TextFormField(
                maxLength: widget.maxLength,
                enabled: widget.enabled ?? true,
                maxLines: widget.maxLines ?? 1,
                controller: controller,
                obscureText: obscureText,
                focusNode: focusNode,
                keyboardType: widget.keyboardType,
                onChanged: (text) {
                  state.validate();
                  if (widget.onChanged != null) widget.onChanged!(text);
                },
                decoration: InputDecoration(
                  hintText: widget.hintText ?? widget.label ?? 'Type something',
                  hintStyle: rbtMedium(color: AppColors.whiteDark, fontSize: 16),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  border: InputBorder.none,
                  suffixIcon: widget.customIcon,
                  icon:  widget.icon != null ? Padding(padding: EdgeInsets.only(left: 16), child: widget.icon,) : SizedBox()
                ),
                style: widget.textStyle,
              ),
            ),
            if (state.errorText != null || widget.errorText != null)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  state.errorText!,
                  style: rbtMedium(color: AppColors.colorText, fontSize: 16),
                ),
              )
          ],
        );
      },
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print("oldValue$oldValue");
    print("newValue$newValue");
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String newText = newValue.text.replaceAll(',', '');
    newText = newText.replaceAll(' ', ', ');
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

enum InputType {
  None,
  EnabledSearch,
  Focus,
  Error,
}
