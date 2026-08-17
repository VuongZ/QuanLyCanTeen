# ---- Build stage ----
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj trước để cache lớp restore
COPY LuanVanTotNghiep.csproj ./
RUN dotnet restore LuanVanTotNghiep.csproj

# Copy toàn bộ source còn lại và publish
COPY . .
RUN dotnet publish LuanVanTotNghiep.csproj -c Release -o /app/publish

# ---- Runtime stage ----
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Render inject biến PORT lúc chạy, ASP.NET cần bind đúng cổng đó
ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 8080

CMD ASPNETCORE_URLS=http://+:$PORT dotnet LuanVanTotNghiep.dll