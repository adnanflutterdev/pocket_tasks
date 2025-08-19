import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/custom_painter/circle_painter.dart';
import 'package:pocket_tasks/modals/task.dart';
import 'package:pocket_tasks/providers/filters.dart';
import 'package:pocket_tasks/providers/get_tasks.dart';
import 'package:pocket_tasks/providers/search_provider.dart';
import 'package:pocket_tasks/providers/task_completion_indicator.dart';
import 'package:pocket_tasks/providers/task_provider.dart';
import 'package:pocket_tasks/utils/button.dart';
import 'package:pocket_tasks/utils/colors.dart';
import 'package:pocket_tasks/utils/spacers.dart';
import 'package:pocket_tasks/widgets/custom_text_field.dart';
import 'package:pocket_tasks/widgets/snackbars.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _addTaskController;

  @override
  void initState() {
    super.initState();
    _addTaskController = TextEditingController();
  }

  void saveTask(taskNotifier) {
    String title = _addTaskController.text.trim();
    if (title.isEmpty) {
      showAppSnackbar(
        context: context,
        message: 'Title can\'t be empty',
        snackBarType: SnackBarType.error,
      );
      return;
    }
    DateTime dateTime = DateTime.now();
    _addTaskController.clear();
    taskNotifier.addTask(
      Task(
        id: dateTime.microsecondsSinceEpoch,
        title: title,
        isDone: false,
        createdAt: dateTime,
      ),
    );
    showAppSnackbar(
      context: context,
      message: 'Task added...',
      snackBarType: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = ref.watch(getTasks);
    TaskNotifier taskNotifier = ref.watch(taskProvider.notifier);
    int filterIndex = ref.watch(filterIndexProvider);
    FilterIndexNotifier filterIndexNotifier = ref.watch(
      filterIndexProvider.notifier,
    );
    Map<String, dynamic> taskCompletionDetails = ref.watch(
      taskCompletionIndicator,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 16, 99),
        title: Row(
          children: [
            CustomPaint(
              size: const Size(50, 50),
              painter: CirclePainter(taskCompletionDetails['percentage']),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    taskCompletionDetails['label'],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            w15,
            Text('PocketTasks', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundGredient,
            begin: Alignment.bottomLeft,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Column(
            children: [
              h10,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _addTaskController,
                      hint: 'Add Task',
                    ),
                  ),
                  w10,
                  button(
                    context: context,
                    onPressed: () {
                      saveTask(taskNotifier);
                    },
                    text: 'Add',
                    backgroundColor: buttonColor,
                    circularButton: false,
                  ),
                ],
              ),
              h20,
              CustomTextField(
                searchNotifier: ref.watch(searchedTextProvider.notifier),
                hint: 'Search',
                icon: Icon(Icons.search, color: textFieldIconColor),
              ),
              h20,
              Row(
                children: List.generate(filters.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: button(
                      context: context,
                      onPressed: () {
                        filterIndexNotifier.changeIndex(index);
                      },
                      text: filters[index],
                      backgroundColor: index == filterIndex
                          ? activeButtonColor
                          : buttonColor,
                    ),
                  );
                }),
              ),

              if (tasks.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      filterIndex == 1
                          ? 'No Active Tasks'
                          : filterIndex == 2
                          ? 'No Completed Tasks'
                          : 'No Tasks',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              h10,
              if (tasks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final dateTime = task.createdAt;
                      String date =
                          '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                      return ListTile(
                        horizontalTitleGap: 5,
                        minTileHeight: 30,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 5,
                        ),
                        leading: IconButton(
                          onPressed: () {
                            taskNotifier.toggleTask(task.id);
                          },
                          icon: Icon(
                            size: 35,
                            task.isDone
                                ? Icons.check_circle_outline
                                : Icons.circle_outlined,
                            color: task.isDone
                                ? greenAccent
                                : greenAccent.withValues(alpha: 0.2),
                          ),
                        ),
                        title: Text(
                          task.title,

                          style: task.isDone
                              ? Theme.of(context).textTheme.labelMedium
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          date,
                          style: TextStyle(color: white.withValues(alpha: 0.5)),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            taskNotifier.removeTask(task.id);
                            showAppSnackbar(
                              context: context,
                              message: 'Task "${task.title}" has been deleted',
                              undo: () {
                                taskNotifier.addTask(task);
                              },
                            );
                          },

                          icon: Icon(Icons.cancel_outlined, color: white),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
