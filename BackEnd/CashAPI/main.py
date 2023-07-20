from fastapi import FastAPI
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad
from uvicorn import run
from os import getcwd
import json
import base64
import re
from requests import post

key_hex = '12345678901234567890123456789ABC'
key = bytes.fromhex(key_hex)
rupify_api = "https://worried-slug-garment.cyclic.app/deposite"


def decrypt_message(key, ciphertext_b64):
    ciphertext = base64.b64decode(ciphertext_b64)
    iv = ciphertext[:AES.block_size]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = cipher.decrypt(ciphertext[AES.block_size:])
    return plaintext.decode('utf-8')


app = FastAPI()


class cash(BaseModel):
    number: str
    val: int


class cash_note(BaseModel):
    note: str


class aadhar(BaseModel):
    aadhar: str


class numbertransfer(BaseModel):
    note_list: list
    receiver_mobile: int


# database = f"{getcwd()}/BackEnd/CashAPI/money.json"

with open("/tmp/database.json", "w+") as f:
    f.write("{}")

database = "/tmp/database.json"


@app.post("/getval")
async def getval(n: cash_note):
    note_data = n.note
    note = decrypt_message(key, note_data.encode())
    note = note.split("::")[-1].strip()
    with open(database, "r") as f:
        notes = json.loads(f.read())
        print(notes)
    note = re.sub(r'[^\x20-\x7E]+', '', note.encode().decode("utf-8", "ignore"))
    print(note.encode())
    if (notes.get(note)):
        return HTMLResponse(content=str(notes[note]), status_code=200)
    return HTMLResponse(content="Not Found", status_code=404)


@app.post("/putval")
async def putval(note: cash):
    with open(database, "r") as f:
        notes = json.loads(f.read())
    notes[note.number] = note.val
    with open(database, "w") as f:
        f.write(json.dumps(notes))
    return HTMLResponse(content="Done", status_code=200)


Temporary_Users_Data = {
    "111111111111": {
        "Name": "Muskan",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1no3PBWeBNKmt9uf3-u0s4-a0zWdmY1BY",
        "purpose": [0],
        "mobile number": "9999999990"
    },
    "111111111112": {
        "Name": "Paras Upadhayay",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=15DfPsiWNuTGXF28eKjTuhoqt0P5j1Axw",
        "purpose": [0],
        "mobile number": "9999999991"
    },
    "111111111113": {
        "Name": "Dhruval Gupta",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1SQg3fn5j8Z6RSCe1BArZu07eQLrftgM-",
        "purpose": [0],
        "mobile number": "9999999992"
    },
    "111111111114": {
        "Name": "Khushi",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=13OKt98UD5fVDIlYQofrzU_VsjwUTfdI1",
        "purpose": [0],
        "mobile number": "9999999993"
    },
    "111111111115": {
        "Name": "Pushkar",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1yaZP6H5kpBAokDgxwu0wb3RqR4tYtIpJ",
        "purpose": [0, 10],
        "mobile number": "9999999994"
    },
    "111111111116": {
        "Name": "Shreya",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1ct_WwQ4odGbJAsOANmVBQ4n_nhD5O27r",
        "purpose": [0],
        "mobile number": "9999999995"
    },
    "222222222222": {
        "Name": "Nitin",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1KoHx8yl7PAyr-sAmzQUzJZqZZgVe88El",
        "purpose": [0, 15],
        "mobile number": "9999999996"
    },
    "989898989898": {
        "Name": "Ramu",
        "Profile Pic": "https://drive.google.com/uc?export=download&id=1tKDo5N7AWYP73dNzTx5mvpy8BsWloD8T",
        "purpose": [0, 15],
        "mobile number": "9999999997"
    },

}


@app.post("/get_name_by_note")
async def get_name_by_note(n: cash_note):
    aadhar = decrypt_message(key, n.note.encode())
    aadhar = aadhar.split("::")[0].strip()
    print(aadhar)
    if Temporary_Users_Data.get(aadhar):
        return JSONResponse(
            content={"Name": Temporary_Users_Data[aadhar]["Name"], "pfp": Temporary_Users_Data[aadhar]["Profile Pic"]})
    return HTMLResponse(content="Unknown", status_code=404)


@app.post("/get_detailes")
async def get_details_by_aadhar(aadhar: aadhar):
    if Temporary_Users_Data.get(aadhar.aadhar):
        return JSONResponse(content=Temporary_Users_Data.get(aadhar.aadhar))
    return HTMLResponse(content="Unknown", status_code=404)


# Not Tested

@app.post("/transer_to_mobile_number")
async def transer_to_mobile_number(n: numbertransfer):
    for details in Temporary_Users_Data:
        if details["mobile number"] == numbertransfer.receiver_mobile:
            reciever_aadhar = details
            break
    else:
        return HTMLResponse(content="User Not Found", status_code=404)

    for notes in numbertransfer.note_list:
        note = decrypt_message(key, notes)
        note = note.split("::")[1].strip()
        headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'
        }
        data = {
            "aadhar": reciever_aadhar,
            "note": note,
            "purpose": 0
        }
        post(rupify_api, json=data, headers=headers)

    return HTMLResponse(content="Done", status_code=200)


run(app, host='0.0.0.0', port=3000)
