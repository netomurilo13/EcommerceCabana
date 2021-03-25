import 'package:ELoja/common/custom_drawe/custom_drawer.dart';
import 'package:ELoja/common/empty_card.dart';
import 'package:ELoja/common/login_card.dart';
import 'package:ELoja/models/orders_manager.dart';
import 'package:ELoja/common/order/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  Text('Meus Pedidos',style: GoogleFonts.comfortaa(),),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(ordersManager.orders.reversed.toList()[index]);
              });
        },
      ),
    );
  }
}
