import 'package:currency_converter/common/utils.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const AnyToAny({super.key, required this.rates, required this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String toDropdownValue = 'INR';
  String fromDropdownValue = 'INR';
  String result = '';

  void convertAmount() {
    setState(() {
      result = '${amountController.text.isEmpty ? '1' : amountController.text} $fromDropdownValue = ${convertAnyToAny(widget.rates[fromDropdownValue], widget.rates[toDropdownValue], amountController.text)} $toDropdownValue';
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Any to Any Currency",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: const Key('Any'),
                    controller: amountController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String value) {
                      convertAmount();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter $fromDropdownValue',
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: convertAmount, child: Text('Convert', style: TextStyle(color: Colors.grey.shade900,),),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade900,
                    value: fromDropdownValue,
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 24.0,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2.0,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? value) {
                      bool isSame = fromDropdownValue == value;
                      setState(() {
                        fromDropdownValue = value!;
                      });
                      if (!isSame) {
                        convertAmount();
                      }
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade900,
                    value: toDropdownValue,
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 24.0,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2.0,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? value) {
                      bool isSame = toDropdownValue == value;
                      setState(() {
                        toDropdownValue = value!;
                      });
                      if (!isSame) {
                        convertAmount();
                      }
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
