import 'package:flutter/material.dart';
import 'package:mobile_wallet/screens/transactions.dart';
import 'package:mobile_wallet/utils.dart';
import 'package:mobile_wallet/wallet_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User user;
  bool _isLoading = false;
  bool _isTransacting = false;
  bool _isError = false;

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  _getUserDetails() {
    setState(() {
      _isLoading = true;
    });

    WalletService().getUserDetails().then((value) {
      setState(() {
        user = value;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  _createTransaction(String userId, String name, int balance) {
    setState(() {
      _isTransacting = true;
    });
    int amount = 20;
    WalletService().createTransaction(userId, amount).then((value) {
      WalletService()
          .updateUserBalance(userId, name, balance, amount)
          .then((value) {
        //update balance inapp
        int newBalance = user.balance - amount;
        setState(() {
          _isTransacting = false;
          user.balance = newBalance;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction created successfully!')),
        );
      }).catchError((e) {
        setState(() {
          _isTransacting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error creating transaction!')),
        );
      });
    }).catchError((e) {
      setState(() {
        _isTransacting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating transaction!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ))
        : _isError
            ? const Center(
                child: Text(
                  'Error getting users details',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Scaffold(
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
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '\$ ${user.balance}',
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
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
                                      builder: (context) =>
                                          const Transactions()),
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
                              onPressed: _isTransacting
                                  ? null
                                  : () {
                                      _createTransaction(
                                        user.$id.toString(),
                                        user.name,
                                        user.balance,
                                      );
                                    },
                              child: Text(
                                'Spend from wallet',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                        style: BorderStyle.solid),
                                  ),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 15.0),
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
