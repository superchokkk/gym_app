import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../domain/models/Cliente.dart';
import '../../../api/perguntasSlideCliente.dart';
import '../treino/treino.dart';

class ListaclientesPage extends StatefulWidget {
  final int idAcesso;

  const ListaclientesPage({
    required this.idAcesso,
    super.key,
  });

  @override
  _ListaclientesPageState createState() => _ListaclientesPageState();
}

class _ListaclientesPageState extends State<ListaclientesPage> {
  late Future<List<Cliente>> clientesFuture;
  int flagView = 0;
  TextEditingController _NameController = TextEditingController();
  TextEditingController _CpfController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _IdadeController = TextEditingController();
  TextEditingController _PesoController = TextEditingController();
  TextEditingController _AlturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientesFuture = fetchClientes();
  }

  void mudaFlag() {
    if (flagView == 0) {
      setState(() {
        flagView = 1;
      });
    } else {
      setState(() {
        flagView = 0;
      });
    }
  }

  void _showAddTreinoDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Adicionar aluno',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _NameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nome:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _CpfController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'CPF:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _EmailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _IdadeController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _PesoController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _AlturaController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Altura:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_NameController.text.isNotEmpty &&
                  _CpfController.text.isNotEmpty &&
                  _EmailController.text.isNotEmpty &&
                  _IdadeController.text.isNotEmpty &&
                  _PesoController.text.isNotEmpty &&
                  _AlturaController.text.isNotEmpty) {
                bool success = await adicionarCliente(
                  nome: _NameController.text,
                  cpf: _CpfController.text,
                  email: _EmailController.text,
                  senha: 'senha',
                  idade: int.parse(_IdadeController.text),
                  peso: double.parse(_PesoController.text),
                  altura: double.parse(_AlturaController.text),
                );

                if (success) {
                  Navigator.of(context).pop();
                  setState(() {
                    clientesFuture = fetchClientes();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cliente adicionado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao adicionar cliente'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

  void _showStatusDialog(BuildContext context, Cliente cliente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Status de ${cliente.nome}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusButton(
                  text: 'Pago',
                  color: Colors.green,
                  onPressed: () async {
                    await updateClientePgto(cliente.id, 1);
                    if (mounted) {
                      setState(() {
                        clientesFuture = fetchClientes();
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildStatusButton(
                  text: 'Em aberto',
                  color: Colors.yellow,
                  onPressed: () async {
                    await updateClientePgto(cliente.id, 2);
                    if (mounted) {
                      setState(() {
                        clientesFuture = fetchClientes();
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildStatusButton(
                  text: 'Vencida',
                  color: Colors.red,
                  onPressed: () async {
                    await updateClientePgto(cliente.id, 3);
                    if (mounted) {
                      setState(() {
                        clientesFuture = fetchClientes();
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _confirmaDelet(int clinetId) async {
      bool? confirmDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Confirmar exclusão',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Deseja realmente excluir esse treino?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        final success = await deletarCliente(clinetId);
        if (success) {
          setState(() {
            clientesFuture = fetchClientes();
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Treino excluído com sucesso!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erro ao excluir treino'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ColorsConst.blacksBackgroundsSplashPage,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            //botão de voltar
            Positioned(
              top: MediaQuery.of(context).padding.top + 30,
              left: 10,
              child: SizedBox(
                width: 50,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            if (widget.idAcesso == 1)
              Positioned(
                top: 30,
                right: 10,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  //botão de excluir serie
                  child: ElevatedButton(
                    onPressed: () {
                      mudaFlag();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 85,
              left: 0,
              right: 0,
              child: Text(
                'Clientes:',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: FutureBuilder<List<Cliente>>(
                future: clientesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar clientes: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum cliente encontrado.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final cliente = snapshot.data![index];
                      return Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      cliente.nome,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'CPF: ${cliente.cpf}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Idade: ${cliente.idade} anos',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Peso: ${cliente.peso} kg',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Altura: ${cliente.altura} m',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (widget.idAcesso == 1)
                                      Builder(
                                        builder: (context) {
                                          final now = DateTime.now();
                                          final dataParts =
                                              cliente.data.split('/');
                                          final clienteData = DateTime(
                                            int.parse(dataParts[2]), // ano
                                            int.parse(dataParts[1]), // mês
                                            int.parse(dataParts[0]), // dia
                                          );

                                          Color statusColor;
                                          String statusText;
                                          if (clienteData.year == now.year &&
                                              clienteData.month == now.month) {
                                            statusColor = Colors.green;
                                            statusText = "Em dia";
                                          } else if (clienteData.year ==
                                                  now.year &&
                                              clienteData.month ==
                                                  now.month - 1) {
                                            statusColor = Colors.yellow;
                                            statusText = "Em aberto";
                                          } else {
                                            statusColor = Colors.red;
                                            statusText = "Atrasado";
                                          }

                                          return ElevatedButton(
                                            onPressed: () {
                                              _showStatusDialog(
                                                  context, cliente);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              elevation: 0,
                                              padding: const EdgeInsets.all(8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Container(
                                              width: 24, // Increased size
                                              height: 24, // Increased size
                                              decoration: BoxDecoration(
                                                color: statusColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      if (flagView == 1)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 24,
                                              ),
                                              onPressed: () =>
                                                  _confirmaDelet(cliente.id),
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                          ),
                                        ),
                                    if (widget.idAcesso == 2)
                                      Container(
                                        width: 56.0,
                                        height: 56.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.red,
                                              Colors.redAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TreinoPage(
                                                        clienteId: cliente.id),
                                              ),
                                            );
                                          },
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      //botão de adicionar
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddTreinoDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
