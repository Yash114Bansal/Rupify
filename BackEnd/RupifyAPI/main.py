from fastapi import FastAPI
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad
import json
import base64
import re

key_hex = '12345678901234567890123456789ABC'
key = bytes.fromhex(key_hex)


def encrypt_message(key, message):
    iv = get_random_bytes(AES.block_size)
    cipher = AES.new(key, AES.MODE_CBC, iv)
    padded_message = pad(message, AES.block_size)
    ciphertext = cipher.encrypt(padded_message)
    return base64.b64encode(iv + ciphertext).decode('utf-8')


def decrypt_message(key, ciphertext_b64):
    ciphertext = base64.b64decode(ciphertext_b64)
    iv = ciphertext[:AES.block_size]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = cipher.decrypt(ciphertext[AES.block_size:])
    return plaintext.decode('utf-8')


class cash(BaseModel):
    aadhar: str
    note: str
    purpose: int


class money_get(BaseModel):
    aadhar: str


class shopkeeper(BaseModel):
    note_code: str
    shopkeeper_aadhar: str


app = FastAPI()


@app.post("/deposite")
def depoiste_money(cash: cash):

    with open("cash_database.json", "r") as f:
        user_data = json.loads(f.read())

    if (not user_data.get(cash.aadhar)):
        user_data[cash.aadhar] = []

    data = {
        "note-number": cash.note,
        "purpose": cash.purpose
    }

    user_data[cash.aadhar].append(data)

    with open("cash_database.json", "w") as f:
        f.write(json.dumps(user_data))

    return HTMLResponse(content="Done", status_code=200)
