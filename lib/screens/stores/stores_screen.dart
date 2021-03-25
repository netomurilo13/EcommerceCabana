import 'package:ELoja/common/custom_drawe/custom_drawer.dart';
import 'package:ELoja/models/stores_manager.dart';
import 'package:ELoja/screens/stores/components/store_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class StoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  Text('Lojas', style: GoogleFonts.comfortaa(),),
        centerTitle: true,
      ),
      body: Consumer<StoresManager>(
        builder: (_, storesManager, __) {
          if (storesManager.stores.isEmpty) {
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.transparent,
            );
          }

          return ListView.builder(
            itemCount: storesManager.stores.length,
            itemBuilder: (_, index) {
              return StoreCard(storesManager.stores[index]);
            },
          );
        },
      ),
    );
  }
}
