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

@app.post("/get_money")
def get_money(money_get: money_get):

    with open("cash_database.json", "r") as f:
        user_data = json.loads(f.read())

    to_return = {"notes": []}

    if (user_data.get(money_get.aadhar)):
        # to_return["notes"] = user_data[money_get.aadhar]
        notes_list = user_data[money_get.aadhar]

        for i in notes_list:
            note_form = f"{money_get.aadhar}::{i['note-number']}"
            encrypted_note = encrypt_message(key, note_form.encode())
            to_return['notes'].append(f"{encrypted_note}::{i['purpose']}")

        user_data[money_get.aadhar] = []

    with open("cash_database.json", "w") as f:
        f.write(json.dumps(user_data))

    return JSONResponse(content=to_return)

@app.post("/transfer")
def get_money(shopkeeper: shopkeeper):
    with open("pending_database.json", "r") as f:
        total_data = json.loads(f.read())

    sender_aadhar, note_number = decrypt_message(
        key, shopkeeper.note_code.encode()).split("::")
    
    note_number = re.sub(r'[^\x20-\x7E]+', '',note_number.encode().decode("utf-8", "ignore"))
    # print(sender_aadhar,note_number)
    if (not total_data.get(sender_aadhar)):
        total_data[sender_aadhar] = []

    # if(note_number in total_data[sender_aadhar]):
    if (shopkeeper.note_code in total_data[sender_aadhar]):
        return HTMLResponse(content="User Does Not Have Ownership", status_code=406)

    total_data[sender_aadhar].append(shopkeeper.note_code)

    with open("pending_database.json", "w") as f:
        f.write(json.dumps(total_data))

    new_note_number = f"{shopkeeper.shopkeeper_aadhar}::{note_number}"
    encrypted_note = encrypt_message(key, new_note_number.encode())

    return {"note": encrypted_note}
