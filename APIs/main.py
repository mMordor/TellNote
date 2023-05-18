import  mysql.connector
from fastapi import FastAPI , Response
from pydantic import BaseModel
from typing import Optional

app = FastAPI()



class User():
    UserName : str
    Password : str
    Email : Optional[str] = None


class Contact():
    UsertID : int
    Name : str
    LastName : Optional[str] = None
    Number : str
    Relation : str 



@app.get("/Get_User")
def Get_Users(uid: int):
    Data = GetUser(uid)

    return Data

@app.get("/Log_User")
def Log_Users(username: str, password: str, respose: Response):
    Data = validating_Users(username,password)
    return Data

@app.get("/Get_Contacts")
def get_Contacts(UserID: int):
    Data = ContactsList(UserID)
    return Data

@app.post("/post_cotacts")
def post_contacts(uID: str,name: str,num: str,rel: str,lname: Optional[str] = None):
    contact = Contact()
    contact.UsertID = uID
    contact.Name=name
    contact.LastName=lname
    contact.Number=num
    contact.Relation=rel
    result = insertContact(contact)
    return result

@app.post("/post_user")
def post_user(name: str,pas: str,email: Optional[str] = None):
    user = User()
    user.UserName=name
    user.Password=pas
    user.Email=email
    result = insertUser(user)
    return result

@app.put("/update_user")
def updata_user(uid : int,uname : str,pas : str,email : Optional[str] = None):
    data = updateUser(uid,uname,pas,email)
    return data

@app.put("/update_contact")
def update_contat(uid : int,uname : str,pas : str,email : Optional[str] = None):
    data = updateContact(uid,uname,pas,email)
    return data

@app.delete("/delete_contact")
def delete_contact(cID : int):
    data = deleteContact(cID)
    return data

@app.delete("/delete_user")
def delete_user(uID : int):
    data = deleteUser(uID)
    return data



def GetUser(uid: int):
    cnx = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
        )

    try :
        cursour = cnx.cursor()
        cursour.execute(
            "select * from users where UsersID = {}".format(uid)
        )
        respon = cursour.fetchall()
        if (respon == []):
            return{"Massage":"User dose not exist"}
        for user in respon:
            User = {
                "UserID" : user[0],
                "UserName" : user[1],
                "Password" : user[2],
                "Email" : user[3],
            }

    except  mysql.connector.Error as e:
        print("Error reading from Mysql database table", e)
    finally:
        if cnx.is_connected():
            cnx.close()
            cursour.close()
    
    return User

def Userslist():
    cnx = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
        )

    try :
        cursour = cnx.cursor()
        cursour.execute(
            "select * from users"
        )
        Users = cursour.fetchall()

        UserJ = {}
        i = 0
        
        for user in Users:
           
            UserJ[i] = {
                "id" : user[0],
                "UserName" : user[1],
                "Password" : user[2],
                "Email" : user[3]
            }
            i += 1

    except  mysql.connector.Error as e:
        print("Error reading from Mysql database table", e)
    finally:
        if cnx.is_connected():
            cnx.close()
            cursour.close()
    
    return UserJ

def validating_Users(Username : str, Password : str):
    Data = Userslist()
    print(Username)
    print(Password)
    chek = False
    for i in range(len(Data)):         
        if Username == Data[i]["UserName"]:
            chek = True
            break

    if chek == False:
        return {"Massage" : "User dose not exist"}
    else:        
        if Data[i]["Password"] == Password:
            return {"Massage" : "Acsses acsepted","ID":Data[i]["id"]}
        else:
            print(Data[i]["Password"])
            print(Password)
            return {"Massage" : "Password is wrong"}

def ContactsList(UID: int):
    cnx = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    try :
        cursour = cnx.cursor()
        cursour.execute(
            "select * from contacts where UserID={}".format(UID)
        )
        Contacts = cursour.fetchall()
        print(Contacts)
        ContactsJ = {
            "Contacts" :[]
        }

        for Contact in Contacts:
           
            x = {
                "ContactID" : Contact[0],
                "Name" : Contact[2],
                "LastName" : Contact[3],
                "Number" : Contact[4],
                "Relation" : Contact[5]
            }
            ContactsJ["Contacts"].append(x)


    except  mysql.connector.Error as e:
        print("Error", e)
    finally:
        if cnx.is_connected():
            cnx.close()
            cursour.close()
    
    return ContactsJ

def insertContact(contact : Contact):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    
    try:
        query="insert into contacts (UserID,Name,LastName,Numb,Relation) values ({},'{}','{}','{}','{}')".format(contact.UsertID,contact.Name,contact.LastName,contact.Number,contact.Relation)
        cursor = DC.cursor()
        cursor.execute(query)
        DC.commit()
    except mysql.connector.Error as e :
        print("Eror",e)
        return {"Massage": "{}".format(e)}
    finally:
        if DC.is_connected():
            DC.close()
            cursor.close()
    return {"Massage" : "Contact added"}

def insertUser(user : User):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    email : str
    if user.Email == None:
        email="NULL"
    else:
        email=user.Email

    try:
        query = "INSERT INTO users(UserName,Password,Email) VALUES ('{}','{}','{}');".format(user.UserName,user.Password,email)
        print(query)
        cursor = DC.cursor()
        cursor.execute(query)
        DC.commit()
        
    except mysql.connector.Error as e :
        print("Eror",e)
    finally:
        if DC.is_connected():
            DC.close()
            cursor.close()
    return {"Massage" : "User added"}

def updateContact(CID : int,Name : str,Numb : str,Rel : str,Lname : Optional[str] = None):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    if Lname == None:
        Lname = "NULL"

    query="update contacts set Name = '{}',LastName = '{}',Numb = '{}',Relation = '{}' where ContactID = {}".format(Name,Lname,Numb,Rel,CID)
    try:
        cursor=DC.cursor()
        cursor.execute(query)
        DC.commit()
    except mysql.connector.Error as e :
        print("Error",e)
    finally:
        if DC.is_connected():
            DC.close()
            cursor.close()
    return {"Massage" : "Contact Updated"}

def updateUser(UID : int,UName : str,Pas : str,Email : Optional[str] = None):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    if Email == None:
        Email = "NULL"

    query="UPDATE users SET UserName='{}',Password='{}',Email='{}' where UsersID='{}'".format(UName,Pas,Email,UID)
    try:
        cursor=DC.cursor()
        cursor.execute(query)
        DC.commit()
    except mysql.connector.Error as e :
        print("Error",e)
    finally:
        if DC.is_connected():
            DC.close()
            cursor.close()
    return {"Massage" : "User Updated"}

def deleteContact(CID : int):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    query = "DELETE FROM contacts WHERE ContactID={}".format(CID)
    try:
        cursor = DC.cursor()
        cursor.execute(query)
        DC.commit()
    except mysql.connector.Error as e:
        print("Eror",e)
        return {"Massage" : "{}".format(e)}
    finally:
        if DC.is_connected :
            DC.close()
            cursor.close()
    return {"Massage" : "Contact Deleted"}

def deleteUser(UID : int):
    DC = mysql.connector.connect(
        host="localhost",
        user="admin",
        password="@#Tellnotes2019",
        database="tellnotes"
    )
    query = "DELETE FROM users WHERE UsersID={}".format(UID)
    try:
        cursor = DC.cursor()
        cursor.execute(query)
        DC.commit()
    except mysql.connector.Error as e:
        print("Error",e)
    finally:
        if DC.is_connected :
            DC.close()
            cursor.close()
    return {"massage" : "User Deleted"}

