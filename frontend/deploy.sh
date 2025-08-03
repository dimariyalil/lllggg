#!/bin/bash
echo "�� Деплоим на GitHub Pages..."

# Обновляем vite.config.ts
sed -i "s|plugins: \[react()\],|plugins: [react()],\n  base: '/lllggg/',|" vite.config.ts

# Обновляем package.json
sed -i '/"preview":/a\    "deploy": "npm run build \&\& gh-pages -d dist",' package.json

# Собираем проект
npm run build

# Деплоим
npx gh-pages -d dist

echo "✅ Готово! Сайт будет доступен через 2-5 минут на:"
echo "https://dimariyalil.github.io/lllggg/"
