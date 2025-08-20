CREATE DATABASE mainframe_override;

-- OBJECTIVE: FIND HACKERS DAD CREDIENTIALS AND LOGIN
-- Provide correct admin credentials to `node mainframe -stop` to shut down the project. 
-- To access EmptyStack's internal data, you will have to find an employee's credentials and log in via `node mainframe`.

-- CLUE: WHAT YOU KNOW… 
-- Forum post created "April 2048" 
-- EmptyStack and their dad, shares same last name"
-- "an active participant in the forum."


CREATE TABLE forum_posts (
-- contains all the posts written on the online forum
	id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    date timestamp(3) without time zone NOT NULL,
    author text NOT NULL
);


-- RESEARCHED THIS FROM GOOGLE
-- https://www.google.com/search?client=safari&rls=en&q=wHERE+psql++find+date+between&ie=UTF-8&oe=UTF-8
-- WHERE date_column BETWEEN 'start_date' AND 'end_date';

-- 1a: REFINE DATE
-- SELECT id, title, date, author
-- FROM forum_posts 
-- WHERE date BETWEEN '2048-04-01' AND '2048-04-30';

-- 1b: DISCOVERED MESSAGE
-- SELECT id, title, date, author
-- FROM forum_posts
-- WHERE id = 'nbZY_'

-- 1c: RETURNED ROW
-- | ID     | TITLE          | DATE                | AUTHOR 
-- | nbZY_  | Get rich fast  | 2048-04-08 00:00:00 | smart-money-44

-- 1d: LOCATED AUTHOR/USERNAME
--? 'smart-money-44'


CREATE TABLE forum_accounts (
-- contains information about the online forum accounts
	username text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL
);

-- 2a: FILTER FROM LOCATED AUTHOR/USERNAME DATA
-- SELECT username, first_name, last_name
-- FROM forum_accounts
-- WHERE username = 'smart-money-44';

-- 2b: RETURNED ROW
-- | USERNAME       | FIRST_NAME    | LAST_NAME
-- | smart-money-44 | Brad          | Steele

-- 2c: LOCATED PERSON
--? 'Steele'

-- 3a: FILTER LAST NAMES
-- SELECT username, first_name, last_name
-- FROM forum_accounts
-- WHERE last_name = 'Steele';

-- 3b: PINPOINTED ROWS
-- | USERNAME        | FIRST_NAME    | LAST_NAME
-- | smart-money-44  | Brad          | Steele
-- | sharp-engine-57 | Andrew        | Steele
-- | stinky-tofu-98  | Kevin         | Steele

-- 3c: RETURNED ACCOUNTS
--? 'sharp-engine-57	Andrew	Steele'
--? 'stinky-tofu-98     Kevin	Steele'
--? 'smart-money-44     Brad	Steele'


CREATE TABLE emptystack_accounts (
-- contains credentials for EmptyStack Solutions employee accounts
	username text NOT NULL,
    password text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL
);

-- IDEA: SYNTAX GUESS
-- SELECT username, password, first_name, last_name
-- FROM emptystack_accounts
-- WHERE last_name = 'Steele' AND first_name = 'Kevin', 'Andrew', 'Brad';
-- DISCOVERED "IN" TO FILTER COLUMNS

-- 4a: FILTER FROM LOCATED ACCOUNT DATA
-- SELECT username, password, first_name, last_name
-- FROM emptystack_accounts
-- WHERE last_name = 'Steele' 
-- OR first_name IN ('Kevin', 'Andrew', 'Brad') 
-- OR username   IN ('smart-money-44', 'stinky-tofu-98', 'sharp-engine-57')

-- 4b: PINPOINTED ROWS
-- | USERNAME           | PASSWORD          | FIRST_NAME  | LAST_NAME
--// | worse-insolence-73	| SJXJhMrH2jqjBJ_	| Brad	      | Smith
-- | triple-cart-38	    | password456       | Andrew	  | Steele
-- | lance-main-11	    | password789       | Lance       | Steele

-- 4c: RETURNED ACCOUNTS
--? 'triple-cart-38    password456	Andrew  Steele'
--? 'lance-main-11     password789	Lance   Steele'

-- 5: LOGIN SUCCESSFUL
-- Welcome, triple-cart-38!
-- Loading messages and projects...
--? Your data has been loaded to emptystack.sql. Have a nice day!

CREATE TABLE emptystack_messages (
-- contains EmptyStack Solutions employee messages
    id text PRIMARY KEY,
    "from" text NOT NULL,
    "to" text NOT NULL,
    subject text NOT NULL,
    body text NOT NULL
);

CREATE TABLE emptystack_projects (
-- contains EmptyStack Solutions project credentials
    id text PRIMARY KEY,
    code text NOT NULL
);


-- 6a: FILTER FROM WORDS "TAXI", "PROJECT", OR "SELF-DRIVING"
-- IDEA: INITIAL ATTEMPT
-- SELECT *
-- FROM emptystack_messages
-- WHERE subject = 'Project';

-- DISCOVERED ROWS WITH COPY NEED "ILIKE '%COPY%'" - BAD :-(
-- SELECT *
-- FROM emptystack_messages
-- WHERE subject ILIKE '%Project%';

-- ALT DISCOVERY "~* 'COPY'" - SIMPLE :-)
-- SELECT *
-- FROM emptystack_messages
-- WHERE subject ~* 'project';

-- 6b: PINPOINTED ROWS
-- | ID    | FROM         | TO              | SUBJECT       | BODY
-- | LidWj | your-boss-99 |	triple-cart-38	| Project TAXI  | Deploy Project TAXI by end of week. We need this out ASAP.

-- 6c: RETURN "SENDER"
--? 'your-boss-99 Deploy Project "TAXI" ...'

-- 7a: FILTER FROM SENDER DATA
-- SELECT *
-- FROM emptystack_accounts
-- WHERE username = 'your-boss-99';

-- 7b: PINPOINTED ROWS
-- | ID             | PASSWORD          | FIRST_NAME    | LAST_NAME
-- | your-boss-99	| notagaincarter	| Skylar        | Singer

-- 7c: RETURN "PASSWORD"
--? 'notagaincarter'

-- 8a FILTER FROM SENDER DATA "TAXI"
-- SELECT *
-- FROM emptystack_projects
-- WHERE code = 'TAXI';

-- 8b: PINPOINTED ROWS
-- | ID         | CODE    
-- | DczE0v2b	| TAXI

-- 8c: RETURN "ID"
--? 'DczE0v2b'

-- 9: TERMINATE SUCCESSFUL
-- WARNING: admin access required. Unauthorized access will be logged.
-- Username: your-boss-99
-- Password: notagaincarter
-- Welcome, your-boss-99.
-- Project ID: DczE0v2b
-- Initiating project shutdown sequence...
-- 5...
-- 4...
-- 3...
-- 2...
-- 1...
-- Project shutdown complete.