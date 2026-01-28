# Tests Unitaires - Tic Tac Toe App

## 📁 Structure des Tests

```
test/
└── features/
    └── game/
        └── domain/
            ├── enum/
            │   └── player_test.dart
            ├── usecases/
            │   ├── validate_move_usecase_test.dart
            │   ├── check_winning_line_usecase_test.dart
            │   ├── check_winner_usecase_test.dart
            │   ├── make_move_usecase_test.dart
            │   └── ai_move_usecase_test.dart
            └── all_tests.dart
```

## 🧪 Lancer les Tests

### Tous les tests
```bash
flutter test
```

### Tests d'un fichier spécifique
```bash
flutter test test/features/game/domain/usecases/validate_move_usecase_test.dart
```

### Tous les tests du domain
```bash
flutter test test/features/game/domain/all_tests.dart
```

### Avec coverage
```bash
flutter test --coverage
```

### Voir le rapport de coverage (après avoir lancé les tests avec --coverage)
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 📊 Couverture des Tests

### Use Cases (100% couverts)
- ✅ **ValidateMoveUseCase** - 6 tests
  - Validation des mouvements valides
  - Détection des cases occupées
  - Vérification des index hors limites
  - Blocage sur board avec gagnant

- ✅ **CheckWinningLineUseCase** - 13 tests
  - Détection des lignes gagnantes (rows, columns, diagonals)
  - Gestion des cas sans gagnant
  - Board vide, en cours, match nul

- ✅ **CheckWinnerUseCase** - 5 tests
  - Détection du gagnant
  - Match nul (board full)
  - Jeu en cours (null)

- ✅ **MakeMoveUseCase** - 8 tests
  - Placement des pions X et O
  - Immutabilité du board original
  - Validation des index
  - Gestion des cases occupées
  - Mouvements multiples

- ✅ **AiMoveUseCase** - 10 tests
  - Détection des coups gagnants
  - Blocage de l'adversaire
  - Coups aléatoires intelligents
  - Priorité win > block

### Extensions (100% couvertes)
- ✅ **Player.opponent** - 5 tests
  - X → O, O → X, None → None
  - Propriété symétrique (opponent.opponent = self)

- ✅ **Player.displayName** - 3 tests
  - Affichage correct des symboles

## 🎯 Bonnes Pratiques Appliquées

1. **AAA Pattern (Arrange-Act-Assert)**
   ```dart
   test('should return true for valid move', () {
     // Arrange - Préparer les données
     final board = Board.initial();

     // Act - Exécuter l'action
     final result = useCase.call(board, 0);

     // Assert - Vérifier le résultat
     expect(result, true);
   });
   ```

2. **Tests Isolés**
   - Chaque test est indépendant
   - Setup dans `setUp()` pour éviter duplication

3. **Nommage Descriptif**
   - `should [expected behavior] when [condition]`
   - Ex: "should return false when cell is already occupied"

4. **Couverture Complète**
   - Happy path (cas nominal)
   - Edge cases (limites)
   - Error cases (erreurs)

5. **Tests Déterministes**
   - Pas de dépendance au temps ou aléatoire
   - Résultats prévisibles et reproductibles

## 🚀 Ajouter de Nouveaux Tests

### Template de test use case
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/usecases/my_usecase.dart';

void main() {
  late MyUseCase useCase;

  setUp(() {
    useCase = MyUseCase();
  });

  group('MyUseCase', () {
    test('should do something when condition', () {
      // Arrange

      // Act

      // Assert
    });
  });
}
```

## 📈 Métriques Cibles

- ✅ Couverture des Use Cases: 100%
- ✅ Couverture des Extensions: 100%
- ⏳ Couverture des Entities: TODO
- ⏳ Couverture des Notifiers: TODO (plus complexe avec Riverpod)

## 🛠️ Dépendances de Test

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  test: any
```

## 💡 Tips

- Lancer les tests à chaque modification avec `flutter test --watch`
- Utiliser `--dart-define=FLUTTER_TEST=true` pour des configs spécifiques en test
- Mocker les dépendances externes avec `mockito` si nécessaire
- Tester les edge cases et non seulement les happy paths
