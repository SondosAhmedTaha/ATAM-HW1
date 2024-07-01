.section .text
.global _start

_start:
    mov $root, %rsi          # מצביע לשורש של העץ
    xor %rdi, %rdi           # איפוס מונה הצמתים
    xor %rcx, %rcx           # איפוס מונה העלים
    xor %rdx, %rdx           # איפוס מונה העומק

scan_tree:
    # טעינת הצומת הנוכחי
    mov (%rsi), %rbx
    test %rbx, %rbx
    je check_leaf

    # הגדלת מונה הצמתים
    inc %rdi

    # שמירת המצביע הנוכחי בסטאק
    push %rsi
    mov %rbx, %rsi
    inc %rdx                # הגדלת מונה העומק
    cmp $6, %rdx            # בדיקת עומק העץ
    je check_leaf

    jmp scan_tree

check_leaf:
    # אם הגעת כאן, זה אומר שהגענו לסוף רשימת השכנים
    cmp $0, %rbx
    jne backtrack

    # אם זה עלה, הגדל את מונה העלים
    inc %rcx

backtrack:
    # חזרה לצומת הקודם
    pop %rsi
    dec %rdx                # הקטנת מונה העומק
    add $8, %rsi            # מעבר למצביע הבא ברשימת השכנים

    # בדיקה אם סיימנו לסרוק את כל הצמתים
    test %rsi, %rsi
    jne scan_tree

check_richness:
    # אם אין עלים, העץ לא עשיר בעלים
    cmp $0, %rcx
    je not_rich

    # חישוב היחס בין מספר הצמתים למספר העלים
    mov %rdi, %rax
    cqo
    idiv %rcx

    # בדיקת אם היחס קטן או שווה ל-3
    cmp $3, %rax
    jle is_rich

not_rich:
    movb $0, rich
    jmp end_program

is_rich:
    movb $1, rich

end_program:
