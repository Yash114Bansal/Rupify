from tkinter import *
from tkinter import ttk
from PIL import ImageTk, Image
import requests


root = Tk()
root.title("E-Rupi ATM")
root.geometry("500x300")
root.configure(background='#ffffcc')
root.geometry("1600x950")
root.minsize(800, 900)
root.maxsize(800, 900)

# govt_api = "https://casgapi.onrender.com/putval"
# govt_api = "http://127.0.0.1:8000/putval" # For Debugging
# rupify_api = "https://rupify-production.up.railway.app/deposite"
govt_api = "https://funny-bull-bathing-suit.cyclic.app/putval"
rupify_api = "https://drab-jade-duckling-cape.cyclic.app/deposite"

def send_request():
    note_number = entry1.get()
    aadhar_number = entry2.get()
    amount = int(combo_box.get())
    purpose = int(entry4.get())
    print(amount)
    headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json'
    }

    data = {
        'number': note_number,
        'val':  amount
    }
    r = requests.post(govt_api, headers=headers, json=data)
    print(r)

    data = {
        "aadhar": aadhar_number,
        "note": note_number,
        "purpose": purpose
    }

    requests.post(rupify_api, json=data, headers=headers)


img = Image.open("logo.png")
img = img.resize((300, 200))


img = ImageTk.PhotoImage(img)
logo = Label(root, image=img)
logo.place(x=250, y=70)

# Note Number
text1_label = Label(root, text="Note Number : ",
                    bg="#ffffcc", font=('Arial', 18))
text1_label.place(x=150, y=350)

entry1 = Entry(root, width=30, bg="#ffff99")
entry1.place(x=360, y=356)


# Aadhar Number

text2_label = Label(root, text="Aadhar Number : ",
                    bg="#ffffcc", font=('Arial', 18))
text2_label.place(x=150, y=400)

entry2 = Entry(root, width=30, bg="#ffff99")
entry2.place(x=360, y=406)

# Amount

text3_label = Label(root, text="Cash: ", bg="#ffffcc", font=('Arial', 18))
text3_label.place(x=150, y=450)

Cashes = [
    "10",
    "20",
    "50",
    "100",
    "200",
    "500",
    "1000",
    "2000",
]

# ComboBox

combostyle = ttk.Style()

combostyle.theme_create('combostyle', parent='alt',
                        settings={'TCombobox':
                            {'configure':
                                {
                                    'fieldbackground': '#ffff99',
                                    'background': '#ffff99'
                                }}}
                        )
combostyle.theme_use('combostyle')

combo_box = ttk.Combobox(root, values=Cashes, background="#ffff99")
combo_box.current(0)
combo_box['state'] = 'readonly'
combo_box.pack(fill='none', expand='False')
combo_box.place(x=360, y=456, height=20, width=280)

# Purpose
text4_label = Label(root, text="Purpose: ", bg="#ffffcc", font=('Arial', 18))
text4_label.place(x=150, y=500)

entry4 = Entry(root, width=30, bg="#ffff99")
entry4.place(x=360, y=506)

submit_button = Button(root, text="Deposite", bg="#ff751a",activebackground="#ff751a", fg="white", command=send_request)
submit_button.place(x=400, y=550)

root.mainloop()
