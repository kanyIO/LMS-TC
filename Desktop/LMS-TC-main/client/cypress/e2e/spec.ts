// describe('Login Functionality Tests', () => {
//   let isLoggedIn: boolean = false;
//   const baseUrl: string = 'http://localhost:3000';

//   beforeEach({ timeout: 60000 }, () => { // Timeout in milliseconds
//     cy.visit(`${baseUrl}/login`);
//     cy.login('admin', 'admin123'); // Assuming cy.login is a custom command
//   });

//   afterEach(() => {
//     cy.get('a[href*="/home"]').should('exist').and('be.visible').click();
//   });

//   it('should visit the clients page and create new borrower', () => {
//     cy.url().should('include', '/borrowers', { timeout: 60000 });
//     cy.get('a[href="/addBorrower"]').should('exist').and('be.visible').click();

//     cy.get('input[name="firstname"]').should('exist').and('be.visible').type('Noki');
//     cy.get('input[name="lastname"]').should('exist').and('be.visible').type('Gnocchi');
//     cy.get('input[name="contactNumber"]').should('exist').and('be.visible').type('0714561810');
//     cy.get('input[name="address"]').should('exist').and('be.visible').type('WoodRock Rd');
//     cy.get('input[name="email"]').should('exist').and('be.visible').type('nokGnocchi@gmail.com');
//     cy.get('input[name="username"]').should('exist').and('be.visible').type('gnocchi');
//     cy.get('button[type="submit"]').should('exist').and('be.visible').click();

//     cy.get('a.ml-2\\.5[href="/borrowers"]').should('exist').and('be.visible').click();
//     // cy.get('input[id="creditCardNumber"]').should('be.visible').type('12345');
//   });

//   it('should successfully delete a client', () => {
//     cy.url().should('include', '/borrowers', { timeout: 60000 });

//     cy.contains('Noki Gnocchi').then(($element) => { // Use .then() to handle the conditional
//       if ($element.length > 0) {
//         cy.wrap($element).parent().within(() => {
//           cy.get('[data-testid="DeleteForeverIcon"]').click();
//         });
//         cy.wait(500);
//         cy.contains('Noki Gnocchi', { timeout: 5000 }).should('not.exist');
//       } else {
//         cy.log('Client "Noki Gnocchi" not found. Skipping deletion.');
//       }
//     });
//   });

//   it('Adding Payments', () => {
//     cy.get('a[href*="/payments"]').should('exist').and('be.visible').click();
//     cy.get('a[href="/borrowers"]').eq(1).click();
//   });

//   it('Should navigate to the Loans view and create new loan', () => {
//     cy.get('a[href*="/loans"]').should('exist').and('be.visible').click();
//     cy.url().should('include', '/loans');
//     cy.get('.mb-2 > a').click();

//     cy.get('input[name="client_id"]').type('9');
//     cy.get('#type').select('Personal Loan');
//     cy.get('#status').select('Approved');
//     cy.get('input[name="gross_loan"]').type('10000');
//     cy.get('input[name="balance"]').type('10000');
//     cy.get('input[name="amort"]').type('30');
//     cy.get('#terms').type('12');
//     cy.get('input[name="date_released"]').type('2023-02-04T05:30:01');
//     cy.get('input[name="maturity_date"]').type('2025-11-22');
//     cy.get('.w-auto').click();

//     cy.get('a[href*="/loans"]').should('exist').and('be.visible').click();
//   });
// });