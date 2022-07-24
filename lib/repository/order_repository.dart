import 'package:rezeki_bundle_mobile/api/order_api.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';

class OrderRepository {
     OrderRepository():super();
 
  final OrderService service = OrderService();

  Future<List<Order>> getUserOrderTransaction(token, userID) async => service.getUserOrderTransaction(token, userID);

}
