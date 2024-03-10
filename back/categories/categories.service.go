package categories

import (
	"back/dic"
	"back/models"
	"database/sql"
	"fmt"
)

func findCategories(
	accountId string,
	filter models.CategoryFilter,
) ([]models.CategoryDto, error) {
	categories := []models.CategoryDto{}

	dataSource := dic.Instance.Get("DB").(*sql.DB)

	rows, err := dataSource.Query(`
		SELECT id, name 
		FROM categories
		WHERE accountId=$1
		AND LOWER(name) LIKE LOWER($2 || '%')
		ORDER BY name ASC`,
		accountId,
		filter.Name,
	)

	if err != nil {
		return categories, err
	}

	defer rows.Close()

	for rows.Next() {
		c := models.CategoryDto{}
		err := rows.Scan(&c.ID, &c.Name)
		if err != nil {
			fmt.Println(err)
			continue
		}
		categories = append(categories, c)
	}

	return categories, err
}
