#!/bin/bash
set -e

# === Конфигурация ===
# Укажите URL вашего репозитория, содержащего файлы mbh, mbh.command и install.sh
REPO_URL="https://github.com/httsp0werz/macbookhelper.git"
# Временная директория для клонирования репозитория
TMP_DIR=$(mktemp -d)

# === Клонирование репозитория ===
echo "Клонирование репозитория из $REPO_URL..."
git clone "$REPO_URL" "$TMP_DIR"

# === Установка зависимостей через Homebrew ===
echo "Установка oath-toolkit..."
brew install oath-toolkit

echo "Установка tunblkct..."
brew install azhuchkov/tools/tunblkctl

# === Установка скрипта mbh ===
echo "Копирование скрипта mbh в /usr/local/bin..."
sudo cp "$TMP_DIR/mbh" /usr/local/bin/mbh
sudo chown root:wheel /usr/local/bin/mbh
sudo chmod 500 /usr/local/bin/mbh

# === Установка mbh.command в домашнюю директорию пользователя ===
echo "Копирование mbh.command в $HOME..."
cp "$TMP_DIR/mbh.command" "$HOME/mbh.command"
chmod +x "$HOME/mbh.command"

# === Очистка временной директории ===
rm -rf "$TMP_DIR"

echo "Установка завершена!"

