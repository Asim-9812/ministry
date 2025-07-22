


import 'package:khalti/khalti.dart';
import 'package:ministry/src/core/utils/launch_url.dart';

class ConnectIpsService{


  Future<void> connectIps() async{
    try{


      KhaltiService.publicKey = 'live_public_key_ceead578475246fc83a9040d00610f93';
      final service = KhaltiService(client: KhaltiHttpClient());
      final bankPaymentUrl = service.buildBankUrl(
        bankId: 'UniqueID',
        amount: 1000,
        paymentType: PaymentType.connectIPS,
        productName: 'Test product',
        mobile: '9887162315',
        productIdentity: 'TEST122',
        returnUrl: 'www.google.com'
      );
      await ExternalLinks.url(bankPaymentUrl);
    }catch (e){
      print(e);
    }
  }
}