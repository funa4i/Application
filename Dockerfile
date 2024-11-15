# Используем официальный образ для .NET SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Устанавливаем рабочую директорию
WORKDIR /src

# Копируем все файлы проекта в контейнер
COPY . .

# Восстановление зависимостей для всех проектов
RUN dotnet restore MyConsoleApp/MyConsoleApp.csproj
RUN dotnet restore MyConsoleApp.Tests/MyConsoleApp.Tests.csproj

# Сборка консольного приложения
RUN dotnet publish MyConsoleApp/MyConsoleApp.csproj -c Release -o /app/publish

# Выполнение юнит-тестов и сохранение результатов в файл
RUN dotnet test MyConsoleApp.Tests/MyConsoleApp.Tests.csproj --logger "trx;LogFileName=test_results.trx"

# Вторая стадия - образ с только runtime для запуска приложения
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# Устанавливаем рабочую директорию для запуска приложения
WORKDIR /app

# Копируем собранное приложение из первого этапа
COPY --from=build /app/publish .

# Указываем команду для запуска консольного приложения
ENTRYPOINT ["dotnet", "MyConsoleApp.dll"]

# Опционально: Выводим результаты тестов на консоль в логи контейнера
# Для этого можно использовать команду `docker logs` после выполнения тестов
CMD tail -f /dev/null
