# 56. Database Sample Schemas

> 源文件: `en/comsc/database-sample-schemas.pdf`

Oracle® Database
Database Sample Schemas




   19c
   E96482-02
   November 2019
Oracle Database Database Sample Schemas, 19c

E96482-02

Copyright © 2002, 2019, Oracle and/or its affiliates. All rights reserved.

Primary Author: Lavanya Jayapalan

Contributing Authors: Apoorva Srinivas, Amith R. Kumar, Tulika Das, Roza Leyderman, David Austin ,
Christian Bauwens, Vimmika Dinesh, Mark Drake, Nancy Greenberg, Deepti Kamal, Diana Lorentz, Nagavalli
Pataballa

This software and related documentation are provided under a license agreement containing restrictions on
use and disclosure and are protected by intellectual property laws. Except as expressly permitted in your
license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify,
license, transmit, distribute, exhibit, perform, publish, or display any part, in any form, or by any means.
Reverse engineering, disassembly, or decompilation of this software, unless required by law for
interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If
you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on
behalf of the U.S. Government, then the following notice is applicable:

U.S. GOVERNMENT END USERS: Oracle programs, including any operating system, integrated software,
any programs installed on the hardware, and/or documentation, delivered to U.S. Government end users are
"commercial computer software" pursuant to the applicable Federal Acquisition Regulation and agency-
specific supplemental regulations. As such, use, duplication, disclosure, modification, and adaptation of the
programs, including any operating system, integrated software, any programs installed on the hardware,
and/or documentation, shall be subject to license terms and license restrictions applicable to the programs.
No other rights are granted to the U.S. Government.

This software or hardware is developed for general use in a variety of information management applications.
It is not developed or intended for use in any inherently dangerous applications, including applications that
may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you
shall be responsible to take all appropriate fail-safe, backup, redundancy, and other measures to ensure its
safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by use of this
software or hardware in dangerous applications.

Oracle and Java are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of
their respective owners.

Intel and Intel Xeon are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are
used under license and are trademarks or registered trademarks of SPARC International, Inc. AMD, Opteron,
the AMD logo, and the AMD Opteron logo are trademarks or registered trademarks of Advanced Micro
Devices. UNIX is a registered trademark of The Open Group.

This software or hardware and documentation may provide access to or information about content, products,
and services from third parties. Oracle Corporation and its affiliates are not responsible for and expressly
disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise
set forth in an applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not be
responsible for any loss, costs, or damages incurred due to your access to or use of third-party content,
products, or services, except as set forth in an applicable agreement between you and Oracle.
Contents
    Preface
    Audience                                                                    viii
    Documentation Accessibility                                                 viii
    Related Documents                                                           viii
    Conventions                                                                 viii



1   Introduction to Sample Schemas
    1.1     About the Sample Schemas                                            1-1
    1.2     Design Principles for Sample Schemas                                1-1
    1.3     Customer Benefits of Sample Schemas                                 1-2
    1.4     Overview of the Sample Schemas                                      1-2
          1.4.1   HR Sample Schema                                              1-2
          1.4.2   OE Sample Schema                                              1-3
          1.4.3   OC Sample Schema                                              1-4
          1.4.4   PM Sample Schema                                              1-4
          1.4.5   IX Sample Schema                                              1-4
          1.4.6   SH Sample Schema                                              1-5
          1.4.7   CO Sample Schema                                              1-5



2   Installing Sample Schemas
    2.1     Installing HR Schema Only                                           2-1
          2.1.1   Installing HR Schema Using Database Configuration Assistant   2-1
          2.1.2   Manually Installing the HR Schema                             2-2
          2.1.3   Uninstalling HR Schema                                        2-3
    2.2     Installing Sample Schemas from GitHub                               2-3
          2.2.1   Resetting Sample Schemas                                      2-4
          2.2.2   Uninstalling Sample Schemas                                   2-4
    2.3     Installing CO schema                                                2-5




                                                                                 iii
3   Schema Diagrams
    3.1     Sample Schema Diagrams                   3-1



4   Sample Schema Scripts and Object Descriptions
    4.1     Master Script for Sample Schemas         4-1
          4.1.1    mksample.sql                      4-1
    4.2     HR Sample Schema Scripts and Objects     4-4
    4.3     HR Sample Schema Table Descriptions      4-5
          4.3.1    Table HR.COUNTRIES                4-5
          4.3.2    Table HR.DEPARTMENTS              4-5
          4.3.3    Table HR.EMPLOYEES                4-6
          4.3.4    Table HR.JOBS                     4-6
          4.3.5    Table HR.JOB_HISTORY              4-6
          4.3.6    Table HR.LOCATIONS                4-7
          4.3.7    Table HR.REGIONS                  4-7
    4.4     OE Sample Schema Scripts and Objects     4-7
    4.5     OE Sample Schema Table Descriptions      4-9
          4.5.1    Table OE.CUSTOMERS                4-9
          4.5.2    Table OE.INVENTORIES             4-10
          4.5.3    Table OE.ORDERS                  4-10
          4.5.4    Table OE.ORDER_ITEMS             4-11
          4.5.5    Table OE.PRODUCT_DESCRIPTIONS    4-11
          4.5.6    Table OE.PRODUCT_INFORMATION     4-11
          4.5.7    Table OE.WAREHOUSES              4-12
          4.5.8    Table OE.PURCHASEORDER           4-12
    4.6     PM Sample Schema Scripts and Objects    4-12
    4.7     PM Sample Schema Table Descriptions     4-13
          4.7.1    Table PM.PRINT_MEDIA             4-13
    4.8     IX Sample Schema Scripts and Objects    4-14
    4.9     IX Sample Schema Table Descriptions     4-15
          4.9.1    Table IX.ORDERS_QUEUETABLE       4-15
          4.9.2    Table IX.STREAMS_QUEUE_TABLE     4-16
    4.10     SH Sample Schema Scripts and Objects   4-17
    4.11     SH Sample Schema Table Descriptions    4-18
          4.11.1    Table SH.CHANNELS               4-18
          4.11.2    Table SH.COSTS                  4-18
          4.11.3    Table SH.COUNTRIES              4-19
          4.11.4    Table SH.CUSTOMERS              4-19
          4.11.5    Table SH.PRODUCTS               4-20
          4.11.6    Table SH.PROMOTIONS             4-21



                                                      iv
   4.11.7   Table SH.SALES                    4-21
   4.11.8   Table SH.TIMES                    4-22
4.12   CO Sample Schema Scripts and Objects   4-23
4.13   CO Sample Schema Table Descriptions    4-24
   4.13.1   Table CO.CUSTOMERS                4-24
   4.13.2   Table CO.STORES                   4-24
   4.13.3   Table CO.PRODUCTS                 4-25
   4.13.4   Table CO.ORDERS                   4-25
   4.13.5   Table CO.ORDER_ITEMS              4-26


Index




                                                v
List of Tables
4-1    HR Sample Schema Scripts                     4-4
4-2    HR Sample Schema Objects                     4-4
4-3    HR.COUNTRIES Table Description               4-5
4-4    HR.DEPARTMENTS Table Description             4-5
4-5    HR.EMPLOYEES Table Description               4-6
4-6    HR.JOBS Table Description                    4-6
4-7    HR.JOB_HISTORY Table Description             4-6
4-8    HR.LOCATIONS Table Description               4-7
4-9    HR.REGIONS Table Description                 4-7
4-10   OE Sample Schema Scripts                     4-7
4-11   OE Sample Schema Objects                     4-8
4-12   OE.CUSTOMERS Table Description               4-9
4-13   OE.INVENTORIES Table Description            4-10
4-14   OE.ORDERS Table Description                 4-10
4-15   OE.ORDER_ITEMS Table Description            4-11
4-16   OE.PRODUCT_DESCRIPTIONS Table Description   4-11
4-17   OE.PRODUCT_INFORMATION Table Description    4-11
4-18   OE.WAREHOUSES Table Description             4-12
4-19   PM Schema Scripts                           4-13
4-20   PM Sample Schema Objects                    4-13
4-21   PM.PRINT_MEDIA Table Description            4-13
4-22   IX Sample Schema Scripts                    4-14
4-23   IX Sample Schema Objects                    4-14
4-24   IX.ORDERS_QUEUETABLE Table Description      4-15
4-25   IX.STREAMS_QUEUE_TABLE Table Description    4-16
4-26   SH Sample Schema Scripts                    4-17
4-27   SH Sample Schema Objects                    4-17
4-28   SH.CHANNELS Table Description               4-18
4-29   SH.COSTS Table Description                  4-18
4-30   SH.COUNTRIES Table Description              4-19
4-31   SH.CUSTOMERS Table Description              4-19
4-32   SH.PRODUCTS Table Description               4-20
4-33   SH.PROMOTIONS Table Description             4-21
4-34   SH.SALES Table Description                  4-21
4-35   SH.TIMES Table Description                  4-22




                                                     vi
4-36   CO Sample Schema Scripts                 4-23
4-37   CO Sample Schema Objects                 4-24
4-38   CO.CUSTOMERS Table Description           4-24
4-39   Table CO.STORES Table Description        4-25
4-40   Table CO.PRODUCTS Table Description      4-25
4-41   Table CO.ORDERS Table Description        4-26
4-42   Table CO.ORDER_ITEMS Table Description   4-26




                                                 vii
                                                                                           Preface




Preface
           This guide is a primary source of information about the sample database schemas that
           are used for examples in Oracle Database documentation.
           This preface contains the following topics:
           •   Audience
           •   Related Documents
           •   Conventions


Audience
           This document is intended for all users of the seed database, which is installed when
           you install Oracle Database.


Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the Oracle
           Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
           ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support
           through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
           lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
           if you are hearing impaired.


Related Documents
           This guide does not discuss specific programming examples that use data in the
           sample schemas; see the Oracle Database documentation library for specific books
           that discuss the technology that you are using.
           Sample database schema OE contains tables that use SQL data type XMLType. For
           information about the use of such data, see Oracle XML DB Developer's Guide.


Conventions
           The following text conventions are used in this document:




                                                                                               viii
                                                                                 Preface




Convention   Meaning
boldface     Boldface type indicates graphical user interface elements associated
             with an action, or terms defined in text or the glossary.
italic       Italic type indicates book titles, emphasis, or placeholder variables for
             which you supply particular values.
monospace    Monospace type indicates commands within a paragraph, URLs, code
             in examples, text that appears on the screen, or text that you enter.




                                                                                         ix
1
Introduction to Sample Schemas
         For many years, Oracle used the simple database schema SCOTT, with its two
         prominent tables EMP and DEPT, for various examples in documentation and training.
         These tables are inadequate to show the basic features of Oracle Database and other
         Oracle products. The sample database schemas can be used for product
         documentation, courseware, software development, and application demos.


1.1 About the Sample Schemas
         The sample database schemas provide a common platform for examples in each
         release of the Oracle Database. The sample schemas are a set of interlinked
         database schemas. This set provides approach to complexity:
         •   Schema Human Resources (HR) is useful for introducing basic topics. An
             extension to this schema supports Oracle Internet Directory demos.
         •   Schema Order Entry (OE) is useful for dealing with matters of intermediate
             complexity. Many data types are available in this schema, including nonscalar data
             types.
         •   Schema Online Catalog (OC) is a collection of object-relational database objects
             built inside schema OE.
         •   Schema Product Media (PM) is dedicated to print media data types.
         •   A set of schemas gathered under the main schema name Information Exchange
             (IX) can be used to demonstrate Oracle Advanced Queuing capabilities.
         •   Schema Sales History (SH) is designed to allow for demos with large amounts of
             data. An extension to this schema provides support for advanced analytic
             processing.
         •   Schema Customer Orders (CO) is a modern schema useful for demos of e-
             commerce transactions. It allows the storage of semi-structured data using JSON.


1.2 Design Principles for Sample Schemas
         The sample database schemas have been created with the following design principles
         in mind:
         •   Simplicity and ease of use. Schemas HR and OE are intentionally simple. They
             provide a graduated path from simple to intermediate levels of database use.
         •   Relevance for typical users. The base schemas and their extensions bring to the
             foreground the functionality that customers typically use. Only the most commonly
             used database objects are built automatically in the schemas. The entire set of
             schemas provides a foundation upon which one can expand to illustrate additional
             functionality.
         •   Extensibility. The sample schemas provide a logical and physical foundation for
             adding objects to demonstrate functionality beyond the fundamental scope.




                                                                                            1-1
                                                                                             Chapter 1
                                                                Customer Benefits of Sample Schemas


          •   Relevance. The sample schemas are designed to be applicable to e-business and
              other significant industry trends (for example, XML). When this goal conflicts with
              the goal of simplicity, schema extensions are used to showcase the trends in
              focus.


