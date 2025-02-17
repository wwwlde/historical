;------------------------------------------------;
; Программа для замены всех нулевых элементов массива на 10
;------------------------------------------------;
; Автор: Денис Лемешко (Z26114)
; Группа: 261
;------------------------------------------------;

; Стек
stk segment stack 'stack'
  dw 64 dup(?)  ; Выделение места для стека размером 64 байта
stk ends

; Данные
dat segment 'data'
  len equ 10  ; Длина массива
  x db 1, 0, 4, -5, 7, 9, -7, 0, 3, 7  ; Массив с числами
  msg_start db ""  ; Пустое сообщение
dat ends

; Код программы
cd segment 'code'
  assume cs:cd, ds:dat, ss:stk

; Установим сегмент данных в DS
begin:
  mov ax, dat     ; Загружаем адрес сегмента данных в регистр AX
  mov ds, ax      ; Переносим адрес в сегмент данных (DS)

  xor ax, ax      ; Обнуляем регистр AX
  xor cx, cx      ; Обнуляем регистр CX (счётчик для цикла)
  xor si, si      ; Обнуляем регистр SI (индекс для массива)

; Цикл обработки элементов массива
cycl:
  jcxz exit       ; Если CX = 0, выходим из программы
  cmp x[si], 0    ; Сравниваем текущий элемент массива с 0
  jne next        ; Если элемент не равен 0, пропускаем замену
  inc al          ; Увеличиваем AL (будет использоваться как флаг)
  mov x[si], 10   ; Заменяем текущий элемент массива на 10

next:
  inc si          ; Увеличиваем индекс массива на 1
  dec cx          ; Уменьшаем счётчик на 1
  jmp cycl        ; Переходим к следующей итерации

exit:
  mov ah, 4ch     ; Завершаем программу с кодом 4Ch
  int 21h         ; Прерывание для завершения программы
cd ends
end begin
;------------------------------------------------;
