### Famili Budget - мэнеджер расходов

## Email: our.budget.online@gmail.com

# Migrations

goose -dir db/migrations postgres "user= password= dbname=budget host= port= sslmode=disable" up

# Mock Data Generator для Budget App

**Заполнить базу данных mock данными:**

```bash
go run cmd/seed/main.go -seed
```

**Очистить mock данные:**

```bash
go run cmd/seed/main.go -clean
```

## Тестовые данные для входа

| Логин     | Пароль      | Email             |
| --------- | ----------- | ----------------- |
| testuser1 | password123 | test1@example.com |
| testuser2 | password123 | test2@example.com |
| demo      | password123 | demo@example.com  |

# Development start

air

# Generate dart model methods

dart run build_runner watch --delete-conflicting-outputs
