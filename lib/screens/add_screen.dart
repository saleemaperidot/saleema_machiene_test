import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerskel/data/models/construction_model.dart';
import 'package:providerskel/provider/construction_provider.dart';

class AddProjectScreen extends StatefulWidget {
  final ConstructionModel? project;
  AddProjectScreen({this.project});

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  String? _startDate;
  String? _endDate;
  String _status = "Ongoing";

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _nameController.text = widget.project!.name;
      _locationController.text = widget.project!.location;
      _startDate = widget.project!.startDate;
      _endDate = widget.project!.endDate;
      _status = widget.project!.status;
    }
  }

  // Function to select a date
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        String formattedDate =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        if (isStartDate) {
          _startDate = formattedDate;
        } else {
          _endDate = formattedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.project == null ? "Add Project" : "Edit Project")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Project Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter project name" : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: "Location"),
                validator: (value) => value!.isEmpty ? "Enter location" : null,
              ),
              SizedBox(height: 16),

              // Start Date Picker
              ListTile(
                title: Text("Start Date: ${_startDate ?? 'Select Date'}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),

              // End Date Picker
              ListTile(
                title: Text("End Date: ${_endDate ?? 'Select Date'}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),

              // Status Dropdown
              DropdownButtonFormField(
                value: _status,
                items: ["Ongoing", "Completed", "Pending"]
                    .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _startDate != null &&
                      _endDate != null) {
                    ConstructionModel newProject = ConstructionModel(
                      id: widget.project?.id,
                      name: _nameController.text,
                      location: _locationController.text,
                      startDate: _startDate!,
                      endDate: _endDate!,
                      status: _status,
                    );

                    if (widget.project == null) {
                      Provider.of<ProjectProvider>(context, listen: false)
                          .addProject(newProject);
                    } else {
                      Provider.of<ProjectProvider>(context, listen: false)
                          .updateProject(newProject);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text("Save Project"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
