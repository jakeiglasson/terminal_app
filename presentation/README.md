**R4 - Provide a link to your source control repository**

https://github.com/jakeiglasson/terminal_app


**Software Development Plan**

**R5 - 	Develop a statement of purpose and scope for your application. It must include:**

	- describe at a high level what the application will do
	- identify the problem it will solve and explain why you are developing it
	- identify the target audience
	- explain how a member of the target audience will use it

The applications purpose is to allow a company to hire out equipment to customers.

The target audience is the workers at the hire company.

The application will enable a user to create a list of customers as well as a list of equipment and write these lists to their respective csv database. 

The user will be able to update the existing equipment database by modifying existing entries (assigning and unassigning equipment to customers), deleteing existing entries and creating new entries.  
  
The user will be able to update the existing customer database by removing existing customers and create new customers.

The user will be able to list all current customers as well as all equipment available for hire.

**R6 - Develop a list of features that will be included in the application. It must include:**

	- at least THREE features
	- describe each feature
	
	Note: 
	
	Ensure that your features allow you to demonstrate your understanding of the following language elements and concepts:
	
	- use of variables and the concept of variable scope
	- loops and conditional control structures
	- error handling

My Features:

1: Create a database with a list of customers or equipment and write to csv

2: modify existing databases from csv

3: list data from existing database csv

**R7 - 	Develop an outline of the user interaction and experience for the application.**

	Your outline must include:  
	
	- how the user will find out how to interact with / use each feature
	- how the user will interact with / use each feature
	- how errors will be handled by the application and displayed to the user

When the app is started ther user is prompted by a menu with selection options labeled with numbers. The user enters the corresponding number to execute the listed command. Prompts are given throughout the program asking the user for input and what that input needs to be.

If the user selects option 1 "create customer" they will be asked to enter the customers name as well as their address.

If the user selects option 2 "create equipment" they will be asked to enter the the name of the equipment and the daily hire price.

if the user selects option 3 "list customers" the terminal will display all current customer entries and the information associated with them including customer generated ID's.

if the user selects option 4 "list equipment" the terminal will display all current equipment entries and the information associated with them including equipment generated ID's.

if the user selects option 5 "remove customer entry from database" the user will be prompted to enter the ID associated with the customer they want to remove, then the customer will be removed.

if the user selects option 6 "remove quipment entry from databse" the user will be prompted to enter the ID associated with the equipment they want to remove, then the equipment will be removed.

if the user selects option 7 "modify quipment status" they will be prompted to enter the ID of the quipment they want to modify, then they will be prompted to modify the "status of the equipment" (entering either hired/available).   
The user is then prompted to enter "Name of person who hired the equipment".   
The user is then prompted to enter "Date equipment was hired: dd/mm/yyyy".   
The user is then prompted to enter "Due back date of the quipment: dd/mm/yyyy".

**R8 - 	Develop a diagram which describes the control flow of your application. Your diagram must:**

	- show the workflow/logic and/or integration of the features in your application for each feature.
	- 
	- utilise a recognised format or set of conventions for a control flow diagram, such as UML.
	

**R10 - Design help documentation which includes a set of instructions which accurately describe how to use and install the application.**

	You must include:
	- steps to install the application
	- any dependencies required by the application to operate
	- any system/hardware requirements