1.3 Customer Benefits of Sample Schemas
          Benefits provided by the sample schemas include the following:
          •   Continuity of context. When encountering the same set of tables everywhere,
              users, students, and developers can spend less time becoming familiar with the
              schema and more time understanding or explaining the technical concepts.
          •   Usability. Customers can use these schemas in the seed database to run
              examples that are shown in Oracle Database documentation and training
              materials. This first-hand access to examples facilitates both conceptual
              understanding and application development.
          •   Quality. Through central maintenance and testing of both the creation scripts that
              build the sample schemas and the examples that run against the schemas, the
              quality of Oracle Database documentation and training materials is enhanced.


1.4 Overview of the Sample Schemas
          The Oracle Database sample schemas are based on a fictitious sample company that
          sells goods through various channels. The company operates worldwide to fill orders
          for products. It has several divisions, each of which is represented by a sample
          database schema.
          Topics:
          •   Schema HR – Division Human Resources tracks information about the company
              employees and facilities.
          •   Schema OE – Division Order Entry tracks product inventories and sales of
              company products through various channels.
          •   Schema PM – Division Product Media maintains descriptions and detailed
              information about each product sold by the company.
          •   Schema IX – Division Information Exchange manages shipping through B2B
              applications.
          •   Schema SH – Division Sales tracks business statistics to facilitate business
              decisions.
          •   Schema CO - Division Customer Orders models a simple retail application
              consisting of customer, product, store and order data.


1.4.1 HR Sample Schema
          In the Human Resource (HR) records, each employee has an identification number, e-
          mail address, job identification code, salary, and manager. Some employees earn
          commissions in addition to their salary.
          The company also tracks information about jobs within the organization. Each job has
          an identification code, job title, and a minimum and maximum salary range for the job.
          Some employees have been with the company for a long time and have held different



                                                                                                 1-2
                                                                                             Chapter 1
                                                                       Overview of the Sample Schemas


          positions within the company. When an employee resigns, the duration the employee
          was working, the job identification number, and the department are recorded.
          The sample company is regionally diverse, so it tracks the locations of its warehouses
          and departments. Each employee is assigned to a department, and each department
          is identified either by a unique department number or a short name. Each department
          is associated with one location, and each location has a full address that includes the
          street name, postal code, city, state or province, and the country code.
          In places where the departments and warehouses are located, the company records
          details such as the country name, currency symbol, currency name, and the region
          where the country is located geographically.


1.4.2 OE Sample Schema
          The company sells several products, such as computer hardware and software, music,
          clothing, and tools. The company maintains information about these products, such as
          product identification numbers, the category into which the product falls, order entry
          (OE), the weight group (for shipping purposes), the warranty period if applicable, the
          supplier, the availability status of the product, a list price, a minimum price at which a
          product will be sold, and a URL address for manufacturer information. Inventory
          information is also recorded for all products, including the warehouse where the
          product is available and the quantity on hand. Because products are sold worldwide,
          the company maintains the names of the products and their descriptions in several
          languages.
          The company maintains warehouses in several locations to fulfill customer needs.
          Each warehouse has a warehouse identification number, name, facility description,
          and location identification number.
          Customer information is also tracked. Each customer has an identification number.
          Customer records include customer name, street name, city or province, country,
          phone numbers (up to five phone numbers for each customer), and postal code. Some
          customers place orders through the Internet, so e-mail addresses are also recorded.
          Because of language differences among customers, the company records the native
          language and territory of each customer.
          The company places a credit limit on its customers, to limit the amount of products
          they can purchase at one time. Some customers have an account manager, and this
          information is also recorded.
          When a customer places an order, the company tracks the date of the order, how the
          order was placed, the current status of the order, shipping mode, total amount of the
          order, and the sales representative who helped place the order. The sales
          representative may or may not be the same person as the account manager for a
          customer. If an order is placed over the Internet, no sales representative is recorded.
          In addition to order information, the company also tracks the number of items ordered,
          the unit price, and the products ordered.
          Schema OE also contains XML purchase-order documents. These are stored in Oracle
          XML DB Repository after validation against the registered XML schema
          purchaseorder.xsd. You can access these documents in various ways, such as by
          querying table purchaseorder using SQL, querying public views RESOURCE_VIEW and
          PATH_VIEW, and querying the repository using XPath expressions.




                                                                                                 1-3
                                                                                           Chapter 1
                                                                     Overview of the Sample Schemas


          The purchase-order XML documents are located in Oracle XML DB Repository
          folder $ORACLE_HOME/rdbms/demo/order_entry/2002/month, where month is a three-
          letter month abbreviation (for example, Jan, Feb, Mar).


1.4.3 OC Sample Schema
          The Online Catalog (OC) subschema of database schema OE addresses an online
          catalog merchandising scenario. The same customers and products are used in OC as
          in schema OE proper, but subschema OC organizes the products into a hierarchy of
          parent categories and subcategories. This hierarchy corresponds to the arrangement
          on an e-commerce portal site, where users navigate to specific products by drilling
          down through increasingly specialized categories of products.


1.4.4 PM Sample Schema
          The company stores print information about its products in a database. The Product
          Media (PM) schema is used to store such information. Examples of such information
          are:
          •   Press release texts
          •   Print media advertisements
          •   Other promotional texts and translations


1.4.5 IX Sample Schema
          The company has decided to test the use of messaging to manage its proposed B2B
          applications. The plan calls for a small test that will allow a user from outside the
          firewall to place an order and track its status. The order must be booked into the main
          system. Then, depending on the location of the customer, the order is routed to the
          nearest region for shipping. The Information Exchange (IX) schema stores such
          information.
          Eventually, the company intends to expand beyond its current in-house distribution
          system to a system that will allow other businesses to provide the shipping. The
          messages sent must be in a self-contained format. XML is the perfect format for
          sending messages, and both Advanced Queuing Servlet and Oracle Internet Directory
          provide the required routing between the queues.
          After the orders are either shipped or back ordered, a message must be sent back to
          the employee concerned to inform about the status of the order and to initiate the
          billing. It is important that the message be delivered only once and that there be a
          system for tracking and reviewing messages to facilitate resolution of any
          discrepancies with the order.
          For the purpose of this test application, the company uses a database server and an
          application server. The application provides a mechanism for examining the XML
          messages as well as monitoring the queues. To demonstrate connectivity from outside
          the firewall, both the generation of a new order and customer service reporting are
          performed using queues. The new order application directly enables a queue, while
          the customer service queries require XML messaging to disable a queue.




                                                                                               1-4
                                                                                            Chapter 1
                                                                      Overview of the Sample Schemas




1.4.6 SH Sample Schema
          The sample company does a high volume of business, so it runs business statistics
          reports to aid in decision making. Many of these reports are time-based and
          nonvolatile. That is, they analyze past data trends. The company loads data into its
          data warehouse regularly to gather statistics for these reports. These reports include
          annual, quarterly, monthly, and weekly sales figures by product. These reports are
          stored with the help of schema Sales History (SH).

          The company also runs reports on distribution channels through which its sales are
          delivered. When the company runs special promotions on its products, it analyzes the
          impact of the promotions on sales. It also analyzes sales by geographical area.


1.4.7 CO Sample Schema
          The Customer Orders (CO) schema records the details of transactions made by a
          retail application.
          The CO schema is similar in concept to the OE schema. The CO schema is modern
          and highlights the features of Oracle database 12c such as JSON support.
          The company sells a variety of products which is maintained in the products table.
          Each product has a unique identification number, name, price, details stored in a
          JSON object and product image details.
          The orders placed by the customer is tracked using the order identification number,
          date and time when the order was placed, customer details, order status and the store
          information.
          The details of the products in a particular order is also tracked using the order
          identification number. Details of the product(s), price at the time of purchase and
          quantity are recorded.
          The information of a customer placing an order is tracked. Each customer has an
          identification number, name and email address which is used for communication of the
          orders.
          The customers can purchase the products in stores or online through the company's
          website. The company stores the information of all the stores and their corresponding
          physical and virtual addresses. The information of the store is also recorded in the
          order details.




                                                                                                1-5
2
Installing Sample Schemas
           Starting with Oracle Database 12c Release 2, the latest version of the sample schema
           scripts are available on GitHub at https://github.com/oracle/db-sample-schemas/
           releases/latest.
           During a complete installation of Oracle Database, the HR schema can be installed
           either manually or automatically when creating a database using the dbca option. All
           the other sample schemas must be installed manually via the scripts available on
           GitHub.
           This chapter contains the following topics:
           •   Installing HR Schema Only
           •   Installing Sample Schemas from GitHub



                  Note:
                  By installing any of the Oracle Database sample schemas, you will drop any
                  previously installed schemas that use the following user names: HR, OE, PM,
                  SH, IX, BI.

                  Data contained in any of these schemas will be lost if you run any of the
                  installation scripts described in this section. You should not use the sample
                  schemas for your personal or business data and applications. They are
                  meant to be used for demonstration purposes only.




2.1 Installing HR Schema Only
           This section contains the following topics:
           •   Installing HR Schema Using Database Configuration Assistant
           •   Manually Installing the HR Schema
           •   Uninstalling HR Schema


2.1.1 Installing HR Schema Using Database Configuration Assistant
           Select the sample schemas option to install HR schema in the database.

           At the end of the installation process, a dialog box displays the accounts that have
           been created and their lock status. By default, sample schemas are locked and their
           passwords are expired. Before you can use a locked account, you must unlock it and
           reset its password. You can unlock the accounts at this point in the installation
           process. Alternatively, after the installation completes, you can unlock the schemas




                                                                                                  2-1
                                                                                             Chapter 2
                                                                             Installing HR Schema Only


           and reset their passwords by using the ALTER USER ... ACCOUNT UNLOCK statement.
           For example:
           ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY Password;



                   See Also:
                   "Guidelines for Securing Passwords" in Oracle Database Security Guide for
                   guidelines related to creating secure passwords



2.1.2 Manually Installing the HR Schema
           All scripts necessary to create the Human Resource (HR) schema reside
           in $ORACLE_HOME/demo/schema/human_resources.

           You need to call only one script, hr_main.sql, to create all the objects and load the
           data. The following steps provide a summary of the installation process:
           1.   Log on to SQL*Plus as SYS and connect using the AS SYSDBA privilege.
                sqlplus connect sys as sysdba
                Enter password: password

           2.   To run the hr_main.sql script, use the following command:
                SQL> @?/demo/schema/human_resources/hr_main.sql
           3.   Enter a secure password for HR
                specify password for HR as parameter 1:
                Enter value for 1:

                Enter an appropriate tablespace, for example, users as the default tablespace for
                HR
                specify default tablespace for HR as parameter 2:
                Enter value for 2:
           4.   Enter temp as the temporary tablespace for HR
                specify temporary tablespace for HR as parameter 3:
                Enter value for 3:
           5.   Enter your SYS password
                specify password for SYS as parameter 4:
                Enter value for 4:
           6.   Enter the directory path, for example, $ORACLE_HOME/demo/schema/log/, for your
                log directory
                specify log path as parameter 5:
                Enter value for 5:
           After script hr_main.sql runs successfully and schema HR is installed, you are
           connected as user HR. To verify that the schema was created, use the following
           command:
           SQL> SELECT table_name FROM user_tables;




                                                                                                   2-2
                                                                                                Chapter 2
                                                                    Installing Sample Schemas from GitHub


           Running hr_main.sql accomplishes the following tasks:

           1.   Removes any previously installed HR schema
           2.   Creates user HR and grants the necessary privileges
           3.   Connects as HR
           4.   Calls the scripts that create and populate the schema objects
           For a complete listing of the scripts and their functions, refer to HR Sample Schema
           Scripts and Objects.
           A pair of optional scripts, hr_dn_c.sql and hr_dn_d.sql, is provided as a schema
           extension. To prepare schema HR for use with the directory capabilities of Oracle
           Internet Directory, run the hr_dn_c.sql script. If you want to return to the initial setup
           of schema HR, use script hr_dn_d.sql to undo the effects of script hr_dn_c.sql.

           You can use script hr_drop.sql to drop schema HR.



                   See Also:
                   Oracle Database Security Guide for the minimum password requirements



2.1.3 Uninstalling HR Schema
           If you need to remove the HR schema, run the following script on the SQL* Plus
           command line.

           sqlplus system/systempw@connect_string
           @drop_hr.sql



2.2 Installing Sample Schemas from GitHub
           Starting with Oracle Database 12c Release 2, only the HR sample schema SQL scripts
           are available in the $ORACLE_HOME/demo/schema/human_resources directory. If
           you want to use sample schemas other than HR, such as OE, OC, PM, and SH
           schemas, you must download them from the GitHub repository.
           The procedure to install sample schemas from GitHub is as follows:
           1.   To find the latest version of the sample schemas installation scripts, go to the
                following GitHub web site : https://github.com/oracle/db-sample-schemas/releases/
                latest
                For example, If you want a 12.2.0.1 version of the scripts, then go to https://
                github.com/oracle/db-sample-schemas/releases/tag/v12.2.0.1
           2.   Clone the GitHub repository, or download the ZIP bundle from GitHub and extract
                the files.
           3.   Unzip the file.
           4.   Follow the instructions to create the schemas in the README contained in the zip
                file.




                                                                                                    2-3
                                                                                               Chapter 2
                                                                   Installing Sample Schemas from GitHub


           This section includes the following topics:
           •   Resetting Sample Schemas
           •   Uninstalling Sample Schemas


