import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/product_provider.dart' show ProductProvider;
import '../widgets/category_header.dart';
import '../../screens/shop/product.dart';


class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.080,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buy your",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.050,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "favorite gadget",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.040,
                        ),
                      )
                    ],
                  ),
                   CircleAvatar(
                    radius: size.width * 0.060,
                    foregroundImage: const NetworkImage(
                      "https://t3.ftcdn.net/jpg/02/00/90/24/360_F_200902415_G4eZ9Ok3Ypd4SZZKjc8nqJyFVp1eOD6V.jpg",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              SizedBox(
                width: size.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    focusColor: Colors.black38,
                    isCollapsed: false,
                    hintText: "Search gadgets",
                    prefixIcon: const Icon(Icons.search),
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.01,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Column(
                children: [
                  CategoryHeader(
                    title: 'Mac',
                    count:
                        '${Provider.of<ProductProvider>(context).macs.length}',
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) => Row(
                        children: value.macs
                            .map((product) => Product(
                          product: product as ProductModel,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CategoryHeader(
                    title: 'iPad',
                    count:
                        '${Provider.of<ProductProvider>(context).ipads.length}',
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) => Row(
                        children: value.ipads
                            .map((product) => Product(
                                  product: product as ProductModel,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CategoryHeader(
                    title: 'iPhone',
                    count:
                        '${Provider.of<ProductProvider>(context).iphone.length}',
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) => Row(
                        children: value.iphone
                            .map((product) => Product(
                          product: product as ProductModel,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CategoryHeader(
                    title: 'Accessories',
                    count:
                        '${Provider.of<ProductProvider>(context).accessories.length}',
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) => Row(
                        children: value.accessories
                            .map((product) => Product(
                          product: product as ProductModel,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CategoryHeader(
                    title: 'Audio',
                    count:
                        '${Provider.of<ProductProvider>(context).audio.length}',
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) => Row(
                        children: value.audio
                            .map((product) => Product(
                          product: product as ProductModel,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
