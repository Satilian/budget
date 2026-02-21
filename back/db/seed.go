package db

import (
	"database/sql"
	"fmt"
	"log"
	"math/rand"
	"time"

	"github.com/lib/pq"
	"golang.org/x/crypto/bcrypt"
)

// Category represents expense category
type Category struct {
	ID   string
	Name string
}

// ExpenseName represents expense item name
type ExpenseName struct {
	ID   string
	Name string
}

// SeedMockData заполняет базу данных тестовыми данными
func SeedMockData(db *sql.DB) error {
	log.Println("Starting to seed mock data...")

	// Хеширование пароля
	password := "password123"
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return fmt.Errorf("failed to hash password: %w", err)
	}

	// 1. Создание аккаунтов
	accounts := []struct {
		ID    string
		Email string
	}{
		{"11111111-1111-1111-1111-111111111111", "test1@example.com"},
		{"22222222-2222-2222-2222-222222222222", "test2@example.com"},
		{"33333333-3333-3333-3333-333333333333", "demo@example.com"},
	}

	for _, acc := range accounts {
		_, err := db.Exec(`
			INSERT INTO accounts (id, email, active, created_at)
			VALUES ($1, $2, true, $3)
			ON CONFLICT (email) DO NOTHING
		`, acc.ID, acc.Email, time.Now().AddDate(0, 0, -30))
		if err != nil {
			return fmt.Errorf("failed to insert account %s: %w", acc.Email, err)
		}
		log.Printf("Created account: %s", acc.Email)
	}

	// 2. Создание пользователей
	users := []struct {
		ID        string
		AccountID string
		Login     string
	}{
		{"a1111111-1111-1111-1111-111111111111", "11111111-1111-1111-1111-111111111111", "testuser1"},
		{"a2222222-2222-2222-2222-222222222222", "22222222-2222-2222-2222-222222222222", "testuser2"},
		{"a3333333-3333-3333-3333-333333333333", "33333333-3333-3333-3333-333333333333", "demo"},
	}

	for _, user := range users {
		_, err := db.Exec(`
			INSERT INTO users (id, accountId, login, password, active, created_at)
			VALUES ($1, $2, $3, $4, true, $5)
			ON CONFLICT (login) DO NOTHING
		`, user.ID, user.AccountID, user.Login, string(hashedPassword), time.Now().AddDate(0, 0, -30))
		if err != nil {
			return fmt.Errorf("failed to insert user %s: %w", user.Login, err)
		}
		log.Printf("Created user: %s (password: password123)", user.Login)
	}

	// 3. Создание категорий
	accountID := "11111111-1111-1111-1111-111111111111"
	categories := []Category{
		{ID: "c1111111-1111-1111-1111-111111111111", Name: "Продукты"},
		{ID: "c1111111-2222-2222-2222-222222222222", Name: "Транспорт"},
		{ID: "c1111111-3333-3333-3333-333333333333", Name: "Развлечения"},
		{ID: "c1111111-4444-4444-4444-444444444444", Name: "Здоровье"},
		{ID: "c1111111-5555-5555-5555-555555555555", Name: "Образование"},
		{ID: "c1111111-6666-6666-6666-666666666666", Name: "Коммунальные услуги"},
		{ID: "c1111111-7777-7777-7777-777777777777", Name: "Одежда"},
		{ID: "c1111111-8888-8888-8888-888888888888", Name: "Рестораны"},
	}

	for _, cat := range categories {
		_, err := db.Exec(`
			INSERT INTO categories (id, name, accountId, created_at)
			VALUES ($1, $2, $3, $4)
			ON CONFLICT (name) DO NOTHING
		`, cat.ID, cat.Name, accountID, time.Now().AddDate(0, 0, -30))
		if err != nil {
			return fmt.Errorf("failed to insert category %s: %w", cat.Name, err)
		}
		log.Printf("Created category: %s", cat.Name)
	}

	// 4. Создание названий расходов
	expenseNames := []ExpenseName{
		{ID: "e1111111-1111-1111-1111-111111111111", Name: "Супермаркет"},
		{ID: "e1111111-2222-2222-2222-222222222222", Name: "Метро"},
		{ID: "e1111111-3333-3333-3333-333333333333", Name: "Кино"},
		{ID: "e1111111-4444-4444-4444-444444444444", Name: "Аптека"},
		{ID: "e1111111-5555-5555-5555-555555555555", Name: "Онлайн курсы"},
		{ID: "e1111111-6666-6666-6666-666666666666", Name: "Электричество"},
		{ID: "e1111111-7777-7777-7777-777777777777", Name: "H&M"},
		{ID: "e1111111-8888-8888-8888-888888888888", Name: "McDonalds"},
		{ID: "e1111111-9999-9999-9999-999999999999", Name: "Яндекс Такси"},
		{ID: "e1111111-aaaa-aaaa-aaaa-aaaaaaaaaaaa", Name: "Netflix"},
		{ID: "e1111111-bbbb-bbbb-bbbb-bbbbbbbbbbbb", Name: "Спортзал"},
		{ID: "e1111111-cccc-cccc-cccc-cccccccccccc", Name: "Продуктовый рынок"},
		{ID: "e1111111-dddd-dddd-dddd-dddddddddddd", Name: "Бензин"},
		{ID: "e1111111-eeee-eeee-eeee-eeeeeeeeeeee", Name: "Вода"},
	}

	for _, en := range expenseNames {
		_, err := db.Exec(`
			INSERT INTO expense_names (id, name, accountId, created_at)
			VALUES ($1, $2, $3, $4)
			ON CONFLICT (name) DO NOTHING
		`, en.ID, en.Name, accountID, time.Now().AddDate(0, 0, -30))
		if err != nil {
			return fmt.Errorf("failed to insert expense name %s: %w", en.Name, err)
		}
		log.Printf("Created expense name: %s", en.Name)
	}

	// 5. Создание расходов
	userID := "a1111111-1111-1111-1111-111111111111"
	
	// Генерация расходов за последние 30 дней
	expenses := generateRandomExpenses(userID, accountID, categories, expenseNames, 100)
	
	for _, exp := range expenses {
		_, err := db.Exec(`
			INSERT INTO expense (value, userId, accountId, categoryId, expense_nameId, created_at)
			VALUES ($1, $2, $3, $4, $5, $6)
		`, exp.Value, exp.UserID, exp.AccountID, exp.CategoryID, exp.ExpenseNameID, exp.CreatedAt)
		if err != nil {
			return fmt.Errorf("failed to insert expense: %w", err)
		}
	}
	
	log.Printf("Created %d expenses", len(expenses))
	log.Println("Mock data seeding completed successfully!")
	
	return nil
}

