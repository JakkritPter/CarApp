import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {


  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('แบบฟอร์มเพิ่มข้อมูล',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 85, 75, 114)),
          ),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ชื่อรถ',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    autofocus: false,
                    controller: titleController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ราคา',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (String? input) {
                      try {
                        double amount = double.parse(input!);
                        if (amount < 0) {
                          return 'กรุณากรอกข้อมูลมากกว่า 0';
                        }
                      } catch (e) {
                        return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                      }
                    },
                  ),
                ),
                TextButton(
                    child: const Text('บันทึก', 
                    style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 85, 75, 114)
                      ),
                    ),
                    onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              // create transaction data object
                              var statement = Transactions(
                                  keyID: null,
                                  title: titleController.text,
                                  amount: double.parse(amountController.text),
                                  date: DateTime.now()
                                  );
                              // add transaction data object to provider
                              var provider = Provider.of<TransactionProvider>(context, listen: false);
                              provider.addTransaction(statement);
                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context){
                                  return MyHomePage();
                                }
                              ));
                            }
                        })
              ],
            )));
  }
}
