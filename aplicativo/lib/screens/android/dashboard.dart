import 'package:aplicativo/model/evento.dart';
import 'package:aplicativo/screens/android/login.dart';
import 'package:aplicativo/screens/android/novo.dart';
import 'package:aplicativo/service/eventoservice.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  late Future<List<Evento>> futureEvento;

  TextEditingController pesquisarController = TextEditingController();
  List<Evento> eventos = [];

  @override
  void initState() {
    super.initState();
    refreshEventos();
  }

  void refreshEventos() {
    setState(() {
      futureEvento = EventoService().getEventos().then((eventos) {
        //armazena a lista completa de eventos
        this.eventos = eventos;
        return eventos;
      });
    });
  }

  void realizarPesquisa(String texto) {
    setState(() {
      if (texto.isEmpty) {
        //caso campo de pesquisa estiver vazio exibe todos eventos
        futureEvento = Future.value(eventos);
      } else {
        //filtra a lista de eventos de acordo com o texto digitado
        List<Evento> eventosFiltrados = eventos
            .where((evento) =>
            evento.nome.toLowerCase().contains(texto.toLowerCase()))
            .toList();
        futureEvento = Future.value(eventosFiltrados);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DASHBOARD'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: pesquisarController,
              onChanged: (value) {
                //chama o método quando o campo de pesquisa é alterado
                realizarPesquisa(value);
              },
              decoration: InputDecoration(
                labelText: "Pesquisar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: Container(
                child: futureBuilderEvento(),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Novo()),
            );
            if (result == true) {
              //atualiza a lista de eventos após cadastro
              refreshEventos();
            }
          },
          child: Icon(Icons.add)
      ),
    );
  }

  Widget futureBuilderEvento() {
    return Center(
      child: FutureBuilder<List<Evento>>(
        future: futureEvento,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final eventos = snapshot.data!;
            return ListView.builder(
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return ItemEvento(evento);
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // por padrão mostra o spinner carregando
          return const CircularProgressIndicator();
        },
      ),
    );
  }

}

class ItemEvento extends StatelessWidget {
  final Evento evento;
//final Function onclick;

  ItemEvento(this.evento);
//ItemEvento(this.evento, {required this.onclick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          //onTap: () => this.onclick(),
            title: Text(this.evento.nome),
            subtitle: Row(
              children: <Widget>[
                Text(this.evento.data),
                const Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Icon(
                    Icons.access_time_rounded, size: 16, color: Colors.blue,),
                ),
                Text(this.evento.hora)
              ],
            )
        ),
        const Divider(
          color: Colors.blue,
          indent: 16,
          endIndent: 16,
          thickness: 1.0,
          height: 0.0,
        )
      ],
    );
  }
}
