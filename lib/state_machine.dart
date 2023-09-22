import 'state.dart';

class StateMachine {
  int _stepNumber = 0;
  final List<Step> _steps = [
    Step(
        'Paciente com glicemia capilar > 250mg/dL. \n\nHá sinais/sintomas de cetoacidose diabética ou estado hiperosmolar?',
        'Sim',
        'Não'),
    Step('Há suspeita de doença intercorrente (excluindo emergências)?', 'Sim',
        'Não'),
    Step('Cetonúria disponível (Se indisponível, considerar negativa)?',
        'Positiva', 'Negativa'),
    Step(
        'Aplicar insulina regular e reavaliar glicemia capilar em 2 horas.\n\nGlicemia abaixo de 250mg/dL?',
        'Sim',
        'Não'),
    Step(
        'Provável descompensação crônica. Ajustar tratamento (considerar insulina). Solicitar controle de glicemia capilar. Orientar sinais de alarme e reavaliação breve',
        'Reiniciar',
        ''),
    Step(
        'Encaminhar para emergência imediatamente. Monitorar sinais vitais. Realizar hidratação EV com SF 0,9% enquanto aguarda o transporte',
        'Reiniciar',
        ''),
    Step(
        'Tratar complicações agudas. Aumentar transitoriamente dose total de insulina até resolução do quadro.',
        'Reiniciar',
        ''),
  ];

  void restart() {
    _stepNumber = 0;
  }

  String getStep() {
    return _steps[_stepNumber].text;
  }

  String getStepChoice1() {
    return _steps[_stepNumber].choice1;
  }

  String getStepChoice2() {
    return _steps[_stepNumber].choice2;
  }

  bool isChoice2Available() {
    return _stepNumber <= 3;
  }

  void nextStep(int choice) {
    if (!isChoice2Available()) return restart();

    if (_stepNumber == 0) {
      if (choice == 1) {
        _stepNumber = 5;
      } else {
        _stepNumber = 1;
      }
      return;
    }

    if (_stepNumber == 1) {
      if (choice == 1) {
        _stepNumber = 2;
      } else {
        _stepNumber = 4;
      }
      return;
    }

    if (_stepNumber == 2) {
      if (choice == 1) {
        _stepNumber = 5;
      } else {
        _stepNumber = 3;
      }
      return;
    }

    if (_stepNumber == 3) {
      if (choice == 1) {
        _stepNumber = 6;
      } else {
        _stepNumber = 5;
      }
      return;
    }
  }
}
