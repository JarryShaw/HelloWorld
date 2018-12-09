alphabet = "0123456789."
code = input()
grid = []
variables = []
loops = 10

for i in range(100):
    grid.append(00)

while code[0] != "3" or code[1] != "." or code[-1] != "4":
    code = input("Code invalid. ")

code += "000000"

i = 2

while i < len(code) - 6:
    variables = []
    variables.append(int(code[i+1] + code[i+2]))
    variables.append(int(code[i+3] + code[i+4]))
    variables.append(int(code[i+5] + code[i+6]))
    if code[i] == "0":
        grid[variables[0]] = grid[variables[1]] + grid[variables[2]]
        i += 7
    elif code[i] == "1":
        grid[variables[0]] = grid[variables[1]] - grid[variables[2]]
        i += 7
    elif code[i] == "2":
        grid[variables[0]] = grid[variables[1]] * grid[variables[2]]
        i += 7
    elif code[i] == "3":
        grid[variables[0]] = grid[variables[1]] / grid[variables[2]]
        i += 7
    elif code[i] == "4":
        i = len(code)
    elif code[i] == "5":
        print(chr(grid[variables[0]]),end='')
        i += 3
    elif code[i] == "6":
        grid[variables[0]] = variables[1]
        i += 5
    elif code[i] == "7":
        grid[variables[0]] = ord(input())
        i += 3
    elif code[i] == "8":
        if grid[variables[0]] == 0:
            found = False
            nests = 0
            while found == False:
                i += 1
                if code[i] == "8":
                    nests += 1
                elif code[i] == "9":
                    if nests == 0:
                        i += 1
                        found = True
                    else:
                        nests -= 1
        elif grid[variables[0]] != 0:
            i += 1
            found = True
    elif code[i] == "9":
        storei = i
        nests = 0
        returned = False
        while returned == False:
            i -= 1
            if code[i] == "9":
                nests += 1
            elif code[i] == "8":
                if nests == 0:
                    if grid[int(str(code[i+1]) + str(code[i+2]))] == 0:
                        i = storei
                        returned = True
                    else:
                        returned = True
    else:
          print("Error found with character " + code[i])
