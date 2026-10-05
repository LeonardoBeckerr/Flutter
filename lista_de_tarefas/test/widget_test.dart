import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/main.dart';

void main() {
  testWidgets('adiciona e conclui uma tarefa', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tudo em dia!'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'O que precisa ser feito?'),
      'Comprar leite',
    );
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Comprar leite'), findsOneWidget);
    expect(find.text('1 pendente'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.radio_button_unchecked_rounded));
    await tester.pumpAndSettle();

    expect(find.text('0 pendentes'), findsOneWidget);
    expect(find.text('1 concluída'), findsOneWidget);
  });
}