2.2.1 Resetting Sample Schemas
           To reset sample schemas to their initial state, use the following syntax from the
           SQL*Plus command-line interface:
           sqlplus system/systempw@connect_string
           @mksample systempw syspw hrpw oepw pmpw ixpw shpw bipw users temp /your/path/to/log/
           connect_string

           The mksample script expects 11 parameters. Provide the password for SYSTEM and SYS,
           and for schemas HR, OE, PM, IX, and SH. Specify a temporary and a default tablespace,
           and make sure to end the name of the log file directory with a trailing slash.
           The mksample script produces several log files:

           •   mkverify.log is the Sample Schema creation log file.
           •   hr_main.log is the HR schema creation log file.
           •   oe_oc_main.log is the OE schema creation log file.
           •   pm_main.log is the PM schema creation log file.
           •   pm_p_lob.log is the SQL*Loader log file for PM.PRINT_MEDIA.
           •   ix_main.log is the IX schema creation log file.
           •   sh_main.log is the SH schema creation log file.
           •   cust.log is the SQL*Loader log file for SH.CUSTOMERS.
           •   prod.log is the SQL*Loader log file for SH.PRODUCTS.
           •   promo.log is the SQL*Loader log file for SH.PROMOTIONS.
           •   sales.log is the SQL*Loader log file for SH.SALES.
           •   sales_ext.log is the external table log file for SH.COSTS.
           In most situations, there is no difference between installing a Sample Schema for the
           first time or reinstalling it over a previously installed version. The *_main.sql scripts
           drop the schema users and all of their objects.


2.2.2 Uninstalling Sample Schemas
           If you need to remove the sample schemas from the installation, run script
           drop_sch.sql on the SQL*Plus command line. This script ships with Oracle Database.

           This script uses the following parameters:
           •   systempwd
           •   SYSTEM
           •   connect_string

           The systempwd is the password for SYSTEM user and connect_string is the connection
           string of the database.



                                                                                                   2-4
                                                                                          Chapter 2
                                                                               Installing CO schema


         Example 2-1      How to Uninstall Sample Schemas
         sqlplus system/systempw@connect_string
         @drop_sch.sql


2.3 Installing CO schema
         Currently, CO schema cannot be installed along with the other schema using the
         mksample script. Install the CO schema independently from GitHub.
         The steps to install CO schema from GitHub is as follows:
         1.   Go to the GitHub web site: https://github.com/oracle/db-sample-schemas/
              releases/tag/v19.2
         2.   Clone the GitHub repository, or download the ZIP bundle from GitHub and extract
              the files.
         3.   Unzip the file.
         4.   Follow the instructions to create the schema in README.txt contained in the zip
              file.
         5.   Review co_install.log in the extracted zip folder for errors.
         6.   To verify that the schema was created, use the following command:
              SQL> SELECT table_name FROM user_tables;
         7.   To remove the CO schema, run the following script to drop the CO user:
              SQL> @co_drop_user.sql



                 Note:

                 •   The Customer Orders(CO) schema is available from Oracle Database
                     12c onwards.
                 •   The master script @mksample currently does not include the CO schema.




                                                                                                2-5
3
Schema Diagrams
        Examine the diagrams of the sample database schemas.


3.1 Sample Schema Diagrams
        Figure 3-1 illustrates sample schemas HR and OE and their relationship. The scripts and
        table descriptions for these schemas are in section "HR Schema" and "OE Schema",
        respectively.
        Figure 3-2 illustrates schema PM. The scripts and table description for schema PM are
        at "PM Schema".
        Figure 3-3 illustrates schema SH. The scripts and table description for schema SH are
        in section "SH Schema".
        This edition of the book does not illustrate schema IX, but its scripts and table
        description are in section "IX Schema".
        Figure 3-4 illustrates schema CO. The scripts and table description for schema CO are
        in section "CO Schema"




                                                                                            3-1
                                                                                  Chapter 3
                                                                    Sample Schema Diagrams


Figure 3-1    Sample Schemas HR and OE

             HR                     DEPARTMENTS               LOCATIONS
                                     department_id             location_id
                                   department_name           street_address
                                      manager_id              postal_code
                                      location_id                  city
              JOB_HISTORY                                    state_province
                employee_id                                     country_id
                 start_date
                 end_date             EMPLOYEES
                   job_id              employee_id
               department_id            first_name            COUNTRIES
                                        last_name              country_id
                                            email            country_name
                                     phone_number               region_id
                                         hire_date
                    JOBS                   job_id
                    job_id                 salary
                   job_title         commission_pct            REGIONS
                  min_salary           manager_id              region_id
                  max_salary          department_id          region_name



             OE
              ORDER_ITEMS               ORDERS               CUSTOMERS
                  order_id              order_id               customer_id
               line_item_id            order_date           cust_first_name
                 product_id           order_mode            cust_last_name
                 unit_price           customer_id            cust_address
                  quantity            order_status          phone_numbers
                                       order_total           nls_language
                                      sales_rep_id             nls_territory
                                      promotion_id              credit_limit
                                                                cust_email
                 PRODUCT_                                   account_mgr_id
               INFORMATION              PRODUCT_            cust_geo_location
                                     DESCRIPTIONS            date_of_birth
                  product_id             product_id          marital_status
                product_name            language_id               gender
             product_description     translated_name          income_level
                 category_id       translated_description
                 weight_class
               warranty_period                               WAREHOUSES
                  supplier_id                                 warehouse_id
                product_status       INVENTORIES            warehouse_spec
                   list_price          product_id           warehouse_name
                   min_price          warehouse_id             location_id
                  catalog_url       quantity_on_hand        wh_geo_location




                                                                                      3-2
                                                        Chapter 3
                                          Sample Schema Diagrams


Figure 3-2     Sample Schemas OE and PM

OE

 PRODUCT_INFORMATION

             product_id
                 ...




PM

       PRINT_MEDIA
          product_id
             ad_id
        ad_composite
        ad_sourcetext
         ad_finaltext
           ad_fltextn
       ad_textdocs_ntab
           ad_photo
          ad_graphic
          ad_header




                                                            3-3
                                                                                 Chapter 3
                                                               Sample Schema Diagrams


Figure 3-3    Sample Schema SH

 SH
                                    PROMOTIONS                      TIMES
                COSTS                     promo_id                          time_id
                 prod_id                promo_name                       day_name
                 time_id            promo_subcategory          day_number_in_week
                promo_id           promo_subcategory_id       day_number_in_month
               channel_id             promo_category         calendar_week_number
                unit_cost            promo_category_id          fiscal_week_number
                unit_price               promo_cost               week_ending_day
                                     promo_begin_date           week_ending_day_id
                                      promo_end_date         calendar_month_number
                                         promo_total           fiscal_month_number
                                       promo_total_id          calendar_month_desc
             PRODUCTS                                            calendar_month_id
                                                                  fiscal_month_desc
                  prod_id                                            fiscal_month_id
                prod_name                                        days_in_cal_month
                 prod_desc              SALES                     days_in_fis_month
           prod_subcategory                                       end_of_cal_month
                                          prod_id
          prod_subcategory_id                                      end_of_fis_month
                                          cust_id
        prod_subcategory_desc                                 calendar_month_name
                                          time_id
              prod_category                                      fiscal_month_name
                                        channel_id
            prod_category_id                                  calendar_quarter_desc
                                         promo_id
          prod_category_desc                                     calendar_quarter_id
                                       quantity_sold
           prod_weight_class                                     fiscal_quarter_desc
                                       amount_sold
         prod_unit_of_measure                                       fiscal_quarter_id
             prod_pack_size                                     days_in_cal_quarter
                supplier_id                                      days_in_fis_quarter
                prod_status                                      end_of_cal_quarter
              prod_list_price                                     end_of_fis_quarter
             prod_min_price          CUSTOMERS              calendar_quarter_number
                 prod_total                cust_id            fiscal_quarter_number
               prod_total_id                                          calendar_year
                                      cust_first_name
               prod_src_id                                         calendar_year_id
                                      cust_last_name
              prod_eff_from                                              fiscal_year
                                        cust_gender
                prod_eff_to                                            fiscal_year_id
                                     cust_year_of_birth
                 prod_valid                                        days_in_cal_year
                                    cust_marital_status
                                    cust_street_address            days_in_fis_year
                                     cust_postal_code               end_of_cal_year
                                          cust_city                 end_of_fis_year
                                        cust_city_id
             CHANNELS               cust_state_province
                channel_id         cust_state_province_id
              channel_desc               country_id             COUNTRIES
              channel_class      cust_main_phone_number             country_id
             channel_class_id        cust_income_level          country_iso_code
               channel_total          cust_credit_limit           country_name
             channel_total_id            cust_email            country_subregion
                                          cust_total          country_subregion_id
                                        cust_total_id             country_region
                                         cust_src_id           country_region_id
                                       cust_eff_from               country_total
                                         cust_eff_to             country_total_id
                                          cust_valid           country_name_hist




                                                                                        3-4
                                                                       Chapter 3
                                                        Sample Schema Diagrams


Figure 3-4    Sample Schema CO

             CO
                 PRODUCTS         CUSTOMERS
                  product_id       customer_id
                product_name      email_address
                   unit_price       full_name
                product_details
                product_image
              image_mime_type
                image_charset                            STORES
               image_filename                             store_id
             image_last_updated                         store_name
                                                       web_address
                                                    physical_address
                                                          latitude
              ORDER _ITEMS           ORDERS              longitude
                  order_id           order_id               logo
               line_item_id       order_datetime    logo_mime_type
                 product_id        customer_id         logo_charset
                 unit_price        order_status       logo_filename
                  quantity           store_id      logo_last_updated




                                                                           3-5
4
Sample Schema Scripts and Object
Descriptions
           Consider the scripts used to generate the Oracle Database Sample Schemas. Each
           schema has two primary scripts:
           •   The xx_main.sql script, where xx is the schema abbreviation, resets and creates
               all objects and data for a particular schema. This main script calls all other scripts
               necessary to build and load the schema.
           •   Script xx_drop.sql, where xx is the schema name, removes all objects from a
               particular schema.


4.1 Master Script for Sample Schemas
           The master script, mksample.sql, sets up the overall Sample Schema environment
           and creates all the schemas.
           In the master script (mksample.sql), you will notice variables such as %s_pmPath%,
           %s_logPath%, and %s_shPath%. These variables are instantiated on installation.


4.1.1 mksample.sql
           The text of the mksample.sql script follows:
           Rem
           Rem $Header: mksample.sql.sbs 02-apr-2003.14:55:17 $
           Rem
           Rem mksample.sql
           Rem
           Rem Copyright (c) 2001, 2003, Oracle Corporation. All rights reserved.
           Rem
           Rem NAME
           Rem mksample.sql - creates all 5 Sample Schemas
           Rem
           Rem DESCRIPTION
           Rem This script rees and creates all Schemas belonging
           Rem to the Oracle Database 10g Sample Schemas.
           Rem If you are unsure about the prerequisites for the Sample Schemas,
           Rem please use the Database Configuration Assistant DBCA to
           Rem configure the Sample Schemas.
           Rem
           Rem NOTES
           Rem - OUI instantiates this script during install and saves it
           Rem as mksample.sql. The instantiated scripts matches
           Rem the directory structure on your system
           Rem - Tablespace EXAMPLE created with:
           Rem CREATE TABLESPACE example
           Rem NOLOGGING
           Rem DATAFILE '<filename>' SIZE 150M REUSE
           Rem AUTOEXTEND ON NEXT 640k




                                                                                                  4-1
                                                                                Chapter 4
                                                         Master Script for Sample Schemas


Rem MAXSIZE UNLIMITED
Rem EXTENT MANAGEMENT LOCAL
Rem SEGMENT SPACE MANAGEMENT AUTO;
Rem
Rem - CAUTION: This script will erase the following schemas:
Rem - HR
Rem - OE
Rem - PM
Rem - SH
Rem - IX
Rem - BI
Rem - CAUTION: Never use the preceding Sample Schemas for
Rem anything other than demos and examples
Rem - USAGE: To return the Sample Schemas to their initial
Rem state, you can call this script and pass the passwords
Rem for SYS, SYSTEM and the schemas as parameters.
Rem Example: @?/demo/schema/mksample mgr secure h1 o2 p3 q4 s5
Rem (please choose your own passwords for security purposes)
Rem
Rem MODIFIED (MM/DD/YY)
Rem
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 999
SET ECHO OFF
SET CONCAT '.'
SET SHOWMODE OFF

