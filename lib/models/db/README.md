## DB: SQLite3, ORM: Drift

### 1. auto generate code

```sh
dart run build_runner build
```

- typedef로 Map을 사용하면 변환이 제대로 안되는 것 같음.
  수동으로 바꿔줘야 함.

```
ComponentCount<String, int> => ComponentCount
AccuracyCount<String, int> => AccuracyCount
```
