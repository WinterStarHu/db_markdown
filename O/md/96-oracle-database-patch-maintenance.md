# 96. Oracle Database Patch Maintenance

> 源文件: `en/dbptc/oracle-database-patch-maintenance.pdf`

Oracle® Database
Oracle Database Patch Maintenance
Release 19c and Later Releases
F31334-07
June 2026




                               Patch Delivery Methods for Oracle Database
                               In this article, you can learn about patch delivery methods for Oracle Database 19c
                               and later versions.
                               •    Introduction to Oracle AI Database Patch Maintenance
                                           Discover how reactive patch maintenance differs from proactive patch
                                           maintenance.
                               •    Proactive Maintenance with RUs and MRPs
                                          Proactive maintenance is accomplished by proactively applying a routine
                                          quarterly patch bundle (Release Update) that is available from the My
                                          Oracle Support (MOS) Customer Portal for each Oracle Database software
                                          release.
                               •    Reactive Maintenance with One-off Patches
                                          All methods allow one-off patches to be installed, but the version of a one-
                                          off patch that is required may vary depending on the patching method.
                               •    Streamlining Your Update Experience with Oracle Update Advisor
                                          Oracle Update Advisor is a software update recommendation framework
                                          that provides accurate, up-to-date information to keep software at
                                          recommended versions.
                               •    Monthly Recommended Patches (MRPs)
                                          For Linux x86-64 platforms, MRPs provide a method to apply all Oracle
                                          recommended fixes easily for the current RU.
                               •    Patch Conflict Resolution
                                          If interim patches are used in conjunction with one of the proactive patching
                                          methods, then there may be patch conflicts.
                               •    Patching with Oracle Fleet Patching and Provisioning (Oracle FPP)
                                          Oracle recommends the Oracle FPP service as the maintenance method
                                          for Oracle Database deployed with Oracle RAC, Exadata, and Oracle Data
                                          Guard.
                               •    Patching Oracle Database and Oracle GoldenGate
                                          When you use Oracle GoldenGate with Oracle Database, you must ensure
                                          that Oracle GoldenGate processes are shut down before patching the
                                          database.




Oracle Database Patch Maintenance
F31334-07                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 1 of 18
                               •    Frequently Asked Questions
                                          This section lists frequently asked questions.
                               •    Current Database Proactive Patches
                                          The following table gives information on available proactive database
                                          related patches by platform, environment, and version.


                               Introduction to Oracle AI Database Patch Maintenance
                               Discover how reactive patch maintenance differs from proactive patch maintenance.
                               The Critical Patch Update (CPU) is the primary mechanism for the delivery of security
                               bug fixes for all Oracle on-premises products. Critical Patch Updates are released
                               quarterly on the third Tuesday of January, April, July, and October, and published on
                               the Critical Patch Updates and Security Alerts page. Oracle retains the ability to issue
                               out of schedule patches or workaround instructions in case of particularly critical
                               vulnerabilities and/or when active exploits are reported in the wild. This program is
                               known as the Security Alert program.
                               To protect your Oracle database estate from new AI-enabled threats, Oracle strongly
                               recommends that you upgrade the major version of your databases to either Oracle
                               Database 19c or Oracle AI Database 26ai. Oracle also strongly recommends that
                               customers apply very recent quarterly Release Updates (RUs) to their databases. For
                               more information about these recommendations, see Recommendations to Help
                               Protect Oracle Databases from Emerging AI-enabled Security Threats (PNEWS3015):
                               Recommendations to Help Protect Oracle Databases from Emerging AI-enabled
                               Security Threats PNEWS3015
                               You can obtain up-to-date information on Oracle's Critical Patch Updates, Security
                               Alerts and Bulletins site:
                               Critical Patch Updates, Security Alerts and Bulletins
                               The following terms are often used to refer to patches:
                               Reactive Patches react to specific maintenance issues. They are characterized as
                               follows:
                               •    Usually delivered as “Interim Patches”
                               •    Historically known as “one-off” patches
                               •    Are provided on demand for a given “defect, version, platform” combination
                               •    Go through basic sanity tests
                               •    Certain reactive fixes may be included in future Release Updates
                               Proactive Patches provide recommended updates for all Oracle AI Database
                               customers. Proactive patches employ bundles of patches optimized to be delivered
                               together. Starting with Oracle AI Database 26ai, these patch bundles will also be
                               provided as gold images.
                               Proactive patches (patch bundles) are characterized as follows:
                               •    Address high impact bugs that affect a given configuration




