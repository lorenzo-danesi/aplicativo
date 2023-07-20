import 'package:aplicativo/service/eventoservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/evento.dart';

class Novo extends StatefulWidget {
//const Novo({Key? key}) : super(key: key);

  @override
  State<Novo> createState() => _NovoState();
}

class _NovoState extends State<Novo> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EVENTO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: nomeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome"
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: dataController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Selecione a data"
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selecionaData = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2100)
                      );

                      if(selecionaData != null) {
                        setState(() {
                          dataController.text = DateFormat('dd-MM-yyyy').format(selecionaData);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: horaController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.access_time_rounded),
                          labelText: "Selecione a hora"
                      ),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? selecionaHora = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 12, minute: 00),
                        );

                        if (selecionaHora != null) {
                          setState(() {
                            horaController.text = selecionaHora.format(context);
                          });
                        }
                      }
                  ),
                  Container(
                    //color: Colors.red,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(18),
                        elevation: 5.0,
                      ),
                      onPressed: () async {
                        // verifica se o campo tem algo, caso contrário não salva
                        if (formKey.currentState!.validate()) {
                          //cria o evento com os dados do formulário
                          Evento e = Evento(
                            nomeController.text,
                            dataController.text,
                            horaController.text,
                          );
                          await EventoService().adicionar(e);

                          //retorna para a tela anterior e atualiza a lista de eventos
                          Navigator.pop(context, true);
                        } else {
                          debugPrint('formulário inválido');
                        }
                      },
                      child: const Text('Adicionar'),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
