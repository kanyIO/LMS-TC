##### API Test :



1. Test Admin Creation (POST Request)

Endpoint: POST http://localhost:8000/addAdmin

-- Request Body:
{
"firstname": "Admin",
"lastname": "User",
"contactNumber": 123456789,
"address": "Admin Address",
"email": "admin@example.com",
"username": "admin",
"password": "admin123" }    

-- test has passed with Response status code is 401 

##### Test script 
pm.test("Response status code is 401", function () {
  pm.response.to.have.status(401);
});





2. retreive loan by id
-- under Headers enter authorization key for logged in user. 

Endpoint: GET http://localhost:3000/loans/1

-- Request Body:
{
  "client_id": 14, 
  "amort": 500, 
  "loan_term": 24
}


##### Test script 
pm.test("Response time is less than 200ms", function () {
  pm.expect(pm.response.responseTime).to.be.below(200);
});