Oracle Database Patch Maintenance
F31334-07                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 2 of 18
                               •    Contain proven, low-risk fixes
                               •    Include cumulative prior fixes
                               •    Undergo additional levels of testing, determined by the features affected by the
                                    patch
                               •    Are available on "My Oracle Support" by clicking on the Patches tab
                               •    Are available as Release Updates (RU) and Monthly Recommended Patches
                                    (MRPs)
                               Starting with Oracle AI Database, for proactive patch bundles, Oracle recommends
                               that you perform software maintenance using one of the following methods:
                               •    Database Configuration Assistant (DBCA): Use DBCA as the recommended
                                    software maintenance method for single-instance Oracle databases.
                               •    Oracle Fleet Patching and Provisioning (FPP): Use FPP as the recommended
                                    software maintenance method for Oracle Real Application Clusters (Oracle RAC)
                                    databases, and for Oracle databases deployed with Oracle Data Guard. In
                                    addition, Oracle recommends that you use FPP for larger database fleets, and
                                    with Exadata databases.
                               You can continue to use OPatch and OPatchAuto for in-place and out-of-place
                               patching (installing the software update into a new Oracle home). Oracle recommends
                               that all patch operations are performed as Out-of-Place patching.


                                        Caution
                                        To avoid the risk of logical corruption, before you start patch maintenance,
                                        ensure that all running Oracle Data Pump jobs are stopped before applying
                                        patches or before performing any other software maintenance. You also must
                                        not start any new Oracle Data Pump jobs until the patching process is fully
                                        completed. Oracle strongly recommends that you stop all data movement
                                        operations of any kind during maintenance windows. For more information,
                                        see "Datapatch: Database 12c or later Post Patch SQL Automation KB148594
                                        (formerly My Oracle Support 1585822.1)".


                               For more information about preparing a maintenance plan for your release, see the
                               following My Oracle Support notes:
                               Related Topics
                               •    Critical Patch Updates, Security Alerts and Bulletins
                               •    Primary Note for Database Quarterly Release Updates KB106822 (formerly My
                                    Oracle Support 888.1)
                               •    Oracle Database 19c and Oracle AI Database 26ai Important Recommended One-
                                    off Patches KB188772 (formerly My Oracle Support 555.1)
                               •    Release Schedule of Current Database Releases PNEWS1360 (formerly My
                                    Oracle Support 742060.1)
                               •    Datapatch: Database 12c or later Post Patch SQL Automation KB148594 (formerly
                                    My Oracle Support 1585822.1)




Oracle Database Patch Maintenance
F31334-07                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 3 of 18
                               Proactive Maintenance with RUs and MRPs
                               Proactive maintenance is accomplished by proactively applying a routine quarterly
                               patch bundle (Release Update) that is available from the My Oracle Support (MOS)
                               Customer Portal for each Oracle Database software release.
                               Release Updates (RUs) are release quarterly: Third Tuesday of January, April, July
                               and October. Each RU will be given a maximum of six Monthly Recommended
                               Patches (MRPs), released monthly.
                               Patch updates are announced in the following locations
                               •    Primary Note for Database Proactive Patch Program (Doc ID 888.1)
                               •    Monthly Recommended Patches (MRPs)
                               •    Critical Patch Updates, Security Alerts and Bulletins
                               Quarterly patch updates are announced on the Critical Patch Updates, Security Alerts
                               and Bulletins page each page each January, April, July, and October. Monthly
                               Recommended Patches are released each month in between a quarterly Release
                               Update, and are cumulative bundles of recommended patches. To receive email
                               notifications when quarterly patch bundles are available, subscribe to Oracle Security
                               alerts.
                               •    Release Updates (RUs)
                                          RUs are highly tested bundles of critical fixes which enable you to avoid
                                          known issues. They usually contain the following type of fixes: security,
                                          regression (bug), optimizer, and functional (which may include feature
                                          extensions as well).
                               •    Monthly Recommended Patches (MRP)
                                          Starting with update 19.17, Oracle is providing MRPs for Linux x86-64 to
                                          provide proactive patching between Release Updates.
                               •    RUs and MRPs Content Differences
                                         There are content differences between release updates (RUs) and monthly
                                         recommended patches (MRPs).
                               •    Additional Proactive Patches
                                           In addition to RUs and MRPs, there are quarterly full stack download
                                           patches and combo patches, as well as other proactive patches.
                               •    Proactive Apply Frequency Patching Strategy
                                          Oracle recommends that you keep your database and Oracle Grid
                                          Infrastructure software current by applying the most recent Release
                                          Updates (RUs).
                               Related Topics
                               •    Primary Note for Database Proactive Patch Program (Doc ID 888.1)
                               •    Subscribe to Oracle Security Alerts

                               Release Updates (RUs)




