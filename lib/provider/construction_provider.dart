import 'package:flutter/material.dart';
import 'package:providerskel/data/models/construction_model.dart';
import 'package:providerskel/data/repos/database_helper.dart';

class ProjectProvider with ChangeNotifier {
  List<ConstructionModel> _projects = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<ConstructionModel> get projects => _projects;

  Future<void> loadProjects() async {
    _projects = await _dbHelper.getProjects();
    notifyListeners();
  }

  Future<void> addProject(ConstructionModel project) async {
    await _dbHelper.insertProject(project);
    await loadProjects();
  }

  Future<void> updateProject(ConstructionModel project) async {
    await _dbHelper.updateProject(project);
    await loadProjects();
  }

  Future<void> deleteProject(int id) async {
    await _dbHelper.deleteProject(id);
    await loadProjects();
  }
}
