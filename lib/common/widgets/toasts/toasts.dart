import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  //success toast
  static Future<bool?> successToast({required String msg}) {
    return Fluttertoast.showToast(
      msg: "\u2714 $msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green, // Mobile background color
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
      //  Web styling
      webBgColor: "#00C853", // Green hex (or any shade you want)
      webPosition: "center",
      webShowClose: true,
    );
  }

  //info toast
  static Future<bool?> infoToast({required String msg}) {
    return Fluttertoast.showToast(
      msg: "! $msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue, // Mobile background color
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
      //  Web styling
      webBgColor: "#0000FF", // blue hex (or any shade you want)
      webPosition: "center",
      webShowClose: true,
    );
  }

  //warning  toast
  static Future<bool?> warningToast({required String msg}) {
    return Fluttertoast.showToast(
      msg: "\u26A0 $msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange, // Mobile background color
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
      //  Web styling
      webBgColor: "#FFA500", // orange hex (or any shade you want)
      webPosition: "center",
      webShowClose: true,
    );
  }

  //error  toast
  static Future<bool?> errorToast({required String msg}) {
    return Fluttertoast.showToast(
      msg: "\u203C $msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red, // Mobile background color
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 3,
      //  Web styling
      webBgColor: "#FF0000", // red hex (or any shade you want)
      webPosition: "center",
      webShowClose: true,
    );
  }
}
