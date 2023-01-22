import 'package:flutter/material.dart';
import 'package:mobile_wallet/utils.dart';
import 'package:mobile_wallet/wallet_service.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late List<Transaction> transactions;
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    _getTransactions();
    super.initState();
  }

  _getTransactions() {
    setState(() {
      _isLoading = true;
    });

    WalletService().getTransactions().then((value) {
      setState(() {
        transactions = value;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
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
                  'Error getting list of transactions',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Transactions'),
                  backgroundColor: Colors.black,
                ),
                body: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: .5, color: Colors.grey),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactions[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 10.0),
                                Text(transactions[index].paymentMethod)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10.0),
                              Text('\$ ${transactions[index].amount}')
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
  }
}