PROMPT
PROMPT specify password for SYSTEM as parameter 1:
DEFINE password_system = &1
PROMPT
PROMPT specify password for SYS as parameter 2:
DEFINE password_sys = &2
PROMPT
PROMPT specify password for HR as parameter 3:
DEFINE password_hr = &3
PROMPT
PROMPT specify password for OE as parameter 4:
DEFINE password_oe = &4
PROMPT
PROMPT specify password for PM as parameter 5:
DEFINE password_pm = &5
PROMPT
PROMPT specify password for IX as parameter 6:
DEFINE password_ix = &6
PROMPT
PROMPT specify password for SH as parameter 7:
DEFINE password_sh = &7
PROMPT
PROMPT specify password for BI as parameter 8:
DEFINE password_bi = &8
PROMPT
PROMPT specify default tablespace as parameter 9:
DEFINE default_ts = &9
PROMPT




                                                                                    4-2
                                                                                Chapter 4
                                                         Master Script for Sample Schemas


PROMPT specify temporary tablespace as parameter 10:
DEFINE temp_ts = &10
PROMPT
PROMPT specify log file directory (including trailing delimiter) as parameter
 11:
DEFINE logfile_dir = &11
PROMPT
PROMPT Sample Schemas are being created ...
PROMPT
DEFINE vrs = v3

CONNECT system/&&password_system

DROP USER hr CASCADE;
DROP USER oe CASCADE;
DROP USER pm CASCADE;
DROP USER ix CASCADE;
DROP USER sh CASCADE;
DROP USER bi CASCADE;

CONNECT system/&&password_system

SET SHOWMODE OFF

@?/demo/schema/human_resources/hr_main.sql &&password_hr &&default_ts &&temp_ts
 &&password_sys &&logfile_dir

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/order_entry/oe_main.sql &&password_oe &&default_ts &&temp_ts
 &&password_hr &&password_sys %s_oePath% &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/product_media/pm_main.sql &&password_pm &&default_ts &&temp_ts
 &&password_oe &&password_sys %s_pmPath% &&logfile_dir %s_pmPath%

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/info_exchange/ix_main.sql &&password_ix &&default_ts &&temp_ts
 &&password_sys &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/sales_history/sh_main &&password_sh &&default_ts &&temp_ts
 &&password_sys %s_shPath% &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/bus_intelligence/bi_main &&password_bi &&default_ts &&temp_ts
 &&password_sys &&password_oe &&password_sh &&logfile_dir &vrs

CONNECT system/&&password_system

SPOOL OFF




                                                                                    4-3
                                                                                              Chapter 4
                                                                  HR Sample Schema Scripts and Objects


         DEFINE veri_spool = &&logfile_dir.mkverify_&vrs..log

         @?/demo/schema/mkverify &&password_system &veri_spool

         EXIT



                 Note:
                 The master script @mksample currently does not include the CO schema.



4.2 HR Sample Schema Scripts and Objects
         This section lists the names of the scripts that create the human resources (HR)
         schema and describes the objects in the schema. Table 4-1 lists the HR scripts in
         alphabetical order, while Table 4-2 lists its objects.

         Table 4-1   HR Sample Schema Scripts

         Script Name               Description
         hr_analz.sql              Collects statistics on the tables in the schema
         hr_code.sql               Creates procedural objects in the schema
         hr_comnt.sql              Creates comments for each object in the schema
         hr_cre.sql                Creates the HR objects
         hr_dn_c.sql               Adds the distinguished name column used by Oracle Internet
                                   Directory to the employees and departments tables
         hr_dn_d.sql               Drops the Oracle Internet Directory distinguished name column
                                   from employees and departments
         hr_drop.sql               Drops schema HR and all its objects
         hr_idx.sql                Creates indexes on the HR tables
         hr_main.sql               Main script for schema HR ; calls other scripts
         hr_popul.sql              Populates the objects


         Table 4-2   HR Sample Schema Objects

         Object Type     Objects
         Index           COUNTRY_C_ID_PK, DEPT_ID_PK, DEPT_LOCATION_IX,
                         EMP_DEPARTMENT_IX, EMP_EMAIL_UK, EMP_EMP_ID_PK, EMP_JOB_IX,
                         EMP_MANAGER_IX, EMP_NAME_IX, JHIST_DEPARTMENT_IX,
                         JHIST_EMPLOYEE_IX, JHIST_EMP_ID_ST_DATE_PK, JHIST_JOB_IX,
                         JOB_ID_PK, LOC_CITY_IX, LOC_COUNTRY_IX, LOC_ID_PK,
                         LOC_STATE_PROVINCE_IX, REG_ID_PK
         Procedure       ADD_JOB_HISTORY, SECURE_DML
         Sequence        DEPARTMENTS_SEQ, EMPLOYEES_SEQ, LOCATIONS_SEQ
         Table           COUNTRIES, DEPARTMENTS, EMPLOYEES, JOBS, JOB_HISTORY, LOCATIONS,
                         REGIONS




                                                                                                   4-4
                                                                                       Chapter 4
                                                            HR Sample Schema Table Descriptions




         Table 4-2    (Cont.) HR Sample Schema Objects

          Object Type    Objects
          Trigger        SECURE_EMPLOYEES, UPDATE_JOB_HISTORY
          View           EMP_DETAILS_VIEW


4.3 HR Sample Schema Table Descriptions
         Consider the columns of each table of HR sample schema.

         •   Table HR.COUNTRIES
         •   Table HR.DEPARTMENTS
         •   Table HR.EMPLOYEES
         •   Table HR.JOBS
         •   Table HR.JOB_HISTORY
         •   Table HR.LOCATIONS
         •   Table HR.REGIONS


4.3.1 Table HR.COUNTRIES
         Table 4-3    HR.COUNTRIES Table Description

          Column Name               Null?                  Type
          COUNTRY_ID                NOT NULL               CHAR(2)
          COUNTRY_NAME                                     VARCHAR2(40)
          REGION_ID                                        NUMBER


4.3.2 Table HR.DEPARTMENTS
         Table 4-4    HR.DEPARTMENTS Table Description

          Column Name               Null?                  Type
          DEPARTMENT_ID             NOT NULL               NUMBER(4)
          DEPARTMENT_NAME           NOT NULL               VARCHAR2(30)
          MANAGER_ID                                       NUMBER(6)
          LOCATION_ID                                      NUMBER(4)




                                                                                           4-5
                                                                                    Chapter 4
                                                         HR Sample Schema Table Descriptions




4.3.3 Table HR.EMPLOYEES
          Table 4-5   HR.EMPLOYEES Table Description

          Column Name               Null?                Type
          EMPLOYEE_ID               NOT NULL             NUMBER(6)
          FIRST_NAME                                     VARCHAR2(20)
          LAST_NAME                 NOT NULL             VARCHAR2(25)
          EMAIL                     NOT NULL             VARCHAR2(20)
          PHONE_NUMBER                                   VARCHAR2(20)
          HIRE_DATE                 NOT NULL             DATE
          JOB_ID                    NOT NULL             VARCHAR2(10)
          SALARY                                         NUMBER(8,2)
          COMMISSION_PCT                                 NUMBER(2,2)
          MANAGER_ID                                     NUMBER(6)
          DEPARTMENT_ID                                  NUMBER(4)


4.3.4 Table HR.JOBS
          Table 4-6   HR.JOBS Table Description

          Column Name               Null?                Type
          JOB_ID                    NOT NULL             VARCHAR2(10)
          JOB_TITLE                 NOT NULL             VARCHAR2(35)
          MIN_SALARY                                     NUMBER(6)
          MAX_SALARY                                     NUMBER(6)


4.3.5 Table HR.JOB_HISTORY
          Table 4-7   HR.JOB_HISTORY Table Description

          Column Name               Null?                Type
          EMPLOYEE_ID               NOT NULL             NUMBER(6)
          START_DATE                NOT NULL             DATE
          END_DATE                  NOT NULL             DATE
          JOB_ID                    NOT NULL             VARCHAR2(10)
          DEPARTMENT_ID                                  NUMBER(4)




                                                                                        4-6
                                                                                               Chapter 4
                                                                   OE Sample Schema Scripts and Objects




4.3.6 Table HR.LOCATIONS
          Table 4-8    HR.LOCATIONS Table Description

          Column Name                  Null?                       Type
          LOCATION_ID                  NOT NULL                    NUMBER(4)
          STREET_ADDRESS                                           VARCHAR2(40)
          POSTAL_CODE                                              VARCHAR2(12)
          CITY                         NOT NULL                    VARCHAR2(30)
          STATE_PROVINCE                                           VARCHAR2(25)
          COUNTRY_ID                                               CHAR(2)


4.3.7 Table HR.REGIONS
          Table 4-9    HR.REGIONS Table Description

          Column Name                  Null?                       Type
          REGION_ID                    NOT NULL                    NUMBER
          REGION_NAME                                              VARCHAR2(25)


4.4 OE Sample Schema Scripts and Objects
          This section lists the names of the scripts that create the Order Entry (OE) sample
          schema and describes the objects in the schema. Table 4-10 lists the OE scripts in
          alphabetical order, while Table 4-11 lists its objects. Note that language-specific
          statements for product names and descriptions are stored in these files (each
          representing a different language): INSERToe_p_us.sqloe_p_ar.sql, oe_p_cs.sql,
          oe_p_d.sql, oe_p_dk.sql, oe_p_e.sql, oe_p_el.sql, oe_p_esa.sql, oe_p_f.sql,
          oe_p_frc.sql, oe_p_hu.sql, oe_p_i.sql, oe_p_iw.sql, oe_p_ja.sql, oe_p_ko.sql,
          oe_p_n.sql, oe_p_nl.sql, oe_p_pl.sql, oe_p_pt.sql, oe_p_ptb.sql, oe_p_ro.sql,
          oe_p_ru.sql, oe_p_s.sql, oe_p_sf.sql, oe_p_sk.sql, oe_p_th.sql, oe_p_tr.sql,
          oe_p_zhs.sql, oe_p_zht.sql.

          Table 4-10    OE Sample Schema Scripts

          Script Name               Description
          oc_comnt.sql              Adds comments to the online catalog (OC) subschema wherever
                                    possible
          oc_cre.sql                Creates subschema OC
          oc_drop.sql               Drops subschema OC
          oc_main.sql               Main script for subschema OC
          oc_popul.sqla             Populates the object tables
          oe_analz.sql              Gathers statistics on the OE objects




                                                                                                   4-7
                                                                                   Chapter 4
                                                       OE Sample Schema Scripts and Objects




Table 4-10    (Cont.) OE Sample Schema Scripts

Script Name              Description
oe_comnt.sql             Creates comments for the objects in the schema
oe_cre.sql               Creates the OE objects
oe_drop.sql              Drops schema OE and all its objects
oe_idx.sql               Creates indexes on the OE tables
oe_main.sql              Main script for the OE schema; calls other scripts
oe_views.sql             Creates the OE schema views


Table 4-11    OE Sample Schema Objects

Object Type    Objects
Index          CUSTOMERS_PK, CUST_ACCOUNT_MANAGER_IX, CUST_EMAIL_IX,
               CUST_LNAME_IX, CUST_UPPER_NAME_IX, INVENTORY_IX, INV_PRODUCT_IX,
               ITEM_ORDER_IX, ITEM_PRODUCT_IX, ORDER_ITEMS_PK, ORDER_ITEMS_UK,
               ORDER_PK, ORD_CUSTOMER_IX, ORD_ORDER_DATE_IX, ORD_SALES_REP_IX,
               PRD_DESC_PK, PRODUCT_INFORMATION_PK, PROD_NAME_IX,
               PROD_SUPPLIER_IX, PROMO_ID_PK, REFERENCE_IS_UNIQUE, SYS_C003584,
               SYS_C003587, SYS_C003588, SYS_C003589, SYS_C003590,
               WAREHOUSES_PK, WHS_LOCATION_IX
Function       GET_PHONE_NUMBER_F
Sequence       ORDERS_SEQ
Lob            SYS_LOB0000045843C00022$$, SYS_LOB0000045843C00023$$,
               SYS_LOB0000045852C00003$$, SYS_LOB0000045852C00012$$,
               SYS_LOB0000045852C00013$$, SYS_LOB0000046019C00004$$,
               SYS_LOB0000046019C00005$$, SYS_LOB0000046019C00007$$,
               SYS_LOB0000046019C00011$$, SYS_LOB0000046019C00012$$,
               SYS_LOB0000046019C00015$$, SYS_LOB0000046019C00024$$,
               SYS_LOB0000046019C00031$$, SYS_LOB0000046019C00032$$,
               SYS_LOB0000046044C00003$$
