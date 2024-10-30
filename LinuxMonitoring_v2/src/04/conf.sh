response_codes=(
    200
    201
    400 
    401 
    403
    404 
    500 
    501 
    502 
    503)

# 200 #успешно
# 201 #создано
# 400 #некорректный запрос
# 401 #не авторизован
# 403 #запрещено
# 404 #не найдено
# 500 #внутренняя ошибка сервера
# 501 #не реализовано
# 502 #плохой, ошибочный шлюз
# 503 #сервис недоступен

methods=(
    "GET"
    "POST" 
    "PUT"
    "PATCH"
    "DELETE")

URL=(
    "ya.ru"
    "nstu.ru"
    "gismeteo.ru"
    "hitmo.ru"
    "radio.ru")
    
agents=(
    "Mozilla" 
    "Google Chrome"
    "Opera"
    "Safari"
    "Internet Explorer"
    "Microsoft Edge"
    "Crawler and bot"
    "Library"
    "net tool")

# 1xx: Informational (информационные)
# 2xx: Success (успешно)
# 3xx: Redirection (перенаправление)
# 4xx: Client Error (ошибка клиента)
# 5xx: Server Error (ошибка сервера)