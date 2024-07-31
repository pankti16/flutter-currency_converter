import 'package:currency_converter/common/utils.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const UsdToAny({super.key, required this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'INR';
  String result = '';

  void convertAmount() {
    setState(() {
      result = '${usdController.text.isEmpty ? '1' : usdController.text} USD = ${convertUsdToAny(widget.rates[dropdownValue], usdController.text)} $dropdownValue';
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
                "USD to Any Currency",
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
            TextFormField(
              key: const Key('USD'),
              controller: usdController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              onChanged: (String value) {
                convertAmount();
              },
              decoration: const InputDecoration(
                hintText: 'Enter USD',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade900,
                    value: dropdownValue,
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
                      setState(() {
                        dropdownValue = value!;
                      });
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
                ElevatedButton(
                  onPressed: convertAmount, child: Text('Convert', style: TextStyle(color: Colors.grey.shade900,),),
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