Synonym        COUNTRIES, DEPARTMENTS, EMPLOYEES, JOBS, JOB_HISTORY, LOCATIONS
Table          CUSTOMERS, INVENTORIES, ORDERS, ORDER_ITEMS,
               PRODUCT_DESCRIPTIONS, PRODUCT_INFORMATION, WAREHOUSES
Trigger        INSERT_ORD_LINE, ORDERS_ITEMS_TRG, ORDERS_TRG




                                                                                       4-8
                                                                                      Chapter 4
                                                           OE Sample Schema Table Descriptions




         Table 4-11    (Cont.) OE Sample Schema Objects

         Object Type    Objects
         Type           CATALOG_TYP, CATEGORY_TYP, COMPOSITE_CATEGORY_TYP,
                        CORPORATE_CUSTOMER_TYP, CUSTOMER_TYP, CUST_ADDRESS_TYP,
                        INVENTORY_LIST_TYP, INVENTORY_TYP, LEAF_CATEGORY_TYP,
                        ORDER_ITEM_LIST_TYP, ORDER_ITEM_TYP, ORDER_LIST_TYP, ORDER_TYP,
                        PHONE_LIST_TYP, PRODUCT_INFORMATION_TYP, PRODUCT_REF_LIST_TYP,
                        SUBCATEGORY_REF_LIST_TYP, SYS_YOID0000046073$,
                        SYS_YOID0000046075$, SYS_YOID0000046077$, SYS_YOID0000046079$,
                        SYS_YOID0000046081$, WAREHOUSE_TYP, XDBPO_ACTIONS_TYPE,
                        XDBPO_ACTION_COLLECTION, XDBPO_ACTION_TYPE,
                        XDBPO_LINEITEMS_TYPE, XDBPO_LINEITEM_COLLECTION,
                        XDBPO_LINEITEM_TYPE, XDBPO_PART_TYPE, XDBPO_REJECTION_TYPE,
                        XDBPO_SHIPINSTRUCTIONS_TYPE, XDBPO_TYPE
         Type Body      CATALOG_TYP, COMPOSITE_CATEGORY_TYP, LEAF_CATEGORY_TYP
         View           ACCOUNT_MANAGERS, BOMBAY_INVENTORY, CUSTOMERS_VIEW, DEPTVIEW,
                        OC_CORPORATE_CUSTOMERS, OC_CUSTOMERS, OC_INVENTORIES, OC_ORDERS,
                        OC_PRODUCT_INFORMATION, ORDERS_VIEW, PRODUCTS, PRODUCT_PRICES,
                        SYDNEY_INVENTORY, TORONTO_INVENTORY


4.5 OE Sample Schema Table Descriptions
         Consider the tables of the OE sample schema.

         •   Table OE.CUSTOMERS
         •   Table OE.INVENTORIES
         •   Table OE.ORDERS
         •   Table OE.ORDER_ITEMS
         •   Table OE.PRODUCT_DESCRIPTIONS
         •   Table OE.PRODUCT_INFORMATION
         •   Table OE.WAREHOUSES
         •   Table OE.PURCHASEORDER


4.5.1 Table OE.CUSTOMERS
         Table 4-12    OE.CUSTOMERS Table Description

         Column Name                Null?               Type
         CUSTOMER_ID                NOT NULL            NUMBER(6)
         CUST_FIRST_NAME            NOT NULL            VARCHAR2(20)
         CUST_LAST_NAME             NOT NULL            VARCHAR2(20)
         CUST_ADDRESS                                   CUST_ADDRESS_TYP
         PHONE_NUMBERS                                  PHONE_LIST_TYP




                                                                                          4-9
                                                                                      Chapter 4
                                                           OE Sample Schema Table Descriptions




         Table 4-12     (Cont.) OE.CUSTOMERS Table Description

          Column Name               Null?             Type
          NLS_LANGUAGE                                VARCHAR2(3)
          NLS_TERRITORY                               VARCHAR2(30)
          CREDIT_LIMIT                                NUMBER(9,2)
          CUST_EMAIL                                  VARCHAR2(30)
          ACCOUNT_MGR_ID                              NUMBER(6)
          CUST_GEO_LOCATION                           MDSYS.SDO_GEOMETRY
          DATE_OF_BIRTH                               DATE
          MARITAL_STATUS                              VARCHAR2(20)
          GENDER                                      VARCHAR2(1)
          INCOME_LEVEL                                VARCHAR2(20)


4.5.2 Table OE.INVENTORIES
         Table 4-13     OE.INVENTORIES Table Description

          Column Name               Null?             Type
          PRODUCT_ID                NOT NULL          NUMBER(6)
          WAREHOUSE_ID              NOT NULL          NUMBER(3)
          QUANTITY_ON_HAND          NOT NULL          NUMBER(8)


4.5.3 Table OE.ORDERS
         Table 4-14     OE.ORDERS Table Description

          Column Name               Null?             Type
          ORDER_ID                  NOT NULL          NUMBER(12)
          ORDER_DATE                NOT NULL          TIMESTAMP(6) WITH LOCAL TIME
                                                      ZONE
          ORDER_MODE                                  VARCHAR2(8)
          CUSTOMER_ID               NOT NULL          NUMBER(6)
          ORDER_STATUS                                NUMBER(2)
          ORDER_TOTAL                                 NUMBER(8,2)
          SALES_REP_ID                                NUMBER(6)
          PROMOTION_ID                                NUMBER(6)




                                                                                        4-10
                                                                                      Chapter 4
                                                           OE Sample Schema Table Descriptions




4.5.4 Table OE.ORDER_ITEMS
         Table 4-15     OE.ORDER_ITEMS Table Description

          Column Name               Null?            Type
          ORDER_ID                  NOT NULL         NUMBER(12)
          LINE_ITEM_ID              NOT NULL         NUMBER(3)
          PRODUCT_ID                NOT NULL         NUMBER(6)
          UNIT_PRICE                                 NUMBER(8,2)
          QUANTITY                                   NUMBER(8)


4.5.5 Table OE.PRODUCT_DESCRIPTIONS
         Table 4-16     OE.PRODUCT_DESCRIPTIONS Table Description

          Column Name                   Null?              Type
          PRODUCT_ID                    NOT NULL           NUMBER(6)
          LANGUAGE_ID                   NOT NULL           VARCHAR2(3)
          TRANSLATED_NAME               NOT NULL           NVARCHAR2(50)
          TRANSLATED_DESCRIPTION        NOT NULL           NVARCHAR2(2000)


4.5.6 Table OE.PRODUCT_INFORMATION
         Table 4-17     OE.PRODUCT_INFORMATION Table Description

          Column Name               Null?             Type
          PRODUCT_ID                NOT NULL          NUMBER(6)
          PRODUCT_NAME                                VARCHAR2(50)
          PRODUCT_DESCRIPTION                         VARCHAR2(2000)
          CATEGORY_ID                                 NUMBER(2)
          WEIGHT_CLASS                                NUMBER(1)
          WARRANTY_PERIOD                             INTERVAL YEAR(2) TO MONTH
          SUPPLIER_ID                                 NUMBER(6))
          PRODUCT_STATUS                              VARCHAR2(20)
          LIST_PRICE                                  NUMBER(8,2)
          MIN_PRICE                                   NUMBER(8,2)
          CATALOG_URL                                 VARCHAR2(50)




                                                                                        4-11
                                                                                           Chapter 4
                                                               PM Sample Schema Scripts and Objects




4.5.7 Table OE.WAREHOUSES
         Table 4-18    OE.WAREHOUSES Table Description

         Column Name                   Null?                 Type
         WAREHOUSE_ID                  NOT NULL              NUMBER(3)
         WAREHOUSE_SPEC                                      SYS.XMLTYPE
         WAREHOUSE_NAME                                      VARCHAR2(35)
         LOCATION_ID                                         NUMBER(4)
         WH_GEO_LOCATION                                     MDSYS.SDO_GEOMETRY

         Column warehouse_spec of table OE.warehouses contains XMLType data. This data is
         not based on any XML schema, which means that it can take any form. However, the
         actual data in column warehouse_spec at the outset (before any changes you might
         have made to it) has a top-level element Warehouse with the following child elements:

         •   Building, with text node Owned or Rented
         •   Area, with text node a number (representing, for example, square feet)
         •   Docks, with text node the number of loading docks (for example, 1, 2, or 3)
         •   DockType, with text node empty or Rear Load or Side Load
         •   WaterAccess, with text node Y or N
         •   RailAccess, with text node Y or N
         •   Parking, with text node Street or Lot
         •   VClearance (vertical clearance), with text node a number followed by a linear unit
             (for example, 11.5 ft)



                See Also:
                Oracle XML DB Developer's Guide for examples using the XMLType data in
                column warehouse_spec



4.5.8 Table OE.PURCHASEORDER
         Table OE.purchaseorder is an object-relational table with XMLType data. The data
         conforms to XML schema purchaseOrder.xsd.


4.6 PM Sample Schema Scripts and Objects
         This section lists the names of the scripts that create the Product Media (PM) schema
         and describes the objects in the schema. Table 4-19 lists the PM scripts in alphabetical
         order, while Table 4-20 lists its objects. Note that the SQL*Loader data file
         pm_p_lob.dat contains hard-coded absolute path names that have been set during




                                                                                             4-12
                                                                                                  Chapter 4
                                                                    PM Sample Schema Table Descriptions


         installation. Before attempting to load the data in a different environment, you should
         first edit the path names in this file.

         Table 4-19     PM Schema Scripts

          Script Name                      Description
          pm_analz.sql                     Gathers statistics on the PM objects
          pm_cre.sql                       Creates the PM objects
          pm_drop.sql                      Drops schema PM and all its objects
          pm_p_ord.sql, pm_p_lob.sql,      Populates the objects in the schema
          pm_p_lob.ctl, pm_p_lob.dat
          pm_main.sql                      Main script for schema PM, which calls other scripts


         Table 4-20     PM Sample Schema Objects

          Object Type    Objects
          Index          PRINTMEDIA_PK, SYS_C003538
          Lob            SYS_LOB0000045882C00003$$, SYS_LOB0000045882C00017$$,
                         SYS_LOB0000045882C00019$$, SYS_LOB0000045882C00034$$,
                         SYS_LOB0000045882C00042$$, SYS_LOB0000045882C00054$$,
                         SYS_LOB0000045882C00062$$, SYS_LOB0000045882C00069$$,
                         SYS_LOB0000045882C00071$$, SYS_LOB0000045882C00080$$,
                         SYS_LOB0000045907C00003$$, SYS_LOB0000045907C00004$$,
                         SYS_LOB0000045907C00005$$, SYS_LOB0000045907C00006$$,
                         SYS_LOB0000045907C00009$$, SYS_LOB0000045907C00015$$,
                         SYS_LOB0000045908C00004$$
          Table          PRINT_MEDIA
          Type           ADHEADER_TYP, TEXTDOC_TAB, TEXTDOC_TYP


4.7 PM Sample Schema Table Descriptions
         Consider the columns of PRINT_MEDIA table of PM sample schema.

         •   Table PM.PRINT_MEDIA


4.7.1 Table PM.PRINT_MEDIA
         Table 4-21     PM.PRINT_MEDIA Table Description

          Column Name                   Null?                   Type
          PRODUCT_ID                    NOT NULL                NUMBER(6)
          AD_ID                         NOT NULL                NUMBER(6)
          AD_COMPOSITE                                          BLOB
          AD_SOURCETEXT                                         CLOB
          AD_FINALTEXT                                          CLOB




                                                                                                    4-13
                                                                                              Chapter 4
                                                                   IX Sample Schema Scripts and Objects




         Table 4-21    (Cont.) PM.PRINT_MEDIA Table Description

         Column Name                    Null?                    Type
         AD_FLTEXTN                                              NCLOB
         AD_TEXTDOCS_NTAB                                        TEXTDOC_TAB
         AD_PHOTO                                                BLOB
         AD_GRAPHIC                                              BINARY FILE LOB
         AD_HEADER                                               ADHEADER_TYP


