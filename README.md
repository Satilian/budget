### Famili Budget - мэнеджер расходов

## Email: our.budget.online@gmail.com

# Migrations

goose -dir db/migrations postgres "user= password= dbname=budget host= port= sslmode=disable" up

# Development start

air

# Generate dart model methods

dart run build_runner watch --delete-conflicting-outputs
