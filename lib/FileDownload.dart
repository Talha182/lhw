import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;

  Future<void> startDownloading(
      BuildContext context, Function(double, double) progressCallback) async {
    String fileName = "Chapter13.pdf";

    String baseUrl =
        "https://phcglobal524-my.sharepoint.com/personal/ajwah_nadeem_phcglobal_org/_layouts/15/onedrive.aspx?ga=1&id=%2Fpersonal%2Fajwah%5Fnadeem%5Fphcglobal%5Forg%2FDocuments%2FE%20learning%20LHW%2FSyllabus%2FLHW%20CH%2E13%2Epdf&parent=%2Fpersonal%2Fajwah%5Fnadeem%5Fphcglobal%5Forg%2FDocuments%2FE%20learning%20LHW%2FSyllabus";

    String path = await _getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (receivedBytes, totalBytes) {
          progressCallback(receivedBytes.toDouble(), totalBytes.toDouble());
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception $e");
    }

    if (isSuccess) {
      Navigator.pop(context);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}
