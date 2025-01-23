# Testing Strategy Summary for Loan Management System Challenge

**Author:** Kanyi

This document outlines a comprehensive testing strategy for the Loan Management System, focusing on the core functionalities:

* Loan Management
* Client Management
* Payments Management

**Testing Approach:**

This strategy combines manual and automated testing techniques to achieve thorough coverage.

* **Manual Testing:**
    * **Test Case Design:** Developed detailed test cases for each feature, covering positive and negative scenarios.
    * **Execution:** Executed the test cases to verify expected behavior and identify any bugs or inconsistencies.
    * **Bug Reporting:** Documented any issues found, including detailed reproduction steps and screenshots.

* **Automated Testing:** E2E Automation:** Implemented automated UI tests using Cypress to validate critical user flows across different screen sizes and browsers.
* **Database Tests:** 
        * **Constraints & Triggers Test:** Verifies the integrity of database constraints and triggers.
        * **CRUD Operations Test:** Validates Create, Read, Update, and Delete operations on database tables.
* **API Automation:**  API tests for the backend using Postman.

**Deliverables:**

1. **Test Case Documents:** A document outlining designed test cases with priority levels.
2. **Bug Report:** A report detailing any bugs found during manual testing, along with reproduction steps and screenshots.
3. **Automated Test Repository:** A repository containing the automated test scripts (UI, API, Database) within the "Files" folder.
4. **Database Testing Summary:** A summary of database testing results and any identified issues. There are 2 Database test cases, one containing  Constraints and Triggers Test, and the other to test crud functions
5. **(Bonus) Performance & Security Testing Plans:** A brief report outlining plans for performance and security testing.

**Project Structure:**

* **"Testing_Artifacts" folder:** Contains all test-related files, including test cases for API, Database, and Client UI Manual test cases and bug report, as well as a test planning document.
* **Source Code Folder:** Contains the application's source code, separate from the "Testing_Artifacts" folder.
* **Cypress Tests:** Located within the source code folder for easy integration with the application.

**Tools Used:**

* **PostgreSQL:** For database testing.
* **Postman:** For API testing.
* **Cypress:** For E2E automation testing.
* **IDE:** Used for code development and testing.

**Challenges Encountered:**

* Bugs and challenges encountered are documented in the manual test case sheets and a dedicated bug report sheet. Screenshots of bugs are also provided in the "Files" folder.
