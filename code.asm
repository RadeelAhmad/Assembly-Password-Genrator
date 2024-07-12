INCLUDE Irvine32.inc
.data
password BYTE 50 DUP(?)
passwordLength DWORD ?
passwordComplexity DWORD ?
uppercase BYTE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 0
lowercase BYTE 'abcdefghijklmnopqrstuvwxyz', 0
numbers BYTE '0123456789', 0
specialChars BYTE '!@#$%^&*()_+-={}:<>?', 0
sprompt BYTE "Enter Desired Password Length: ", 0
smenu BYTE " --------- Main Menu ------------", 0
smenu1 BYTE "1. Weak Password (lowercase + length fewer than 8)", 0
smenu2 BYTE "2. Average Password (mixedcase + numbers + length 8 to 12)", 0
smenu3 BYTE "3. Strong Password (mixedcase + numbers + special characters + length greater than 12)", 0
soption BYTE "Choose Complexity (1-3): ", 0
spassword BYTE "Password Will be: ", 0
serror BYTE "------------ Invalid Length --------- ", 0
.code
start PROC
    mov edx, OFFSET smenu
    call WriteString
    call Crlf
    mov edx, OFFSET smenu1
    call WriteString
    call Crlf
    mov edx, OFFSET smenu2
    call WriteString
    call Crlf
    mov edx, OFFSET smenu3
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET soption
    call WriteString
    call ReadInt
    mov passwordComplexity, eax
    mov edx, OFFSET sprompt
    call WriteString
    call ReadInt
    mov passwordLength, eax
    ; Validate password length based on complexity
    mov eax, passwordComplexity
    cmp eax, 1
    je validateWeak
    cmp eax, 2
    je validateAverage
    cmp eax, 3
    je validateStrong
    jmp invalidOption

validateWeak:
    cmp passwordLength, 8
    jb generate
    jmp invalidLength

validateAverage:
    cmp passwordLength, 8
    jb invalidLength
    cmp passwordLength, 12
    jbe generate
    jmp invalidLength

validateStrong:
    cmp passwordLength, 12
    jb invalidLength
    jmp generate

invalidLength:
    call Crlf
    mov edx, OFFSET serror
    call WriteString
    call Crlf
    invoke ExitProcess, 0

invalidOption:
    call Crlf
    mov edx, OFFSET serror
    call WriteString
    call Crlf
    invoke ExitProcess, 0

generate:
    mov esi, OFFSET password
    mov ecx, passwordLength
generatePassword:
    call GenerateRandomChar
    mov [esi], al
    inc esi
    loop generatePassword
    mov byte ptr [esi], 0
    call Crlf
    mov edx, OFFSET spassword
    call WriteString
    mov edx, OFFSET password
    call WriteString
    call Crlf
    invoke ExitProcess, 0

start ENDP

GenerateRandomChar PROC
    mov eax, passwordComplexity
    cmp eax, 1
    je generateWeakChar
    cmp eax, 2
    je generateAverageChar
    cmp eax, 3
    je generateStrongChar
    ret

generateWeakChar:
    mov eax, 36
    call RandomRange
    cmp eax, 26
    jl weakLowercase
    sub eax, 26
    add eax, OFFSET numbers
    mov al, [eax]
    ret

weakLowercase:
    add eax, OFFSET lowercase
    mov al, [eax]
    ret

generateAverageChar:
    mov eax, 62
    call RandomRange
    cmp eax, 26
    jl averageUppercase
    cmp eax, 52
    jl averageLowercase
    sub eax, 52
    add eax, OFFSET numbers
    mov al, [eax]
    ret

averageUppercase:
    add eax, OFFSET uppercase
    mov al, [eax]
    ret

averageLowercase:
    sub eax, 26
    add eax, OFFSET lowercase
    mov al, [eax]
    ret

generateStrongChar:
    mov eax, 94
    call RandomRange
    cmp eax, 26
    jl strongUppercase
    cmp eax, 52
    jl strongLowercase
    cmp eax, 62
    jl strongNumbers
    sub eax, 62
    add eax, OFFSET specialChars
    mov al, [eax]
    ret

strongUppercase:
    add eax, OFFSET uppercase
    mov al, [eax]
    ret

strongLowercase:
    sub eax, 26
    add eax, OFFSET lowercase
    mov al, [eax]
    ret

strongNumbers:
    sub eax, 52
    add eax, OFFSET numbers
    mov al, [eax]
    ret

GenerateRandomChar ENDP
END start
