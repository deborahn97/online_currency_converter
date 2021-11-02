// ignore_for_file: avoid_unnecessary_containers, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// Online Currency Converter Page

class OnlineCurrencyConverter extends StatefulWidget {
  const OnlineCurrencyConverter({ Key? key }) : super(key: key);

  @override
  _OnlineCurrencyConverterState createState() => _OnlineCurrencyConverterState();
}

class _OnlineCurrencyConverterState extends State<OnlineCurrencyConverter> {
  var conVal = "0.00";
  TextEditingController oriEC = TextEditingController();
  String oriCur = "MYR";
  String conCur = "USD";
  List<String> curList = [
    "MYR",
    "SGD",
    "USD",
    "GBP",
    "CNY",
  ];

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Online Currency Converter'),
        ),
        body: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset('assets/images/convert_currency.png', scale: 9),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          GridView.count(
                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.3),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            children: [
                              Container( // Select Initial Currency
                                child: Column(
                                  children: [
                                    const Text(
                                      "Select currency:",
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                    DropdownButton(
                                      itemHeight: 50,
                                      value: oriCur, 
                                      onChanged: (newValue) {
                                        setState(() {
                                          oriCur = newValue.toString();
                                        });
                                      },
                                      items: curList.map((oriCur) {
                                        return DropdownMenuItem(
                                          child: Text(oriCur),
                                          value: oriCur,
                                        );
                                      },).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Container( // Select Currency to Convert To
                                child: Column(
                                  children: [
                                    const Text(
                                      "Convert to:",
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                    DropdownButton(
                                      itemHeight: 50,
                                      value: conCur, 
                                      onChanged: (newValue) {
                                        setState(() {
                                          conCur = newValue.toString();
                                        });
                                      },
                                      items: curList.map((conCur) {
                                        return DropdownMenuItem(
                                          child: Text(conCur),
                                          value: conCur,
                                        );
                                      },).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Container( // Input Value to Convert
                                child: Column(
                                  children: [
                                    const Text(
                                      "Input value:",
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                    TextField(
                                      controller: oriEC,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'),),],
                                      decoration: InputDecoration(
                                        hintText: "e.g. 10.11", 
                                        isDense: true, 
                                        contentPadding: const EdgeInsets.all(12.0), 
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container( // Display Converted Value
                                child: Column(
                                  children: [
                                    const Text(
                                      "Equals to :",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        conVal.toString(), // Value to be changed
                                        style: const TextStyle(fontSize: 20, color: Color(0xFFD32F2F)),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.amber,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _convert, 
                          child: const Text('Convert Now'),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ),
    );
  }

  Future<void> _convert() async {
    if(oriEC.text.isNotEmpty) {
      var apiID = "967fae70-3ae0-11ec-b2c0-752ee73a22ca";
      var url = Uri.parse('https://freecurrencyapi.net/api/v2/latest?apikey=$apiID&base_currency=$oriCur');
      var response = await http.get(url);
      var resCode = response.statusCode;

      if(resCode == 200) { // Query success
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);

        setState(() {
          double oriValue = double.parse(oriEC.text);
          // Conversion
          var currencyRate = parsedJson['data']['$conCur'];
          if(oriCur != conCur) {
            conVal = (oriValue * currencyRate).toStringAsFixed(2);
          } else {
            conVal = oriValue.toStringAsFixed(2); // Reprint original value
          }
        });
      } else { // Query failed
        setState(() {
          conVal = "Error"; 
        });
      }
    } else { 
        setState(() {
          conVal = "Enter a Value"; 
        });
      }
  }
}