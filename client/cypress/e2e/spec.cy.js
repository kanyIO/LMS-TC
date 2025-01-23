describe('Login Functionality Tests', () => {
  // Base URL setup in Cypress config file or as a variable
  const baseUrl = 'http://localhost:3000'; // Replace with your application's URL
  
  beforeEach(() => {
    // Visit the login page before each test
    cy.visit(`${baseUrl}/login`);
  });

  it('Logs in successfully with valid credentials', () => {
    // Visit the login page
    cy.visit('http://localhost:3000/login');
    // Wait for the email input to be visible and type in it
    cy.get('input[id="username"]', { timeout: 30000 }).should('be.visible').type('admin');
    // Wait for the password input and type in it
    cy.get('input[id="password"]', { timeout: 30000 }).should('be.visible').type('admin123');
    // Click the submit button
    cy.get('button[type="submit"]').click();
    // Validate successful login
    cy.url().should('include', '/dashboard');
  });
  it('should successfully delete a client', () => {
    cy.login('admin', 'admin123'); 
    // Find the client to delete (e.g., by name or ID)
    cy.contains('Bruce Banner').parent().within(() => { 
      cy.get('[data-testid="DeleteForeverIcon"]').click(); 
    });
    // Confirm deletion (if applicable)
    cy.get('.confirmation-modal').within(() => {
      cy.contains('button', 'Confirm').click(); 
    });
    // Assert that the client is no longer present
    cy.contains('John Doe').should('not.exist'); 
  });
  it('Should navigate to the Loans view and display the Loans screen', () => {
    cy.login('admin', 'admin123'); 
  // Locate and click the Loans view button
  cy.get('a[href="/loans"]') // Adjust this selector to match your Loans button/link
    .should('exist') // Ensure the Loans button exists
    .and('be.visible') // Ensure it is visible
    .click(); // Click to navigate to Loans view

  // Validate that the Loans screen is opened
  cy.url().should('include', '/loans'); // Check that the URL includes '/loans'

  // Validate page title or header
  cy.get('h1') // Assuming the Loans screen has an H1 title
    .should('contain', 'Loans'); // Replace 'Loans' with the actual title text

  // Validate that loans list or table is visible
  cy.get('.loans-list') // Replace with the actual selector for loans list/table
    .should('exist') // Ensure the loans list exists
    .and('be.visible'); // Ensure it is visible
});
});
