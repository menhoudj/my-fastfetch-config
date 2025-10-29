#!/bin/bash

# =========================
# Fastfetch Config Installer
# =========================

# مسارات المصدر (داخل مجلد التحميل)
SRC_DIR="$(pwd)"
SRC_LOGOS="$SRC_DIR/logos"
SRC_CONFIG_JSONC="$SRC_DIR/config.jsonc"
SRC_CONFIG_FISH="$SRC_DIR/config.fish"

# مسارات الوجهة
DEST_FASTFETCH="$HOME/.config/fastfetch"
DEST_LOGOS="$DEST_FASTFETCH/logos"
DEST_CONFIG_JSONC="$DEST_FASTFETCH/config.jsonc"
DEST_CONFIG_FISH="$HOME/.config/fish/config.fish"

# التحقق من وجود Fish و Fastfetch
if ! command -v fish &> /dev/null; then
    echo "Fish shell غير مثبت. يرجى تثبيته أولاً."
    exit 1
fi

if ! command -v fastfetch &> /dev/null; then
    echo "fastfetch غير مثبت. يرجى تثبيته أولاً."
    exit 1
fi

# إنشاء مجلدات الوجهة إذا لم تكن موجودة
mkdir -p "$DEST_LOGOS"

# نسخ الشعارات
cp -r "$SRC_LOGOS/"* "$DEST_LOGOS/"
echo "تم نسخ الشعارات إلى $DEST_LOGOS"

# نسخ config.jsonc واستبداله
cp "$SRC_CONFIG_JSONC" "$DEST_CONFIG_JSONC"
echo "تم استبدال ملف config.jsonc في $DEST_FASTFETCH"

# نسخ config.fish واستبداله (مع عمل نسخة احتياطية)
if [ -f "$DEST_CONFIG_FISH" ]; then
    cp "$DEST_CONFIG_FISH" "$DEST_CONFIG_FISH.bak"
    echo "تم عمل نسخة احتياطية من config.fish الحالية في config.fish.bak"
fi
cp "$SRC_CONFIG_FISH" "$DEST_CONFIG_FISH"
echo "تم استبدال ملف config.fish"

echo "تم التثبيت بنجاح! افتح تيرمنال Fish جديد لتطبيق الإعدادات."