// Expense represents an expense record
type Expense struct {
	Value         float64
	UserID        string
	AccountID     string
	CategoryID    string
	ExpenseNameID string
	CreatedAt     time.Time
}

// generateRandomExpenses генерирует случайные расходы
func generateRandomExpenses(userID, accountID string, categories []Category, expenseNames []ExpenseName, count int) []Expense {
	rand.Seed(time.Now().UnixNano())
	
	expenses := make([]Expense, count)
	now := time.Now()
	
	// Привязка expense_names к категориям (упрощенная логика)
	categoryExpenseMap := map[string][]string{
		"c1111111-1111-1111-1111-111111111111": {"e1111111-1111-1111-1111-111111111111", "e1111111-cccc-cccc-cccc-cccccccccccc"}, // Продукты
		"c1111111-2222-2222-2222-222222222222": {"e1111111-2222-2222-2222-222222222222", "e1111111-9999-9999-9999-999999999999", "e1111111-dddd-dddd-dddd-dddddddddddd"}, // Транспорт
		"c1111111-3333-3333-3333-333333333333": {"e1111111-3333-3333-3333-333333333333", "e1111111-aaaa-aaaa-aaaa-aaaaaaaaaaaa", "e1111111-bbbb-bbbb-bbbb-bbbbbbbbbbbb"}, // Развлечения
		"c1111111-4444-4444-4444-444444444444": {"e1111111-4444-4444-4444-444444444444"}, // Здоровье
		"c1111111-5555-5555-5555-555555555555": {"e1111111-5555-5555-5555-555555555555"}, // Образование
		"c1111111-6666-6666-6666-666666666666": {"e1111111-6666-6666-6666-666666666666", "e1111111-eeee-eeee-eeee-eeeeeeeeeeee"}, // Коммунальные
		"c1111111-7777-7777-7777-777777777777": {"e1111111-7777-7777-7777-777777777777"}, // Одежда
		"c1111111-8888-8888-8888-888888888888": {"e1111111-8888-8888-8888-888888888888"}, // Рестораны
	}
	
	// Примерные диапазоны цен для категорий
	priceRanges := map[string][2]float64{
		"c1111111-1111-1111-1111-111111111111": {500, 2000},   // Продукты
		"c1111111-2222-2222-2222-222222222222": {100, 3000},   // Транспорт
		"c1111111-3333-3333-3333-333333333333": {500, 2000},   // Развлечения
		"c1111111-4444-4444-4444-444444444444": {300, 2000},   // Здоровье
		"c1111111-5555-5555-5555-555555555555": {2000, 5000},  // Образование
		"c1111111-6666-6666-6666-666666666666": {300, 2500},   // Коммунальные
		"c1111111-7777-7777-7777-777777777777": {1000, 8000},  // Одежда
		"c1111111-8888-8888-8888-888888888888": {400, 1500},   // Рестораны
	}
	
	for i := 0; i < count; i++ {
		// Случайная категория
		category := categories[rand.Intn(len(categories))]
		
		// Случайное название расхода из связанных с категорией
		expenseNameIDs := categoryExpenseMap[category.ID]
		expenseNameID := expenseNameIDs[rand.Intn(len(expenseNameIDs))]
		
		// Случайная цена в диапазоне категории
		priceRange := priceRanges[category.ID]
		value := priceRange[0] + rand.Float64()*(priceRange[1]-priceRange[0])
		
		// Случайная дата за последние 30 дней
		daysAgo := rand.Intn(30)
		createdAt := now.AddDate(0, 0, -daysAgo)
		
		expenses[i] = Expense{
			Value:         value,
			UserID:        userID,
			AccountID:     accountID,
			CategoryID:    category.ID,
			ExpenseNameID: expenseNameID,
			CreatedAt:     createdAt,
		}
	}
	
	return expenses
}

