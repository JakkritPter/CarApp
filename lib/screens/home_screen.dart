import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 74, 61),
        title: const Text(
          "ShoCar",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'ค้นหารายการ...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final filteredTransactions = provider.transactions.where((transaction) {
            return transaction.name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();
          if (filteredTransactions.isEmpty) {
            return const Center(
              child: Text(
                'ไม่มีรายการ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                var statement = filteredTransactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      statement.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ราคา: ${statement.price.toInt()} บาท', style: TextStyle(fontSize: 16)),
                        Text('ยี่ห้อ: ${statement.brand}', style: TextStyle(fontSize: 16)),
                        Text('รุ่น: ${statement.model}', style: TextStyle(fontSize: 16)),
                        Text('ปี: ${statement.year}', style: TextStyle(fontSize: 16)),
                        Text('สี: ${statement.color}', style: TextStyle(fontSize: 16)),
                        Text(
                          DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 73, 73),
                      child: FittedBox(
                        child: Text(
                          statement.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 45,
                      ),
                      onPressed: () {
                        provider.deleteTransaction(statement.keyID);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