Oracle Database Patch Maintenance
F31334-07                                                                                                  June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                       Page 4 of 18
                               RUs are highly tested bundles of critical fixes which enable you to avoid known issues.
                               They usually contain the following type of fixes: security, regression (bug), optimizer,
                               and functional (which may include feature extensions as well).
                               Oracle recommends that you stay current by using RUs. By doing this, you minimize
                               the chance of encountering known bugs and security vulnerabilities.
                               The nomenclature for the RU patches is a five-field number, such as 19.7.0.0.0.
                               •    The first of the five fields indicates the year that this annual set of new features
                                    (also known as, this release) was first available.
                               •    The second field shows the RU level that has been applied against that annual
                                    new features release. 19.7.0.0 would designate the seventh quarterly RU for
                                    Oracle Database 19c. Please note that several of the initial RUs are internal to
                                    Oracle and the first publicly available RU is often the forth quarterly RU, as in
                                    19.4.0.0. That first publicly available RU is provided the next quarter after the
                                    release is publicly available.
                               •    The third field refers to the RUR (Discontinued January 2023).
                               •    The fourth field is reserved for future use and is currently always set to 0.
                               •    Although only the first three fields are commonly used, the fifth field may show a
                                    numerical value that redundantly clarifies the release date of the RU, such as
                                    19.7.0.0.200414.

                               Monthly Recommended Patches (MRP)
                               Starting with update 19.17, Oracle is providing MRPs for Linux x86-64 to provide
                               proactive patching between Release Updates.
                               In October 2022, starting with RU 19.17, Oracle is modifying its proactive patch
                               program between Release Updates to use Monthly Recommended Patches. Release
                               Update Revisions (RURs) are deprecated, and planned to be discontinued after
                               January 2023. MRPs provide many of the same features of the RUR patches.
                               However, they are offered only for Oracle Database 19c on Linux x86-64 platforms.
                               MRPs will be delivered for each RU in the 6 months following each RU's release,
                               starting with Oracle Database 19c RU19.17 (mid-October, 2022). MRPs will include
                               the fixes documented in "Oracle Database Important Recommended Patches" (My
                               Oracle Support Doc ID 555.1), plus the prior MRPs for the RU. While RUs will continue
                               to be available on all supported platforms, MRPs will only be offered on Linux x86-64
                               platforms. Customers can continue to request one-off patches on all supported
                               platforms. If a particular month does not have new recommended fixes for an RU, then
                               no MRP will be released, and an annotation will be added in the relevant My Oracle
                               Support notes to avoid confusion. Merge patches will be provided if there are conflicts
                               between one-off patches and the latest MRP for an RU.
                               MRPs are a collection of one-off patches bundled together. Unlike an RU, an MRP
                               does not affect the release revision number. The release number continues to be
                               designated by the RU number. The MOS Conflict Checker will treat the MRP fixes as it
                               does with other bundled patches, and regular conflict resolution will take place. The
                               patches in an MRP are tracked in the Oracle Inventory directory (oraInventory),
                               which is updated to indicate which one-off are installed from the MRP.




Oracle Database Patch Maintenance
F31334-07                                                                                                       June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                            Page 5 of 18
                               MRPs are provided as separate patches for the database (RDBMS), Oracle
                               Clusterware (OCW), Advanced Cluster File System (ACFS) and Rapid Home
                               Provisioning (RHP). Each MRP is packaged as a bundle of One-off patches that you
                               can apply by using the command opatch napply. You can apply or rollback by using
                               the opatchauto tool.

                               Each MRP includes the latest critical and regression fixes, but also contains the critical
                               content that was released six months prior. By choosing to wait on taking new RU
                               content by six months, you can take a more conservative approach to Oracle
                               Database software maintenance, but you still risk the chance of hitting known issues
                               that are fixed in the most recent RU. The main benefit of this patching strategy is that,
                               if there are any regressions reported on the base RU or succeeding MRP, then they
                               will be fixed in later MRPs.
                               MRPs are characterized as follows:
                               •    MRPs are cumulative: each new MRP will contain the patches in any earlier MRPs
                                    released for a given release update, as well as the current set of one-off patches
                                    that Oracle recommends for the RU plus the current set of recommended one-off
                                    patches for the RU documented in Oracle Database 19c and Oracle AI Database
                                    26ai Important Recommended One-off Patches KB188772.
                               •    MRPs do not change the release number
                               •    MRPs are deployed using Opatchauto
                               •    MRPs are available only on the Linux x86-64 platform
                               Related Topics
                               •    Oracle Database 19c and Oracle AI Database 26ai Important Recommended One-
                                    off Patches KB188772

                               RUs and MRPs Content Differences
                               There are content differences between release updates (RUs) and monthly
                               recommended patches (MRPs).
                               The following table describes the differences:


                                Criteria                      Release Update (RU)          MRPs
                                Cadence                       Quarterly                    Monthly for Release 19c on
                                                                                           Linux x86-64
                                Zero downtime (ZDT)           RAC Rolling                  RAC Rolling
                                Security fixes                Included                     May include CPU Alerts and
                                                                                           high CVSS fixes
                                Regression fixes              Included                     Included
                                Proactive functional fixes    Included                     Not included
                                Optimizer plan changes (off by Included                    Not included
                                default)
                                Functional enhancements       Included                     Not included
                                (minor)
                                Emergency one-offs            Included                     Included




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                         Page 6 of 18
                                Criteria                      Release Update (RU)           MRPs
                                Supported operating systems   All supported platforms       Release 19c on Linux x86-64

                               Monthly Recommended Patches (MRPs) are offered for Oracle Database 19c on Linux
                               x86-64. Both RUs and MRPs are cumulative bundle patches. Each of them include all
                               the fixes of the previous patches. You can install directly whatever bundle patch as
                               long as its year digits are the same as the digits of your current installation and the
                               bundle was released at the same time or after your current installed version.
                               For Oracle Database on Linux x86-64 platforms, RUs and MRPs are designed to
                               coexist and allow future RUs and MRPs to be installed.
                               Moving from one MRP to the next (for example 221115 to 221220) results in taking up
                               all the functional fixes in the underlying RU (in this case 19.17), but with an additional
                               month of more recent patch updates.

                               Additional Proactive Patches
                               In addition to RUs and MRPs, there are quarterly full stack download patches and
                               combo patches, as well as other proactive patches.
                               Quarterly Full Stack Download Patch and Combo Patch
                               Oracle delivers a number of different patches packaged together. For example:
                               •    Quarterly Full Stack Download Patch for Exadata, which includes the quarterly
                                    Grid Infrastructure RU along with the OJVM update and other Exadata system
                                    patches in a single download.
                               •    Combo Patch of OJVM RU and Database RU
                               Other Proactive Patches
                               Oracle produces some proactive patches for very specific purposes outside of the
                               normal update and revision cycle. Such patches are usually delivered as "Interim
                               Patches". For example, special time zone patches are released every six months for
                               customers who require systems to use latest time zone data.


                                        Note
                                        If you are using Oracle Grid Infrastructure software in addition to Oracle
                                        Database software, then you should use the parallel Oracle Grid Infrastructure
                                        RU. These Oracle Grid Infrastructure RUs include everything that the parallel
                                        database RU contains.



                               Proactive Apply Frequency Patching Strategy
                               Oracle recommends that you keep your database and Oracle Grid Infrastructure
                               software current by applying the most recent Release Updates (RUs).