// CleanMockData удаляет все тестовые данные
func CleanMockData(db *sql.DB) error {
	log.Println("Cleaning mock data...")

	testAccountIDs := []string{
		"11111111-1111-1111-1111-111111111111",
		"22222222-2222-2222-2222-222222222222",
		"33333333-3333-3333-3333-333333333333",
	}

	// Удаление в правильном порядке (из-за foreign keys)
	_, err := db.Exec(`DELETE FROM expense WHERE accountId = ANY($1)`, pq.Array(testAccountIDs))
	if err != nil {
		return fmt.Errorf("failed to delete expenses: %w", err)
	}

	_, err = db.Exec(`DELETE FROM expense_names WHERE accountId = ANY($1)`, pq.Array(testAccountIDs))
	if err != nil {
		return fmt.Errorf("failed to delete expense_names: %w", err)
	}

	_, err = db.Exec(`DELETE FROM categories WHERE accountId = ANY($1)`, pq.Array(testAccountIDs))
	if err != nil {
		return fmt.Errorf("failed to delete categories: %w", err)
	}

	_, err = db.Exec(`DELETE FROM users WHERE accountId = ANY($1)`, pq.Array(testAccountIDs))
	if err != nil {
		return fmt.Errorf("failed to delete users: %w", err)
	}

	_, err = db.Exec(`DELETE FROM accounts WHERE id = ANY($1)`, pq.Array(testAccountIDs))
	if err != nil {
		return fmt.Errorf("failed to delete accounts: %w", err)
	}

	log.Println("Mock data cleaned successfully!")
	return nil
}
