# Encryption/Decryption Using XOR
## Nigel Boswell

# Encrypting the Message

## Step 1:
My chosen word is Awesome, I now have to conver this to Hexadecimal

## Step 2 : ASCII to Hexadecimal then to Binary

| Letter | Hexadecimal | Binary |
|--------|-------------|--------|
| B      | 42          | 0100 0010 |
| o      | 6F          | 0110 1111 |
| o      | 6F          | 0110 1111 |
| m      | 6D          | 0110 1101 |
| b      | 62          | 0110 0010 |
| o      | 6F          | 0110 1111 |
| x      | 78          | 0111 1000 |

For the Hexadecimal to Binary, I know that I can take each digit of Hex and have it represnt 4 digits in Binary

## Step 3: Converting "Boombox" to Binary

### ASCII to Hexadecimal then to Binary

| Letter | Hexadecimal | Binary |
|--------|-------------|--------|
| A      | 41          | 0100 0001 |
| w      | 77          | 0111 0111 |
| e      | 65          | 0110 0101 |
| s      | 73          | 0111 0011 |
| o      | 6F          | 0110 1111 |
| m      | 6D          | 0110 1101 |
| e      | 65          | 0110 0101 |

## Step 4: XOR Encryption

| Position | Awesome | Boombox | XOR Result (Binary) | XOR Result (Hex) |
|----------|---------|---------|---------------------|------------------|
| 1        | 01000001 | 01000010 | 00000011            | 03               |
| 2        | 01110111 | 01101111 | 00011000            | 18               |
| 3        | 01100101 | 01101111 | 00001010            | 0A               |
| 4        | 01110011 | 01101101 | 00011110            | 1E               |
| 5        | 01101111 | 01100010 | 00001101            | 0D               |
| 6        | 01101101 | 01101111 | 00000010            | 02               |
| 7        | 01100101 | 01111000 | 00011101            | 1D               |

# Decrypting the message

## Step 1: XOR Decryption

### Bitwise XOR Operation

| Position | XOR Result | Boombox | Decryption Result |
|----------|------------------|------------------|------------|
|  1   | 00000011         | 01000010         | 01000001   |
|  2   | 00011000         | 01101111         | 01110111   |
|  3   | 00001010         | 01101111         | 01100101   |
|  4   | 00011110         | 01101101         | 01110011   |
|  5   | 00001101         | 01100010         | 01101111   |
|  6   | 00000010         | 01101111         | 01101101   |
|  7   | 00011101         | 01111000         | 01100101   |

## Step 2: Decrypted Result

**Binary (separated):** `01000001 01110111 01100101 01110011 01101111 01101101 01100101`

**Hexadecimal:** `41 77 65 73 6F 6D 65`

**ASCII:** `Awesome`

## Step 3: Explain how XOR encryption can be performed when the plaintext and key have different lengths.
Although the Key and messaage dont align, I know this can be worked around by simply repeating the key again to make a longer encryption key, and not using the entire key when encoding a smaller word.

## My hand worked solutions
![Hand Worked Process and Calculations](https://github.com/NigelBOS/assignments/blob/main/XOR%20encryption.pdf)

## My flow chart of thought process
![Flow Chart](https://github.com/NigelBOS/assignments/blob/main/flowchart5.pdf)

## Difficulties encountered
Honestly, my biggest difficulty was uploading this all to github and remaking it on markdown. Other than that, I have expereince dealing with Binary and Hexadecimal so most annoying problem was the tedious conversion between it all. I should've picked smaller words, but the challenge was there and I don't regret it.