4.8 IX Sample Schema Scripts and Objects
         This section lists the names of the scripts that create the Information Exchange (IX)
         schema group and describes the objects in the schemas. Table 4-22 lists the IX
         scripts in alphabetical order, while Table 4-23 lists its objects.

         Table 4-22    IX Sample Schema Scripts

         Script Name          Description
         cix_v3.sql           Creates the IX schema objects
         dix_v3.sql           Drops schema IX objects
         ix_main.sql          Main script for schema IX; calls other scripts
         vix_v3.sql           Enables, disables, and verifies IX objects


         Table 4-23    IX Sample Schema Objects

         Object Type          Objects
         Evaluation Context   AQ$_ORDERS_QUEUETABLE_V, AQ$_STREAMS_QUEUE_TABLE_V
         Index                SYS_C003540, SYS_C003543, SYS_C003548, SYS_C003551,
                              SYS_IOT_TOP_45932, SYS_IOT_TOP_45934, SYS_IOT_TOP_45936,
                              SYS_IOT_TOP_45939, SYS_IOT_TOP_45949, SYS_IOT_TOP_45951,
                              SYS_IOT_TOP_45953, SYS_IOT_TOP_45956
         Lob                  SYS_LOB0000045926C00036$$, SYS_LOB0000045941C00028$$,
                              SYS_LOB0000045941C00029$$
         Queue                AQ$_ORDERS_QUEUETABLE_E, AQ$_STREAMS_QUEUE_TABLE_E,
                              ORDERS_QUEUE, STREAMS_QUEUE
         Rule Set             ORDERS_QUEUE_N, ORDERS_QUEUE_R, STREAMS_QUEUE_N,
                              STREAMS_QUEUE_R
         Sequence             AQ$_ORDERS_QUEUETABLE_N, AQ$_STREAMS_QUEUE_TABLE_N
         Table                ORDERS_QUEUETABLE, STREAMS_QUEUE_TABLE
         Type                 ORDER_EVENT_TYP
         View                 AQ$ORDERS_QUEUETABLE, AQ$ORDERS_QUEUETABLE_R,
                              AQ$ORDERS_QUEUETABLE_S, AQ$STREAMS_QUEUE_TABLE,
                              AQ$STREAMS_QUEUE_TABLE_R, AQ$STREAMS_QUEUE_TABLE_S



                                                                                                 4-14
                                                                                       Chapter 4
                                                             IX Sample Schema Table Descriptions




4.9 IX Sample Schema Table Descriptions
         Consider the columns of each table of IX sample schema.

         •   Table IX.ORDERS_QUEUETABLE
         •   Table IX.STREAMS_QUEUE_TABLE


4.9.1 Table IX.ORDERS_QUEUETABLE
         Table 4-24    IX.ORDERS_QUEUETABLE Table Description

         Column Name                 Null?                Type
         Q_NAME                                           VARCHAR2(30)
         MSGID                       NOT NULL             RAW(16)
         CORRID                                           VARCHAR2(128)
         PRIORITY                                         NUMBER
         STATE                                            NUMBER
         DELAY                                            TIMESTAMP(6)
         EXPIRATION                                       NUMBER
         TIME_MANAGER_INFO                                TIMESTAMP(6)
         LOCAL_ORDER_NO                                   NUMBER
         CHAIN_NO                                         NUMBER
         CSCN                                             NUMBER
         DSCN                                             NUMBER
         ENQ_TIME                                         TIMESTAMP(6)
         ENQ_UID                                          VARCHAR2(30)
         ENQ_TID                                          VARCHAR2(30)
         DEQ_TIME                                         TIMESTAMP(6)
         EEQ_UID                                          VARCHAR2(30)
         DEQ_TID                                          VARCHAR2(30)
         RETRY_COUNT                                      NUMBER
         EXCEPTION_QSCHEMA                                VARCHAR2(30)
         EXCEPTION_QUEUE                                  VARCHAR2(30)
         STEP_NO                                          NUMBER
         RECIPIENT_KEY                                    NUMBER
         DEQUEUE_MSGID                                    RAW(16)
         SENDER_NAME                                      VARCHAR2(30)
         SENDER_ADDRESS                                   VARCHAR2(1024)
         SENDER_PROTOCOL                                  NUMBER




                                                                                          4-15
                                                                                  Chapter 4
                                                        IX Sample Schema Table Descriptions




         Table 4-24    (Cont.) IX.ORDERS_QUEUETABLE Table Description

         Column Name                Null?             Type
         USER_DATA                                    ORDER_EVENT_TYP
         USER_PROP                                    SYS.ANYDATA


4.9.2 Table IX.STREAMS_QUEUE_TABLE
         Table 4-25    IX.STREAMS_QUEUE_TABLE Table Description

         Column Name                Null?             Type
         Q_NAME                                       VARCHAR2(30)
         MSGID                      NOT NULL          RAW(16)
         CORRID                                       VARCHAR2(128)
         PRIORITY                                     NUMBER
         STATE                                        NUMBER
         DELAY                                        TIMESTAMP(6)
         EXPIRATION                                   NUMBER
         TIME_MANAGER_INFO                            TIMESTAMP(6)
         LOCAL_ORDER_NO                               NUMBER
         CHAIN_NO                                     NUMBER
         CSCN                                         NUMBER
         DSCN                                         NUMBER
         ENQ_TIME                                     TIMESTAMP(6)
         ENQ_UID                                      VARCHAR2(30)
         ENQ_TID                                      VARCHAR2(30)
         DEQ_TIME                                     TIMESTAMP(6)
         EEQ_UID                                      VARCHAR2(30)
         DEQ_TID                                      VARCHAR2(30)
         RETRY_COUNT                                  NUMBER
         EXCEPTION_QSCHEMA                            VARCHAR2(30)
         EXCEPTION_QUEUE                              VARCHAR2(30)
         STEP_NO                                      NUMBER
         RECIPIENT_KEY                                NUMBER
         DEQUEUE_MSGID                                RAW(16)
         SENDER_NAME                                  VARCHAR2(30)
         SENDER_ADDRESS                               VARCHAR2(1024)
         SENDER_PROTOCOL                              NUMBER
         USER_DATA                                    ORDER_EVENT_TYP



                                                                                     4-16
                                                                                               Chapter 4
                                                                   SH Sample Schema Scripts and Objects




         Table 4-25    (Cont.) IX.STREAMS_QUEUE_TABLE Table Description

         Column Name                    Null?                    Type
         USER_PROP                                               SYS.ANYDATA


4.10 SH Sample Schema Scripts and Objects
         This section lists the names of the scripts that create the Sales History (SH) schema
         and describes the objects in the schema. Table 4-26 lists the SH scripts in alphabetical
         order, while Table 4-27 lists its objects.

         Table 4-26    SH Sample Schema Scripts

         Script Name                Description
         sh_analz.sql               Gathers statistics on the schema objects
         sh_comnt.sql               Creates comments for the objects in the schema
         sh_cons.sql                Modifies constraints on objects in the schema
         sh_cre.sql                 Creates the objects in the schema
         sh_cremv.sql               Creates materialized views and bitmapped indexes
         sh_drop.sql                Drops schema SH and all its objects
         sh_idx.sql                 Creates indexes on tables in the schema
         sh_main.sql                Main script for schema SH; calls other scripts
         olp_v3.sql                 Creates dimensions and hierarchies used by the OLAP server
         sh_olp_d.sql               Drops the objects used by the OLAP server


         Table 4-27    SH Sample Schema Objects

         Object Type          Objects
         Dimension            CHANNELS_DIM, CUSTOMERS_DIM, PRODUCTS_DIM, PROMOTIONS_DIM,
                              TIMES_DIM
         Index                CHANNELS_PK, COSTS_PROD_BIX, COSTS_TIME_BIX, COUNTRIES_PK,
                              CUSTOMERS_GENDER_BIX, CUSTOMERS_MARITAL_BIX, CUSTOMERS_PK,
                              CUSTOMERS_YOB_BIX, DR$SUP_TEXT_IDX$X,
                              FW_PSC_S_MV_CHAN_BIX, FW_PSC_S_MV_PROMO_BIX,
                              FW_PSC_S_MV_SUBCAT_BIX, FW_PSC_S_MV_WD_BIX, PRODUCTS_PK,
                              PRODUCTS_PROD_CAT_IX, PRODUCTS_PROD_STATUS_BIX,
                              PRODUCTS_PROD_SUBCAT_IX, PROMO_PK, SALES_CHANNEL_BIX,
                              SALES_CUST_BIX, SALES_PROD_BIX, SALES_PROMO_BIX,
                              SALES_TIME_BIX, SUP_TEXT_IDX, SYS_IOT_TOP_45927,
                              SYS_IOT_TOP_45932, TIMES_PK
         Index Partition      COSTS_PROD_BIX, COSTS_TIME_BIX, SALES_CHANNEL_BIX,
                              SALES_CUST_BIX, SALES_PROD_BIX, SALES_PROMO_BIX,
                              SALES_TIME_BIX
         Lob                  SYS_LOB0000045924C00006$$, SYS_LOB0000045929C00002$$




                                                                                                 4-17
                                                                                        Chapter 4
                                                             SH Sample Schema Table Descriptions




          Table 4-27    (Cont.) SH Sample Schema Objects

          Object Type         Objects
          Materialized View   CAL_MONTH_SALES_MV, FWEEK_PSCAT_SALES_MV
          Table               CHANNELS, COSTS, COUNTRIES, CUSTOMERS, PRODUCTS, PROMOTIONS,
                              SALES, TIMES
          Table Partition     COSTS, SALES
          View                PROFITS


4.11 SH Sample Schema Table Descriptions
          Consider the columns of each table of SH sample schema.

          •   Table SH.CHANNELS
          •   Table SH.COSTS
          •   Table SH.COUNTRIES
          •   Table SH.CUSTOMERS
          •   Table SH.PRODUCTS
          •   Table SH.PROMOTIONS
          •   Table SH.SALES
          •   Table SH.TIMES


4.11.1 Table SH.CHANNELS
          Table 4-28    SH.CHANNELS Table Description

          Column Name                        Null?         Type
          CHANNEL_ID                         NOT NULL      NUMBER
          CHANNEL_DESC                       NOT NULL      VARCHAR2(20)
          CHANNEL_CLASS                      NOT NULL      VARCHAR2(20)
          CHANNEL_CLASS_ID                   NOT NULL      NUMBER
          CHANNEL_TOTAL                      NOT NULL      VARCHAR2(13)
          CHANNEL_TOTAL_ID                   NOT NULL      NUMBER


4.11.2 Table SH.COSTS
          Table 4-29    SH.COSTS Table Description

          Column Name                        Null?         Type
          PROD_ID                            NOT NULL      NUMBER
          TIME_DESC                          NOT NULL      DATE



                                                                                          4-18
                                                                                        Chapter 4
                                                             SH Sample Schema Table Descriptions




         Table 4-29     (Cont.) SH.COSTS Table Description

          Column Name                     Null?          Type
          PROMO_ID                        NOT NULL       NUMBER
          CHANNEL_ID                      NOT NULL       NUMBER
          UNIT_COST                       NOT NULL       NUMBER(10,2)
          UNIT_PRICE                      NOT NULL       NUMBER(10,2)


4.11.3 Table SH.COUNTRIES
         Table 4-30     SH.COUNTRIES Table Description

          Column Name                     Null?          Type
          COUNTRY_ID                      NOT NULL       NUMBER
          COUNTRY_ISO_CODE                NOT NULL       CHAR(2)
          COUNTRY_NAME                    NOT NULL       VARCHAR2(40)
          COUNTRY_SUBREGION               NOT NULL       VARCHAR2(30)
          COUNTRY_SUBREGION_ID            NOT NULL       NUMBER
          COUNTRY_REGION                  NOT NULL       VARCHAR2(20)
          COUNTRY_REGION_ID               NOT NULL       NUMBER
          COUNTRY_TOTAL                   NOT NULL       VARCHAR2(11)
          COUNTRY_TOTAL_ID                NOT NULL       NUMBER
          COUNTRY_NAME_HIST                              VARCHAR2(40)


4.11.4 Table SH.CUSTOMERS
         Table 4-31     SH.CUSTOMERS Table Description

          Column Name                     Null?          Type
          CUST_ID                         NOT NULL       NUMBER
          CUST_FIRST_NAME                 NOT NULL       VARCHAR2(20)
          CUST_LAST_NAME                  NOT NULL       VARCHAR2(40)
          CUST_GENDER                     NOT NULL       CHAR(1)
          CUST_YEAR_OF_BIRTH              NOT NULL       NUMBER(4)
          CUST_MARITAL_STATUS                            VARCHAR2(20)
          CUST_STREET_ADDRESS             NOT NULL       VARCHAR2(40)
          CUST_POSTAL_CODE                NOT NULL       VARCHAR2(10)
          CUST_CITY                       NOT NULL       VARCHAR2(30)
          CUST_CITY_ID                    NOT NULL       NUMBER




                                                                                          4-19
                                                                                    Chapter 4
                                                         SH Sample Schema Table Descriptions




         Table 4-31     (Cont.) SH.CUSTOMERS Table Description

          Column Name                    Null?          Type
          CUST_STATE_PROVINCE            NOT NULL       VARCHAR2(40)
          CUST_STATE_PROVINCE_ID         NOT NULL       NUMBER
          COUNTRY_ID                     NOT NULL       NUMBER
          CUST_MAIN_PHONE_NUMBER         NOT NULL       VARCHAR2(25)
          CUST_INCOME_LEVEL                             VARCHAR2(30)
          CUST_CREDIT_LIMIT                             NUMBER
          CUST_EMAIL                                    VARCHAR2(30)
          CUST_TOTAL                     NOT NULL       VARCHAR2(14)
          CUST_TOTAL_ID                  NOT NULL       NUMBER
          CUST_SRC_ID                                   NUMBER
          CUST_EFF_FROM                                 DATE
          CUST_EFF_TO                                   DATE
          CUST_VALID                                    VARCHAR2(1)