Oracle Database Patch Maintenance
F31334-07                                                                                                     June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                          Page 7 of 18
                               Apply frequency defines how often you apply an update to the database software. It
                               does not define selecting a Release Update that is not the latest RU. Oracle
                               recommends that you always update to the latest available RU for your release.

                               Release Update Lag and Apply Frequency
                               Oracle recommends you install the latest Release Update (RU), whenever you
                               perform an installation. RUs include the most recent security, regression, and critical
                               fixes. Applying RUs minimizes the chance of encountering known bugs and security
                               vulnerabilities. Staying current with RUs reduces the likelihood of requiring separate
                               interim one-off patches, which lead to unique software baselines and a potential for
                               ongoing costly patch maintenance.


                                        Note
                                        As part of your proactive maintenance policy, Oracle recommends that you
                                        apply quarterly Release Updates (RU) promptly, use Oracle Database security
                                        tools and features, and adopt security best practices. You can obtain up-to-
                                        date information on Oracle's Critical Patch Updates, Security Alerts and
                                        Bulletins site:
                                        Critical Patch Updates, Security Alerts and Bulletins



                               Example 1-1         Apply the Most Recent RU each quarter
                               This is the default plan for single-instance databases. The simplest maintenance
                               schedule plan is to apply the latest Release Update (RU_Latest) quarterly, and never
                               apply MRPs.


                                        Note
                                        If you choose this strategy, then Oracle recommends that your apply
                                        frequency is quarterly (every three months).


                               Table 1-1       Quarterly RU Software Maintenance Plan (RU_N)

                                Apply Frequency             Release Updates (RU_N)
                                Monthly                     Not applicable
                                Quarterly                   Every 3 months - Apply RU_Latest (N)
                                Semiannually                Every 6 months - Apply RU_Latest (N)
                                Annually                    Every 12 months - Apply RU_Latest (N)

                               Example 1-2         Apply the most recent quarterly RU and most recent MRP for that
                               RU
                               RU_LatestNN




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                         Page 8 of 18
                                        Note
                                        If you choose this strategy, then Oracle recommends that your apply
                                        frequency is quarterly (every three months).


                               Table 1-2 RU (RU_N) and Monthly Recommended Patches Software
                               Maintenance Plan (MRP_N)

                                Apply Frequency            RU (RU_Latest) + MRP_N
                                Monthly                    Every 1 month - Apply RU_Latest + MRP_N
                                Quarterly                  Every 1 month - Apply RU_Latest + Recommended_Latest_N
                                Semiannually               Every 6 months - Apply RU_Latest + Recommended_Latest_N
                                Annually                   Every 12 months - Apply RU_Latest + Recommended_Latest_N


                               Reactive Maintenance with One-off Patches
                               All methods allow one-off patches to be installed, but the version of a one-off patch
                               that is required may vary depending on the patching method.
                               Windows platforms do not support normal “one-off patches”. See My Oracle Support
                               Note 2337415.1 for details of current and historic proactive patches.
                               The one-off patches are delivered as standalone on request for a given “defect,
                               version, platform” combination (also known as “Interim Patches”).
                               •    One-off patches are provided on top of any release or updates for supported
                                    version as long as technically feasible.
                               •    One-off patches go through basic sanity tests.
                               •    One-off patches are considered for inclusion in an update based on technical
                                    severity or blast radius.
                               Oracle recommends you to apply the update including the fix. For an additional
                               discussion of the pros and cons of asking for one-off bug fixes instead of waiting on
                               RUs, see My Oracle Support Note 2648544.1.


                               Streamlining Your Update Experience with Oracle Update
                               Advisor
                               Oracle Update Advisor is a software update recommendation framework that provides
                               accurate, up-to-date information to keep software at recommended versions.
                               •    What is Oracle Update Advisor
                                          Oracle Update Advisor analyzes your Oracle Database and Grid
                                          Infrastructure homes, identifies necessary updates, and delivers
                                          preconfigured deployment packages.




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                         Page 9 of 18
                               •    How Do I Get Started with Oracle Update Advisor
                                         To get started with Oracle Update Advisor, you just need your Oracle user
                                         information, secure HTTP, and a supported Oracle software maintenance
                                         tool.
                               •    Example of Using Oracle Update Advisor with DBCA
                                         See how you can use Database Configuration Assistant (DBCA) with the
                                         Oracle Update Advisor features to simplify proactive checks during
                                         maintenance.
                               •    Example of Using Oracle Update Advisor with Oracle FPP
                                         Oracle recommends that you use Oracle Fleet Patching and Provisioning
                                         (Oracle FPP) with the Oracle Update Advisor features to maintain Oracle
                                         Real Application Clusters (Oracle RAC) databases.

                               What is Oracle Update Advisor
                               Oracle Update Advisor analyzes your Oracle Database and Grid Infrastructure homes,
                               identifies necessary updates, and delivers preconfigured deployment packages.
                               Maintaining software is not easy. To understand what you need to maintain your
                               software enterprise security and functionality, administrators must review multiple
                               product information sources, including My Oracle Support documents, and support
                               recommendation technical briefs. You then must apply that information in accordance
                               with your maintenance polices.

                               Streamlined Access to Updates
                               Oracle Update Advisor provides you with a powerful software update recommendation
                               framework to streamline your maintenance. The advisor analyzes your Oracle
                               Database and Oracle Grid Infrastructure homes, and identifies up-to-date guidance
                               based on your defined maintenance policy, in a single, easy-to-understand report.
                               Oracle Update Advisor also provides you with a preconfigured, fully functional gold
                               image zip file that you can use to simplify the deployment of consistent operating
                               system and Oracle software updates across your enterprise.
                               The Oracle Update Advisor commands are added to the Configuration Assistant
                               (DBCA) and Oracle Fleet Patching and Provisioning (FPP). With the release of
                               Database Configuration Assistant Utility (dbcactl) , a lightweight self extractable
                               executable version of the Database Configuration Assistant, DBCA now also supports
                               Oracle Database 19c. Oracle Update Advisor is not available with Oracle Database
                               21c. These commands enable you to provide to Oracle information that can help you
                               to maintain the database and Grid Infrastructure software at recommended versions.
                               Other Oracle tools are planned to interact with the Oracle Update Advisor in the future.

                               Accurate Software Health Status, Up-to-Date Version Guidance
                               Oracle Update Advisor provides two fundamental functions:
                               •    Software Status
                               •    Software Recommendations




Oracle Database Patch Maintenance
F31334-07                                                                                                  June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                      Page 10 of 18
                               Software Status indicates whether the currently installed software meets Oracle's
                               current recommendations. When the installed software does not meet current
                               recommendations, Oracle Update Advisor provides a list of Software
                               Recommendations and also a software image of updates and maintenance fixes
                               that you can use to bring your software up to the current recommendations for your
                               software. That image is then used to create a new Oracle Home that meets the
                               software recommendations.

                               Where to learn more about Oracle Update Advisor
                               The "Oracle Update Advisor API Reference and Integration Guide" is now available
                               directly on Oracle Help Center, without requiring a login to Oracle Support:
                               Oracle AI Database Oracle Update Advisor API Reference and Integration Guide
                               The Knowledge Base article KB886700 continues to be available.
                               Related Topics
                               •    Oracle Update Advisor API Reference and Integration Guide KB886700

                               How Do I Get Started with Oracle Update Advisor
                               To get started with Oracle Update Advisor, you just need your Oracle user information,
                               secure HTTP, and a supported Oracle software maintenance tool.

                               What do you need?
                               Using Oracle Update Advisor is simple, as it enhances the use of features you already
                               use. To enable Oracle Update Advisor functionality, you just need the following:
                               •    A valid Oracle Support contract, Customer Support Identifier (CSI) number, and a
                                    My Oracle Support user
                               •    Secure HTTP (HTTPS) network connectivity to Data Transport Services (DTS),
                                    https://transport.oracle.com to transport information for obtaining proactive advice
                                    on product use and configurations
                               •    Oracle Object Store service, which is required to download the Oracle Update
                                    Advisor image.


                                        Note
                                        Oracle Update Advisor uses Data Transport Services (DTS) to handle
                                        customer registration for Oracle Update Advisor, to upload configuration data
                                        (such as RU and patch inventory), and to deliver patch update status and
                                        recommendations.



                               How does it work?




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 11 of 18
                               Using Oracle Update Advisor can be as simple as 1, 2, 3:
                               1.   Register a My Oracle Support user for the Oracle Update Advisor service.
                               2.   Use either Database Configuration Assistant with the Database Configuration
                                    Assistant Utility (dbcactl) command, which includes the Oracle Update Advisor
                                    options, or Fleet Patching and Provisioning (FPP) to run a check on the software
                                    status of an installed Oracle home. The dbcactl command syntax is identical with
                                    the dbca command syntax,
                               3.   Review the status report. If the status is not green, then download and install the
                                    recommended software image.


                                        Note
                                        the Database Configuration Assistant Utility software package is only
                                        available on Linux.


                               Related Topics
                               •    Overview of Object Storage service
                               •    Database Configuration Assistant Utility (dbcactl) - Standalone Software Package
                                    (Doc ID 3099785.1)

                               Example of Using Oracle Update Advisor with DBCA
                               See how you can use Database Configuration Assistant (DBCA) with the Oracle
                               Update Advisor features to simplify proactive checks during maintenance.
                               If your preferred patching tool is DBCA then you just need to add an Oracle Update
                               Advisor command to your patching process.
                               For Database Configuration Assistant Utility (dbcactl), you must first download and
                               install the utility from Oracle Support (Support for Oracle Cloud Infrastructure and
                               Cloud applications). Refer to "Database Configuration Assistant Utility (dbcactl) -
                               Standalone Software Package (Doc ID 3099785.1)".
                               To register the user for Oracle Update Advisor, use the following command syntax,
                               where sso_username is the name of the Oracle user account, and csi_number is the
                               Customer Support Identifier (CSI) number

                               dbcactl -managePatches -silent -registerUser -ssoUserName sso_username -
                               csiNumber csi_number


                               To check software service, use the following command syntax:

                               dbcactl -managePatches -checkPatchStatus -silent


                               Example of Using Oracle Update Advisor with Oracle FPP




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 12 of 18
                               Oracle recommends that you use Oracle Fleet Patching and Provisioning (Oracle
                               FPP) with the Oracle Update Advisor features to maintain Oracle Real Application
                               Clusters (Oracle RAC) databases.
                               To manage the maintenance updates in your cluster, you use the Oracle Fleet
                               Patching and Provisioning Control (RHPCTL) command-line utility with Oracle Update
                               Advisor commands.
                               For maintenance with Oracle Update Advisor, you use Oracle Fleet Patching and
                               Provisioning in Local Mode. This enables you to perform version updates on a local
                               Oracle RAC Cluster without any configuration except for connectivity to the Oracle
                               Update Advisor. See how in this example:
                               1.   Register with Oracle Update Advisor using the command rhpctl manage
                                    updateadvisor update. The syntax is as follows:

                                    $ rhpctl manage updateadvisor
                                          {-registeruser -ssousername <sso_username>
                                                [-csinumber <csi_number]
                                                [-proxyserver <proxy_server> -proxyport <port_number>
                                                      [-proxyuser <proxy_user>] ]
                                                [-endpoint <endpoint_url>] |
                                           -unregisteruser}


                                    These options are as follows:
                                    •     -registeruser: Register user to Oracle update advisor
                                    •     -ssousername <sso_username>: SSO user name
                                    •     csinumber <csi_number>: Customer Support Identifier (CSI)
                                    •     -proxyserver <proxy_server>: Proxy server IP/name
                                    •     -proxyport <proxy_port>: Proxy server port number
                                    •     -proxyuser <proxy_user>: Proxy server user name
                                    •     -endpoint <endpoint_url> Oracle Update Advisor end point URL
                                    •     -unregisteruser Unregister the user from Oracle Update Advisor
                                    In this example, the My Oracle Support user is enterprise1, the CSI number is
                                    123456789, the proxy server is 192.0.2.1, the proxy port is 20001, and the proxy
                                    user maint1:
                                    rhpctl manage updateadvisor -registeruser --ssousername enterprise1 -
                                    csinumber 123456789 -proxyserver -192.0.2.1 -proxyport 20001 -
                                    proxyuser maint1
                               2.   Use the command rhpctl evaluate patch to check the status of the database or
                                    Grid Infrastructure home that you are maintaining. In this example, we check the
                                    Oracle Grid Infrastructure image GI_1928:

                                    rhpctl evaluate patch       -image GI_1928 iso -path




