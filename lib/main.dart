import 'package:navegacao/Telas/tela_produtos.dart';
import 'package:navegacao/models/produtos.dart';
import 'package:flutter/material.dart';
import 'utils/rotas.dart';
// depois de programar a tela

import 'Telas/tela_categoria.dart';

void main() => runApp(AppCardapio());

class AppCardapio extends StatelessWidget {
  Future<List<Produto>>? produtosValidos = dados_categoria();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Schyler',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(
                fontSize: 20,
                fontFamily: "Schyler",
              ),
            ),
      ),
      // home: TelaCategorias(),
      routes: {
        Rotas.HOME: (ctx) => TelaCategorias(),
        Rotas.PRODUTOS: (ctx) => FutureBuilder<List<Produto>>(
          future: produtosValidos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text('Erro ao carregar os produtos');
            } else {
              return TelaProdutos(snapshot.data!);
            }
          },
        ),
      },
    );
  }
}
