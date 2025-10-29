# ملف config.fish

set LOGO_DIR $HOME/.config/fastfetch/logos
set USED_FILE $HOME/.config/fastfetch/used_logos.txt

function fastfetch_random
    if not test -d $LOGO_DIR
        echo "مجلد الشعارات غير موجود: $LOGO_DIR"
        return
    end

    set all_logos (ls $LOGO_DIR)

    if test (count $all_logos) -eq 0
        echo "لا يوجد شعارات في المجلد $LOGO_DIR"
        return
    end

    # قراءة الشعارات المستخدمة من الملف إذا موجود
    if test -f $USED_FILE
        set used_logos (cat $USED_FILE)
    else
        set used_logos
    end

    # إيجاد الشعارات غير المستخدمة
    set unused_logos
    for logo in $all_logos
        if not contains $logo $used_logos
            set unused_logos $unused_logos $logo
        end
    end

    # إذا تم استخدام كل الشعارات، إعادة التعيين
    if test (count $unused_logos) -eq 0
        set unused_logos $all_logos
        # مسح الملف
        echo -n > $USED_FILE
        set used_logos
    end

    # اختيار شعار عشوائي
    set rand_index (random 1 (count $unused_logos))
    set LOGO $unused_logos[$rand_index]

    # تحديث ملف الشعارات المستخدمة
    echo $LOGO >> $USED_FILE

    # تشغيل fastfetch
    fastfetch --logo $LOGO_DIR/$LOGO
end

# استدعاء الدالة مباشرة
fastfetch_random
