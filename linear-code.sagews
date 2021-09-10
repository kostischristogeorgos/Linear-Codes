︠412de066-6f06-4a29-875d-165c2d4a3081s︠
import random

def binaryToDecimal(binary):
    decimal, i, n = 0, 0, 0
    while (binary != 0):
        dec = binary % 10
        decimal = decimal + dec * pow(2, i)
        binary = binary // 10
        i += 1
    return decimal

def binary_representation_of_message(message, encoding_length):
    asciivalues = [ord(c) for c in message]
    print("ASCII VALUES OF ORIGINAL MESSAGE: ", asciivalues)

    binaryvalues = [("0" * 8 + bin(c)[2:])[-8:] for c in asciivalues]
    print("BINARY VALUES OF ORIGINAL MESSAGE: ", binaryvalues)

    binarystring = "".join(binaryvalues)
    print("CONCATENATED BINARY VALUES INTO A STRING: ", binarystring)

    original_length = len(binarystring)
    print("LENGTH OF ORIGINAL MESSAGE: ",len(binarystring))
    length = len(binarystring) + 32
    print("LENGTH WITH 32 BITS ADDED: ", length)
    total_length = 0
    iterator = 1
    while True:
        if length % encoding_length == 0:
            total_length = length
            break
        else:
            if encoding_length*iterator > length:
                total_length = encoding_length*iterator
                break
            else:
                iterator = iterator + 1
                continue


    print("LENGTH WITH 32 BITS ADDED AND WITH NEEDED BITS FOR ENCODING ADDED: ", total_length)

    binary_length = ("0" * 8 + bin(len(binarystring))[2:])[-8:]
    print("ORIGINAL MESSAGE'S LENGTH IN BINARY: ", binary_length)

    if total_length - length > 0:
        binarystring = "0"*(total_length - length) + binarystring
    print("MESSAGE WITH", total_length, "-", length,"=",total_length - length, " 0 BITS ADDED ON THE LEFT: ", binarystring)

    binarystring = 4*(str(binary_length)) + binarystring
    print("MESSAGE WITH", total_length - length, "0 BITS ADDED ON THE LEFT AND WITH 4 TIMES THE ORIGINAL MESSAGE'S BINARY LENGTH ADDED: ", binarystring)
    print("")
    return binarystring,total_length,encoding_length,original_length




def ProduceCode(n,k):
    while(True):
        G1 = random_matrix(ZZ, k, k, x=0, y=2)
        S = random_matrix(ZZ, n, k, x=0, y=2)
        P = identity_matrix(k, k)
        G = matrix(GF(2), S * G1 * P)
        C = LinearCode(G)
        if(C.generator_matrix().nrows() != n):
            continue
        else:
            break
    return C


# DEFINE N AND K
n = 4
k = 7
message = "coron2as182+"
print("MESSAGE: ", message)
string_to_code,total_length,encoding_length,original_length = binary_representation_of_message(message,n)

print("FOR C1 CODE")
while(True):
    C1 = ProduceCode(n,k)
    print(C1.generator_matrix())
    print("MINIMUM DISTANCE OF C1: ", C1.minimum_distance())
    if C1.minimum_distance() >= 2:
        break
    else:
        continue
print("")

print("FOR C2 CODE")
while(True):
    C2 = ProduceCode(k,k+3)
    print(C2.generator_matrix())
    print("MINIMUM DISTANCE OF C2: ", C2.minimum_distance())
    if C2.minimum_distance() >= 2:
        break
    else:
        continue
print("")

decoded_list = []
for i in range(0, total_length, encoding_length):
    print("ORIGINAL MESSAGE BEFORE ENCODING: ", string_to_code[i:i + encoding_length])
    temp = []
    temp = list(string_to_code[i:i + encoding_length])
    for c in range(len(temp)):
        temp[c] = int(temp[c])
    message = vector(temp)

    print("MESSAGE AFTER ENCODING WITH C1")
    C1.encode(message)
    c1_encoded = C1.encode(message)
    print("MESSAGE AFTER ENCODING WITH C2")
    C2.encode(c1_encoded)
    c2_encoded = C2.encode(c1_encoded)

    while(True):
        random_iteration = random.randint(0,4)
        random_position = random.randint(0,k+2)
        if(random_iteration == 1):
            error = zero_vector(GF(2), k+3)
            print("ADDING RANDOM ERROR NOW")
            for i in range(k+3):
                if random_position == i:
                    error[i] = 1
                    break
            c2_encoded = c2_encoded + error
        break

    print("MESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR", c2_encoded)
    print("DECODED MESSAGE FROM C2")
    c2_decoded = C2.decode_to_message(c2_encoded)
    print(c2_decoded)

    print("DECODED MESSAGE FROM C1")
    c1_decoded = C1.decode_to_message(c2_decoded)
    print(c1_decoded)
    decoded_list.append(c1_decoded)
    print("")

