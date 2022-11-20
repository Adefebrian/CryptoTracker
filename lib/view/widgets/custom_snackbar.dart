import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackbar(
        BuildContext context,{String? message,Color? backgroundColor} ) =>
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(message ?? "Message"),
      backgroundColor: backgroundColor,
    ));
