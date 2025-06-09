


import 'package:khalti/khalti.dart';

class KhaltiServices{

  Future<String> initiatePayment({required String number, required String pin}) async {
    try {
      final service = KhaltiService(client: KhaltiHttpClient());

      final initiationModel = await service.initiatePayment(
        request: PaymentInitiationRequestModel(
          amount: 1000,
          mobile: number,
          productIdentity: 'mac-mini',
          productName: 'Apple Mac Mini',
          transactionPin: pin,
          productUrl: 'https://khalti.com/bazaar/mac-mini-16-512-m1',
          additionalData: {
            'vendor': 'Oliz Store',
            'manufacturer': 'Apple Inc.',
          },
        ),
      );

      print(initiationModel.token);
      return initiationModel.token;
    } catch (e) {
      if (e is FailureHttpResponse) {
        final errorData = e.data as Map<String, dynamic>?;

        final errorDetail = errorData?['detail'] ?? 'Unknown error';
        final errorKey = errorData?['error_key'] ?? '';

        print('Khalti Error [$errorKey]: $errorDetail');
        throw '$errorDetail';
      } else {
        print('Unexpected error: $e');
        throw 'Unexpected error occurred';
      }
    }
  }



  Future<bool> confirmPayment({required String token, required String otp, required String pin}) async {
    try{

      print('confirming');


      final service = KhaltiService(client: KhaltiHttpClient());

      final confirmationModel = await service.confirmPayment(
        request: PaymentConfirmationRequestModel(
          confirmationCode: otp, // the OTP code received through previous step
          token: token,
          transactionPin: pin,
        ),
      );

      return true;


    }catch (e){
      if (e is FailureHttpResponse) {
        final errorData = e.data as Map<String, dynamic>?;

        final errorDetail = errorData?['token'] ?? errorData?['confirmation_code'] ?? errorData?['transaction_pin'] ?? 'Unknown error';
        final errorKey = errorData?['error_key'] ?? '';

        print('Khalti Error [$errorKey]: $errorDetail');
        throw '$errorDetail';
      } else {
        print('Unexpected error: $e');
        throw 'Unexpected error occurred';
      }
    }
  }





}