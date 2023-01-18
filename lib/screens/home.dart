import 'package:flutter/material.dart';
import 'package:mobile_wallet/screens/transactions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/wallet.jpg'),
            const SizedBox(height: 40.0),
            const Text(
              'WALLET BALANCE',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5.0),
            Text(
              '\$ 1200',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transactions()),
                      );
                    },
                    child: Text(
                      'View transactions',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Spend from wallet',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ButtonStyle(
                        // shape: MaterialStateProperty.all(
                        //   RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(5.0),
                        //   ),
                        // ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                              style: BorderStyle.solid),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 15.0),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