Oracle Database Patch Maintenance
F31334-07                                                                                                  June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                      Page 13 of 18
                               3.   After you validate the software installed on that test system, you can deploy the
                                    gold image software version on your production environment
                               This is a simple example. For examples using a centralized approach, you can refer to
                               the Oracle Fleet Patching and Provisioning documentation. With Oracle Fleet Patching
                               and Provisioning, you can centrally manage a complete Oracle Database landscape,
                               including Oracle Exadata, Oracle Grid Infrastructure, Oracle Database, Oracle Restart,
                               and Oracle Single instance deployments.
                               Related Topics
                               •    Fleet Patching and Provisioning Use Cases in Oracle Fleet Patching and
                                    Provisioning Administrator's Guide
                               •    Using Oracle Update Advisor in Oracle FPP Server Mode in Oracle Fleet Patching
                                    and Provisioning Administrator's Guide


                               Monthly Recommended Patches (MRPs)
                               For Linux x86-64 platforms, MRPs provide a method to apply all Oracle recommended
                               fixes easily for the current RU.
                               Monthly Recommended Patches (MRPs) are a collection of recommended interim
                               ("one-off") fixes that are provided at monthly intervals using a single downloadable
                               patch. Each MRP provides update content updated monthly after the RU associated
                               with that monthly update is released, up to six months after the release date of the RU.
                               By waiting to install a new update content by three or six months, you take a more
                               conservative approach to Oracle Database software maintenance, but you still risk the
                               chance of encountering known issues fixed in the most recent updates.
                               Additionally, you should install the following:
                               •    The OJVM patches where the JVM component is available in an Oracle Database.
                               •    Interim patches only for specific issues that you know apply to your environment
                               •    A minimum of interim patches
                               Installing the latest update is a good way to reduce the need for interim patches.


                               Patch Conflict Resolution
                               If interim patches are used in conjunction with one of the proactive patching methods,
                               then there may be patch conflicts.
                               For the quarterly proactive patches (Quarterly Exadata Patch, RU, and MRPs), Oracle
                               proactively produces new interim patches for existing patches that would conflict. The
                               new interim patches are usually released at the same time as the proactive patches.
                               For information about resolving patch conflicts, see the My Oracle Support notes for
                               patch conflicts.
                               Related Topics
                               •    My Oracle Support Patch Conflict Checker Overview




