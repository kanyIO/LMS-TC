##### API Test Results:

1. Test Admin Creation (POST Request)

Endpoint: POST http://localhost:8000/addAdmin

- Request Body:
{
"firstname": "Admin",
"lastname": "User",
"contactNumber": 123456789,
"address": "Admin Address",
"email": "admin@example.com",
"username": "admin",
"password": "admin123" }    

- test has passed with Response status code is 401 

- Test script 
pm.test("Response status code is 401", function () {
  pm.response.to.have.status(401);
});


2. Login
- use Endpoint:POST http://localhost:8000/login
- under header: Enter the key "Authorization" and Athorization token
- Status passes with code 200
- Json file returns the authorization token 
"{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RuYW1lIjoiQWRtaW4iLCJsYXN0bmFtZSI6IlVzZXIiLCJjb250YWN0bnVtYmVyIjoxMjM0NTY3ODksImVtYWlsIjoiYWRtaW5AZXhhbXBsZS5jb20iLCJhZGRyZXNzIjoiQWRtaW4gQWRkcmVzcyIsInBhc3N3b3JkIjoiJDJhJDEwJGJBYzhnbXpCemp5WjN4RmouS1JZUGVCYVNlOWRiWWJHb21oL0FJNjFuaVhuekdSRFcydU9TIiwidXNlcm5hbWUiOiJhZG1pbiIsImlhdCI6MTczNzcxMDUzOCwiZXhwIjoxNzM3NzMyMTM4fQ.TY2ufzBCBja0BKjMhFUBLs2EU5qBkIeoLRYT2Vc34lQ"}"


3. fetch customers
- use Endpoint: GET http://localhost:8000/allClients
- under header: Enter the key "Authorization" and Athorization token

- Send request
- The result fetches a JSon file listing the users
[{"id":1,"firstname":"Elon","lastname":"Musk","contactnumber":444333,"email":"elonmusk@gmail.com","address":"Boca Chica, Texas","username":"notElonMusk","password":null},{"id":3,"firstname":"Tony","lastname":"Stark","contactnumber":777888,"email":"tonystark@gmail.com","address":"New York","username":"notTonyStark","password":null},{"id":2,"firstname":"Peter","lastname":"Parker","contactnumber":1234,"email":"peterparker@gmail.com","address":"New York","username":"notPeterParker","password":null},{"id":11,"firstname":"Maina","lastname":"Kimani","contactnumber":723456789,"email":"main.kim@gmail.com","address":"Jane Address","username":"mainkim","password":null},{"id":14,"firstname":"Jane","lastname":"Muthoni","contactnumber":1234567890,"email":"jane.mso@gmail.com","address":"123 Address","username":"janemso","password":null}]

4. retreive loan by id
- under Headers enter authorization key for logged in user. 
- Use Endpoint: GET http://localhost:3000/loans/1
- Request Body:
{
  "client_id": 14, 
  "amort": 500, 
  "loan_term": 24
}
- The rest passes with the response 200. Scipt below
pm.test("Response time is less than 200ms", function () {
  pm.expect(pm.response.responseTime).to.be.below(200);
});
