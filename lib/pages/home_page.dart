import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/services/fetch_rates.dart';
import 'package:currency_converter/widgets/any_to_any.dart';
import 'package:currency_converter/widgets/usd_to_any.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final Key formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    result = fetchRates();
    allCurrencies = fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: FutureBuilder<RatesModel>(future: result, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white,));
              }
              return Center(
                child: FutureBuilder<Map>(future: allCurrencies, builder: (context, currSnapshot) {
                  if (currSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white,));
                  }
                  return Column(
                    children: [
                      UsdToAny(rates: snapshot!.data?.rates, currencies: currSnapshot!.data!,),
                      const SizedBox(height: 10.0,),
                      AnyToAny(rates: snapshot!.data?.rates, currencies: currSnapshot!.data!,),
                    ],
                  );
                },),
              );
            },),
          ),
        ),
      ),
    );
  }
}