Oracle Database Patch Maintenance
F31334-07                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                       Page 14 of 18
                               •    How to Use the My Oracle Support Conflict Checker Tool for Patches Installed with
                                    OPatch
                               •    Database Patch Conflict Resolution (Doc ID 1321267.1)


                               Patching with Oracle Fleet Patching and Provisioning
                               (Oracle FPP)
                               Oracle recommends the Oracle FPP service as the maintenance method for Oracle
                               Database deployed with Oracle RAC, Exadata, and Oracle Data Guard.
                               The Oracle Fleet Patching and Provisioning (FPP), which is a service in Oracle Grid
                               Infrastructure, manages software homes on the cluster hosting the Oracle Fleet
                               Patching and Provisioning Server itself. It enables mass deployment and maintenance
                               of standard operating environments for databases, clusters, and user-defined software
                               types. FPP also helps you to install clusters and provision, patch, scale, and upgrade
                               Oracle Grid Infrastructure and Oracle Database 12c release 2 (12.2), and later
                               releases, and Oracle Exadata stack with Release 19c (19.17 and later releases). FPP
                               can also patch both single-instance Oracle Databases and Oracle Real Application
                               Cluster configurations. You can also use FPP to provision applications and
                               middleware.
                               You can use Oracle Fleet Patching and Provisioning in any of the following modes:
                               •    Using "Lite mode" (Oracle Fleet Patching and Provisioning Server in local
                                    mode also called FPP Lite Mode). This mode is the default configuration when
                                    you install Oracle Grid Infrastructure. FPP Lite Mode operation enables you to
                                    perform Oracle Grid Infrastructure and Oracle Database patching operations on
                                    the local cluster in a simplified environment without having to register or deploy
                                    gold images. Deploy either the Oracle Grid Infrastructure or the Oracle Database
                                    patched home and run the patch operation using either the rhpctl move gihome
                                    or rhpctl move database command, specifying the source and destination paths
                                    instead of working copy names.
                               •    Using a central server (Oracle Fleet Patching and Provisioning Server). The
                                    central server stores and manages standardized images, called gold images. You
                                    can deploy gold images to any number of nodes across a data center. You can use
                                    the deployed homes to create new clusters and databases, and patch, upgrade,
                                    and scale existing installations.
                               Related Topics
                               •    About Deploying Oracle Databases Using Oracle Fleet Patching and Provisioning
                                    in Oracle Real Application Clusters Installation Guide for Linux and UNIX
                               •    FPP by Example : Introduction
                               •    Oracle Fleet Patching & Provisioning (Videos and LiveLabs)
                               •    "A Word about Zero Downtime Oracle Grid Infrastructure Patching," Databases
                                    are Fun


                               Patching Oracle Database and Oracle GoldenGate



Oracle Database Patch Maintenance
F31334-07                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                       Page 15 of 18
                               When you use Oracle GoldenGate with Oracle Database, you must ensure that Oracle
                               GoldenGate processes are shut down before patching the database.
                               When you patch Oracle Database, and you are using Oracle GoldenGate, you must
                               disable Oracle GoldenGate processes before starting to patch the database. The
                               reason for this is that patches and upgrades can modify the RDBMS internal tables
                               and views, which cause stored procedures that call them to be invalidated. All
                               dependent objects are invalidated as well.



                               Related Topics
                               •    Stopping Oracle GoldenGate Processes
                               •    Do I Need To Disable The GoldenGate DDL Trigger Before An Oracle DB Upgrade
                                    or PSU patching? (Doc ID 971222.1)
                               •    Latest Oracle GoldenGate For Oracle Database & Oracle Database Patch
                                    Recommendations (Doc ID 2193391.1)


                               Frequently Asked Questions
                               This section lists frequently asked questions.
                               Do proactive patches include optimizer fixes?
                               •    "Windows Database Bundle Patch" can include optimizer fixes.
                               •    Oracle Database RUs can include optimizer fixes for issues that arise from
                                    inaccurate optimizer results, but only in a form that enables or disables them
                                    individually, as required. RUs include optimizer fixes in the "disabled by default"
                                    state. For more information, see My Oracle Support Note 2147007.1, "Automatic
                                    Fix Control Persistence (FCP) for Database Proactive Bundle Patch ".
                               How can I tell what patching method an installation uses?
                               Review the opatch lsinventory output to see what patches are applied. RUs and
                               RURs include a description of the patch name and version in the output.
                               What is the difference between "Windows Database Bundle Patch" and "QFSDP
                               for Exadata" and so on?
                               These bundles are targeted at different environments. The latest versions include the
                               same update content, but all other content is specific to the target environment. There
                               may be some other common content but there are differences in content.
                               Do proactive patches affect the database version as reported in trace files and
                               database views like V$VERSION?

                               For Oracle Database 19c (19.3.0.0), the patch level in the ORACLE_HOME is reflected in
                               the opatch lsinventory data, and for some patch types, the patch level is reflected in
                               DBA_REGISTRY or DBA_REGISTRY_HISTORY. The DBA_REGISTRY_SQLPATCH view tells you
                               the SQL patches that are applied to the database.
                               Should I ask for a one-off bug fix or wait for the next RU?




