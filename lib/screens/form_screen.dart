import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCtl = TextEditingController();
  final modelCtl = TextEditingController();
  final brandCtl = TextEditingController();
  final priceCtl = TextEditingController();
  final yearCtl = TextEditingController();
  final colorCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'แบบฟอร์มเพิ่มข้อมูล',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 85, 75, 114)),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'ชื่อรถ',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      autofocus: false,
                      controller: nameCtl,
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
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      keyboardType: TextInputType.number,
                      controller: priceCtl,
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
          
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'ยี่ห้อ',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      controller: brandCtl,
                    ),
                  ),
          
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'รุ่น',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      controller: modelCtl,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'ปี',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)
                              ),
                      keyboardType: TextInputType.number,
                      controller: yearCtl,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'สี',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      controller: colorCtl,
                    ),
                  ),
          
                  TextButton(
                      child: const Text(
                        'บันทึก',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(255, 85, 75, 114)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // create transaction data object
                          var statement = Transactions(
                              keyID: null,
                              name: nameCtl.text,
                              price: double.parse(priceCtl.text),
                              brand: brandCtl.text,
                              model:modelCtl.text,
                              year: int.parse(yearCtl.text),
                              color: colorCtl.text, 
                              date: DateTime.now());
          
                          // add transaction data object to provider
                          var provider = Provider.of<TransactionProvider>(context, listen: false);
                          provider.addTransaction(statement);
          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return MyHomePage();
                                  }));
                        }
                      })
                ],
              )),
        ));
  }
}
