### Famili Budget - мэнеджер расходов

# Migrations
goose -dir db/migrations postgres "user= password= dbname=budget sslmode=disable" up

# Development start
air

# Generate dart model methods
dart run build_runner watch --delete-conflicting-outputs