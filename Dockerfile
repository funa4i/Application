# ���������� ����������� ����� ��� .NET SDK ��� ������ ����������
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# ������������� ������� ����������
WORKDIR /src

# �������� ��� ����� ������� � ���������
COPY . .

# �������������� ������������ ��� ���� ��������
RUN dotnet restore Client/Client.csproj
RUN dotnet restore Client.Tests/Client.Tests.csproj

# ������ ����������� ����������
RUN dotnet publish Client/Client.csproj -c Release -o /app/publish

# ���������� ����-������ � ���������� ����������� � ����
RUN dotnet test Client.Tests/Client.Tests.csproj --logger "trx;LogFileName=test_results.trx"

# ������ ������ - ����� � ������ runtime ��� ������� ����������
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# ������������� ������� ���������� ��� ������� ����������
WORKDIR /app

# �������� ��������� ���������� �� ������� �����
COPY --from=build /app/publish .

# ��������� ������� ��� ������� ����������� ����������
ENTRYPOINT ["dotnet", "Client.dll"]

# �����������: ������� ���������� ������ �� ������� � ���� ����������
# ��� ����� ����� ������������ ������� `docker logs` ����� ���������� ������
CMD tail -f /dev/null
