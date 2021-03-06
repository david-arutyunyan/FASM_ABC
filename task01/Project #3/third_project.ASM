format PE console ; ������ ��������� �����

entry start ; ����� ����� � ���������

include 'win32a.inc' ; ������������ ����(��������� � �������)

section '.data' data readable writable ; ��������������������� ������, � ������� �� ����� ����������

        strA db 'Enter A: ', 0 ; strA - ����� �� ������(���������� �� ��������� ��� ����������). Define byte(db) - ������
        strB db 'Enter B: ', 0

        spaceStr db ' %d', 0

        older db '%d more than %d!', 0
        younger db '%d less than %d!', 0
        same db '%d and %d are equal!', 0

        A dd ? ; dd - Define double (2 �������� ����� ~ 4 bytes)
        B dd ?

        NULL = 0

section '.code' code readable executable ; ����������� ��� ���������

        start:
                push strA ; ���������� � ����
                call [printf] ; ����� �������

                push A
                push spaceStr
                call [scanf]

                push strB ; ���������� � ����
                call [printf] ; ����� �������

                push B
                push spaceStr
                call [scanf]

                mov edx, [B]

                cmp [A], edx
                jge vers1
                   mov ecx, [A]
                   sub ecx, [B]

                   push [A]
                   push edx
                   push older
                   call [printf]

                   jmp finish
                vers1:

                cmp [A], edx
                jle vers2
                   mov ecx, [B]
                   sub ecx, [A]

                   push [A]
                   push edx
                   push younger
                   call [printf]

                   jmp finish
                vers2:

                cmp [A], edx
                jne vers3

                   push [A]
                   push edx
                   push same
                   call [printf]

                   jmp finish
                vers3:


                finish:

                call [getch]

                push NULL
                call [ExitProcess]

section '.idata' import data readable ; ������ � �������������� �� ������ ��������� ���������

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'