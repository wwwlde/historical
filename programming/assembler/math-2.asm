;------------------------------------------------;
; Программа для выполнения вычислений: 
; z = |x| + |y|
; z = x² + y²
; x=2, y=2 и x=-1, y=10
;------------------------------------------------;
; Автор: Денис Лемешко (Z26114)
; Группа: 261
;------------------------------------------------;

stk segment stack 'stack'  ; Сегмент стека
  dw 64 dup(?)             ; 64 байта для стека
stk ends

dat segment 'data'   ; Сегмент данных
  x db 2              ; Значение x = 2
  y db 2              ; Значение y = 2
  z db ?              ; Переменная для z
dat ends

cd segment 'code'    ; Сегмент кода
  assume cs:cd, ds:dat, ss:stk

begin:
  mov ax, dat         ; Загрузка адреса сегмента данных в регистр ax
  mov ds, ax          ; Устанавливаем сегмент данных

; Вычисление |x| + |y|
  mov cl, x           ; cl <- x
  mov ch, y           ; ch <- y

  ; Проверка на отрицательность x
  cmp cl, 0
  jl x_negative       ; Если x < 0, переходим в x_negative
  ; Если x >= 0, оставляем значение
  jmp check_y         ; Переход к проверке для y

x_negative:
  neg cl               ; Если x < 0, берем |x| = -x

check_y:
  cmp ch, 0
  jl y_negative       ; Если y < 0, переходим в y_negative
  ; Если y >= 0, оставляем значение
  jmp compute_z       ; Переход к вычислению z

y_negative:
  neg ch               ; Если y < 0, берем |y| = -y

compute_z:
  add ch, cl           ; Суммируем |x| + |y|
  mov z, ch            ; Записываем результат в z

; Вычисление x² + y²
  mov al, x            ; al <- x
  imul al              ; al = x²
  mov bl, al           ; сохраняем x² в bl
  mov al, y            ; al <- y
  imul al              ; al = y²
  add bl, al           ; bl = x² + y²
  mov z, bl            ; Записываем результат в z

; Завершение программы
  mov ah, 4Ch          ; Завершаем программу
  int 21h              ; Прерывание для завершения

cd ends
end begin
