


import 'package:khalti/khalti.dart';
import 'package:ministry/src/core/utils/launch_url.dart';

class ConnectIpsService{


  Future<void> connectIps() async{
    try{


      KhaltiService.publicKey = 'live_public_key_ceead578475246fc83a9040d00610f93';
      final service = KhaltiService(client: KhaltiHttpClient());
      final bankPaymentUrl = service.buildBankUrl(
        bankId: '1234567890',
        amount: 1000,
        mobile: '9818327838',
        productIdentity: 'macbook-pro-21',
        productName: 'Macbook Pro 2021',
        paymentType: PaymentType.connectIPS,
        returnUrl: 'www.google.com',
      );
      print('url ; $bankPaymentUrl');

      await ExternalLinks.url(bankPaymentUrl);


    }catch (e){
      print(e);
    }

  }

}