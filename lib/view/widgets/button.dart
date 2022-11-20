import 'package:miniproject/view/constant/constant.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final bool isLoading;
  const Button({
    this.onTap,
    this.text,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 2),
              color: primaryColor.withOpacity(0.4))
        ], color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text ?? "",
                    style: titleStyleText.copyWith(color: Colors.white),
                  )),
      ),
    );
  }
}