4.11.5 Table SH.PRODUCTS
         Table 4-32     SH.PRODUCTS Table Description

          Column Name                    Null?          Type
          PROD_ID                        NOT NULL       NUMBER(6)
          PROD_NAME                      NOT NULL       VARCHAR2(50)
          PROD_DESC                      NOT NULL       VARCHAR2(4000)
          PROD_SUBCATEGORY               NOT NULL       VARCHAR2(50)
          PROD_SUBCATEGORY_ID            NOT NULL       NUMBER
          PROD_SUBCATEGORY_DESC          NOT NULL       VARCHAR2(2000)
          PROD_CATEGORY                  NOT NULL       VARCHAR2(50)
          PRD_CATEGORY_ID                NOT NULL       NUMBER
          PROD_CATEGORY_DESC             NOT NULL       VARCHAR2(2000)
          PROD_WEIGHT_CLASS              NOT NULL       NUMBER(3)
          PROD_UNIT_OF_MEASURE                          VARCHAR2(20)
          PRD_PACK_SIZE                  NOT NULL       VARCHAR2(30)
          PROD_SUPPLIER_ID               NOT NULL       NUMBER(6)
          PROD_STATUS                    NOT NULL       VARCHAR2(20)
          PROD_LIST_PRICE                NOT NULL       NUMBER(8,2)
          PRD_MIN_PRICE                  NOT NULL       NUMBER(8,2)
          PROD_TOTAL                     NOT NULL       VARCHAR2(13)



                                                                                      4-20
                                                                                     Chapter 4
                                                          SH Sample Schema Table Descriptions




          Table 4-32    (Cont.) SH.PRODUCTS Table Description

          Column Name                    Null?          Type
          PROD_TOTAL_ID                  NOT NULL       NUMBER
          PROD_SRC_ID                                   NUMBER
          PRD_EFF_FROM                                  DATE
          PROD_EFF_TO                                   DATE
          PROD_VALID                                    VARCHAR2(1)


4.11.6 Table SH.PROMOTIONS
          Table 4-33    SH.PROMOTIONS Table Description

          Column Name                    Null?          Type
          PROMO_ID                       NOT NULL       NUMBER(6)
          PROMO_NAME                     NOT NULL       VARCHAR2(30)
          PROMO_SUBCATEGORY              NOT NULL       VARCHAR2(30)
          PROMO_SUBCATEGORY_ID           NOT NULL       NUMBER
          PROMO_CATEGORY                 NOT NULL       VARCHAR2(30)
          PRMO_CATEGORY_ID               NOT NULL       NUMBER
          PROMO_COST                     NOT NULL       NUMBER(10,2)
          PROMO_BEGIN_DATE               NOT NULL       DATE
          PROMO_END_DATE                 NOT NULL       DATE
          PROMO_TOTAL                    NOT NULL       VARCHAR2(15)
          PROMO_TOTAL_ID                 NOT NULL       NUMBER


4.11.7 Table SH.SALES
          Table 4-34    SH.SALES Table Description

          Column Name                    Null?          Type
          PROD_ID                        NOT NULL       NUMBER
          CUST_ID                        NOT NULL       NUMBER
          TIME_ID                        NOT NULL       DATE
          CHANNEL_ID                     NOT NULL       NUMBER
          PROMO_ID                       NOT NULL       NUMBER
          QUANTITY_SOLD                  NOT NULL       NUMBER(10,2)
          AMOUNT_SOLD                    NOT NULL       NUMBER(10,2)




                                                                                       4-21
                                                                                 Chapter 4
                                                      SH Sample Schema Table Descriptions




4.11.8 Table SH.TIMES
          Table 4-35    SH.TIMES Table Description

          Column Name                     Null?      Type
          TIME_ID                         NOT NULL   DATE
          DAY_NAME                        NOT NULL   VARCHAR2(9)
          DAY_NUMBER_IN_WEEK              NOT NULL   NUMBER(1)
          DAY_NUMBER_IN_MONTH             NOT NULL   NUMBER(2)
          CALENDAR_WEEK_NUMBER            NOT NULL   NUMBER(2)
          FISCAL_WEEK_NUMBER              NOT NULL   NUMBER(2)
          WEEK_ENDING_DAY                 NOT NULL   DATE
          WEEK_ENDING_DAY_ID              NOT NULL   NUMBER
          CALENDAR_MONTH_NUMBER           NOT NULL   NUMBER(2)
          FISCAL_MONTH_NUMBER             NOT NULL   NUMBER(2)
          CALENDAR_MONTH_DESC             NOT NULL   VARCHAR2(8)
          CALENDAR_MONTH_ID               NOT NULL   NUMBER
          FISCAL_MONTH_DESC               NOT NULL   VARCHAR2(8)
          FISCAL_MONTH_ID                 NOT NULL   NUMBER
          DAYS_IN_CAL_MONTH               NOT NULL   NUMBER
          DAYS_IN_FIS_MONTH               NOT NULL   NUMBER
          END_OF_CAL_MONTH                NOT NULL   DATE
          END_OF_FIS_MONTH                NOT NULL   DATE
          CALENDAR_MONTH_NAME             NOT NULL   VARCHAR2(9)
          FISCAL_MONTH_NAME               NOT NULL   VARCHAR2(9)
          CALENDAR_QUARTER_DESC           NOT NULL   CHAR(7)
          CALENBDAR_QUARTER_ID            NOT NULL   NUMBER
          FISCAL_QUARTER_DESC             NOT NULL   CHAR(7)
          FISCAL_QUARTER_ID               NOT NULL   NUMBER
          DAYS_IN_CAL_QUARTER             NOT NULL   NUMBER
          DAYS_IN_FIS_QUARTER             NOT NULL   NUMBER
          END_OF_CAL_QUARTER              NOT NULL   DATE
          END_OF_FIS_QUARTER              NOT NULL   DATE
          CALENDAR_QUARTER_NUMBER         NOT NULL   NUMBER(1)
          FISCAL_QUARTER_NUMBER           NOT NULL   NUMBER(1)
          CALENDAR_YEAR                   NOT NULL   NUMBER(4)
          CALENDAR_YEAR_ID                NOT NULL   NUMBER
          FISCAL_YEAR                     NOT NULL   NUMBER(4)




                                                                                   4-22
                                                                                                    Chapter 4
                                                                   CO Sample Schema Scripts and Objects




         Table 4-35    (Cont.) SH.TIMES Table Description

         Column Name                          Null?               Type
         FISCAL_YEAR_ID                       NOT NULL            NUMBER
         DAYS_IN_CAL_YEAR                     NOT NULL            NUMBER
         DAYS_IN_FIS_YEAR                     NOT NULL            NUMBER
         END_OF_CAL_YEAR                      NOT NULL            DATE
         END_OF_FIS_YEAR                      NOT NULL            DATE


4.12 CO Sample Schema Scripts and Objects
         This section lists the names of the scripts that create the customer orders (CO) schema
         and describes the objects in the schema.
         Table 4-36 lists the CO scripts in alphabetical order, while Table 4-37 lists its objects.

         Table 4-36    CO Sample Schema Scripts

         Script Name                                     Description
         co_ddl.sql                                      Creates tables, views and indexes
         co_dml.sql                                      Populates the tables
         co_drop_objects.sql                             Drops CO objects from current schema
         co_drop_user.sql                                Drops CO user
         co_main.sql                                     Main installation script for CO schema; calls
                                                         other scripts
         co_set_identity_starts.sql                      Resets the current value of the identity
                                                         columns
         co_user.sql                                     Creates the CO database user
         customers.sql                                   Inserts for the customers table
         orders.sql                                      Inserts for the orders table
         order_items.sql                                 Inserts for the order_items table
         products.sql                                    Inserts for the products table
         sample_queries.sql                              Provides example SQL statements for data
                                                         analysis
         stores.sql                                      Inserts for the stores table




                                                                                                      4-23
                                                                                            Chapter 4
                                                                 CO Sample Schema Table Descriptions




         Table 4-37     CO Sample Schema Objects

          Object Type                                Objects
          Index                                      customers_name_i,
                                                     orders_customer_id_i,
                                                     orders_store_id_i, products_pk,
                                                     stores_pk, store_name_u, customers_pk,
                                                     customers_email_u,
                                                     store_at_least_one_address_c,
                                                     products_json_c, orders_pk,
                                                     orders_customer_id_fk,
                                                     orders_status_c, orders_store_id_fk,
                                                     order_items_order_id_fk,
                                                     order_items_product_id_fk,
                                                     order_items_pk, order_items_product_u
          Table                                      customers, stores, products, orders,
                                                     order_items
          View                                       customer_order_products,
                                                     store_orders, product_reviews,
                                                     product_orders


4.13 CO Sample Schema Table Descriptions
         Consider the columns of each table of CO sample schema.

         •   Table CO.CUSTOMERS
         •   Table CO.STORES
         •   Table CO.PRODUCTS
         •   Table CO.ORDERS
         •   Table CO.ORDER_ITEMS


4.13.1 Table CO.CUSTOMERS
         The table below lists CO.CUSTOMERS table description.

         Table 4-38     CO.CUSTOMERS Table Description

          Column Name                  Nulls Allowed?                Type
          CUSTOMER_ID                  NO                            INTEGER
          EMAIL_ADDRESS                NO                            VARCHAR2(255 CHAR)
          FULL_NAME                    NO                            VARCHAR2(255 CHAR)


4.13.2 Table CO.STORES
         The table below lists CO.STORES table description.




                                                                                              4-24
                                                                                           Chapter 4
                                                                CO Sample Schema Table Descriptions




         Table 4-39      Table CO.STORES Table Description

          Column Name                  Nulls Allowed?               Type
          STORE_ID                     NO                           INTEGER
          STORE_NAME                   NO                           VARCHAR2(255 CHAR)
          WEB_ADDRESS                  YES                          VARCHAR2(100 CHAR)
          PHYSICAL_ADDRESS             YES                          VARCHAR2(512 CHAR)
          LATITUDE                     YES                          NUMBER
          LONGITUDE                    YES                          NUMBER
          LOGO                         YES                          BLOB
          LOGO_MIME_TYPE               YES                          VARCHAR2(512 CHAR)
          LOGO_FILENAME                YES                          VARCHAR2(512 CHAR)
          LOGO_CHARSET                 YES                          VARCHAR2(512 CHAR)
          LOGO_LAST_UPDATED            YES                          DATE



                 Note:
                 The table has a constraint to verify either WEB_ADDRESS or PHYSICAL ADDRESS
                 is NOT NULL.



4.13.3 Table CO.PRODUCTS
         The table below lists CO.PRODUCTS table description.

         Table 4-40      Table CO.PRODUCTS Table Description

          Column Name                  Nulls Allowed?               Type
          PRODUCT_ID                   NO                           INTEGER
          PRODUCT_NAME                 NO                           VARCHAR2(255 CHAR)
          UNIT_PRICE                   YES                          NUMBER(10,2)
          PRODUCT_DETAILS              YES                          BLOB
          PRODUCT_IMAGE                YES                          BLOB
          IMAGE_MIME_TYPE              YES                          VARCHAR2(512 CHAR)
          IMAGE_FILENAME               YES                          VARCHAR2(512 CHAR)
          IMAGE_CHARSET                YES                          VARCHAR2(512 CHAR)
          IMAGE_LAST_UPDATED           YES                          DATE


4.13.4 Table CO.ORDERS
         The table below lists CO.ORDERS table description.




                                                                                             4-25
                                                                                         Chapter 4
                                                              CO Sample Schema Table Descriptions




         Table 4-41    Table CO.ORDERS Table Description

         Column Name                  Nulls Allowed?               Type
         ORDER_ID                     NO                           INTEGER
         ORDER_DATETIME               NO                           TIMESTAMP
         CUSTOMER_ID                  NO                           INTEGER
         ORDER_STATUS                 NO                           VARCHAR2(10 CHAR)
         STORE_ID                     NO                           INTEGER


4.13.5 Table CO.ORDER_ITEMS
         The table below lists CO.ORDER_ITEMS table description.

         Table 4-42    Table CO.ORDER_ITEMS Table Description

         Column Name                  Nulls Allowed?               Type
         ORDER_ID                     NO                           INTEGER
         LINE_ITEM_ID                 NO                           INTEGER
         PRODUCT_ID                   NO                           INTEGER
         UNIT_PRICE                   NO                           NUMBER(10,2)
         QUANTITY                     NO                           INTEGER




                                                                                           4-26
Index
A                               COUNTRY_REGION, 4-19
                                COUNTRY_REGION_ID, 4-19
