def first_string():
    return "All Hail The Queen!"

def transform_string(input_string):
    result = []
    
    for char in input_string:
        # XOR the ASCII value of the character with 10
        transformed_char = chr(ord(char) ^ 10)
        result.append(transformed_char)
    
    # Join the transformed characters into a single string
    return ''.join(result)

def xor_decrypt_2(target_str, key=0x41524241):
    result = b''
    # pad to multiple of 4 bytes
    padded = target_str.encode('ascii')
    while len(padded) % 4 != 0:
        padded += b'\x00'

    for i in range(0, len(padded), 4):
        chunk = padded[i:i+4]
        chunk_val = int.from_bytes(chunk, byteorder='little')
        xored = chunk_val ^ key
        result += xored.to_bytes(4, byteorder='little')

    return result.rstrip(b'\x00')

def extract_valid_password():
    # Step 1: Raw bytes as found in the binary (little-endian)
    raw_bytes = [
        0x07, 0x00,  # 0 → 0x0007 = 7
        0x21, 0x00,  # 1 → 0x0021 = 33
        0x01, 0x00,  # 2 → 0x0001 = 1
        0xA8, 0xFD,  # 3 → 0xFDA8 = -600
        0x78, 0xEC,  # 4 → 0xEC78 = -5000
        0xF1, 0x06,  # 5 → 0x06F1 = 1777
        0x0D, 0x00,  # 6 → 0x000D = 13
        0x45, 0x00   # 7 → 0x0045 = 69
    ]

    # Step 2: Convert every pair of bytes into a signed 16-bit integer
    word_404000 = []
    for i in range(0, len(raw_bytes), 2):
        low = raw_bytes[i]
        high = raw_bytes[i + 1]
        value = (high << 8) | low
        # Convert to signed 16-bit
        if value >= 0x8000:
            value -= 0x10000
        word_404000.append(value)

    # Step 3: Map each value to its original index, then sort by value
    indexed = list(enumerate(word_404000))
    sorted_by_value = sorted(indexed, key=lambda x: x[1])
    indices = [str(index) for index, _ in sorted_by_value]

    # Step 4: Join indices into string and return
    return ' '.join(indices)


print(transform_string("intro the rabbit hole"))
input_needed = xor_decrypt_2("into the rabbit hole")
print(input_needed.decode('ascii'))
print(extract_valid_password())