Oracle Database Patch Maintenance
F31334-07                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                        Page 16 of 18
                               For a discussion of the pros and cons of asking for one-off bug fixes instead of waiting
                               on RUs, see My Oracle Support Note 2648544.1.
                               How to apply patches? Use either the opatch utility or the OPLAN utility?

                               Refer to the README to learn how to install patches.
                               OPatch - Where Can I Find the Latest Version of OPatch?
                               See My Oracle Support Note 6880880.1 or My Oracle Support Note 224346.1


                               Current Database Proactive Patches
                               The following table gives information on available proactive database related patches
                               by platform, environment, and version.
                               The short names that are used in the Methods column in the table are expanded in My
                               Oracle Support Note 2337415.1.


                                Platform                                     Environment                          DB Version                 Methods
                                Unix platforms                               Exadata                              19.3.0.0 and QFSDP for Exadata, OJVM Update,
                                                                                                                  later        TZ
                                                                                                                  releases
                                Linux Platforms                              Exadata                              19.3.0.0 and QFSDP for Exadata, OJVM Update,
                                                                                                                  later        TZ, MRP
                                                                                                                  releases
                                Unix platforms                               RAC                                  19.3.0.0 and GI Update, OJVM Update, Combo,
                                                                                                                  later        TZ
                                                                                                                  releases
                                Linux platforms                              RAC                                  19.3.0.0 and GI Update, OJVM Update, Combo,
                                                                                                                  later        TZ, MRP
                                                                                                                  releases
                                Unix platforms                               Non-RAC                              19.3.0.0 and DB Update, OJVM Update, Combo,
                                                                                                                  later        TZ
                                                                                                                  releases
                                Linux platforms                              Non-RAC                              19.3.0.0 and DB Update, OJVM Update, Combo,
                                                                                                                  later        TZ, MRP
                                                                                                                  releases
                                Windows platforms                            All                                  19.3.0.0                   Windows Bundles, TZ




                               Oracle Database Oracle Database Patch Maintenance , Release 19c and Later Releases
                               F31334-07

                               Copyright © 2020, 2026, Oracle and/or its affiliates

                               This software and related documentation are provided under a license agreement containing restrictions on use and disclosure and are protected by intellectual property laws.
                               Except as expressly permitted in your license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license, transmit, distribute, exhibit,
                               perform, publish, or display any part, in any form, or by any means. Reverse engineering, disassembly, or decompilation of this software, unless required by law for
                               interoperability, is prohibited.

                               The information contained herein is subject to change without notice and is not warranted to be error-free. If you find any errors, please report them to us in writing.

                               If this is software, software documentation, data (as defined in the Federal Acquisition Regulation), or related documentation that is delivered to the U.S. Government or anyone
                               licensing it on behalf of the U.S. Government, then the following notice is applicable:




Oracle Database Patch Maintenance
F31334-07                                                                                                                                                                                    June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                                                                                                        Page 17 of 18
                               U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software, any programs embedded, installed, or activated on delivered
                               hardware, and modifications of such programs) and Oracle computer documentation or other Oracle data delivered to or accessed by U.S. Government end users are
                               "commercial computer software," "commercial computer software documentation," or "limited rights data" pursuant to the applicable Federal Acquisition Regulation and agency-
                               specific supplemental regulations. As such, the use, reproduction, duplication, release, display, disclosure, modification, preparation of derivative works, and/or adaptation of i)
                               Oracle programs (including any operating system, integrated software, any programs embedded, installed, or activated on delivered hardware, and modifications of such
                               programs), ii) Oracle computer documentation and/or iii) other Oracle data, is subject to the rights and limitations specified in the license contained in the applicable contract.
                               The terms governing the U.S. Government's use of Oracle cloud services are defined by the applicable contract for such services. No other rights are granted to the U.S.
                               Government.

                               This software or hardware is developed for general use in a variety of information management applications. It is not developed or intended for use in any inherently dangerous
                               applications, including applications that may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you shall be responsible to take
                               all appropriate fail-safe, backup, redundancy, and other measures to ensure its safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by
                               use of this software or hardware in dangerous applications.

                               Oracle®, Java, MySQL, and NetSuite are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of their respective owners.

                               Intel and Intel Inside are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are used under license and are trademarks or registered trademarks
                               of SPARC International, Inc. AMD, Epyc, and the AMD logo are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered trademark of The Open
                               Group.

                               This software or hardware and documentation may provide access to or information about content, products, and services from third parties. Oracle Corporation and its affiliates
                               are not responsible for and expressly disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise set forth in an applicable
                               agreement between you and Oracle. Oracle Corporation and its affiliates will not be responsible for any loss, costs, or damages incurred due to your access to or use of third-
                               party content, products, or services, except as set forth in an applicable agreement between you and Oracle.


                               For information about Oracle's commitment to accessibility, visit the Oracle Accessibility Program website at   http://www.oracle.com/pls/
                               topic/lookup?ctx=acc&id=docacc.


                               Access to Oracle Support
                               Oracle customer access to and use of Oracle support services will be pursuant to the terms and
                               conditions specified in their Oracle order for the applicable services.




Oracle Database Patch Maintenance
F31334-07                                                                                                                                                                                   June 15, 2026
Copyright © 2020, 2026, Oracle and/or its affiliates.                                                                                                                                       Page 18 of 18

