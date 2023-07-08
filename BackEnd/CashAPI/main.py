from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad
from uvicorn import run
from os import getcwd
import json 
import base64
import re

key_hex = '12345678901234567890123456789ABC'
key = bytes.fromhex(key_hex)

def decrypt_message(key, ciphertext_b64):
    ciphertext = base64.b64decode(ciphertext_b64)
    iv = ciphertext[:AES.block_size]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = cipher.decrypt(ciphertext[AES.block_size:])
    return plaintext.decode('utf-8')

app = FastAPI()

class cash(BaseModel):
    number:str
    val:int

class cash_note(BaseModel):
    note :str


# database = f"{getcwd()}/BackEnd/CashAPI/money.json"

with open("/tmp/database.json","w+") as f:
    f.write("{}")

database = "/tmp/database.json"

@app.post("/getval")
async def getval(n:cash_note):
    note_data = n.note
    note = decrypt_message(key,note_data.encode())
    note = note.split("::")[-1].strip()
    with open(database,"r") as f:
        notes = json.loads(f.read())
        print(notes)
    note = re.sub(r'[^\x20-\x7E]+', '', note.encode().decode("utf-8","ignore"))
    print(note.encode())
    if(notes.get(note)):
        return HTMLResponse(content=str(notes[note]),status_code=200)
    return HTMLResponse(content="Not Found",status_code = 404 )

@app.post("/putval")
async def putval(note:cash):
    with open(database,"r") as f:
        notes = json.loads(f.read())
    notes[note.number] = note.val
    with open(database,"w") as f:
        f.write(json.dumps(notes))   
    return HTMLResponse(content="Done",status_code = 200)

run(app,host = '0.0.0.0', port = 3000 )
