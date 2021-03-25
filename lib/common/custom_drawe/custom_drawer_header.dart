import 'package:ELoja/models/page_manager.dart';
import 'package:ELoja/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                'assets/logo.png',
                height: 34,
              ),
              SizedBox(width: 12,),
              Text(
                'Cabana',
                style: GoogleFonts.comfortaa(
                  textStyle: const TextStyle(color: Colors.white),
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
                ),
                ],
              ),
              const SizedBox(height: 10,),
              Text(
                'Olá, ${userManager.user?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.comfortaa(
                  textStyle: const TextStyle(color: Colors.white),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userManager.isLoggedIn) {
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                  style: GoogleFonts.comfortaa(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
//fonte mokoto - caixa alta - 
