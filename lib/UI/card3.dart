import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/task.dart';
import 'detail.dart';

class Ecran3 extends StatelessWidget {
  const Ecran3({super.key});

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((json) {
        return Task(
          id: json['id'],
          title: json['title'],
          tags: ["user ${json['userId']}"],
          nbhours: 0,
          difficulty: json['completed'] ? 1 : 0,
          description:
              "Tâche ${json['id']} pour l'utilisateur ${json['userId']}\n"
              "Statut : ${json['completed'] ? "Terminée ✅" : "En cours ❌"}",
          color: json['completed'] ? Colors.greenAccent : Colors.redAccent,
        );
      }).toList();
    } else {
      throw Exception('Erreur lors du chargement des tâches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.data != null) {
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                color: Colors.white,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 0, 247, 226),
                    child: Text(task.id.toString()),
                  ),
                  title: Text(task.title),
                  subtitle: Text(task.tags.join(" ")),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(task: task),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
