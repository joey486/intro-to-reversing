import lief

# Load the original binary
binary = lief.parse("C:/assembly/InjectMe1.exe")

# Convert RVA to file offset helper
def rva2offset(rva):
    for section in binary.sections:
        start = section.virtual_address
        end = start + section.size
        if start <= rva < end:
            offset = rva - start + section.offset
            return offset
    raise ValueError("RVA not in any section")

# Shellcode
shellcode = bytes.fromhex("""
6A00 68B8104000 68AF104000 6A00 FF1500604000 6A00 FF1504604000
48656C6C6F00 496E6A65637465642100
""".replace("\n", "").replace(" ", ""))

# Patch jump at 0x4010B0 to jump to 0x4010B5
jmp_rva = 0x4010B0
jmp_to = 0x4010B5
jmp_offset = rva2offset(jmp_rva)

rel = jmp_to - (jmp_rva + 5)  # 5 = size of jmp instruction
jmp_patch = bytes([0xE9]) + rel.to_bytes(4, "little", signed=True) + b'\x90'

# Inject shellcode at 0x4010B5
shellcode_rva = 0x4010B5
shellcode_offset = rva2offset(shellcode_rva)

# Patch binary content
with open("njectMe1.exe", "rb") as f:
    data = bytearray(f.read())

# Overwrite jmp instruction
data[jmp_offset:jmp_offset+6] = jmp_patch

# Overwrite shellcode
data[shellcode_offset:shellcode_offset + len(shellcode)] = shellcode

# Write patched output
with open("patched.exe", "wb") as f:
    f.write(data)

print("[+] Patch complete: patched.exe")
