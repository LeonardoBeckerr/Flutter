import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.createdAt,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
  });

  final String todo;
  final DateTime createdAt;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  String get formattedDate {
    final day = createdAt.day.toString().padLeft(2, '0');
    final month = createdAt.month.toString().padLeft(2, '0');
    return '$day/$month/${createdAt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: isCompleted
              ? colors.primaryContainer.withValues(alpha: 0.45)
              : colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? colors.primary.withValues(alpha: 0.35)
                : colors.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      key: ValueKey(isCompleted),
                      color: isCompleted ? colors.primary : colors.outline,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: isCompleted
                                    ? colors.onSurfaceVariant
                                    : colors.onSurface,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontWeight: FontWeight.w600,
                              ),
                          child: Text(todo),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 13,
                              color: colors.outline,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              formattedDate,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: colors.outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    tooltip: 'Excluir tarefa',
                    icon: const Icon(Icons.delete_outline_rounded),
                    color: colors.error,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
