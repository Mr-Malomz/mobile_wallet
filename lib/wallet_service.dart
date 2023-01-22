import 'package:appwrite/appwrite.dart';
import 'package:mobile_wallet/utils.dart';

class WalletService {
  Client _client = Client();
  Databases? _db;

  WalletService() {
    _init();
  }

  //initialize the application
  _init() async {
    _client
        .setEndpoint(AppConstant().endpoint)
        .setProject(AppConstant().projectId);

    _db = Databases(_client);

    //get current session
    Account account = Account(_client);

    try {
      await account.get();
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        account
            .createAnonymousSession()
            .then((value) => value)
            .catchError((e) => e);
      }
    }
  }

  Future<User> getUserDetails() async {
    try {
      var data = await _db?.getDocument(
          databaseId: AppConstant().databaseId,
          collectionId: AppConstant().userCollectionId,
          documentId: AppConstant().userId);
      var user = data?.convertTo((doc) => User.fromJson(doc));
      return user!;
    } catch (e) {
      throw Exception('Error getting user details');
    }
  }

  Future updateUserBalance(
    String userId,
    String name,
    int balance,
    int amount,
  ) async {
    int newBalance = balance - amount;
    try {
      User updatedUserBalance = User(name: name, balance: newBalance);
      var result = await _db?.updateDocument(
          databaseId: AppConstant().databaseId,
          collectionId: AppConstant().userCollectionId,
          documentId: userId,
          data: updatedUserBalance.toJson());
      return result;
    } catch (e) {
      throw Exception('Error updating user balance!');
    }
  }

  Future createTransaction(String userId, int amount) async {
    try {
      Transaction updatedTransaction = Transaction(
        userId: userId,
        name: "Stamp duty",
        paymentMethod: "internet payment",
        amount: amount,
      );
      var data = await _db?.createDocument(
        databaseId: AppConstant().databaseId,
        collectionId: AppConstant().transactionCollectionId,
        documentId: ID.unique(),
        data: updatedTransaction.toJson(),
      );
      return data;
    } catch (e) {
      throw Exception('Error creating transaction!');
    }
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      var data = await _db?.listDocuments(
        databaseId: AppConstant().databaseId,
        collectionId: AppConstant().transactionCollectionId,
        queries: [Query.orderDesc('userId')],
      );
      var transactionList = data?.documents
          .map((transaction) => Transaction.fromJson(transaction.data))
          .toList();
      return transactionList!;
    } catch (e) {
      throw Exception('Error getting list of transactions!');
    }
  }
}
