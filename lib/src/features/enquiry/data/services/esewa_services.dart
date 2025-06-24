

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/features/enquiry/data/payment_creds/esewa_creds.dart';

class EsewaServices{
  
  final dio = Dio();

  Future<EsewaPaymentSuccessResult?> makePayment({required String pkey, required String skey}) async {
    final completer = Completer<EsewaPaymentSuccessResult?>();
    String? error;

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: pkey,
          secretId: skey,
        ),
        esewaPayment: EsewaPayment(
          productId: "1",
          productName: "Appointment",
          productPrice: "10",
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          completer.complete(data);
        },
        onPaymentFailure: (data) {
          error = 'Payment failure';
          completer.completeError(error!);
        },
        onPaymentCancellation: (data) {
          error = 'Payment cancelled';
          completer.completeError(error!);
        },
      );
    } on Exception catch (e) {
      error = e.toString();
      completer.completeError(error!);
    }

    return completer.future;
  }


  Future<bool> verifyTransactionStatus({required EsewaPaymentSuccessResult result, required String pkey, required String skey}) async {
    var response = await dio.get('https://rc.esewa.com.np/mobile/transaction?txnRefId=${result.refId}',
      options: Options(
        headers: {
          'merchantId' : pkey,
          'merchantSecret': skey,
          'Content-Type' : 'application/json'
        }
      )
    );
    if (response.statusCode == 200) {

      final sucResponse = response;

      if (sucResponse.data[0]['transactionDetails']['status'] == 'COMPLETE') {
        return true;
      }
      //TODO Handle Txn Verification Failure
      return false;
    }
    else {
      //TODO Handle Txn Verification Failure
      return false;
    }
  }

}