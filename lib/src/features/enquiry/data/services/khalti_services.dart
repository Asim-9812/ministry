



import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:ministry/src/features/enquiry/data/payment_creds/khalti_creds.dart';

class KhaltiServices{
  
  final dio = Dio();
  

  Future<String?> initiatePayment({required String name, required String email, required String number}) async {
    
    try{
      final initiateResponse = await dio.post('https://dev.khalti.com/api/v2/epayment/initiate/',
        options: Options(
          headers: {
            // "Authorization": "Key ${khalti_secret_key}"
            "Authorization": "Key a1acb2805ba54cf39bb4bbf0a669c803"
          }
        ),
        data: {
          "return_url": "https://ministry.meroupachar.com/",
          "website_url": "https://ministry.meroupachar.com/",
          "amount": 1000,
          "purchase_order_id": "1",
          "purchase_order_name": "Appointment Fee",
          "customer_info": {
            "name": name,
            "email": email,
            "phone": number
          },
          "amount_breakdown": [
            {
              "label": "Appointment Fee",
              "amount": 1000
            },
          ],
          "product_details": [
            {
              "identity": "1",
              "name": "Appointment Fee",
              "total_price": 1000,
              "quantity": 1,
              "unit_price": 1000
            }
          ],
        }
      );
      if(initiateResponse.statusCode == 200){
        return initiateResponse.data['pidx'];
      }
      else{
        return null;
      }
    }on DioException catch(e){
      print(e);
      return null;
    }
    
  }


  Future<bool> makePayment({required BuildContext context, required String pidx}) async {

    print('pidx : $pidx');

    final completer = Completer<bool>();

    final payConfig = KhaltiPayConfig(
      publicKey: 'd0d0802174344f28b50816f3ee4e493c', // Merchant's public key
      pidx: pidx, // This should be generated via a server side POST request.
      environment: Environment.test,
    );

    // Define the onReturn callback as a named function
    void handleReturn(Khalti payment) {
      payment.close(context);
    }

    final khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        khalti.close(context);

        if(paymentResult.payload?.status == 'Completed'){
          completer.complete(true);
        }
        else{
          completer.complete(false);
        }

      },
      onMessage: (
          khalti, {
            description,
            statusCode,
            event,
            needsPaymentConfirmation,
          }) async {
        print(
          'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
        );
        khalti.close(context);
      },
      onReturn: null
    ).then((payment){
      payment.open(context);
    });


    return completer.future;


  }

}