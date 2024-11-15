# ���������� ����������� ����� ��� .NET SDK ��� ������ ����������
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# ������������� ������� ����������
WORKDIR /src

# �������� ��� ����� ������� � ���������
COPY . .

# �������������� ������������ ��� ���� ��������
RUN dotnet restore MyConsoleApp/MyConsoleApp.csproj
RUN dotnet restore MyConsoleApp.Tests/MyConsoleApp.Tests.csproj

# ������ ����������� ����������
RUN dotnet publish MyConsoleApp/MyConsoleApp.csproj -c Release -o /app/publish

# ���������� ����-������ � ���������� ����������� � ����
RUN dotnet test MyConsoleApp.Tests/MyConsoleApp.Tests.csproj --logger "trx;LogFileName=test_results.trx"

# ������ ������ - ����� � ������ runtime ��� ������� ����������
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# ������������� ������� ���������� ��� ������� ����������
WORKDIR /app

# �������� ��������� ���������� �� ������� �����
COPY --from=build /app/publish .

# ��������� ������� ��� ������� ����������� ����������
ENTRYPOINT ["dotnet", "MyConsoleApp.dll"]

# �����������: ������� ���������� ������ �� ������� � ���� ����������
# ��� ����� ����� ������������ ������� `docker logs` ����� ���������� ������
CMD tail -f /dev/null
