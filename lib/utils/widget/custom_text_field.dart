import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
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
    this.icon,
    this.customWidget,
    this.labelColor,
    this.spaceCoverToComma = false,
    this.colorBorder = false,
    this.borderRadius = 8,
  }) : super(key: key) {
    if (this.textStyle == null) {
      this.textStyle = rbtMedium(color: AppColors.black, fontSize: 14);
    }
  }

  final InputType? inputType;
  final String? label;
  final String? labelColor;
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
  final double borderRadius;
  final bool? colorBorder;
  final Widget?icon;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
        color = focusNode.hasFocus ? AppColors.BG : AppColors.black;
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
                      style: rbtMedium(color: color, fontSize: 18),
                    ),
                    widget.labelColor != null && widget.labelColor != '' ? Text(
                      widget.labelColor!,
                      textAlign: TextAlign.end,
                      style: rbtMedium(color: AppColors.colorText, fontSize: 18),
                    ) : SizedBox(),
                    SizedBox(width: 10),
                    widget.customWidget ?? SizedBox()
                  ],
                ),
              ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color:
                      widget.colorBorder == true ? AppColors.colorBlack8 : color,
                  width: widget.colorBorder == true ? 1 : 2,
                ),
              ),
              child: TextFormField(
                maxLength: widget.maxLength,
                enabled: widget.enabled ?? true,
                maxLines: widget.maxLines ?? 1,
                minLines: 1,
                controller: controller,
                obscureText: obscureText,
                focusNode: focusNode,
                keyboardType: widget.keyboardType,
                inputFormatters: <TextInputFormatter>[
                  if (widget.keyboardType == TextInputType.phone ||
                      widget.keyboardType == TextInputType.number)
                    FilteringTextInputFormatter.digitsOnly,
                  if (widget.spaceCoverToComma == true) ...{
                    CurrencyInputFormatter()
                  }
                ],
                onChanged: (text) {
                  state.validate();
                  if (widget.onChanged != null) widget.onChanged!(text);
                },
                decoration: InputDecoration(
                    hintText:
                        widget.hintText ?? widget.label ?? 'Type something',
                    hintStyle:
                        rbtMedium(color: AppColors.black.withOpacity(0.3), fontSize: 16),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    border: InputBorder.none,
                    suffixIcon:
                        widget.obscureText != null || widget.suffixIcon != null
                            ? CupertinoButton(
                                child: Icon(
                                  widget.suffixIcon != null
                                      ? widget.suffixIcon
                                      : obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                                pressedOpacity: 0.7,
                                padding: EdgeInsets.zero,
                                onPressed: () => {
                                  if (widget.obscureText != null)
                                    setState(() => obscureText = !obscureText),
                                  if (widget.onSuffixPressed != null)
                                    widget.onSuffixPressed!(),
                                },
                              )
                            : null,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: widget.icon,
                    )),
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
