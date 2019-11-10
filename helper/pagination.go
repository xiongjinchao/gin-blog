package helper

import (
	"math"
	"strconv"
	"strings"
)

type Pagination struct {
	Label    string
	Url      string
	Active   bool
	Disabled bool
}

// generate pagination data
func (p *Pagination) Generate(total, size, page int, link string) (pagination []Pagination) {
	if total <= 0 {
		return
	}

	t, _ := strconv.ParseFloat(strconv.Itoa(total), 64)
	s, _ := strconv.ParseFloat(strconv.Itoa(size), 64)
	count := int(math.Ceil(t / s))

	if page > count {
		return
	}
	base := link
	if strings.Contains(link, "?") {
		link = base + "&page="
	} else {
		link = base + "?page="
	}

	prevPage := page - 1
	prev := Pagination{
		"上一页",
		link + strconv.Itoa(prevPage),
		false,
		false,
	}
	if prevPage <= 0 {
		prev.Url = link + "1"
		prev.Disabled = true
	}
	if prevPage == 1 {
		prev.Url = base
	}
	pagination = append(pagination, prev)

	side := 3
	for i := page - side; i < page+side; i++ {
		if i < 1 {
			continue
		}
		if i > count {
			continue
		}
		itemPage := Pagination{
			strconv.Itoa(i),
			link + strconv.Itoa(i),
			false,
			false,
		}
		if page == 1 {
			itemPage.Url = base
		}
		if page == i {
			itemPage.Active = true
		}
		pagination = append(pagination, itemPage)
	}

	nextPage := page + 1
	next := Pagination{
		"下一页",
		link + strconv.Itoa(nextPage),
		false,
		false,
	}

	if nextPage == 1 {
		next.Url = base
	}

	if nextPage > count {
		next.Url = link + strconv.Itoa(count)
		next.Disabled = true
	}
	pagination = append(pagination, next)

	return
}
