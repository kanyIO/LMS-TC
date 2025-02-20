describe('Login Functionality Tests', () => {
  let isLoggedIn = false;
  const baseUrl = 'http://localhost:3000'; 
//sign in before each test case
  beforeEach({ timeout: 60 * 1000 }, () => {
    cy.visit(`${baseUrl}/login`);
    cy.login('admin', 'admin123'); 
  });
  // Visit home page after each test
  afterEach(() => {
    cy.get('a[href*="/home"]').should('exist').and('be.visible').click();
  });
 
// CREATE NEW BORRROWER
it('should visit the clients page and create new borrower', ()=>{
cy.url().should('include', '/borrowers',  { timeout: 10 * 60000 } );  //get client page
cy.get('a[href="/addBorrower"]').should('exist').and('be.visible').click(); // Select add borrower button 
// fill in borrower form
cy.get('input[name="firstname"]').should('exist').and('be.visible').type('Noki');
cy.get('input[name="lastname"]').should('exist').and('be.visible').type('Gnocchi');
cy.get('input[name="contactNumber"]').should('exist').and('be.visible').type('0714561810');
cy.get('input[name="address"]').should('exist').and('be.visible').type('WoodRock Rd');
cy.get('input[name="email"]').should('exist').and('be.visible').type('nokGnocchi@gmail.com');
cy.get('input[name="username"]').should('exist').and('be.visible').type('gnocchi');
cy.get('button[type="submit"]').should('exist').and('be.visible').click();
cy.get('a.ml-2\\.5[href="/borrowers"]').should('exist').and('be.visible').click(); // Validate that the borrower's list  is opened
// cy.get('input[id="creditCardNumber"]').should('be.visible').type('12345'); // waits for credit card field to be visible
});
// DELETE BORROWER 
it('should successfully delete a client', () => {
cy.url().should('include', '/borrowers',  { timeout: 10 * 6000 } );
if (cy.contains('Noki Gnocchi')) { 
cy.contains('Noki Gnocchi').parent().within(() => {  
cy.get('[data-testid="DeleteForeverIcon"]').click(); 
});
 cy.wait(500); // Wait for a short period to allow the UI to update after deletion
cy.contains('Noki Gnocchi', { timeout: 5000 }).should('not.exist'); 
} else { cy.log('Client "Noki Gnocchi" not found. Skipping deletion.'); } });

// CREATE PAYMENT 
it('Adding Payments', ()=>{
  cy.get('a[href*="/payments"]').should('exist').and('be.visible').click();
  // cy.xpath('(//a[contains(@href, "/borrowers")])[2]').click();
  cy.get('a[href="/borrowers"]').eq(1).click();// You will be led to add borrower view due to code function
});
// CREATE NEW LOANS
it('Should navigate to the Loans view and create new loan', () => {// Locate and click the Loans view button
cy.get('a[href*="/loans"]').should('exist').and('be.visible').click(); // Validate that the Loans screen is opened
cy.url().should('include', '/loans'); // Check that the URL includes '/loans'
cy.get('.mb-2 > a').click(); // select the Add Loan button 
    // Fill in the loan details
    cy.get('input[name="client_id"]').type('9'); 
    cy.get('#type').select('Personal Loan'); 
    cy.get('#status').select('Approved'); 
    cy.get('input[name="gross_loan"]').type('10000'); 
    cy.get('input[name="balance"]').type('10000'); 
    cy.get('input[name="amort"]').type('30'); 
    cy.get('#terms').type('12'); 
    cy.get('input[name="date_released"]').type('2023-02-04T05:30:01');
    cy.get('input[name="maturity_date"]').type('2025-11-22'); 
    // Submit the loan 
    cy.get('.w-auto').click(); 
    // Verify successful creation (e.g., check for success message, redirect to loan details page)
    cy.get('a[href*="/loans"]').should('exist').and('be.visible').click();
  });
  
});
