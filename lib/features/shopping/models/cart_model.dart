import 'package:provider_base1/features/shopping/models/product_model.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CartModel {
  final String id;
  final ProductModel product;
  int quantity;

  CartModel({
    required this.product,
    required this.quantity,
  }) : id = uuid.v4();
}