ACCOUNT_MGR_ID, 4-9             COUNTRY_SUBREGION, 4-19
AD_COMPOSITE, 4-13              COUNTRY_SUBREGION_ID, 4-19
AD_FINALTEXT, 4-13              COUNTRY_TOTAL, 4-19
AD_FLTEXTN, 4-13                COUNTRY_TOTAL_ID, 4-19
AD_GRAPHIC, 4-13                CREDIT_LIMIT, 4-9
AD_HEADER, 4-13                 CSCN, 4-15, 4-16
AD_ID, 4-13                     CUST_ADDRESS, 4-9
AD_PHOTO, 4-13                  CUST_CITY, 4-19
AD_SOURCETEXT, 4-13             CUST_CITY_ID, 4-19
AD_TEXTDOCS_NTAB, 4-13          CUST_CREDIT_LIMIT, 4-19
AMOUNT_SOLD, 4-21               CUST_EFF_FROM, 4-19
                                CUST_EFF_TO, 4-19
                                CUST_EMAIL, 4-9, 4-19
C                               CUST_FIRST_NAME, 4-9, 4-19
CALENBDAR_QUARTER_ID, 4-22      CUST_GENDER, 4-19
CALENDAR_MONTH_DESC, 4-22       CUST_GEO_LOCATION, 4-9
CALENDAR_MONTH_ID, 4-22         CUST_ID, 4-19, 4-21
CALENDAR_MONTH_NAME, 4-22       CUST_INCOME_LEVEL, 4-19
CALENDAR_MONTH_NUMBER, 4-22     CUST_LAST_NAME, 4-9, 4-19
CALENDAR_QUARTER_DESC, 4-22     CUST_MAIN_PHONE_NUMBER, 4-19
CALENDAR_QUARTER_NUMBER, 4-22   CUST_MARITAL_STATUS, 4-19
CALENDAR_WEEK_NUMBER, 4-22      CUST_POSTAL_CODE, 4-19
CALENDAR_YEAR, 4-22             CUST_SRC_ID, 4-19
CALENDAR_YEAR_ID, 4-22          CUST_STATE_PROVINCE, 4-19
CATALOG_URL, 4-11               CUST_STATE_PROVINCE_ID, 4-19
CATEGORY_ID, 4-11               CUST_STREET_ADDRESS, 4-19
CHAIN_NO, 4-15, 4-16            CUST_TOTAL, 4-19
CHANNEL_CLASS, 4-18             CUST_TOTAL_ID, 4-19
CHANNEL_CLASS_ID, 4-18          CUST_VALID, 4-19
CHANNEL_DESC, 4-18              CUST_YEAR_OF_BIRTH, 4-19
CHANNEL_ID, 4-18, 4-21          customer_id, 4-24, 4-25
CHANNEL_TOTAL, 4-18             CUSTOMER_ID, 4-9, 4-10
CHANNEL_TOTAL_ID, 4-18
CITY, 4-7                       D
CO schema, 1-5
   objects, 4-23                Database Configuration Assistant
   scripts, 4-23                   using to install Sample Schemas, 2-1
COMMISSION_PCT, 4-6             DATE_OF_BIRTH, 4-9
CORRID, 4-15, 4-16              DAY_NAME, 4-22
COUNTRY_ID, 4-5, 4-7, 4-19      DAY_NUMBER_IN_MONTH, 4-22
COUNTRY_ISO_CODE, 4-19          DAY_NUMBER_IN_WEEK, 4-22
COUNTRY_NAME, 4-5, 4-19         DAYS_IN_CAL_MONTH, 4-22
COUNTRY_NAME_HIST, 4-19         DAYS_IN_CAL_QUARTER, 4-22



                                                                          Index-1
                                                                             Index


DAYS_IN_CAL_YEAR, 4-22          H
DAYS_IN_FIS_MONTH, 4-22
DAYS_IN_FIS_QUARTER, 4-22       HIRE_DATE, 4-6
DAYS_IN_FIS_YEAR, 4-22          HR schema
DELAY, 4-15, 4-16                  general description, 1-2
DEPARTMENT_ID, 4-5, 4-6            installing, 2-2
DEPARTMENT_NAME, 4-5            HR.COUNTRIES, 4-5
DEPT table, 1-1                 HR.DEPARTMENTS, 4-5
DEQ_TID, 4-15, 4-16             HR.EMPLOYEES, 4-6
DEQ_TIME, 4-15, 4-16            HR.JOB_HISTORY, 4-6
DEQUEUE_MSGID, 4-15, 4-16       HR.JOBS, 4-6
DSCN, 4-15, 4-16                HR.LOCATIONS, 4-7
                                HR.REGIONS, 4-7
E
                                I
EEQ_UID, 4-15, 4-16
EMAIL, 4-6                      image_charset, 4-25
email_id, 4-24                  image_filename, 4-25
EMP table, 1-1                  image_last_updated, 4-25
EMPLOYEE_ID, 4-6                image_mime_type, 4-25
END_DATE, 4-6                   INCOME_LEVEL, 4-9
END_OF_CAL_MONTH, 4-22          installation
END_OF_CAL_QUARTER, 4-22            CO schema, 2-5
END_OF_CAL_YEAR, 4-22               github, 2-5
END_OF_FIS_MONTH, 4-22              GitHub, 2-3
END_OF_FIS_QUARTER, 4-22            manual, of Sample Schemas, 2-3
END_OF_FIS_YEAR, 4-22               using Database Configuration Assistant, 2-1
ENQ_TID, 4-15, 4-16             installing sample schema, 2-1
ENQ_TIME, 4-15, 4-16            installing Sample Schemas, 2-1
ENQ_UID, 4-15, 4-16             Installing Sample Schemas, 2-1
EO.ORDERS, 4-10                 IX schema
EXCEPTION_QSCHEMA, 4-15, 4-16       general description, 1-4
EXCEPTION_QUEUE, 4-15, 4-16         scripts, 4-14
EXPIRATION, 4-15, 4-16          IX.ORDERS_QUEUETABLE, 4-15
                                IX.STREAMS_QUEUE_TABLE, 4-16
F
                                J
FIRST_NAME, 4-6
FISCAL_MONTH_DESC, 4-22         JOB_ID, 4-6
FISCAL_MONTH_ID, 4-22           JOB_TITLE, 4-6
FISCAL_MONTH_NAME, 4-22
FISCAL_MONTH_NUMBER, 4-22
FISCAL_QUARTER_DESC, 4-22
                                L
FISCAL_QUARTER_ID, 4-22         LANGUAGE_ID, 4-11
FISCAL_QUARTER_NUMBER, 4-22     LAST_NAME, 4-6
FISCAL_WEEK_NUMBER, 4-22        latitude, 4-24
FISCAL_YEAR, 4-22               line_item_id, 4-26
FISCAL_YEAR_ID, 4-22            LINE_ITEM_ID, 4-11
full_name, 4-24                 LIST_PRICE, 4-11
                                LOCAL_ORDER_NO, 4-15, 4-16
G                               LOCATION_ID, 4-5, 4-7, 4-12
                                logo, 4-24
GENDER, 4-9                     logo_charset, 4-24
                                logo_filename, 4-24
                                logo_last_updated, 4-24



                                                                         Index-2
                                                                    Index


logo_mime_type, 4-24            PRMO_CATEGORY_ID, 4-21
longitude, 4-24                 PROD_CATEGORY, 4-20
                                PROD_CATEGORY_DESC, 4-20
                                PROD_DESC, 4-20
M                               PROD_EFF_TO, 4-20
MANAGER_ID, 4-5, 4-6            PROD_ID, 4-18, 4-20, 4-21
MARITAL_STATUS, 4-9             PROD_LIST_PRICE, 4-20
MAX_SALARY, 4-6                 PROD_NAME, 4-20
MIN_PRICE, 4-11                 PROD_SRC_ID, 4-20
MIN_SALARY, 4-6                 PROD_STATUS, 4-20
MSGID, 4-15, 4-16               PROD_SUBCATEGORY, 4-20
                                PROD_SUBCATEGORY_DESC, 4-20
                                PROD_SUBCATEGORY_ID, 4-20
N                               PROD_SUPPLIER_ID, 4-20
NLS_LANGUAGE, 4-9               PROD_TOTAL, 4-20
NLS_TERRITORY, 4-9              PROD_TOTAL_ID, 4-20
                                PROD_UNIT_OF_MEASURE, 4-20
                                PROD_VALID, 4-20
O                               PROD_WEIGHT_CLASS, 4-20
                                PRODUCT_DESCRIPTION, 4-11
OC subschema
                                product_details, 4-25
    general description, 1-4
                                product_id, 4-25, 4-26
OE schema
                                PRODUCT_ID, 4-10, 4-11, 4-13
    general description, 1-3
                                product_image, 4-25
    scripts, 4-7
                                product_name, 4-25
OE.CUSTOMERS, 4-9
                                PRODUCT_NAME, 4-11
OE.INVENTORIES, 4-10
                                PRODUCT_STATUS, 4-11
OE.ORDER_ITEMS, 4-11
                                PROMO_BEGIN_DATE, 4-21
OE.PRODUCT_DESCRIPTIONS, 4-11
                                PROMO_CATEGORY, 4-21
OE.PRODUCT_INFORMATION, 4-11
                                PROMO_COST, 4-21
OE.WAREHOUSES, 4-12
                                PROMO_END_DATE, 4-21
ORDER_DATE, 4-10
                                PROMO_ID, 4-18, 4-21
order_datetime, 4-25
                                PROMO_NAME, 4-21
order_id, 4-25, 4-26
                                PROMO_SUBCATEGORY, 4-21
ORDER_ID, 4-10, 4-11
                                PROMO_SUBCATEGORY_ID, 4-21
ORDER_MODE, 4-10
                                PROMO_TOTAL, 4-21
order_status, 4-25
                                PROMO_TOTAL_ID, 4-21
ORDER_STATUS, 4-10
                                PROMOTION_ID, 4-10
ORDER_TOTAL, 4-10

P                               Q
                                Q_NAME, 4-15, 4-16
PHONE_NUMBER, 4-6
                                quantity, 4-26
PHONE_NUMBERS, 4-9
                                QUANTITY, 4-11
physical_address, 4-24
                                QUANTITY_ON_HAND, 4-10
PM schema
                                QUANTITY_SOLD, 4-21
   general description, 1-4
   scripts, 4-12
PM.PRINT_MEDIA, 4-13            R
POSTAL_CODE, 4-7
PRD_CATEGORY_ID, 4-20           RECIPIENT_KEY, 4-15, 4-16
PRD_EFF_FROM, 4-20              REGION_ID, 4-5, 4-7
PRD_MIN_PRICE, 4-20             REGION_NAME, 4-7
PRD_PACK_SIZE, 4-20             resetting the Sample Schemas, 2-4
PRIORITY, 4-15, 4-16            RETRY_COUNT, 4-15, 4-16




                                                                       3
                                                                           Index



S                                       store_name, 4-24
                                        STREET_ADDRESS, 4-7
SALARY, 4-6                             SUPPLIER_ID, 4-11
SALES_REP_ID, 4-10
sample schema, 2-1
Sample Schema
                                        T
    scripts                             table
        OE, 4-7                             description, 4-24–4-26
        PM, 4-12                        TIME_DESC, 4-18
    scripts, general information, 4-1   TIME_ID, 4-21, 4-22
Sample Schemas                          TIME_MANAGER_INFO, 4-15, 4-16
    design principles, 1-1              TRANSLATED_DESCRIPTION, 4-11
    general information, 1-1            TRANSLATED_NAME, 4-11
    installing, 2-1
    scripts
        master, 4-1                     U
SCOTT schema, 1-1                       UNIT_COST, 4-18
SENDER_ADDRESS, 4-15, 4-16              unit_price, 4-25, 4-26
SENDER_NAME, 4-15, 4-16                 UNIT_PRICE, 4-11, 4-18
SENDER_PROTOCOL, 4-15, 4-16             USER_DATA, 4-15, 4-16
SH schema                               USER_PROP, 4-15, 4-16
    general description, 1-5
    scripts, 4-17
SH.CHANNELS, 4-18                       W
SH.COSTS, 4-18
                                        WAREHOUSE__NAME, 4-12
SH.COUNTRIES, 4-19
                                        WAREHOUSE_ID, 4-10, 4-12
SH.CUSTOMERS, 4-19
                                        WAREHOUSE_SPEC, 4-12
SH.PRODUCTS, 4-20
                                        WARRANTY_PERIOD, 4-11
SH.SALES, 4-21
                                        web_address, 4-24
SH.TIMES, 4-22
                                        WEEK_ENDING_DAY, 4-22
START_DATE, 4-6
                                        WEEK_ENDING_DAY_ID, 4-22
STATE, 4-15, 4-16
                                        WEIGHT_CLASS, 4-11
STATE_PROVINCE, 4-7
                                        WH_GEO_LOCATION, 4-12
STEP_NO, 4-15, 4-16
store_id, 4-24, 4-25




                                                                        Index-4