for i in range(len(decoded_list)):
    decoded_list[i] = list(decoded_list[i])

decoded_string = ""
for sublist in decoded_list:
    for item in sublist:
        decoded_string += str(item)
    decoded_string += ""


decoded_string =  decoded_string[total_length - original_length:]
print("FULLY DECODED BINARY STRING: ",decoded_string[total_length - original_length:])

final_string = ""
for c in range(0, len(decoded_string), 8):
    final_string = final_string + "".join(chr(binaryToDecimal(int(decoded_string[c:c+8]))))

print(final_string)
︡b5570f3c-c9ec-4e99-9700-3fe8649f86a4︡{"stdout":"MESSAGE:  coron2as182+\n"}︡{"stdout":"ASCII VALUES OF ORIGINAL MESSAGE:  [99, 111, 114, 111, 110, 50, 97, 115, 49, 56, 50, 43]\nBINARY VALUES OF ORIGINAL MESSAGE:  ['01100011', '01101111', '01110010', '01101111', '01101110', '00110010', '01100001', '01110011', '00110001', '00111000', '00110010', '00101011']\nCONCATENATED BINARY VALUES INTO A STRING:  011000110110111101110010011011110110111000110010011000010111001100110001001110000011001000101011\nLENGTH OF ORIGINAL MESSAGE:  96\nLENGTH WITH 32 BITS ADDED:  128\nLENGTH WITH 32 BITS ADDED AND WITH NEEDED BITS FOR ENCODING ADDED:  128\nORIGINAL MESSAGE'S LENGTH IN BINARY:  01100000\nMESSAGE WITH 128 - 128 = 0  0 BITS ADDED ON THE LEFT:  011000110110111101110010011011110110111000110010011000010111001100110001001110000011001000101011\nMESSAGE WITH 0 0 BITS ADDED ON THE LEFT AND WITH 4 TIMES THE ORIGINAL MESSAGE'S BINARY LENGTH ADDED:  01100000011000000110000001100000011000110110111101110010011011110110111000110010011000010111001100110001001110000011001000101011\n\n"}︡{"stdout":"FOR C1 CODE\n"}︡{"stdout":"[1 1 1 0 1 0 0]\n[0 1 0 0 0 1 0]\n[1 1 0 1 1 1 0]\n[1 0 1 1 1 0 1]\nMINIMUM DISTANCE OF C1:  2\n"}︡{"stdout":"\n"}︡{"stdout":"FOR C2 CODE\n"}︡{"stdout":"[0 0 1 1 0 1 1 0 0 0]\n[1 1 1 0 0 1 1 1 0 0]\n[1 0 0 1 0 1 0 0 1 1]\n[1 1 0 1 0 0 0 1 0 1]\n[1 1 0 1 1 1 0 1 0 1]\n[1 0 0 0 1 0 1 0 0 0]\n[0 0 0 0 0 1 1 1 0 0]\nMINIMUM DISTANCE OF C2: "}︡{"stdout":" 1\n[0 1 0 0 1 1 1 0 0 1]\n[0 0 0 0 0 0 0 1 0 1]\n[1 1 0 0 0 0 0 1 0 1]\n[1 1 1 0 0 0 1 0 0 0]\n[1 0 1 1 1 1 1 1 0 0]\n[0 1 0 0 0 1 1 1 1 0]\n[1 0 1 0 1 0 0 0 0 1]\nMINIMUM DISTANCE OF C2: "}︡{"stdout":" 1\n[1 1 0 1 0 1 1 1 1 1]\n[0 0 1 1 1 0 1 0 1 1]\n[1 0 0 0 1 0 1 1 1 0]\n[0 1 1 0 0 1 1 1 0 0]\n[1 1 0 1 1 0 0 0 0 0]\n[0 1 0 0 0 0 1 0 1 0]\n[1 1 0 0 1 0 1 1 0 0]\nMINIMUM DISTANCE OF C2: "}︡{"stdout":" 1\n[1 1 1 0 0 0 1 0 0 1]\n[0 1 1 0 1 1 1 1 0 0]\n[0 0 1 0 1 0 1 1 0 0]\n[0 0 1 1 0 1 1 1 0 0]\n[0 1 1 0 1 0 1 1 1 1]\n[1 0 0 0 1 1 1 0 0 1]\n[1 0 0 0 1 1 1 1 1 0]\nMINIMUM DISTANCE OF C2: "}︡{"stdout":" 2\n"}︡{"stdout":"\n"}︡{"stdout":"ORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0000\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 1, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0000\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 0, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0000\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0000\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(0, 0, 0, 0, 0, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  1111\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 0, 1, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 1, 0, 1, 0, 0, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 1, 0, 1, 0, 0, 1, 0, 0)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 0, 1, 0, 1)\nDECODED MESSAGE FROM C1\n(1, 1, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0111\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 1, 0, 0, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 0, 0, 1, 0, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 0, 0, 1, 0, 0, 1, 0)"}︡{"stdout":"\nDECODED MESSAGE FROM C2\n(0, 0, 1, 0, 0, 0, 1)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0010\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 1, 1, 1, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 1, 1, 1, 1, 1, 0, 1)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 1, 1, 1, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  1111\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 0, 1, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 1, 0, 1, 0, 0, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 1, 0, 1, 0, 0, 1, 0, 0)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 0, 1, 0, 1)\nDECODED MESSAGE FROM C1\n(1, 1, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  1110\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 1, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 1, 1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 1, 1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 1, 0, 0, 0)\nDECODED MESSAGE FROM C1\n(1, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0010\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 1, 1, 1, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 1, 1, 1, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0110\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 1, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 1, 1, 1, 1, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 1, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(0, 1, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0001\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 1, 1, 1, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 1, 1, 0, 1, 0, 0, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 1, 1, 0, 1, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 1, 1, 1, 0, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0111\nMESSAGE AFTER ENCODING WITH C1\n(0, 0, 1, 0, 0, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 1, 0, 0, 1, 0, 0, 1, 0)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 0, 0, 0, 0, 0, 1, 0)\nDECODED MESSAGE FROM C2\n(0, 1, 0, 0, 0, 0, 1)\nDECODED MESSAGE FROM C1\n(1, 0, 0, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0001\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 1, 1, 1, 0, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 0, 0, 1, 1, 0, 1, 0, 0, 0)"}︡{"stdout":"\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 0, 0, 1, 1, 0, 1, 0, 0, 0)\nDECODED MESSAGE FROM C2\n(1, 0, 1, 1, 1, 0, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 0, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  1000\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 1, 0, 1, 0, 0)\nMESSAGE AFTER ENCODING WITH C2\n(1, 1, 0, 0, 1, 1, 0, 1, 1, 0)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 1, 0, 0, 1, 1, 0, 1, 1, 0)\nDECODED MESSAGE FROM C2\n(1, 1, 1, 0, 1, 0, 0)\nDECODED MESSAGE FROM C1\n(1, 0, 0, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0011\nMESSAGE AFTER ENCODING WITH C1\n(0, 1, 1, 0, 0, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 0, 0, 1, 0, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(0, 1, 1, 0, 0, 1, 1)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 1)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0010\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 1, 1, 1, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 1, 1, 1, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  0010\nMESSAGE AFTER ENCODING WITH C1\n(1, 1, 0, 1, 1, 1, 0)\nMESSAGE AFTER ENCODING WITH C2\n(0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (0, 1, 0, 1, 1, 1, 1, 1, 1, 1)\nDECODED MESSAGE FROM C2\n(1, 1, 0, 1, 1, 1, 0)\nDECODED MESSAGE FROM C1\n(0, 0, 1, 0)\n\nORIGINAL MESSAGE BEFORE ENCODING:  1011\nMESSAGE AFTER ENCODING WITH C1\n(1, 0, 0, 0, 1, 1, 1)\nMESSAGE AFTER ENCODING WITH C2\n(1, 0, 0, 0, 1, 0, 0, 0, 0, 1)\nADDING RANDOM ERROR NOW\nMESSAGE AFTER ENCODING WITH C2 + POSSIBLE ERROR (1, 0, 1, 0, 1, 0, 0, 0, 0, 1)\nDECODED MESSAGE FROM C2\n(1, 0, 0, 0, 1, 1, 1)\nDECODED MESSAGE FROM C1\n(1, 0, 1, 1)\n\n"}︡{"stdout":"FULLY DECODED BINARY STRING:  0110111000110010011000011001001100110001001110000011001000101011\n"}︡{"stdout":"coron2a182+\n"}︡{"done":true}









