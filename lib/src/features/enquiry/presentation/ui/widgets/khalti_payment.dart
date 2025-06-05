


import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiPaymentUi extends StatelessWidget {
  final Future<Khalti?> khalti;
  const KhaltiPaymentUi({required this.khalti,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: khalti,
          initialData: null,
          builder: (context, snapshot) {
            final khaltiSnapshot = snapshot.data;
            if (khaltiSnapshot == null) {
              return const CircularProgressIndicator.adaptive();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Rs. 22',
                  style: TextStyle(fontSize: 25),
                ),
                const Text('1 day fee'),
                OutlinedButton(
                  onPressed: () => khaltiSnapshot.open(context),
                  child: const Text('Pay with Khalti'),
                ),
                const SizedBox(height: 120),
                // paymentResult == null
                //     ? Text(
                //   'pidx: $pidx',
                //   style: const TextStyle(fontSize: 15),
                // )
                //     : Column(
                //   children: [
                //     Text(
                //       'pidx: ${paymentResult!.payload?.pidx}',
                //     ),
                //     Text('Status: ${paymentResult!.payload?.status}'),
                //     Text(
                //       'Amount Paid: ${paymentResult!.payload?.totalAmount}',
                //     ),
                //     Text(
                //       'Transaction ID: ${paymentResult!.payload?.transactionId}',
                //     ),
                //   ],
                // ),
                const SizedBox(height: 120),
                const Text(
                  'This is a demo application developed by some merchant.',
                  style: TextStyle(fontSize: 12),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
