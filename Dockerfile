# Используем официальный образ для .NET SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Устанавливаем рабочую директорию
WORKDIR /src

# Копируем все файлы проекта в контейнер
COPY . .

# Восстановление зависимостей для всех проектов
RUN dotnet restore Client/Client.csproj
RUN dotnet restore Client.Tests/Client.Tests.csproj

# Сборка консольного приложения
RUN dotnet publish Client/Client.csproj -c Release -o /app/publish

# Выполнение юнит-тестов и сохранение результатов в файл
RUN dotnet test Client.Tests/Client.Tests.csproj --logger "trx;LogFileName=test_results.trx"

# Вторая стадия - образ с только runtime для запуска приложения
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# Устанавливаем рабочую директорию для запуска приложения
WORKDIR /app

# Копируем собранное приложение из первого этапа
COPY --from=build /app/publish .

# Указываем команду для запуска консольного приложения
ENTRYPOINT ["dotnet", "Client.dll"]

# Опционально: Выводим результаты тестов на консоль в логи контейнера
# Для этого можно использовать команду `docker logs` после выполнения тестов
CMD tail -f /dev/null
