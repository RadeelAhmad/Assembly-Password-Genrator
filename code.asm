INCLUDE Irvine32.inc

.data
    password BYTE 50 DUP(?)
    passwordLength DWORD ?
    passwordComplexity DWORD ?
    uppercase BYTE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    lowercase BYTE 'abcdefghijklmnopqrstuvwxyz'
    numbers BYTE '0123456789'
    specialChars BYTE '!@#$%^&*()_+-={}:<>?'
    allChars BYTE 0

.code
start PROC
    call ReadInt
    mov passwordLength, eax

    call ReadInt
    mov passwordComplexity, eax

    mov esi, offset password
    mov ecx, passwordLength
generatePassword:
    call GenerateRandomChar
    mov [esi], al
    inc esi
    loop generatePassword

    mov byte ptr [esi], 0 ; Null-terminate the string

    mov edx, offset password
    call WriteString
    call Crlf

    invoke ExitProcess, 0
start ENDP

GenerateRandomChar PROC
    mov eax, passwordComplexity
    cmp eax, 1
    je uppercaseOnly
    cmp eax, 2
    je mixedCase
    cmp eax, 3
    je mixedCaseNumbers
    cmp eax, 4
    je allCharacters
    jmp GenerateRandomChar ; add this to avoid infinite loop

uppercaseOnly:
    mov eax, 26
    call RandomRange
    add eax, offset uppercase
    mov al, [eax]
    ret

mixedCase:
    mov eax, 52
    call RandomRange
    cmp eax, 26
    jl uppercaseOnlyProc
    sub eax, 26
    add eax, offset lowercase
    mov al, [eax]
    ret

mixedCaseNumbers:
    mov eax, 62
    call RandomRange
    cmp eax, 26
    jl uppercaseOnlyProc
    cmp eax, 52
    jl lowercaseOnlyProc
    sub eax, 52
    add eax, offset numbers
    mov al, [eax]
    ret

allCharacters:
    mov eax, 94
    call RandomRange
    cmp eax, 26
    jl uppercaseOnlyProc
    cmp eax, 52
    jl lowercaseOnlyProc
    cmp eax, 62
    jl numbersOnlyProc
    sub eax, 62
    add eax, offset specialChars
    mov al, [eax]
    ret

uppercaseOnlyProc:
    mov eax, 26
    call RandomRange
    add eax, offset uppercase
    mov al, [eax]
    ret

lowercaseOnlyProc:
    mov eax, 26
    call RandomRange
    add eax, offset lowercase
    mov al, [eax]
    ret

numbersOnlyProc:
    mov eax, 10
    call RandomRange
    add eax, offset numbers
    mov al, [eax]
    ret
GenerateRandomChar ENDP

END start
