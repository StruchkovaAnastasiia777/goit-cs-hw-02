# Домашня робота: Введення в Docker та контейнеризацію

## 📋 Опис проекту

Цей репозиторій містить виконання домашнього завдання з вивчення Docker та контейнеризації. Проект складається з двох основних завдань:

1. **Task 1**: Bash-скрипт для моніторингу доступності веб-сайтів
2. **Task 2**: FastAPI застосунок з PostgreSQL в Docker контейнерах

## 📁 Структура проекту

```
goit-cs-hw-02/
├── task1/
│   ├── check_websites.sh      # Скрипт моніторингу сайтів
│   └── website_status.log     # Лог-файл результатів
└── task2/
    ├── Dockerfile             # Конфігурація Docker образу
    ├── docker-compose.yaml    # Оркестрація контейнерів
    ├── main.py               # FastAPI застосунок
    ├── requirements.txt       # Python залежності
    ├── sql_app.sqlite3       # SQLite файл
    ├── conf/
    │   └── db.py             # Налаштування бази даних
    ├── static/               # Статичні файли
    │   ├── main.js
    │   └── style.css
    └── templates/            # HTML шаблони
        └── index.html
```

## 🚀 Task 1: Моніторинг веб-сайтів

### Опис
Bash-скрипт для автоматичної перевірки доступності списку веб-сайтів з логуванням результатів.

### Функціональність
- ✅ Перевірка доступності сайтів через HTTP запити (curl)
- ✅ Логування результатів з часовими мітками
- ✅ Дублювання виводу в термінал і файл (tee)
- ✅ Збереження результатів у файл `website_status.log`
- ✅ Таймаут 10 секунд для кожного запиту
- ✅ Debug-інформація з HTTP кодами відповіді

### Налаштування

**Список сайтів для перевірки:**
```bash
sites=(
  "https://google.com"
  "https://facebook.com" 
  "https://twitter.com"
)
```

### Використання

```bash
# Надати права на виконання
chmod +x check_websites.sh

# Запустити скрипт
./check_websites.sh

# Переглянути результати
cat website_status.log
```

### Приклад виводу
```
Starting check at Mon Jul 14 16:33:22 EEST 2025
DEBUG: https://google.com returned 200
https://google.com is UP
DEBUG: https://facebook.com returned 200
https://facebook.com is UP
DEBUG: https://twitter.com returned 200
https://twitter.com is UP
Done. Results written to website_status.log
```

### Особливості реалізації
- **Безпечні опції curl**: `-skL` (skip SSL errors, follow redirects)
- **Таймаут**: `--max-time 10` для запобігання зависанню
- **Логування**: `tee -a` для одночасного виводу в термінал і файл
- **Очищення логу**: `> "$log_file"` на початку кожного запуску

## 🐳 Task 2: FastAPI + PostgreSQL в Docker

### Опис
Повнофункціональний веб-застосунок на FastAPI з базою даних PostgreSQL, контейнеризований за допомогою Docker.

### Технології
- **Backend**: FastAPI (Python 3.11)
- **База даних**: PostgreSQL 13
- **ORM**: SQLAlchemy
- **Контейнеризація**: Docker + Docker Compose
- **Frontend**: HTML/CSS/JavaScript

### Функціональність
- ✅ REST API на FastAPI
- ✅ Підключення до PostgreSQL
- ✅ Веб-інтерфейс для тестування
- ✅ Перевірка статусу бази даних
- ✅ Автоматична міграція БД

## 🛠️ Встановлення та запуск

### Передумови
```bash
# Перевірте наявність Docker
docker --version
docker-compose --version
```

### Початкове налаштування

1. **Клонувати репозиторій:**
```bash
git clone https://github.com/StruchkovaAnastasiia777/goit-cs-hw-02.git
cd goit-cs-hw-02
```

### Task 1: Запуск скрипта моніторингу

```bash
cd task1
chmod +x check_websites.sh
./check_websites.sh
cat website_status.log
```

### Task 2: Запуск Docker застосунку

1. **Перейти в директорію Task 2:**
```bash
cd task2
```

2. **Збудувати та запустити контейнери:**
```bash
docker-compose up --build
```

3. **Відкрити в браузері:**
```
http://localhost:8000
```

4. **Зупинити застосунок:**
```bash
docker-compose down
```

## 🔧 Конфігурація

### Task 2: Налаштування бази даних

В файлі `conf/db.py`:
```python
SQLALCHEMY_DATABASE_URL = "postgresql+psycopg2://postgres:567234@db:5432/hw02"
```

В файлі `docker-compose.yaml`:
```yaml
environment:
  POSTGRES_DB: hw02
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: 567234
```

## 📊 Основні команди Docker

```bash
# Переглянути запущені контейнери
docker ps

# Переглянути логи
docker-compose logs app
docker-compose logs db

# Підключитися до контейнера
docker-compose exec app bash
docker-compose exec db psql -U postgres -d hw02

# Очистити ресурси
docker-compose down --volumes --rmi all
docker system prune -a
```

## 🐛 Вирішення проблем

### Проблема: "ModuleNotFoundError: No module named 'fastapi'"
**Рішення:**
```bash
# Пересоберіть без кешу
docker-compose build --no-cache
```

### Проблема: "Error connecting to the database"
**Рішення:**
```bash
# Перевірте, що в conf/db.py використовується @db:5432, не @localhost:5432
sed -i 's/localhost/db/' conf/db.py
```

### Проблема: "psycopg2 build failed"
**Рішення:**
```bash
# Замініть psycopg2 на psycopg2-binary в requirements.txt
sed -i 's/psycopg2==/psycopg2-binary==/' requirements.txt
```
