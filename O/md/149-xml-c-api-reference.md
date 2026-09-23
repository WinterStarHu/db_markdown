# 149. XML C++ API Reference

> 源文件: `en/cpxml/xml-c-api-reference.pdf`

Oracle® Database
XML C++ API Reference




   19c
   E96479-01
   January 2019
Oracle Database XML C++ API Reference, 19c

E96479-01

Copyright © 2001, 2019, Oracle and/or its affiliates. All rights reserved.

Primary Author: Jayashree Sharma

Contributing Authors: Tulika Das

Contributors: Roza Leyderman

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
    Audience                         xvii
    Documentation Accessibility      xvii
    Related Documents                xvii
    Conventions                      xviii



1   Package OracleXml APIs for C++
    XmlException Interface           1-1
        getCode()                    1-2
        getMesLang()                 1-2
        getMessage()                 1-2



2   Package Ctx APIs for C++
    Ctx Datatypes                    2-1
        encoding                     2-1
        encodings                    2-1
    MemAllocator Interface           2-1
        alloc()                      2-2
        dealloc()                    2-2
        ~MemAllocator()              2-2
    TCtx Interface                   2-2
        TCtx()                       2-3
        getEncoding()                2-4
        getErrHandler()              2-4
        getMemAllocator()            2-4
        isSimple()                   2-4
        isUnicode()                  2-5
        ~TCtx()                      2-5




                                       iii
3   Package DOM APIs for C++
    About DOM Interfaces          3-1
    Dom Datatypes                 3-1
        AcceptNodeCodes           3-2
        CompareHowCode            3-2
        DOMNodeType               3-2
        DOMExceptionCode          3-3
        WhatToShowCode            3-3
        RangeExceptionCode        3-3
    AttrRef Interface             3-4
        AttrRef()                 3-4
        getName()                 3-4
        getOwnerElement()         3-5
        getSpecified()            3-5
        getValue()                3-5
        setValue()                3-5
        ~AttrRef()                3-6
    CDATASectionRef Interface     3-6
        CDATASectionRef()         3-6
        ~CDATASectionRef()        3-7
    CharacterDataRef Interface    3-7
        appendData()              3-7
        deleteData()              3-7
        freeString()              3-8
        getData()                 3-8
        getLength()               3-8
        insertData()              3-9
        replaceData()             3-9
        setData()                 3-9
        substringData()          3-10
    CommentRef Interface         3-10
        CommentRef()             3-10
        ~CommentRef()            3-11
    DOMException Interface       3-11
        getDOMCode()             3-11
        getMesLang()             3-12
        getMessage()             3-12
    DOMImplRef Interface         3-12
        DOMImplRef()             3-12
        createDocument()         3-13




                                   iv
   createDocumentType()            3-14
   formDocument()                  3-14
   getImplementation()             3-14
   getNoMod()                      3-15
   hasFeature()                    3-15
   setContext()                    3-15
   ~DOMImplRef()                   3-16
DOMImplementation Interface        3-16
   DOMImplementation()             3-16
   getNoMod()                      3-17
   ~DOMImplementation()            3-17
DocumentFragmentRef Interface      3-17
   DocumentFragmentRef()           3-17
   ~DocumentFragmentRef()          3-18
DocumentRange Interface            3-18
   DocumentRange()                 3-18
   createRange()                   3-18
   destroyRange()                  3-19
   ~DocumentRange()                3-19
DocumentRef Interface              3-19
   DocumentRef()                   3-20
   createAttribute()               3-20
   createAttributeNS()             3-21
   createCDATASection()            3-21
   createComment()                 3-22
   createDocumentFragment()        3-22
   createElement()                 3-22
   createElementNS()               3-23
   createEntityReference()         3-23
   createProcessingInstruction()   3-24
   createTextNode()                3-24
   getDoctype()                    3-25
   getDocumentElement()            3-25
   getElementById()                3-25
   getElementsByTagName()          3-26
   getElementsByTagNameNS()        3-26
   getImplementation()             3-27
   importNode()                    3-27
   ~DocumentRef()                  3-28
DocumentTraversal Interface        3-28
   DocumentTraversal()             3-28




                                     v
    createNodeIterator()       3-28
    createTreeWalker()         3-29
    destroyNodeIterator()      3-29
    destroyTreeWalker()        3-30
    ~DocumentTraversal()       3-30
DocumentTypeRef Interface      3-30
    DocumentTypeRef()          3-30
    getEntities()              3-31
    getInternalSubset()        3-31
    getName()                  3-32
    getNotations()             3-32
    getPublicId()              3-32
    getSystemId()              3-32
    ~DocumentTypeRef()         3-32
ElementRef Interface           3-33
    ElementRef()               3-33
    getAttribute()             3-34
    getAttributeNS()           3-34
    getAttributeNode()         3-34
    getElementsByTagName()     3-35
    getTagName()               3-35
    hasAttribute()             3-35
    hasAttributeNS()           3-36
    removeAttribute()          3-36
    removeAttributeNS()        3-36
    removeAttributeNode()      3-37
    setAttribute()             3-37
    setAttributeNS()           3-38
    setAttributeNode()         3-38
    ~ElementRef()              3-38
EntityRef Interface            3-39
    EntityRef()                3-39
    getNotationName()          3-39
    getPublicId()              3-40
    getSystemId()              3-40
    getType()                  3-40
    ~EntityRef()               3-40
EntityReferenceRef Interface   3-40
    EntityReferenceRef()       3-41
    ~EntityReferenceRef()      3-41
NamedNodeMapRef Interface      3-41




                                 vi
    NamedNodeMapRef()      3-42
    getLength()            3-42
    getNamedItem()         3-43
    getNamedItemNS()       3-43
    item()                 3-43
    removeNamedItem()      3-44
    removeNamedItemNS()    3-44
    setNamedItem()         3-44
    setNamedItemNS()       3-45
    ~NamedNodeMapRef()     3-45
NodeFilter Interface       3-45
    acceptNode()           3-45
NodeIterator Interface     3-46
    adjustCtx()            3-46
    detach()               3-46
    nextNode()             3-46
    previousNode()         3-47
NodeListRef Interface      3-47
    NodeListRef()          3-47
    getLength()            3-48
    item()                 3-48
    ~NodeListRef()         3-48
NodeRef Interface          3-48
    NodeRef()              3-49
    appendChild()          3-50
    cloneNode()            3-50
    getAttributes()        3-51
    getChildNodes()        3-51
    getFirstChild()        3-51
    getLastChild()         3-52
    getLocalName()         3-52
    getNamespaceURI()      3-52
    getNextSibling()       3-52
    getNoMod()             3-53
    getNodeName()          3-53
    getNodeType()          3-53
    getNodeValue()         3-53
    getOwnerDocument()     3-54
    getParentNode()        3-54
    getPrefix()            3-54
    getPreviousSibling()   3-54




                            vii
    hasAttributes()                  3-55
    hasChildNodes()                  3-55
    insertBefore()                   3-55
    isSupported()                    3-56
    markToDelete()                   3-56
    normalize()                      3-56
    removeChild()                    3-56
    replaceChild()                   3-57
    resetNode()                      3-57
    setNodeValue()                   3-57
    setPrefix()                      3-58
    ~NodeRef()                       3-58
NotationRef Interface                3-59
    NotationRef()                    3-59
    getPublicId()                    3-59
    getSystemId()                    3-60
    ~NotationRef()                   3-60
ProcessingInstructionRef Interface   3-60
    ProcessingInstructionRef()       3-60
    getData()                        3-61
    getTarget()                      3-61
    setData()                        3-61
    ~ProcessingInstructionRef()      3-62
Range Interface                      3-62
    CompareBoundaryPoints()          3-63
    cloneContent()                   3-63
    cloneRange()                     3-63
    deleteContents()                 3-63
    detach()                         3-64
    extractContent()                 3-64
    getCollapsed()                   3-64
    getCommonAncestorContainer()     3-64
    getEndContainer()                3-64
    getEndOffset()                   3-65
    getStartContainer()              3-65
    getStartOffset()                 3-65
    insertNode()                     3-65
    selectNodeContent()              3-66
    selectNode()                     3-66
    setEnd()                         3-66
    setEndAfter()                    3-66




                                      viii
       setEndBefore()             3-67
       setStart()                 3-67
       setStartAfter()            3-67
       setStartBefore()           3-68
       surroundContents()         3-68
       toString()                 3-68
    RangeException Interface      3-68
       getCode()                  3-69
       getMesLang()               3-69
       getMessage()               3-69
       getRangeCode()             3-69
    TextRef Interface             3-70
       TextRef()                  3-70
       splitText()                3-70
       ~TextRef()                 3-71
    TreeWalker Interface          3-71
       adjustCtx()                3-71
       firstChild()               3-72
       lastChild()                3-72
       nextNode()                 3-72
       nextSibling()              3-72
       parentNode()               3-73
       previousNode()             3-73
       previousSibling()          3-73



4   Package IO APIs for C++
    IO Datatypes                   4-1
       InputSourceType             4-1
    InputSource Interface          4-1
       getBaseURI()                4-2
       getISrcType()               4-2
       setBaseURI()                4-2



5   Package Parser APIs for C++
    Parser Datatypes               5-1
       ParserExceptionCode         5-1
       DOMParserIdType             5-1
       SAXParserIdType             5-2
       SchValidatorIdType          5-2




                                    ix
DOMParser Interface            5-2
   getContext()                5-2
   getParserId()               5-3
   parse()                     5-3
   parseDTD()                  5-3
   parseSchVal()               5-4
   setValidator()              5-4
GParser Interface              5-5
   SetWarnDuplicateEntity()    5-5
   getBaseURI()                5-6
   getDiscardWhitespaces()     5-6
   getExpandCharRefs()         5-6
   getSchemaLocation()         5-6
   getStopOnWarning()          5-7
   getWarnDuplicateEntity()    5-7
   setBaseURI()                5-7
   setDiscardWhitespaces()     5-7
   setExpandCharRefs()         5-8
   setSchemaLocation()         5-8
   setStopOnWarning()          5-8
ParserException Interface      5-9
   getCode()                   5-9
   getMesLang()                5-9
   getMessage()                5-9
   getParserCode()            5-10
SAXHandler Interface          5-10
   CDATA()                    5-10
   XMLDecl()                  5-11
   attributeDecl()            5-11
   characters()               5-12
   comment()                  5-12
   elementDecl()              5-12
   endDocument()              5-13
   endElement()               5-13
   notationDecl()             5-13
   parsedEntityDecl()         5-13
   processingInstruction()    5-14
   startDocument()            5-14
   startElement()             5-14
   startElementNS()           5-15
   unparsedEntityDecl()       5-15




                                x
       whitespace()             5-16
    SAXParser Interface         5-16
       getContext()             5-16
       getParserId()            5-17
       parse()                  5-17
       parseDTD()               5-17
       setSAXHandler()          5-18
    SchemaValidator Interface   5-18
       getSchemaList()          5-18
       getValidatorId()         5-19
       loadSchema()             5-19
       unloadSchema()           5-19



6   Package SOAP APIs for C++
    SOAP Datatypes               6-1
       SoapExceptionCode         6-1
       SoapBinding               6-2
       SoapRole                  6-2
    SoapException Interface      6-2
       getCode()                 6-2
       getMessage()              6-2
       getMesLang()              6-3
       getSoapCode()             6-3
    ConnectRef Interface         6-3
       ~ConnectRef()             6-3
       call()                    6-4
    MsgFactory Interface         6-4
       ~MsgFactory()             6-5
       MsgFactory()              6-5
       addBodyElement()          6-5
       addFaultReason()          6-6
       addHeaderElement()        6-6
       createConnection()        6-6
       createMessage()           6-7
       destroyMessage()          6-7
       getBody()                 6-8
       getBodyElement()          6-8
       getEnvelope()             6-8
       getFault()                6-9
       getHeader()               6-9




                                  xi
        getHeaderElement()               6-10
        getMustUnderstand()              6-10
        getReasonNum()                   6-11
        getReasonLang()                  6-11
        getRole()                        6-11
        hasFault()                       6-12
        setFault()                       6-12
        setMustUnderstand()              6-13
        setRole()                        6-13



7   Package Tools APIs for C++
    Tools Datatypes                       7-1
        FactoryExceptionCode              7-1
    Factory Interface                     7-1
        Factory()                         7-2
        createDOMParser()                 7-2
        createSAXParser()                 7-3
        createSchemaValidator()           7-3
        createXPathCompProcessor()        7-3
        createXPathCompiler()             7-4
        createXPathProcessor()            7-4
        createXPointerProcessor()         7-5
        createXslCompiler()               7-5
        createXslExtendedTransformer()    7-5
        createXslTransformer()            7-6
        getContext()                      7-6
        ~Factory()                        7-6
    FactoryException Interface            7-7
        getCode()                         7-7
        getFactoryCode()                  7-7
        getMesLang()                      7-7
        getMessage()                      7-8



8   Package XPath APIs for C++
    XPath Datatypes                       8-1
        XPathCompIdType                   8-1
        XPathObjType                      8-1
        XPathExceptionCode                8-2
        XPathPrIdType                     8-2




                                          xii
    CompProcessor Interface         8-2
       getProcessorId()             8-2
       process()                    8-2
       processWithBinXPath()        8-3
    Compiler Interface              8-3
       compile()                    8-4
       getCompilerId()              8-4
    NodeSet Interface               8-4
       getNode()                    8-4
       getSize()                    8-5
    Processor Interface             8-5
       getProcessorId()             8-5
       process()                    8-5
    XPathException Interface        8-6
       getCode()                    8-6
       getMesLang()                 8-6
       getMessage()                 8-6
       getXPathCode()               8-7
    XPathObject Interface           8-7
       XPathObject()                8-7
       getNodeSet()                 8-8
       getObjBoolean()              8-8
       getObjNumber()               8-8
       getObjString()               8-8
       getObjType()                 8-8



9   Package XPointer APIs for C++
    XPointer Datatypes              9-1
       XppExceptionCode             9-1
       XppPrIdType                  9-1
       XppLocType                   9-1
    Processor Interface             9-2
       getProcessorId()             9-2
       process()                    9-2
    XppException Interface          9-3
       getCode()                    9-3
       getMesLang()                 9-3
       getMessage()                 9-3
       getXppCode()                 9-4
    XppLocation Interface           9-4




                                    xiii
        getLocType()              9-4
        getNode()                 9-4
        getRange()                9-4
     XppLocSet Interface          9-5
        getItem()                 9-5
        getSize()                 9-5



10   Package Xsl APIs for C++
     Xsl Datatypes               10-1
        XslCompIdType            10-1
        XslExceptionCode         10-1
        XslTrIdType              10-2
     Compiler Interface          10-2
        compile()                10-2
        getCompilerId()          10-2
        getLength()              10-3
     CompTransformer Interface   10-3
        getTransformerId()       10-3
        setBinXsl()              10-3
        setSAXHandler()          10-4
        setXSL()                 10-4
        transform()              10-4
     Transformer Interface       10-5
        getTransformerId()       10-5
        setSAXHandler()          10-5
        setXSL()                 10-6
        transform()              10-6
     XSLException Interface      10-6
        getCode()                10-7
        getMesLang()             10-7
        getMessage()             10-7
        getXslCode()             10-7


     Index




                                  xiv
List of Tables
1-1    Summary of OracleXml Package Interfaces                     1-1
2-1    Summary of Datatypes; Ctx Package                           2-1
2-2    Summary of MemAllocator Methods; Ctx Package                2-2
2-3    Summary of TCtx Methods; Ctx Package                        2-3
3-1    Summary of Datatypes; Dom Package                           3-1
3-2    Summary of AttrRef Methods; Dom Package                     3-4
3-3    Summary of CDATASectionRef Methods; Dom Package             3-6
3-4    Summary of CharacterDataRef Methods; Dom Package            3-7
3-5    Summary of CommentRef Methods; Dom Package                 3-10
3-6    Summary of DOMException Methods; Dom Package               3-11
3-7    Summary of DOMImplRef Methods; Dom Package                 3-12
3-8    Summary of DOMImplementation Methods; Dom Package          3-16
3-9    Summary of DocumentFragmentRef Methods; Dom Package        3-17
3-10   Summary of DocumentRange Methods; Dom Package              3-18
3-11   Summary of DocumentRef Methods; Dom Package                3-19
3-12   Summary of DocumentTraversal Methods; Dom Package          3-28
3-13   Summary of DocumentTypeRef Methods; Dom Package            3-30
3-14   Summary of ElementRef Methods; Dom Package                 3-33
3-15   Summary of EntityRef Methods; Dom Package                  3-39
3-16   Summary of EntityReferenceRef Methods; Dom Package         3-41
3-17   Summary of NamedNodeMapRef Methods; Dom Package            3-41
3-18   Summary of NodeFilter Methods; Dom Package                 3-45
3-19   Summary of NodeIterator Methods; Dom Package               3-46
3-20   Summary of NodeListRef Methods; Dom Package                3-47
3-21   Summary of NodeRef Methods; Dom Package                    3-49
3-22   Summary of NotationRef Methods; Dom Package                3-59
3-23   Summary of ProcessingInstructionRef Methods; Dom Package   3-60
3-24   Summary of Range Methods; Dom Package                      3-62
3-25   Summary of RangeException Methods; Dom Package             3-69
3-26   Summary of TextRef Methods; Dom Package                    3-70
3-27   Summary of TreeWalker Methods; Dom Package                 3-71
4-1    Summary of Datatypes; IO Package                            4-1
4-2    Summary of IO Package Interfaces                            4-1
5-1    Summary of Datatypes; Parser Package                        5-1
5-2    Summary of DOMParser Methods; Parser Package                5-2




                                                                   xv
5-3    Summary of GParser Methods; Parser Package            5-5
5-4    Summary of ParserException Methods; Parser Package    5-9
5-5    Summary of SAXHandler Methods; Parser Package        5-10
5-6    Summary of SAXParser Methods; Parser Package         5-16
5-7    Summary of SchemaValidator Methods; Parser Package   5-18
6-1    Summary of Datatypes; SOAP Package                    6-1
6-2    Summary of SoapException Interfaces                   6-2
6-3    Summary of ConnectRef Interfaces                      6-3
6-4    Summary of MsgFactory Interfaces                      6-4
7-1    Summary of Datatypes; Tools Package                   7-1
7-2    Summary of Factory Methods; Tools Package             7-1
7-3    Summary of FactoryException Methods; Tools Package    7-7
8-1    Summary of Datatypes; XPath Package                   8-1
8-2    Summary of CompProcessor Methods; XPath Package       8-2
8-3    Summary of Compiler Methods; XPath Package            8-3
8-4    Summary of NodeSet Methods; XPath Package             8-4
8-5    Summary of Processor Methods; XPath Package           8-5
8-6    Summary of XPathException Methods; XPath Package      8-6
8-7    Summary of XPathObject Methods; XPath Package         8-7
9-1    Summary of Datatypes; XPointer Package                9-1
9-2    Summary of Processor Methods; XPointer Package        9-2
9-3    Description of Process Method Parameters              9-2
9-4    Summary of XppException Methods; Package XPointer     9-3
9-5    Summary of XppLocation Methods; XPointer Package      9-4
9-6    Summary of XppLocSet Methods; XPointer Package        9-5
9-7    Summary of getItem Method; XPointer Package           9-5
10-1   Summary of Datatypes; Xsl Package                    10-1
10-2   Summary of Compiler Methods; Xsl Package             10-2
10-3   Summary of CompTransformer Methods; Xsl Package      10-3
10-4   Summary of Transformer Methods; Xsl Package          10-5
10-5   Summary of XSLException Methods; Xsl Package         10-7




                                                             xvi
Preface
           This reference describes Oracle XML Developer's Kits (XDK) and Oracle XML DB
           APIs for the C++ programming language. It primarily lists the syntax of functions,
           methods, and procedures associated with these APIs.


Audience
           This guide is intended for developers building XML applications in Oracle.
           To use this document, you need a basic understanding of object-oriented
           programming concepts, familiarity with Structured Query Language (SQL), and
           working knowledge of application development using the C programming language.


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
           For more information, see the following documents in the Oracle Database the 12c
           Release 2 (12.2) documentation set:
           •   Oracle XML Developer's Kit Programmer's Guide
           •   Oracle XML DB Developer's Guide
           •   Oracle Database Concepts
           •   Oracle Database SQL Language Reference
           •   Oracle Database Object-Relational Developer's Guide
           •   Oracle Database New Features Guide
           •   Oracle Database Sample Schemas
           Additional information may be found at http://www.oracle.com/technetwork/
           database-features/xdk/overview/index.html




                                                                                                xvii
                                                                                                 Preface




Conventions
        The following text conventions are used in this document:


         Convention          Meaning
         boldface            Boldface type indicates graphical user interface elements associated
                             with an action, or terms defined in text or the glossary.
         italic              Italic type indicates book titles, emphasis, or placeholder variables for
                             which you supply particular values.
         monospace           Monospace type indicates commands within a paragraph, URLs, code
                             in examples, text that appears on the screen, or text that you enter.




                                                                                                    xviii
1
Package OracleXml APIs for C++
         OracleXml is the namespace for all XML C++ interfaces implemented by Oracle. It
         includes class XmlException, the root for all exceptions in XML, and the following
         namespaces:
         •   Ctx - namespace for TCtx related declarations, described in Package Ctx APIs for
             C++
         •   Dom - namespace for DOM related declarations, described in Package Dom APIs
             for C++
         •   IO - namespace for input and output source declarations, described in Package IO
             APIs for C++
         •   Parser - namespace for parser and schema validator declarations, described in
             Package Parser APIs for C++
         •   SOAP - namespace for the Simple Object Access Protocol declarations, described
             in Package SOAP APIs for C++
         •   Tools - namespace for Tools::Factory related declarations, described in Package
             Tools APIs for C++
         •   XPath - namespace for XPath related declarations, described in Package XPath
             APIs for C++
         •   XPointer - namespace for XPointer related declarations, described in Package
             XPointer APIs for C++
         •   Xsl - namespace for XSLT related declarations, described in Package Xsl APIs for
             C++



                Note:
                Oracle XML Developer's Kit Programmer's Guide




XmlException Interface
         XMLException is the root interface for all XML exceptions. Table 1-1 summarizes the
         methods available through the OracleXml Package.

         Table 1-1    Summary of OracleXml Package Interfaces

          Function                    Summary
          getCode()                   Get Oracle XML error code embedded in the exception.
          getMesLang()                Get current language (encoding) of error messages.
          getMessage()                Get Oracle XML error message.




                                                                                              1-1
                                                                                             Chapter 1
                                                                                XmlException Interface




getCode()
            This is a virtual member function that defines a prototype for implementation defined
            functions returning Oracle XML error codes (like error codes defined in xml.h) of the
            exceptional situations during execution

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            This is a virtual member function that defines a prototype for user defined functions
            returning current language (encoding) of error messages for the exceptional situations
            during execution

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext *) Current language (encoding) of error messages


getMessage()
            This is a virtual member function that defines a prototype for implementation defined
            functions returning Oracle XML error messages of the exceptional situations during
            execution.

            Syntax
            virtual oratext* getMessage() const = 0;

            Returns
            (oratext *) Error message




                                                                                                 1-2
2
Package Ctx APIs for C++
            The XML context-related types and interfaces are represented in the Ctx namespace.
            These include Ctxdatatypes, MemAllocatormethods, and TCtx methods.



                   See Also:
                   Oracle XML Developer's Kit Programmer's Guide




Ctx Datatypes
            Table 2-1 summarizes the datatypes of the Ctx package.

            Table 2-1    Summary of Datatypes; Ctx Package

            Datatype                    Description
            encoding                    A single supported encoding.
            encodings                   An array of encodings.


encoding
            A single supported encoding.

            Definition
            typedef struct encoding {
               oratext *encname;
               oratext *encvalue;
            } encoding;


encodings
            An array of encodings.

            Definition
            typedef struct encodings {
               unsigned num;
               encoding *enc;
            } encodings;


MemAllocator Interface
            Table 2-2 summarizes the methods available through the MemAllocator interface.




                                                                                             2-1
                                                                                                     Chapter 2
                                                                                                TCtx Interface




            Table 2-2   Summary of MemAllocator Methods; Ctx Package

            Function                     Summary
            alloc()                      Allocates memory of given size.
            dealloc()                    Deallocate memory pointed to by the argument.
            ~MemAllocator()              Virtual destructor - interface level handle to actual destructors.


alloc()
            This is a virtual member function that defines a prototype for user defined allocator
            functions

            Syntax
            virtual void* alloc(
               ub4 size) = 0;


            Parameter               Description
                                    memory size
            size



dealloc()
            This is a virtual member function that defines a prototype for user defined deallocator
            functions. Such deallocators are supposed to deallocate memory allocated by the alloc
            member functions

            Syntax
            virtual void dealloc(
               void* ptr) = 0;


            Parameter               Description
                                    pointer to previously allocated memory
            ptr



~MemAllocator()
            It provides an interface level handle to actual destructors that can be invoked without
            knowing their names or implementations

            Syntax
            virtual ~MemAllocator() {}


TCtx Interface
            Table 2-3 summarizes the methods available through the TCtx interface.




                                                                                                         2-2
                                                                                                  Chapter 2
                                                                                             TCtx Interface




         Table 2-3     Summary of TCtx Methods; Ctx Package

         Function                       Summary
         TCtx()                         Class constructor.
         getEncoding()                  Get data encoding in use by XML context.
         getErrHandler()                Get Error Handler provided by the user.
         getMemAllocator()              Get memory allocator.
         isSimple()                     Get a flag that indicates if data encoding is simple.
         isUnicode()                    Get a flag indicating if data encoding is Unicode.
         ~TCtx()                        Destructor - clears space and destroys the implementation.


TCtx()
         TCtx constructor. It throws XmlException if it fails to create a context object.


         Syntax                                    Description
                                                   This constructor creates the context object and
         TCtx() throw (XMLException)
                                                   initializes it with default values of parameters.

                                                   This constructor creates the context object and
         TCtx(
                                                   initializes it with parameter values provided by the
            oratext* name,
                                                   user.
            ErrorHandler* errh = NULL,
            MemAllocator* memalloc = NULL,
            encodings* encs = NULL)
         throw (XMLException)

                                                   This constructor creates the context object and
         TCtx(
                                                   initializes it with parameter values provided by the
            oratext* name,
                                                   user. Takes an additional parameter for memory
            up4 inpblksize,
                                                   block size from input source.
            ErrorIfs* errh = NULL,
            MemAllocator* memalloc = NULL,
            encodings* encs = NULL)
         throw (XMLException)



         Parameter               Description
                                 user defined name of the context
         name

                                 user defined error handler
         errh

                                 user defined memory allocator
         memalloc

                                 user specified encodings
         encs

                                 memory block size for input source
         inpblksize




                                                                                                       2-3
                                                                                              Chapter 2
                                                                                         TCtx Interface




             Returns
             (TCtx) Context object


getEncoding()
             Returns data encoding in use by XML context. Ordinarily, the data encoding is chosen
             by the user, so this function is not needed. However, if the data encoding is not
             specified, and allowed to default, this function can be used to return the name of that
             default encoding.

             Syntax
             oratext* getEncoding() const;

             Returns
             (oratext *) name of data encoding


getErrHandler()
             This member functions returns Error Handler provided by the user when the context
             was created, or NULL if none were provided.

             Syntax
             ErrorHandler* getErrHandler() const;

             Returns
             (ErrorHandler *) Pointer to the Error Handler object, or NULL


getMemAllocator()
             This member function returns memory allocator provided by the user when the context
             was created, or default memory allocator. It is important that this memory allocator is
             used for all C level memory allocations

             Syntax
             MemAllocator* getMemAllocator() const;

             Returns
             (MemAllocator*) Pointer to the memory allocator object


isSimple()
             Returns a flag saying whether the context's data encoding is "simple", single-byte for
             each character, like ASCII or EBCDIC.

             Syntax
             boolean isSimple() const;




                                                                                                  2-4
                                                                                                 Chapter 2
                                                                                         TCtx Interface




              Returns
              (boolean) TRUE of data encoding is "simple", FALSE otherwise


isUnicode()
              Returns a flag saying whether the context's data encoding is Unicode, UTF-16, with
              two-byte for each character.

              Syntax
              boolean isUnicode() const;

              Returns
              (boolean) TRUE if data encoding is Unicode, FALSE otherwise


~TCtx()
              Destructor - should be called by the user the context object is no longer needed

              Syntax
              ~Tctx();




                                                                                                     2-5
3
Package DOM APIs for C++
         The various interfaces in the DOM package represent DOM level 2 Core interfaces
         specified by W3C: http://www.w3.org/TR/DOM-Level-2-Core/.


About DOM Interfaces
         DOM interfaces are represented as generic references to different implementations of
         the DOM specifications. They are parameterized by Node, which supports various
         specializations and instantiations. Of them, the most important is xmlnode that
         corresponds to the current C implementation.
         These generic references do not have a NULL-like value. Any implementation should
         never create a stateless reference. If there is need to signal that something has no
         state, an exception should be thrown.
         Many methods might throw the SYNTAX_ERR exception, if the DOM tree is incorrectly
         formed, or UNDEFINED_ERR, in the case of wrong parameters or unexpected NULL
         pointers. If these are the only errors that a particular method might throw, it is not
         reflected in the method signature.
         Actual DOM trees do not dependent on the context (TCtx). However, manipulations on
         DOM trees in the current, xmlctx based implementation require access to the current
         context (TCtx). This is accomplished by passing the context pointer to the constructor
         of DOMImplRef. In multithreaded environment DOMImplRef is always created in the
         thread context and, so, has the pointer to the right context.
         DOMImplRef providea a way to create DOM trees. DomImplRef is a reference to the
         actual DOMImplementation object that is created when a regular, non-copy constructor
         of DomImplRef is invoked. This works well in multithreaded environment where DOM
         trees need to be shared, and each thread has a separate TCtx associated with it. This
         works equally well in a single threaded environment.
         DOMString is only one of encodings supported by Oracle implementations. The support
         of other encodings is Oracle's extension. The oratext* data type is used for all
         encodings.


Dom Datatypes
         Table 3-1 summarizes the datatypes of the Dom package.

         Table 3-1   Summary of Datatypes; Dom Package

         Datatype                             Description
         AcceptNodeCodes                      Defines values returned by node filters.
         CompareHowCode                       Defines type of comparison.
         DOMNodeType                          Defines type of node.




                                                                                              3-1
                                                                                         Chapter 3
                                                                                   Dom Datatypes




         Table 3-1    (Cont.) Summary of Datatypes; Dom Package

         Datatype                              Description
         DOMExceptionCode                      Defines codes for DOM exception.
         WhatToShowCode                        Defines codes for filtering.
         RangeExceptionCode                    Codes for DOM Range exceptions.


AcceptNodeCodes
         Defines values returned by node filters. Used by node iterators and tree walkers.

         Definition
         typedef enum AcceptNodeCode {
            FILTER_ACCEPT = 1,
            FILTER_REJECT = 2,
            FILTER_SKIP     = 3
             } AcceptNodeCode;


CompareHowCode
         Defines type of comparison.

         Definition
         typedef enum CompareHowCode {
            START_TO_START = 0,
            START_TO_END = 1,
            END_TO_END = 2,
            END_TO_START = 3 }
         CompareHowCode;


DOMNodeType
         Defines type of node.

         Definition
         typedef enum DOMNodeType {
            UNDEFINED_NODE = 0,
            ELEMENT_NODE = 1,
            ATTRIBUTE_NODE = 2,
            TEXT_NODE = 3,
            CDATA_SECTION_NODE = 4,
            ENTITY_REFERENCE_NODE = 5,
            ENTITY_NODE = 6,
            PROCESSING_INSTRUCTION_NODE = 7,
            COMMENT_NODE = 8,
            DOCUMENT_NODE = 9,
            DOCUMENT_TYPE_NODE = 10,
            DOCUMENT_FRAGMENT_NODE = 11,
            NOTATION_NODE = 12
         } DOMNodeType;




                                                                                             3-2
                                                                                 Chapter 3
                                                                            Dom Datatypes




DOMExceptionCode
         Defines codes for DOM exception.

         Definition
         typedef enum DOMExceptionCode {
            UNDEFINED_ERR               = 0,
            INDEX_SIZE_ERR              = 1,
            DOMSTRING_SIZE_ERR          = 2,
            HIERARCHY_REQUEST_ERR       = 3,
            WRONG_DOCUMENT_ERR          = 4,
            INVALID_CHARACTER_ERR       = 5,
            NO_DATA_ALLOWED_ERR         = 6,
            NO_MODIFICATION_ALLOWED_ERR = 7,
            NOT_FOUND_ERR               = 8,
            NOT_SUPPORTED_ERR           = 9,
            INUSE_ATTRIBUTE_ERR         = 10,
            INVALID_STATE_ERR           = 11,
            SYNTAX_ERR                  = 12,
            INVALID_MODIFICATION_ERR    = 13,
            NAMESPACE_ERR               = 14,
            INVALID_ACCESS_ERR          = 15
         } DOMExceptionCode;


WhatToShowCode
         Defines codes for filtering.

         Definition
         typedef unsigned long WhatToShowCode;
            const unsigned long SHOW_ALL = 0xFFFFFFFF; c
            onst unsigned long SHOW_ELEMENT = 0x00000001;
            const unsigned long SHOW_ATTRIBUTE = 0x00000002;
            const unsigned long SHOW_TEXT = 0x00000004;
            const unsigned long SHOW_CDATA_SECTION = 0x00000008;
            const unsigned long SHOW_ENTITY_REFERENCE = 0x00000010;
            const unsigned long SHOW_ENTITY = 0x00000020;
            const unsigned long SHOW_PROCESSING_INSTRUCTION = 0x00000040;
            const unsigned long SHOW_COMMENT = 0x00000080;
            const unsigned long SHOW_DOCUMENT = 0x00000100;
            const unsigned long SHOW_DOCUMENT_TYPE = 0x00000200;
            const unsigned long SHOW_DOCUMENT_FRAGMENT = 0x00000400;
            const unsigned long SHOW_NOTATION = 0x00000800;


RangeExceptionCode
         Codes for DOM Range exceptions.

         Definition
         typedef enum RangeExceptionCode {
            RANGE_UNDEFINED_ERR         = 0,
            BAD_BOUNDARYPOINTS_ERR      = 1,
            INVALID_NODE_TYPE_ERR       = 2
         } RangeExceptionCode;




                                                                                     3-3
                                                                                                    Chapter 3
                                                                                             AttrRef Interface




AttrRef Interface
            Table 3-2 summarizes the methods available through AttrRef interface.

            Table 3-2    Summary of AttrRef Methods; Dom Package

            Function                          Summary
            AttrRef()                         Constructor.
            getName()                         Return attribute's name.
            getOwnerElement()                 Return attribute's owning element.
            getSpecified()                    Return boolean indicating if an attribute was explicitly
                                              created.
            getValue()                        Return attribute's value.
            setValue()                        Set attribute's value.
            ~AttrRef()                        Public default destructor.


AttrRef()
            Class constructor.


            Syntax                                   Description
                                                     Used to create references to a given attribute node
            AttrRef(
               const NodeRef< Node>& node_ref,       after a call to createAttribute.
               Node* nptr);

                                                     Copy constructor.
            AttrRef(
               const AttrRef< Node>& nref);



            Parameter              Description
                                   reference to provide the context
            node_ref

                                   referenced node
            nptr


            Returns
            (AttrRef) Node reference object


getName()
            Returns the fully-qualified name of an attribute (in the data encoding) as a NULL-
            terminated string.

            Syntax
             oratext* getName() const;




                                                                                                         3-4
                                                                                                   Chapter 3
                                                                                            AttrRef Interface




             Returns
             (oratext *) name of attribute


getOwnerElement()
             Returns attribute's owning element

             Syntax
             Node* getOwnerElement();

             Returns
             (Node*) attribute's owning element node.


getSpecified()
             Returns the 'specified' value for an attribute. If the attribute was explicitly given a value
             in the original document, it is TRUE; otherwise, it is FALSE. If the node is not an attribute,
             returns FALSE. If the user sets attribute's value through DOM, its 'specified' value will
             be TRUE.

             Syntax
             boolean getSpecified() const;

             Returns
             (boolean) attribute's "specified" value


getValue()
             Returns the "value" (character data) of an attribute (in the data encoding) as NULL-
             terminated string. Character and general entities will have been replaced.

             Syntax
             oratext* getValue() const;

             Returns
             (oratext*) attribute's value


setValue()
             Sets the given attribute's value to data. The new value must be in the data encoding. It
             is not verified, converted, or checked. The attribute's 'specified' flag will be TRUE after
             setting a new value.

             Syntax
             void setValue(
                oratext* data)
             throw (DOMException);




                                                                                                        3-5
                                                                                                    Chapter 3
                                                                                   CDATASectionRef Interface




             Parameter               Description
                                     new value of attribute
             data



~AttrRef()
             This is the default destructor.

             Syntax
             ~AttrRef();


CDATASectionRef Interface
             Table 3-3 summarizes the methods available through CDATASectionRef interface.

             Table 3-3     Summary of CDATASectionRef Methods; Dom Package

             Function                           Summary
             CDATASectionRef()                  Constructor.
             ~CDATASectionRef()                 Public default destructor.


CDATASectionRef()
             Class constructor.


             Syntax                                           Description
                                                              Used to create references to a given CDATA
             CDATASectionRef(
                const NodeRef< Node>& node_ref,               node after a call to createCDATASection.
                Node* nptr);

                                                              Copy constructor.
             CDATASectionRef(
                const CDATASectionRef< Node>& nref);



             Parameter               Description
                                     reference to provide the context
             node_ref

                                     referenced node
             nptr


             Returns
             (CDATASectionRef) Node reference object




                                                                                                        3-6
                                                                                                  Chapter 3
                                                                                 CharacterDataRef Interface




~CDATASectionRef()
           This is the default destructor.

           Syntax
           ~CDATASectionRef();


CharacterDataRef Interface
           Table 3-4 summarizes the methods available through CharacterDataRef interface.

           Table 3-4      Summary of CharacterDataRef Methods; Dom Package

           Function                          Summary
           appendData()                      Append data to end of node's current data.
           deleteData()                      Remove part of node's data.
           freeString()                      Deallocate the string allocated by substringData.
           getData()                         Return node's data.
           getLength()                       Return length of node's data.
           insertData()                      Insert string into node's current data.
           replaceData()                     Replace part of node's data.
           setData()                         Set node's data.
           substringData()                   Get substring of node's data.


appendData()
           Append a string to the end of a CharacterData node's data. The appended data
           should be in the data encoding. It will not be verified, converted, or checked.

           Syntax
           void appendData(
              oratext* data)
           throw (DOMException);


           Parameter               Description
                                   data to append
           data



deleteData()
           Remove a range of characters from a CharacterData node's data. The offset is zero-
           based, so offset zero refers to the start of the data. Both offset and count are in
           characters, not bytes. If the sum of offset and count exceeds the data length then all
           characters from offset to the end of the data are deleted.




                                                                                                      3-7
                                                                                                  Chapter 3
                                                                                 CharacterDataRef Interface




               Syntax
               void deleteData(
                  ub4 offset,
                  ub4 count)
               throw (DOMException);


               Parameter                Description
                                        character offset where deletion starts
               offset

                                        number of characters to delete
               count



freeString()
               Deallocates the string allocated by substringData(). It is Oracle's extension.

               Syntax
               void freeString(
                  oratext* str);


               Parameter                Description
                                        string
               str



getData()
               Returns the data for a CharacterData node (type text, comment or CDATA) in the data
               encoding.

               Syntax
               oratext* getData() const;

               Returns
               (oratext*) node's data


getLength()
               Returns the length of the data for a CharacterData node (type Text, Comment or CDATA)
               in characters (not bytes).

               Syntax
               ub4 getLength() const;

               Returns
               (ub4) length in characters (not bytes!) of node's data




                                                                                                      3-8
                                                                                                  Chapter 3
                                                                                 CharacterDataRef Interface




insertData()
               Insert a string into a CharacterData node's data at the specified position. The inserted
               data must be in the data encoding. It will not be verified, converted, or checked. The
               offset is specified as characters, not bytes. The offset is zero-based, so inserting at
               offset zero prepends the data.

               Syntax
               void insertData(
                  ub4 offset,
                  oratext* data)
               throw (DOMException);


               Parameter               Description
                                       character offset where insertion starts
               offset

                                       data to insert
               data



replaceData()
               Replaces a range of characters in a CharacterData node's data with a new string. The
               offset is zero-based, so offset zero refers to the start of the data. The replacement
               data must be in the data encoding. It will not be verified, converted, or checked. The
               offset and count are both in characters, not bytes. If the sum of offset and count
               exceeds length, then all characters to the end of the data are replaced.

               Syntax
               void replaceData(
                  ub4 offset,
                  ub4 count,
                  oratext* data)
               throw (DOMException);


               Parameter               Description
                                       offset
               offset

                                       number of characters to replace
               count

                                       data
               data



setData()
               Sets data for a CharacterData node (type text, comment or CDATA), replacing the old
               data. The new data is not verified, converted, or checked -- it should be in the data
               encoding.




                                                                                                      3-9
                                                                                            Chapter 3
                                                                                CommentRef Interface




           Syntax
           void setData(
              oratext* data)
           throw (DOMException);


            Parameter              Description
                                   data
            data



substringData()
           Returns a range of character data from a CharacterData node (type Text, Comment or
           CDATA). Since the data is in the data encoding, offset and count are in characters, not
           bytes. The beginning of the string is offset 0. If the sum of offset and count exceeds
           the length, then all characters to the end of the data are returned. The substring is
           permanently allocated in the context managed memory and should be explicitly
           deallocated by freeString

           Syntax
           oratext* substringData(
              ub4 offset,
              ub4 count)
           throw (DOMException);


            Parameter              Description
                                   offset
            offset

                                   number of characters to extract
            count


           Returns
           (oratext *) specified substring


CommentRef Interface
           Table 3-5 summarizes the methods available through CommentRef interface.

           Table 3-5    Summary of CommentRef Methods; Dom Package

            Function                          Summary
            CommentRef()                      Constructor.
            ~CommentRef()                     Public default destructor.


CommentRef()
           Class constructor.




                                                                                              3-10
                                                                                               Chapter 3
                                                                                 DOMException Interface




         Syntax                                    Description
                                                   Used to create references to a given comment node
         CommentRef(
                                                   after a call to createComment.
            const NodeRef< Node>& node_ref,
            Node* nptr);

                                                   Copy constructor.
         CommentRef(
            const CommentRef< Node>& nref);



         Parameter               Description
                                 reference to provide the context
         node_ref

                                 referenced node
         nptr


         Returns
         (CommentRef) Node reference object


~CommentRef()
         This is the default destructor.

         Syntax
         ~CommentRef();


DOMException Interface
         Table 3-6 summarizes the methods available through the DOMException interface.

         Table 3-6    Summary of DOMException Methods; Dom Package

         Function                          Summary
         getDOMCode()                      Get DOM exception code embedded in the exception.
         getMesLang()                      Get current language encoding of error messages.
         getMessage()                      Get Oracle XML error message.


getDOMCode()
         This is a virtual member function that defines a prototype for implementation defined
         member functions returning DOM exception codes, defined in DOMExceptionCode, of
         the exceptional situations during execution

         Syntax
         virtual DOMExceptionCode getDOMCode() const = 0;




                                                                                                 3-11
                                                                                              Chapter 3
                                                                                  DOMImplRef Interface




          Returns
          (DOMExceptionCode) exception code


getMesLang()
          Virtual member function inherited from XmlException

          Syntax
          virtual oratext* getMesLang() const = 0;

          Returns
          (oratext*) Current language (encoding) of error messages


getMessage()
          Virtual member function inherited from XmlException

          Syntax
          virtual oratext* getMessage() const = 0;

          Returns
          (oratext *) Error message


DOMImplRef Interface
          Table 3-7 summarizes the methods available through DOMImplRef interface.

          Table 3-7      Summary of DOMImplRef Methods; Dom Package

          Function                          Summary
          DOMImplRef()                      Constructor.
          createDocument()                  Create document reference.
          createDocumentType()              Create DTD reference.
          formDocument()                    Forms document reference given a document pointer.
          getImplementation()               Get DOMImplementation object associated with the
                                            document.
          getNoMod()                        Get the 'no modification allowed' flag value.
          hasFeature()                      Determine if DOM feature is implemented.
          setContext()                      Set another context to a node.
          ~DOMImplRef()                     Public default destructor.


DOMImplRef()
          Class constructor.




                                                                                                3-12
                                                                                              Chapter 3
                                                                                  DOMImplRef Interface




          Syntax                                          Description
                                                          Creates reference object to
          DOMImplRef(
             Context* ctx_ptr,                            DOMImplementation object in a given
             DOMImplementation< Node>* impl_ptr);         context. Returns reference to the
                                                          implementation object.
                                                          It is needed to create other references to
          DOMImplRef(
                                                          the implementation object; deletion flags
             const DOMImplRef< Context, Node>& iref);
                                                          are not copied.

                                                          It is needed to create references to the
          DOMImplRef(
                                                          implementation object in a different
             const DOMImplRef< Context, Node>& iref,
                                                          context; deletion flags are not copied.
             Context* ctx_ptr);



          Parameter             Description
                                context pointer
          ctx_ptr

                                implementation
          impl_ptr


          Returns
          (DOMImplRef) reference to the implementation object


createDocument()
          Creates document reference

          Syntax
          DocumentRef< Node>* createDocument(
             oratext* namespaceURI,
             oratext* qualifiedName,
             DocumentTypeRef< Node>& doctype)
          throw (DOMException);


          Parameter             Description
                                namespace URI of root element
          namespaceURI

                                qualified name of root element
          qualifiedName

                                associated DTD node
          doctype


          Returns
          (DocumentRef< Node>*) document reference




                                                                                                 3-13
                                                                                           Chapter 3
                                                                               DOMImplRef Interface




createDocumentType()
           Creates DTD reference

           Syntax
           DocumentTypeRef< Node>* createDocumentType(
              oratext* qualifiedName,
              oratext* publicId,
              oratext* systemId)
           throw (DOMException);


           Parameter             Description
                                 qualified name
           qualifiedName

                                 external subset public Id
           publicId

                                 external subset system Id
           systemId


           Returns
           (DocumentTypeRef< Node>*) DTD reference


formDocument()
           Forms a document reference given a document pointer.

           Syntax
           DocumentRef< Node>* formDocument( Node* node);


           Parameter             Description
                                 pointer to the document node
           node


           Returns
           (DocumentRef< Node>*) pointer to the document reference


getImplementation()
           Returns DOMImplementation object that was used to create this document. When the
           DOMImplementation object is destructed, all document trees associated with it are also
           destructed.

           Syntax
           DOMImplementation< Node>* getImplementation() const;




                                                                                             3-14
                                                                                                  Chapter 3
                                                                                      DOMImplRef Interface




             Returns
             (DOMImplementation) DOMImplementation reference object


getNoMod()
             Get the 'no modification allowed' flag value. This is an Oracle extension.

             Syntax
             boolean getNoMod() const;

             Returns
             TRUE if flag's value is TRUE, FALSE otherwise


hasFeature()
             Determine if a DOM feature is implemented. Returns TRUE if the feature is
             implemented in the specified version, FALSE otherwise.

             In level 1, the legal values for package are 'HTML' and 'XML' (case-insensitive), and
             the version is the string "1.0". If the version is not specified, supporting any version of
             the feature will cause the method to return TRUE.

             DOM 1.0 features are "XML" and "HTML".
             DOM 2.0 features are "Core", "XML", "HTML", "Views", "StyleSheets", "CSS", "CSS2",
             "Events", "UIEvents", "MouseEvents", "MutationEvents", "HTMLEvents", "Range",
             "Traversal"

             Syntax
             boolean hasFeature(
                oratext* feature,
                oratext* version);


               Parameter             Description
                                     package name of feature
               feature

                                     version of package
               version


             Returns
             (boolean) is feature implemented?


setContext()
             It is needed to create node references in a different context




                                                                                                    3-15
                                                                                                    Chapter 3
                                                                                 DOMImplementation Interface




          Syntax
          void setContext(
             NodeRef< Node>& nref,
             Context* ctx_ptr);


          Parameter               Description
                                  reference node
          nref

                                  context pointer
          ctx_ptr



~DOMImplRef()
          This is the default destructor. It cleans the reference to the implementation object. It is
          usually called by the environment. But it can be called by the user directly if necessary.

          Syntax
          ~DOMImplRef();


DOMImplementation Interface
          Table 3-8 summarizes the methods available through DOMImplementation interface.

          Table 3-8    Summary of DOMImplementation Methods; Dom Package

          Function                                  Summary
          DOMImplementation()                       Constructor.
          getNoMod()                                Get the 'nomodificationallowed' flag value.
          ~DOMImplementation()                      Public default destructor.


DOMImplementation()
          Creates DOMImplementation object. Sets the 'no modifications allowed' flag to the
          parameter value.

          Syntax
          DOMImplementation(
             boolean no_mod);


          Parameter               Description

          no_mod                  whether modifications are allowed (FALSE) or not allowed (TRUE)



          Returns
          (DOMImplementation) implementation object




                                                                                                      3-16
                                                                                                   Chapter 3
                                                                              DocumentFragmentRef Interface




getNoMod()
             Get the 'no modification allowed' flag value. This is an Oracle extension.

             Syntax
             boolean getNoMod() const;

             Returns
             TRUE if flag's value is TRUE, FALSE otherwise


~DOMImplementation()
             This is the default destructor. It removes all DOM trees associated with this object.

             Syntax
             ~DOMImplementation();


DocumentFragmentRef Interface
             Table 3-9 summarizes the methods available through DocumentFragmentRef interface.

             Table 3-9   Summary of DocumentFragmentRef Methods; Dom Package

             Function                                Summary
             DocumentFragmentRef()                   Constructor.
             ~DocumentFragmentRef()                  Public default destructor.


DocumentFragmentRef()
             Class constructor.


             Syntax                                             Description
                                                                Used to create references to a given
             DocumentFragmentRef(
                                                                fragment node after a call to
                const NodeRef< Node>& node_ref,
                Node* nptr);                                    createDocumentFragment.

                                                                Copy constructor.
             DocumentFragmentRef(
                const DocumentFragmentRef< Node>& nref);



             Parameter               Description
                                     reference to provide the context
             node_ref

                                     referenced node
             nptr




                                                                                                       3-17
                                                                                               Chapter 3
                                                                                DocumentRange Interface




          Returns
          (DocumentFragmentRef) Node reference object


~DocumentFragmentRef()
          This is the default destructor.

          Syntax
          ~DocumentFragmentRef() {}


DocumentRange Interface
          Table 3-10 summarizes the methods available through DocumentRange interface.

          Table 3-10    Summary of DocumentRange Methods; Dom Package

           Function                                       Summary
           DocumentRange()                                Constructor.
           createRange()                                  Create new range object.
           destroyRange()                                 Destroys Range object.
           ~DocumentRange()                               Default destructor.


DocumentRange()
          Constructs the factory.

          Syntax
          DocumentRange();

          Returns
          (DocumentRange) new factory object


createRange()
          Create new range object.

          Syntax
          Range< Node>* createRange(
             DocumentRef< Node>& doc);


           Parameter                Description
                                    reference to document node
           doc




                                                                                                 3-18
                                                                                             Chapter 3
                                                                                 DocumentRef Interface




          Returns
          (Range*) Pointer to new range


destroyRange()
          Destroys range object.

          Syntax
          void destroyRange(
             Range< Node>* range)
          throw (DOMException);


           Parameter                 Description
                                     range
           range



~DocumentRange()
          Default destructor.

          Syntax
          ~DocumentRange();


DocumentRef Interface
          Table 3-11 summarizes the methods available through DocumentRef interface.

          Table 3-11      Summary of DocumentRef Methods; Dom Package

           Function                                Summary
           DocumentRef()                           Constructor.
           createAttribute()                       Create an attribute node.
           createAttributeNS()                     Create an attribute node with namespace
                                                   information.
           createCDATASection()                    Create a CDATA node.
           createComment()                         Create a comment node.
           createDocumentFragment()                Create a document fragment.
           createElement()                         Create an element node.
           createElementNS()                       Create an element node with names pace
                                                   information.
           createEntityReference()                 Create an entity reference node.
           createProcessingInstruction()           Create a ProcessingInstruction node
           createTextNode()                        Create a text node.
           getDoctype()                            Get DTD associated with the document.
           getDocumentElement()                    Get top-level element of this document.




                                                                                                3-19
                                                                                                   Chapter 3
                                                                                       DocumentRef Interface




            Table 3-11      (Cont.) Summary of DocumentRef Methods; Dom Package

             Function                                   Summary
             getElementById()                           Get an element given its ID.
             getElementsByTagName()                     Get elements in the document by tag name.
             getElementsByTagNameNS()                   Get elements in the document by tag name
                                                        (namespace aware version).
             getImplementation()                        Get DOMImplementation object associated with
                                                        the document.
             importNode()                               Import a node from another DOM.s
             ~DocumentRef()                             Public default destructor.


DocumentRef()
            This is a constructor.


             Syntax                                    Description
                                                       Default constructor.
             DocumentRef(
                const NodeRef< Node>& nref,
                Node* nptr);

                                                       Copy constructor.
             DocumentRef(
                const DocumentRef< Node>& nref);



             Parameter               Description
                                     reference to provide the context
             nref

                                     referenced node
             nptr


            Returns
            (DocumentRef) Node reference object


createAttribute()
            Creates an attribute node with the given name. This is the non-namespace aware
            function. The new attribute will have NULL namespace URI and prefix, and its local
            name will be the same as its name, even if the name specified is a qualified name.
            The new node is an orphan with no parent. The name is not copied, its pointer is just
            stored. The user is responsible for persistence and freeing of that data.

            Syntax
            Node* createAttribute(
               oratext* name)
            throw (DOMException);




                                                                                                      3-20
                                                                                             Chapter 3
                                                                                 DocumentRef Interface




            Parameter             Description
                                  name
            name


           Returns
           (Node*) New attribute node


createAttributeNS()
           Creates an attribute node with the given namespace URI and qualified name. The new
           node is an orphan with no parent. The URI and qualified name are not copied, their
           pointers are just stored. The user is responsible for persistence and freeing of that
           data.

           Syntax
           Node* createAttributeNS(
              oratext* namespaceURI,
              oratext* qualifiedName)
              throw (DOMException);


            Parameter             Description
                                  namespace URI
            namespaceURI

                                  qualified name
            qualifiedName


           Returns
           (Node*) New attribute node


createCDATASection()
           Creates a CDATA section node with the given initial data (which should be in the data
           encoding). A CDATA section is considered verbatim and is never parsed; it will not be
           joined with adjacent text nodes by the normalize operation. The initial data may be
           NULL, if provided; it is not verified, converted, or checked. The name of a CDATA node is
           always "#cdata-section". The new node is an orphan with no parent. The CDATA is not
           copied, its pointer is just stored. The user is responsible for persistence and freeing of
           that data.

           Syntax
           Node* createCDATASection(
              oratext* data)
           throw (DOMException);


            Parameter             Description
                                  data for new node
            data




                                                                                                3-21
                                                                                               Chapter 3
                                                                                   DocumentRef Interface




           Returns
           (Node*) New CDATA node


createComment()
           Creates a comment node with the given initial data (which must be in the data
           encoding). The data may be NULL, if provided; it is not verified, converted, or checked.
           The name of the comment node is always "#comment". The new node is an orphan with
           no parent. The comment data is not copied, its pointer is just stored. The user is
           responsible for persistence and freeing of that data.

           Syntax
           Node* createComment(
              oratext* data)
           throw (DOMException);


           Parameter               Description
                                   data for new node
           data


           Returns
           (Node*) New comment node


createDocumentFragment()
           Creates an empty Document Fragment node. A document fragment is treated
           specially when it is inserted into a DOM tree: the children of the fragment are inserted
           in order instead of the fragment node itself. After insertion, the fragment node will still
           exist, but have no children. The name of a fragment node is always "#document-
           fragment".

           Syntax
           Node* createDocumentFragment()
           throw (DOMException);

           Returns
           (Node*) new document fragment node


createElement()
           Creates an element node with the given tag name (which should be in the data
           encoding). The new node is an orphan with no parent. The tagname is not copied, its
           pointer is just stored. The user is responsible for persistence and freeing of that data.
           Note that the tag name of an element is case sensitive. This is the non-namespace
           aware function: the new node will have NULL namespace URI and prefix, and its local
           name will be the same as its tag name, even if the tag name specified is a qualified
           name.




                                                                                                  3-22
                                                                                            Chapter 3
                                                                                DocumentRef Interface




           Syntax
           Node* createElement(
              oratext* tagname)
           throw (DOMException);


           Parameter               Description
                                   tag name
           tagname


           Returns
           (Node*) New element node


createElementNS()
           Creates an element with the given namespace URI and qualified name. The new node
           is an orphan with no parent. The URI and qualified name are not copied, their pointers
           are just stored. The user is responsible for persistence and freeing of that data.
           Note that element names are case sensitive, and the qualified name is required
           though the URI may be NULL. The qualified name will be split into prefix and local
           parts. The tagName will be the full qualified name.

           Syntax
           Node* createElementNS(
              oratext* namespaceURI,
              oratext* qualifiedName)
           throw (DOMException);


           Parameter               Description
                                   namespace URI
           namespaceURI

                                   qualified name
           qualifiedName


           Returns
           (Node*) New element node


createEntityReference()
           Creates an entity reference node; the name (which should be in the data encoding) is
           the name of the entity to be referenced. The named entity does not have to exist. The
           name is not verified, converted, or checked. The new node is an orphan with no
           parent. The entity reference name is not copied; its pointer is just stored. The user is
           responsible for persistence and freeing of that data.
           Note that entity reference nodes are never generated by the parser; instead, entity
           references are expanded as encountered. On output, an entity reference node will turn
           into a "&name;" style reference.




                                                                                                3-23
                                                                                            Chapter 3
                                                                                DocumentRef Interface




           Syntax
           Node* createEntityReference(
              oratext* name)
           throw (DOMException);


            Parameter              Description
                                   name
            name


           Returns
           (Node*) New entity reference node


createProcessingInstruction()
           Creates a processing instruction node with the given target and data (which should be
           in the data encoding). The data may be NULL, but the target is required and cannot be
           changed. The target and data are not verified, converted, or checked. The name of the
           node is the same as the target. The new node is an orphan with no parent. The target
           and data are not copied; their pointers are just stored. The user is responsible for
           persistence and freeing of that data.

           Syntax
           Node* createProcessingInstruction(
              oratext* target,
              oratext* data)
           throw (DOMException);


            Parameter              Description
                                   target
            target

                                   data for new node
            data


           Returns
           (Node*) New PI node


createTextNode()
           Creates a text node with the given initial data (which must be non-NULL and in the data
           encoding). The data may be NULL; if provided, it is not verified, converted, checked, or
           parsed (entities will not be expanded). The name of the node is always "#text". The
           new node is an orphan with no parent. The text data is not copied, its pointer is just
           stored. The user is responsible for persistence and freeing of that data.

           Syntax
           Node* createTextNode(
              oratext* data)
           throw (DOMException);




                                                                                               3-24
                                                                                            Chapter 3
                                                                                DocumentRef Interface




           Parameter               Description
                                   data for new text node
           data


           Returns
           (Node*) new text node


getDoctype()
           Returns the DTD node associated with this document. After this call, a
           DocumentTypeRef object needs to be created with an appropriate constructor in order
           to call its member functions. The DTD tree cannot be edited.

           Syntax
           Node* getDoctype() const;

           Returns
           (Node*) DTD node


getDocumentElement()
           Returns the root element (node) of the DOM tree. Each document has only one
           uppermost Element node, called the root element. If there is no root element, NULL is
           returned. This can happen when the document tree is being constructed.

           Syntax
           Node* getDocumentElement() const;

           Returns
           (Node*) Root element


getElementById()
           Returns the element node which has the given ID. Throws NOT_FOUND_ERR if no
           element is found. The given ID should be in the data encoding or it might not match.
           Note that attributes named "ID" are not automatically of type ID; ID attributes (which
           can have any name) must be declared as type ID in the DTD or XML schema
           associated with the document.

           Syntax
           Node* getElementById(
              oratext* elementId);


           Parameter               Description
                                   element id
           elementId




                                                                                               3-25
                                                                                           Chapter 3
                                                                               DocumentRef Interface




         Returns
         (Node*)Element node


getElementsByTagName()
         Returns a list of all elements in the document with a given tag name, in document
         order (the order in which they would be encountered in a preorder traversal of the
         tree). The list should be freed by the user when it is no longer needed. The list is not
         live, it is a snapshot. That is, if a new node which matched the tag name were added
         to the DOM after the list was returned, the list would not automatically be updated to
         include the node.
         The special name "*" matches all tag names; a NULL name matches nothing. Note that
         tag names are case sensitive, and should be in the data encoding or a mismatch might
         occur.
         This function is not namespace aware; the full tag names are compared. If two
         qualified names with two different prefixes both of which map to the same URI are
         compared, the comparison will fail.

         Syntax
         NodeList< Node>* getElementsByTagName(
            oratext* tagname) const;


          Parameter             Description
                                tag name
          tagname


         Returns
         (NodeList< Node>*) List of nodes


getElementsByTagNameNS()
         Returns a list of all elements in the document with a given namespace URI and local
         name, in document order (the order in which they would be encountered in a preorder
         traversal of the tree). The list should be freed by the user when it is no longer needed.
         The list is not live, it is a snapshot. That is, if a new node which matches the URI and
         local name were added to the DOM after the list was returned, the list would not
         automatically be updated to include the node.
         The URI and local name should be in the data encoding. The special name "*"
         matches all local names; a NULL local name matches nothing. Namespace URIs must
         always match, however, no wildcard is allowed. Note that comparisons are case
         sensitive.

         Syntax
         NodeList< Node>* getElementsByTagNameNS(
            oratext* namespaceURI,
            oratext* localName);




                                                                                              3-26
                                                                                                  Chapter 3
                                                                                      DocumentRef Interface




           Parameter               Description
                                   namespace URI to match
           namespaceURI

                                   local name to match
           localName


           Returns
           (NodeList< Node>*) List of nodes


getImplementation()
           Returns DOMImplementation object that was used to create this document. When the
           DOMImplementation object is destructed, all document trees associated with it are
           also destructed.

           Syntax
           DOMImplementation< Node>* getImplementation() const;

           Returns
           (DOMImplementation) DOMImplementation reference object


importNode()
           Imports a node from one Document to another. The new node is an orphan and has
           no parent. The original node is not modified in any way or removed from its document;
           instead, a new node is created with copies of all the original node's qualified name,
           prefix, namespace URI, and local name.
           The deep parameter controls whether the children of the node are recursively
           imported. If FALSE, only the node itself is imported, and it will have no children. If TRUE,
           all descendents of the node will be imported as well, and an entire new subtree
           created. Elements will have only their specified attributes imported; non-specified
           (default) attributes are omitted. New default attributes (for the destination document)
           are then added. Document and DocumentType nodes cannot be imported.

           Syntax
           Node* importNode(
              NodeRef< Node>& importedNode,
              boolean deep) const
           throw (DOMException);


           Parameter                     Description
                                         node to import
           importedNode

                                         indicator for recursively importing the subtree
           deep




                                                                                                     3-27
                                                                                              Chapter 3
                                                                            DocumentTraversal Interface




           Returns
           (Node*) New imported node


~DocumentRef()
           This is the default destructor. It cleans the reference to the node. If the document node
           is marked for deletion, the destructor deletes the node and the tree under it. It is
           always deep deletion in the case of a document node. The destructor can be called by
           the environment or by the user directly.

           Syntax
           ~DocumentRef();


DocumentTraversal Interface
           Table 3-12 summarizes the methods available through DocumentTraversal interface.

           Table 3-12     Summary of DocumentTraversal Methods; Dom Package

            Function                                  Summary
            DocumentTraversal()                       Constructor.
            createNodeIterator()                      Create new NodeIterator object.
            createTreeWalker()                        Create new TreeWalker object.
            destroyNodeIterator()                     Destroys NodeIterator object.
            destroyTreeWalker()                       Destroys TreeWalker object.
            ~DocumentTraversal()                      Default destructor.


DocumentTraversal()
           Constructs the factory.

           Syntax
           DocumentTraversal();

           Returns
           (DocumentTraversal) new factory object


createNodeIterator()
           Create new iterator object.

           Syntax
           NodeIterator< Node>* createNodeIterator(
              NodeRef< Node>& root,
              WhatToShowCode whatToShow,




                                                                                                 3-28
                                                                                             Chapter 3
                                                                           DocumentTraversal Interface


              boolean entityReferenceExpansion)
           throw (DOMException);


            Parameter                  Description
                                       root of subtree, for iteration
            root

                                       node types filter
            whatToShow


            entityReferenceExpansion   if TRUE, expand entity references



           Returns
           (NodeIterator*) Pointer to new iterator


createTreeWalker()
           Create new TreeWalker object.

           Syntax
           TreeWalker< Node>* createTreeWalker(
              NodeRef< Node>& root,
              WhatToShowCode whatToShow,
              boolean entityReferenceExpansion)
           throw (DOMException);


            Parameter                  Description
                                       root of subtree, for traversal
            root

                                       node types filter
            whatToShow


            entityReferenceExpansion   if TRUE, expand entity references



           Returns
           (TreeWalker*) Pointer to new tree walker


destroyNodeIterator()
           Destroys node iterator object.

           Syntax
           void destroyNodeIterator(
              NodeIterator< Node>* iter)
           throw (DOMException);




                                                                                                3-29
                                                                                                Chapter 3
                                                                               DocumentTypeRef Interface




           Parameter                Description
                                    iterator
           iter



destroyTreeWalker()
           Destroys TreeWalker object.

           Syntax
           void destroyTreeWalker(
              TreeWalker< Node>* walker)
           throw (DOMException);


           Parameter                Description

           walker                   TreeWalker



~DocumentTraversal()
           Default destructor.

           Syntax
           ~DocumentTraversal();


DocumentTypeRef Interface
           Table 3-13 summarizes the methods available through DocumentTypeRef interface.

           Table 3-13       Summary of DocumentTypeRef Methods; Dom Package

           Function                               Summary
           DocumentTypeRef()                      Constructor.
           getEntities()                          Get DTD's entities.
           getInternalSubset()                    Get DTD's internal subset.
           getName()                              Get name of DTD.
           getNotations()                         Get DTD's notations.
           getPublicId()                          Get DTD's public ID.
           getSystemId()                          Get DTD's system ID.
           ~DocumentTypeRef()                     Public default destructor.


DocumentTypeRef()
           This is a constructor.




                                                                                                  3-30
                                                                                                    Chapter 3
                                                                                   DocumentTypeRef Interface




                Syntax                                         Description
                                                               Default constructor.
                DocumentTypeRef(
                   const NodeRef< Node>& node_ref,
                   Node* nptr);

                                                               Copy constructor.
                DocumentTypeRef(
                   const DocumentTypeRef< Node>& node_ref);



                Parameter            Description
                                     reference to provide the context
                node_ref

                                     referenced node
                nptr


            Returns
            (DocumentTypeRef) Node reference object


getEntities()
            Returns a named node map of general entities defined by the DTD.

            Syntax
            NamedNodeMap< Node>* getEntities() const;

            Returns
            (NamedNodeMap< Node>*) map containing entities


getInternalSubset()
            Returns the content model for an element. If there is no DTD, returns NULL.

            Syntax
            Node* getInternalSubset(
               oratext* name);


                Parameter            Description
                                     name of element
                name


            Returns
            (xmlnode*) content model subtree




                                                                                                      3-31
                                                                                          Chapter 3
                                                                         DocumentTypeRef Interface




getName()
            Returns DTD's name (specified immediately after the DOCTYPE keyword)

            Syntax
            oratext* getName() const;

            Returns
            (oratext*) name of DTD


getNotations()
            Returns a named node map of notations declared by the DTD.

            Syntax
            NamedNodeMap< Node>* getNotations() const;

            Returns
            (NamedNodeMap< Node>*) map containing notations


getPublicId()
            Returns DTD's public identifier

            Syntax
            oratext* getPublicId() const;

            Returns
            (oratext*) DTD's public identifier


getSystemId()
            Returns DTD's system identifier

            Syntax
            oratext* getSystemId() const;

            Returns
            (oratext*) DTD's system identifier


~DocumentTypeRef()
            This is the default destructor.

            Syntax
            ~DocumentTypeRef();




                                                                                            3-32
                                                                                                  Chapter 3
                                                                                       ElementRef Interface




ElementRef Interface
          Table 3-14 summarizes the methods available through ElementRef interface.

          Table 3-14        Summary of ElementRef Methods; Dom Package

           Function                                Summary
           ElementRef()                            Constructor.
           getAttribute()                          Get attribute's value given its name.
           getAttributeNS()                        Get attribute's value given its URI and local name.
           getAttributeNode()                      Get the attribute node given its name.
           getElementsByTagName()                  Get elements with given tag name.
           getTagName()                            Get element's tag name.
           hasAttribute()                          Check if named attribute exists.
           hasAttributeNS()                        Check if named attribute exists (namespace aware
                                                   version).
           removeAttribute()                       Remove attribute with specified name.
           removeAttributeNS()                     Remove attribute with specified URI and local name.
           removeAttributeNode()                   Remove attribute node
           setAttribute()                          Set new attribute for this element and/or new value.
           setAttributeNS()                        Set new attribute for the element and/or new value.
           setAttributeNode()                      Set attribute node.
           ~ElementRef()                           Public default destructor.


ElementRef()
          Class constructor.


           Syntax                                        Description
                                                         Used to create references to a given element
           ElementRef(
                                                         node after a call to createElement.
              const NodeRef< Node>& node_ref,
              Node* nptr);

                                                         Copy constructor.
           ElementRef(
              const ElementRef< Node>& node_ref);



           Parameter               Description
                                   reference to provide the context
           node_ref

                                   referenced node
           nptr




                                                                                                     3-33
                                                                                             Chapter 3
                                                                                  ElementRef Interface




            Returns
            (ElementRef) Node reference object


getAttribute()
            Returns the value of an element's attribute (specified by name). Note that an attribute
            may have the empty string as its value, but cannot be NULL.

            Syntax
            oratext* getAttribute(
               oratext* name) const;


             Parameter             Description
                                   name of attribute (data encoding)
             name


            Returns
            (oratext*) named attribute's value (in data encoding)


getAttributeNS()
            Returns the value of an element's attribute (specified by URI and local name). Note
            that an attribute may have the empty string as its value, but cannot be NULL.

            Syntax
            oratext* getAttributeNS(
               oratext* namespaceURI,
               oratext* localName);


             Parameter             Description
                                   namespace URI of attribute (data encoding)
             namespaceURI

                                   local name of attribute (data encoding)
             localName


            Returns
            (oratext *) named attribute's value (in data encoding)


getAttributeNode()
            Returns the attribute node given its name.

            Syntax
            Node* getAttributeNode(
               oratext* name) const;




                                                                                                3-34
                                                                                            Chapter 3
                                                                                 ElementRef Interface




            Parameter               Description
                                    name of attribute (data encoding)
            name


            Returns
            (Node*) the attribute node


getElementsByTagName()
            Returns a list of all elements with a given tag name, in the order in which they would
            be encountered in a preorder traversal of the subtree. The tag name should be in the
            data encoding. The special name "*" matches all tag names; a NULL name matches
            nothing. Tag names are case sensitive. This function is not namespace aware; the full
            tag names are compared. The returned list should be freed by the user.

            Syntax
            NodeList< Node>* getElementsByTagName(
               oratext* name);


            Parameter               Description
                                    tag name to match (data encoding)
            name


            Returns
            (NodeList< Node>*) the list of elements


getTagName()
            Returns the tag name of an element node which is supposed to have the same value
            as the node name from the node interface

            Syntax
            oratext* getTagName() const;

            Returns
            (oratext*) element's name [in data encoding]


hasAttribute()
            Determines if an element has a attribute with the given name

            Syntax
            boolean hasAttribute(
               oratext* name);




                                                                                               3-35
                                                                                          Chapter 3
                                                                               ElementRef Interface




            Parameter            Description
                                 name of attribute (data encoding)
            name


           Returns
           (boolean) TRUE if element has attribute with given name


hasAttributeNS()
           Determines if an element has a attribute with the given URI and local name

           Syntax
           boolean hasAttributeNS(
              oratext* namespaceURI,
              oratext* localName);


            Parameter            Description
                                 namespace URI of attribute (data encoding)
            namespaceURI

                                 local name of attribute (data encoding)
            localName


           Returns
           (boolean) TRUE if element has such attribute


removeAttribute()
           Removes an attribute specified by name. The attribute is removed from the element's
           list of attributes, but the attribute node itself is not destroyed.

           Syntax
           void removeAttribute(
              oratext* name) throw (DOMException);


            Parameter            Description
                                 name of attribute (data encoding)
            name



removeAttributeNS()
           Removes an attribute specified by URI and local name. The attribute is removed from
           the element's list of attributes, but the attribute node itself is not destroyed.

           Syntax
           void removeAttributeNS(
              oratext* namespaceURI,




                                                                                             3-36
                                                                                             Chapter 3
                                                                                  ElementRef Interface


               oratext* localName)
            throw (DOMException);


             Parameter               Description
                                     namespace URI of attribute (data encoding)
             namespaceURI

                                     local name of attribute (data encoding)
             localName



removeAttributeNode()
            Removes an attribute from an element. Returns a pointer to the removed attribute or
            NULL

            Syntax
            Node* removeAttributeNode(
               AttrRef< Node>& oldAttr)
            throw (DOMException);


             Parameter               Description
                                     old attribute node
             oldAttr


            Returns
            (Node*) the attribute node (old) or NULL


setAttribute()
            Creates a new attribute for an element with the given name and value (which should
            be in the data encoding). If the named attribute already exists, its value is simply
            replaced. The name and value are not verified, converted, or checked. The value is
            not parsed, so entity references will not be expanded.

            Syntax
            void setAttribute(
               oratext* name,
               oratext* value)
            throw (DOMException);


             Parameter               Description
                                     names of attribute (data encoding)
             name

                                     value of attribute (data encoding)
             value




                                                                                                3-37
                                                                                               Chapter 3
                                                                                    ElementRef Interface




setAttributeNS()
           Creates a new attribute for an element with the given URI, local name and value
           (which should be in the data encoding). If the named attribute already exists, its value
           is simply replaced. The name and value are not verified, converted, or checked. The
           value is not parsed, so entity references will not be expanded.

           Syntax
           void setAttributeNS(
              oratext* namespaceURI,
              oratext* qualifiedName,
              oratext* value)
           throw (DOMException);


            Parameter              Description
                                   namespace URI of attribute (data encoding)
            namespaceURI

                                   qualified name of attribute(data encoding)
            qualifiedName

                                   value of attribute(data encoding)
            value



setAttributeNode()
           Adds a new attribute to an element. If an attribute with the given name already exists,
           it is replaced and a pointer to the old attribute returned. If the attribute is new, it is
           added to the element's list and a pointer to the new attribute is returned.

           Syntax
           Node* setAttributeNode(
              AttrRef< Node>& newAttr)
           throw (DOMException);


            Parameter              Description
                                   new node
            newAttr


           Returns
           (Node*) the attribute node (old or new)


~ElementRef()
           This is the default destructor.

           Syntax
           ~ElementRef();




                                                                                                  3-38
                                                                                                          Chapter 3
                                                                                                 EntityRef Interface




EntityRef Interface
              Table 3-15 summarizes the methods available through EntityRef interface.

              Table 3-15    Summary of EntityRef Methods; Dom Package

              Function                              Summary
              EntityRef()EntityRef()                Constructor.
              getNotationName()getNotationNa        Get entity's notation.
              me()
              getPublicId()getPublicId()            Get entity's public ID.
              getSystemId()getSystemId()            Get entity's system ID.
              getType()getType()                    Get entity's type.
              ~EntityRef()~EntityRef()              Public default destructor.


EntityRef()
              Class constructor.


              Syntax                                       Description
                                                           Used to create references to a given entity node after
              EntityRef(
                 const NodeRef< Node>& node_ref,           a call to create Entity.
                 Node* nptr);

                                                           Copy constructor.
              EntityRef(
                 const EntityRef< Node>& nref);



              Parameter                  Description
                                         reference to provide the context
              node_ref

                                         referenced node
              nptr


              Returns
              (EntityRef) Node reference object


getNotationName()
              For unparsed entities, returns the name of its notation (in the data encoding). For
              parsed entities and other node types, returns NULL.

              Syntax
              oratext* getNotationName() const;




                                                                                                             3-39
                                                                                               Chapter 3
                                                                            EntityReferenceRef Interface




            Returns
            (oratext*) entity's notation


getPublicId()
            Returns an entity's public identifier (in the data encoding).

            Syntax
            oratext* getPublicId() const;

            Returns
            (oratext*) entity's public identifier


getSystemId()
            Returns an entity's system identifier (in the data encoding).

            Syntax
            oratext* getSystemId() const;

            Returns
            (oratext*) entity's system identifier


getType()
            Returns a boolean for an entity describing whether it is general (TRUE) or parameter
            (FALSE).

            Syntax
            boolean getType() const;

            Returns
            (boolean) TRUE for general entity, FALSE for parameter entity


~EntityRef()
            This is the default destructor.

            Syntax
            ~EntityRef();


EntityReferenceRef Interface
            Table 3-16 summarizes the methods available through EntityReferenceRef interface.




                                                                                                  3-40
                                                                                                   Chapter 3
                                                                               NamedNodeMapRef Interface




           Table 3-16    Summary of EntityReferenceRef Methods; Dom Package

           Function                                   Summary
           EntityReferenceRef()                       Constructor.
           ~EntityReferenceRef()                      Public default destructor.


EntityReferenceRef()
           Class constructor.


           Syntax                                                Description
                                                                 Used to create references to a given
           EntityReferenceRef(
                                                                 entity reference node after a call to
              const NodeRef< Node>& node_ref,
              Node* nptr);                                       create EntityReference.


                                                                 Copy constructor.
           EntityReferenceRef(
              const EntityReferenceRef< Node>& nref);



           Parameter                Description
                                    reference to provide the context
           node_ref

                                    referenced node
           nptr


           Returns
           (EntityReferenceRef) Node reference object


~EntityReferenceRef()
           This is the default destructor.

           Syntax
           ~EntityReferenceRef();


NamedNodeMapRef Interface
           Table 3-17 summarizes the methods available through NamedNodeMapRef interface.

           Table 3-17    Summary of NamedNodeMapRef Methods; Dom Package

           Function                                Summary
           NamedNodeMapRef()                       Constructor
           getLength()                             Get map's length
           getNamedItem()                          Get item given its name




                                                                                                     3-41
                                                                                                     Chapter 3
                                                                                   NamedNodeMapRef Interface




              Table 3-17   (Cont.) Summary of NamedNodeMapRef Methods; Dom Package

              Function                                Summary
              getNamedItemNS()                        Get item given its namespace URI and local name.
              item()                                  Get item given its index.
              removeNamedItem()                       Remove an item given its name.
              removeNamedItemNS()                     Remove the item from the map.
              setNamedItem()                          Add new item to the map.
              setNamedItemNS()                        Set named item to the map.
              ~NamedNodeMapRef()                      Default destructor.


NamedNodeMapRef()
              Class constructor.


              Syntax                                          Description
                                                              Used to create references to a given
              NamedNodeMapRef(
                 const NodeRef< Node>& node_ref,              NamedNodeMap node.
                 NamedNodeMap< Node>* mptr);

                                                              Copy constructor.
              NamedNodeMapRef(
                 const NamedNodeMapRef< Node>& mref);



              Parameter                Description
                                       reference to provide the context
              node_ref

                                       referenced node
              nptr


              Returns
              (NamedNodeMapRef) Node reference object


getLength()
              Get the length of the map.

              Syntax
              ub4 getLength() const;

              Returns
              (ub4) map's length




                                                                                                       3-42
                                                                                      Chapter 3
                                                                     NamedNodeMapRef Interface




getNamedItem()
          Get the name of the item, given its name.

          Syntax
          Node* getNamedItem( oratext* name) const;


          Parameter               Description
                                  name of item
          name


          Returns
          (Node*) pointer to the item


getNamedItemNS()
          Get the name of the item, given its namespace URI and local name.

          Syntax
          Node* getNamedItemNS(
             oratext* namespaceURI,
             oratext* localName) const;


          Parameter               Description
                                  namespace URI of item
          namespaceURI

                                  local name of item
          localName


          Returns
          (Node*) pointer to the item


item()
          Get item, given its index.

          Syntax
          Node* item(
             ub4 index) const;


          Parameter               Description
                                  index of item
          index




                                                                                        3-43
                                                                                    Chapter 3
                                                                   NamedNodeMapRef Interface




          Returns
          (Node*) pointer to the item


removeNamedItem()
          Remove the item from the map, given its name.

          Syntax
          Node* removeNamedItem(
             oratext* name)
          throw (DOMException);


          Parameter                Description
                                   name of item
          name


          Returns
          (Node*) pointer to the removed item


removeNamedItemNS()
          Remove the item from the map, given its namespace URI and local name.

          Syntax
          Node* removeNamedItemNS(
             oratext* namespaceURI,
             oratext* localName)
          throw (DOMException);


          Parameter                Description
                                   namespace URI of item
          namespaceURI

                                   local name of item
          localName


          Returns
          (Node*) pointer to the removed item


setNamedItem()
          Add new item to the map.

          Syntax
          Node* setNamedItem(
             NodeRef< Node>& newItem)
          throw (DOMException);




                                                                                      3-44
                                                                                                   Chapter 3
                                                                                     NodeFilter Interface




          Parameter             Description
                                item set to the map
          newItem


          Returns
          (Node*) pointer to new item


setNamedItemNS()
          Set named item, which is namespace aware, to the map.

          Syntax
          Node* setNamedItemNS(
             NodeRef< Node>& newItem)
          throw (DOMException);


          Parameter             Description
                                item set to the map
          newItem


          Returns
          (Node*) pointer to the item


~NamedNodeMapRef()
          Default destructor.

          Syntax
          ~NamedNodeMapRef();


NodeFilter Interface
          Table 3-18 summarizes the methods available through NodeFilter interface.

          Table 3-18   Summary of NodeFilter Methods; Dom Package

          Function                         Summary
          acceptNode()acceptNode()         Execute it for a given node and use its return value.


acceptNode()
          This function is used as a test by NodeIterator and TreeWalker.




                                                                                                     3-45
                                                                                                            Chapter 3
                                                                                               NodeIterator Interface




              Syntax
              template< typename Node> AcceptNodeCode AcceptNode(
                 NodeRef< Node>& nref);


              Parameter                   Description
                                          reference to the node to be tested.
              nref


              Returns
              (AcceptNodeCode) result returned by the filter function


NodeIterator Interface
              Table 3-19 summarizes the methods available through NodeIterator interface.

              Table 3-19    Summary of NodeIterator Methods; Dom Package

              Function                               Summary
              adjustCtx()                            Attach this iterator to the another context.
              detach()                               Invalidate the iterator.
              nextNode()                             Go to the next node.
              previousNode()                         Go to the previous node.


adjustCtx()
              Attaches this iterator to the context associated with a given node reference

              Syntax
              void adjustCtx(
                 NodeRef< Node>& nref);


              Parameter                   Description
                                          reference node
              nref



detach()
              Invalidates the iterator.

              Syntax
              void detach();


nextNode()
              Go to the next node.



                                                                                                              3-46
                                                                                                Chapter 3
                                                                                    NodeListRef Interface




           Syntax
           Node* nextNode() throw (DOMException);

           Returns
           (Node*) pointer to the next node


previousNode()
           Go to the previous node.

           Syntax
           Node* previousNode() throw (DOMException);

           Returns
           (Node*) pointer to the previous node


NodeListRef Interface
           Table 3-20 summarizes the methods available through NodeListRef interface.

           Table 3-20      Summary of NodeListRef Methods; Dom Package

           Function                           Summary
           NodeListRef()                      Constructor.
           getLength()                        Get list's length.
           item()                             Get item given its index.
           ~NodeListRef()                     Default destructor.


NodeListRef()
           Class constructor.


           Syntax                                     Description

           NodeListRef(                               Used to create references to a given NodeList
              const NodeRef< Node>& node_ref,         node.
              NodeList< Node>* lptr);

                                                      Copy constructor.
           NodeListRef(
              const NodeListRef< Node>& lref);



           Parameter              Description
                                  reference to provide the context
           node_ref




                                                                                                   3-47
                                                                                          Chapter 3
                                                                                  NodeRef Interface




              Parameter                Description
                                       referenced list
              lptr


              Returns
              (NodeListRef) Node reference object


getLength()
              Get the length of the list.

              Syntax
              ub4 getLength() const;

              Returns
              (ub4) list's length


item()
              Get the item, given its index.

              Syntax
              Node* item(
                 ub4 index) const;


              Parameter                Description
                                       index of item
              index


              Returns
              (Node*) pointer to the item


~NodeListRef()
              Destructs the object.

              Syntax
              ~NodeListRef();


NodeRef Interface
              Table 3-21 summarizes the methods available through NodeRef interface.




                                                                                             3-48
                                                                                                      Chapter 3
                                                                                              NodeRef Interface




            Table 3-21        Summary of NodeRef Methods; Dom Package

            Function                         Summary
            NodeRef()                        Constructor.
            appendChild()                    Append new child to node's list of children.
            cloneNode()                      Clone this node.
            getAttributes()                  Get attributes of this node.
            getChildNodes()                  Get children of this node.
            getFirstChild()                  Get the first child node of this node.
            getLastChild()                   Get the last child node of this node.
            getLocalName()                   Get local name of this node.
            getNamespaceURI()                Get namespace URI of this node as a NULL-terminated
                                             string.
            getNextSibling()                 Get the next sibling node of this node.
            getNoMod()                       Tests if no modifications are allowed for this node.
            getNodeName()                    Get node's name as NULL-terminated string.
            getNodeType()                    Get DOMNodeType of the node.
            getNodeValue()                   Get node's value as NULL-terminated string.
            getOwnerDocument()               Get the owner document of this node.
            getParentNode()                  Get parent node of this node.
            getPrefix()                      Get namespace prefix of this node.
            getPreviousSibling()             Get the previous sibling node of this node.
            hasAttributes()                  Tests if this node has attributes.
            hasChildNodes()                  Test if this node has children.
            insertBefore()                   Insert new child into node's list of children.
            isSupported()                    Tests if specified feature is supported by the
                                             implementation.
            markToDelete()                   Sets the mark to delete the referenced node.
            normalize()                      Merge adjacent text nodes.
            removeChild()                    Remove an existing child node.
            replaceChild()                   Replace an existing child of a node.
            resetNode()                      Reset NodeRef to reference another node.
            setNodeValue()                   Set node's value as NULL-terminated string.
            setPrefix()                      Set namespace prefix of this node.
            ~NodeRef()                       Public default destructor.


NodeRef()
            Class constructor.




                                                                                                         3-49
                                                                                                    Chapter 3
                                                                                           NodeRef Interface




              Syntax                             Description
                                                 Used to create references to a given node when at least
              NodeRef(
                                                 one reference to this node or another node is already
                 const NodeRef< Node>& nref,
                                                 available. The node deletion flag is not copied and is set
                 Node* nptr);
                                                 to FALSE.
                                                 Copy constructor. Used to create additional references to
              NodeRef(
                                                 the node when at least one reference is already
                 const NodeRef< Node>& nref);
                                                 available. The node deletion flag is not copied and is set
                                                 to FALSE.


              Parameter            Description
                                   reference to provide the context
              node_ref

                                   referenced node
              nptr


          Returns
          (NodeRef) Node reference object


appendChild()
          Appends the node to the end of this node's list of children and returns the new node. If
          newChild is a DocumentFragment, all of its children are appended in original order; the
          DocumentFragment node itself is not. If newChild is already in the DOM tree, it is first
          removed from its current position.

          Syntax
          Node* appendChild(
             NodeRef& newChild)
          throw (DOMException);


              Parameter            Description
                                   reference node
              newChild


          Returns
          (Node*) the node appended


cloneNode()
          Creates and returns a duplicate of this node. The duplicate node has no parent.
          Cloning an Element copies all attributes and their values, including those generated by
          the XML processor to represent defaulted attributes, but it does not copy any text it
          contains unless it is a deep clone, since the text is contained in a child Text node.
          Cloning any other type of node simply returns a copy of the node. If deep is TRUE, all
          children of the node are recursively cloned, and the cloned node will have cloned
          children; a non-deep clone will have no children. If the cloned node is not inserted into




                                                                                                       3-50
                                                                                                Chapter 3
                                                                                        NodeRef Interface


            another tree or fragment, it probably should be marked, through its reference, for
            deletion (by the user).

            Syntax
            Node* cloneNode(
               boolean deep);


             Parameter              Description

             deep                   whether to clone the entire node hierarchy beneath the node (TRUE),
                                    or just the node itself (FALSE)


            Returns
            (Node*) duplicate (cloned) node


getAttributes()
            Returns NamedNodeMap of attributes of this node, or NULL if it has no attributes. Only
            element nodes can have attribute nodes. For other node kinds, NULL is always
            returned. In the current implementation, the node map of child nodes is live; all
            changes in the original node are reflected immediately. Because of this, side effects
            can be present for some DOM tree manipulation styles, in particular, in multithreaded
            environments.

            Syntax
            NamedNodeMap< Node>* getAttributes() const;

            Returns
            (NamedNodeMap*) NamedNodeMap of attributes


getChildNodes()
            Returns the list of child nodes, or NULL if this node has no children. Only Element,
            Document, DTD, and DocumentFragment nodes may have children; all other types will
            return NULL. In the current implementation, the list of child nodes is live; all changes in
            the original node are reflected immediately. Because of this, side effects can be
            present for some DOM tree manipulation styles, in particular, in multithreaded
            environments.

            Syntax
            NodeList< Node>* getChildNodes() const;

            Returns
            (NodeList*) the list of child nodes


getFirstChild()
            Returns the first child node, or NULL, if this node has no children




                                                                                                   3-51
                                                                                              Chapter 3
                                                                                      NodeRef Interface




           Syntax
           Node* getFirstChild() const;

           Returns
           (Node*) the first child node, or NULL


getLastChild()
           Returns the last child node, or NULL, if this node has no children

           Syntax
           Node* getLastChild() const;

           Returns
           (Node*) the last child node, or NULL


getLocalName()
           Returns local name (local part of the qualified name) of this node (in the data
           encoding) as a NULL-terminated string. If this node's name is not fully qualified (has no
           prefix), then the local name is the same as the name.

           Syntax
           oratext* getLocalName() const;

           Returns
           (oratext*) local name of this node


getNamespaceURI()
           Returns the namespace URI of this node (in the data encoding) as a NULL-terminated
           string. If the node's name is not qualified (does not contain a namespace prefix), it will
           have the default namespace in effect when the node was created (which may be
           NULL).

           Syntax
           oratext* getNamespaceURI() const;

           Returns
           (oratext*) namespace URI of this node


getNextSibling()
           Returns the next sibling node, or NULL, if this node has no next sibling

           Syntax
           Node* getNextSibling() const;




                                                                                                 3-52
                                                                                              Chapter 3
                                                                                      NodeRef Interface




             Returns
             (Node*) the next sibling node, or NULL


getNoMod()
             Tests if no modifications are allowed for this node and the DOM tree it belongs to. This
             member function is Oracle extension.

             Syntax
             boolean getNoMod() const;

             Returns
             (boolean) TRUE if no modifications are allowed


getNodeName()
             Returns the (fully-qualified) name of the node (in the data encoding) as a NULL-
             terminated string, for example "bar\0" or "foo:bar\0". Some node kinds have fixed
             names: "#text", "#cdata-section", "#comment", "#document", "#document-fragment".
             The name of a node cannot changed once it is created.

             Syntax
             oratext* getNodeName() const;

             Returns
             (oratext*) name of node in data encoding


getNodeType()
             Returns DOMNodeType of the node

             Syntax
             DOMNodeType getNodeType() const;

             Returns
             (DOMNodeType) of the node


getNodeValue()
             Returns the "value" (associated character data) for a node as a NULL-terminated string.
             Character and general entities will have been replaced. Only Attr, CDATA, Comment,
             ProcessingInstruction and Text nodes have values, all other node types have NULL
             value.

             Syntax
             oratext* getNodeValue() const;




                                                                                                 3-53
                                                                                                   Chapter 3
                                                                                           NodeRef Interface




              Returns
              (oratext *) value of node


getOwnerDocument()
              Returns the document node associated with this node. It is assumed that the
              document node type is derived from the node type. Each node may belong to only one
              document, or may not be associated with any document at all, such as immediately
              after it was created on user's request. The "owning" document [node] is returned, or
              the WRONG_DOCUMENT_ERR exception is thrown.

              Syntax
              Node* getOwnerDocument() const throw (DOMException);

              Returns
              (Node*) the owning document node


getParentNode()
              Returns the parent node, or NULL, if this node has no parent

              Syntax
              Node* getParentNode() const;

              Returns
              (Node*) the parent node, or NULL


getPrefix()
              Returns the namespace prefix of this node (in the data encoding) (as a NULL-
              terminated string). If this node's name is not fully qualified (has no prefix), NULL is
              returned.

              Syntax
              oratext* getPrefix() const;

              Returns
              (oratext*) namespace prefix of this node


getPreviousSibling()
              Returns the previous sibling node, or NULL, if this node has no previous siblings

              Syntax
              Node* getPreviousSibling() const;




                                                                                                        3-54
                                                                                                Chapter 3
                                                                                        NodeRef Interface




            Returns
            (Node*) the previous sibling node, or NULL


hasAttributes()
            Returns TRUE if this node has attributes, if it is an element. Otherwise, it returns FALSE.
            Note that for nodes that are not elements, it always returns FALSE.

            Syntax
            boolean hasAttributes() const;

            Returns
            (boolean) TRUE is this node is an element and has attributes


hasChildNodes()
            Tests if this node has children. Only Element, Document, DTD, and DocumentFragment
            nodes may have children.

            Syntax
            boolean hasChildNodes() const;

            Returns
            (boolean) TRUE if this node has any children


insertBefore()
            Inserts the node newChild before the existing child node refChild in this node.
            refChild must be a child of this node. If newChild is a DocumentFragment, all of its
            children are inserted (in the same order) before refChild; the DocumentFragment node
            itself is not. If newChild is already in the DOM tree, it is first removed from its current
            position.

            Syntax
            Node* insertBefore(
               NodeRef& newChild,
               NodeRef& refChild)
            throw (DOMException);


            Parameter               Description
                                    new node
            newChild

                                    reference node
            refChild


            Returns
            (Node*) the node being inserted



                                                                                                   3-55
                                                                                                Chapter 3
                                                                                        NodeRef Interface




isSupported()
              Tests if the feature, specified by the arguments, is supported by the DOM
              implementation of this node.

              Syntax
              boolean isSupported(
                 oratext* feature,
                 oratext* version) const;


              Parameter               Description
                                      package name of feature
              feature

                                      version of package
              version


              Returns
              (boolean) TRUE is specified feature is supported


markToDelete()
              Sets the mark indicating that the referenced node should be deleted at the time when
              destructor of this reference is called. All other references to the node become invalid.
              This behavior is inherited by all other reference classes. This member function is
              Oracle extension.

              Syntax
              void markToDelete();


normalize()
              "Normalizes" the subtree rooted at an element, merges adjacent Text nodes children
              of elements. Note that adjacent Text nodes will never be created during a normal
              parse, only after manipulation of the document with DOM calls.

              Syntax
              void normalize();


removeChild()
              Removes the node from this node's list of children and returns it. The node is
              orphaned; its parent will be NULL after removal.

              Syntax
              Node* removeChild(
                 NodeRef& oldChild)
              throw (DOMException);




                                                                                                   3-56
                                                                                              Chapter 3
                                                                                      NodeRef Interface




              Parameter               Description
                                      old node
              oldChild


              Returns
              (Node*) node removed


replaceChild()
              Replaces the child node oldChild with the new node newChild in this node's children
              list, and returns oldChild (which is now orphaned, with a NULL parent). If newChild is a
              DocumentFragment, all of its children are inserted in place of oldChild; the
              DocumentFragment node itself is not. If newChild is already in the DOM tree, it is first
              removed from its current position.

              Syntax
              Node* replaceChild(
                 NodeRef& newChild,
                 NodeRef& oldChild)
              throw (DOMException);


              Parameter               Description
                                      new node
              newChild

                                      old node
              oldChild


              Returns
              (Node*) the node replaced


resetNode()
              This function resets NodeRef to reference Node given as an argument

              Syntax
              void resetNode(
                 Node* nptr);


              Parameter               Description
                                      reference node
              nptr



setNodeValue()
              Sets a node's value (character data) as a NULL-terminated string. Does not allow
              setting the value to NULL. Only Attr, CDATA, Comment, ProcessingInstruction, and




                                                                                                 3-57
                                                                                                Chapter 3
                                                                                        NodeRef Interface


              Text nodes have values. Trying to set the value of another kind of node is a no-op.
              The new value must be in the data encoding! It is not verified, converted, or checked.
              The value is not copied, its pointer is just stored. The user is responsible for
              persistence and freeing of that data.
              It throws the NO_MODIFICATION_ALLOWED_ERR exception, if no modifications are
              allowed, or UNDEFINED_ERR, with an appropriate Oracle XML error code (see xml.h), in
              the case of an implementation defined error.

              Syntax
              void setNodeValue(
                 oratext* data)
              throw (DOMException);


              Parameter               Description
                                      new value for node
              data



setPrefix()
              Sets the namespace prefix of this node (as NULL-terminated string). Does not verify the
              prefix is defined! And does not verify that the prefix is in the current data encoding.
              Just causes a new qualified name to be formed from the new prefix and the old local
              name.
              It throws the NO_MODIFICATION_ALLOWED_ERR exception, if no modifications are
              allowed. Or it throws NAMESPACE_ERR if the namespaceURI of this node is NULL, or if the
              specified prefix is "xml" and the namespaceURI of this node is different from "http://
              www.w3.org/XML/1998/namespace", or if this node is an attribute and the specified
              prefix is "xmlns" and the namespaceURI of this node is different from "http://
              www.w3.org/2000/xmlns/". Note that the INVALID_CHARACTER_ERR exception is never
              thrown since it is not checked how the prefix is formed

              Syntax
              void setPrefix(
                 oratext* prefix)
              throw (DOMException);


              Parameter               Description
                                      new namespace prefix
              prefix



~NodeRef()
              This is the default destructor. It cleans the reference to the node and, if the node is
              marked for deletion, deletes the node. If the node was marked for deep deletion, the
              tree under the node is also deleted (deallocated). It is usually called by the
              environment. But it can be called by the user directly if necessary.

              Syntax
              ~NodeRef();




                                                                                                   3-58
                                                                                                   Chapter 3
                                                                                       NotationRef Interface




NotationRef Interface
            Table 3-22 summarizes the methods available through NotationRef interface.

            Table 3-22       Summary of NotationRef Methods; Dom Package

            Function                           Summary
            NotationRef()                      Constructor.
            getPublicId()                      Get public ID.
            getSystemId()                      Get system ID.
            ~NotationRef()                     Public default destructor.


NotationRef()
            Class constructor.


            Syntax                                     Description
                                                       Used to create references to a given notation node
            NotationRef(
               const NodeRef< Node>& node_ref,         after a call to create Notation.
               Node* nptr);

                                                       Copy constructor.
            NotationRef(
               const NotationRef< Node>& nref);



            Parameter               Description
                                    reference to provide the context
            node_ref

                                    referenced node
            nptr


            Returns
            (NotationRef) Node reference object


getPublicId()
            Get public id.

            Syntax
            oratext* getPublicId() const;

            Returns
            (oratext*) public ID




                                                                                                      3-59
                                                                                                Chapter 3
                                                                       ProcessingInstructionRef Interface




getSystemId()
           Get system id.

           Syntax
           oratext* getSystemId() const;

           Returns
           (oratext*) system ID


~NotationRef()
           This is the default destructor.

           Syntax
           ~NotationRef();


ProcessingInstructionRef Interface
           Table 3-23 summarizes the methods available through ProcessingInstructionRef
           interface.

           Table 3-23     Summary of ProcessingInstructionRef Methods; Dom Package

            Function                                 Summary
            ProcessingInstructionRef()               Constructor.
            getData()                                Get processing instruction's data.
            getTarget()                              Get processing instruction's target.
            setData()                                Set processing instruction's data.
            ~ProcessingInstructionRef()              Public default destructor.


ProcessingInstructionRef()
           Class constructor.


            Syntax                                               Description
                                                                 Used to create references to a given
            ProcessingInstructionRef(
               const NodeRef< Node>& node_ref,                   ProcessingInstruction node
               Node* nptr);                                      after a call to create
                                                                 ProcessingInstruction.
                                                                 Copy constructor.
            ProcessingInstructionRef(
               const ProcessingInstructionRef< Node>& nref);




                                                                                                   3-60
                                                                                                     Chapter 3
                                                                            ProcessingInstructionRef Interface




              Parameter               Description
                                      reference to provide the context
              node_ref

                                      referenced node
              nptr


              Returns
              (ProcessingInstructionRef) Node reference object


getData()
              Returns the content (data) of a processing instruction (in the data encoding). The
              content is the part from the first non-whitespace character after the target until the
              ending "?>".

              Syntax
              oratext* getData() const;

              Returns
              (oratext*) processing instruction's data


getTarget()
              Returns a processing instruction's target string. The target is the first token following
              the markup that begins the ProcessingInstruction. All ProcessingInstructions
              must have a target, though the data part is optional.

              Syntax
              oratext* getTarget() const;

              Returns
              (oratext*) processing instruction's target


setData()
              Sets processing instruction's data (content), which must be in the data encoding. It is
              not permitted to set the data to NULL. The new data is not verified, converted, or
              checked.

              Syntax
              void setData(
                 oratext* data)
              throw (DOMException);




                                                                                                        3-61
                                                                                              Chapter 3
                                                                                        Range Interface




           Parameter                Description
                                    new data
           data



~ProcessingInstructionRef()
           This is the default destructor.

           Syntax
           ~ProcessingInstructionRef();


Range Interface
           Table 3-24 summarizes the methods available through Range interface.

           Table 3-24        Summary of Range Methods; Dom Package

           Function                                   Summary
           CompareBoundaryPoints()                    Compares boundary points.
           cloneContent()                             Makes a clone of the node.
           cloneRange()                               Clones a range of nodes.
           deleteContents()                           Deletes contents of the node.
           detach()                                   Invalidate the range.
           extractContent()                           Extract the node.
           getCollapsed()                             Check if the range is collapsed.
           getCommonAncestorContainer()               Get the deepest common ancestor node.
           getEndContainer()                          Get end container node.
           getEndOffset()                             Get offset of the end point.
           getStartContainer()                        Get start container node.
           getStartOffset()                           Get offset of the start point.
           insertNode()                               Inserts a node.
           selectNodeContent()                        Selects node content by its reference.
           selectNode()                               Selects a node.
           setEnd()                                   Set end point.
           setEndAfter()                              Sets the end pointer after a specified node.
           setEndBefore()                             Set the end before a specified node.
           setStart()                                 Set start point.
           setStartAfter()                            Sets start pointer after a specified node.
           setStartBefore()                           Sets start pointer before a specified node.
           surroundContents()                         Makes a node into a child of the specified
                                                      node.
           toString()                                 Converts an item into a string.




                                                                                                   3-62
                                                                      Chapter 3
                                                                Range Interface




CompareBoundaryPoints()
           Compares boundary points.

           Syntax
           CompareHowCode compareBoundaryPoints(
              unsigned short how,
              Range< Node>* sourceRange)
           throw (DOMException);


           Parameter              Description
                                  how to compare
           how

                                  range of comparison
           sourceRange


           Returns
           (CompareHowCode) result of comparison


cloneContent()
           Makes a clone of the node, including its children.

           Syntax
           Node* cloneContents() throw (DOMException);

           Returns
           (Node*) subtree cloned


cloneRange()
           Clones a range of nodes.

           Syntax
           Range< Node>* cloneRange();

           Returns
           (Range< Node>*) new cloned range


deleteContents()
           Deletes contents of the node.

           Syntax
           void deleteContents() throw (DOMException);




                                                                         3-63
                                                                                           Chapter 3
                                                                                     Range Interface




detach()
           Invalidates the range. It is not recommended to use this method since it leaves the
           object in invalid state. The preferable way is to call the destructor.

           Syntax
           void detach();


extractContent()
           Extract the node.

           Syntax
           Node* extractContents() throw (DOMException);

           Returns
           (Node*) subtree extracted


getCollapsed()
           Checks if the range is collapsed.

           Syntax
           boolean getCollapsed() const;

           Returns
           (boolean) TRUE if the range is collapsed, FALSE otherwise


getCommonAncestorContainer()
           Get the deepest common ancestor of the node.

           Syntax
           Node* getCommonAncestorContainer() const;

           Returns
           (Node*) common ancestor node


getEndContainer()
           Gets the container node.

           Syntax
           Node* getEndContainer() const;




                                                                                              3-64
                                                           Chapter 3
                                                     Range Interface




            Returns
            (Node*) end container node


getEndOffset()
            Get offset of the end point.

            Syntax
            long getEndOffset() const;

            Returns
            (long) offset


getStartContainer()
            Get start container node.

            Syntax
            Node* getStartContainer() const;

            Returns
            (Node*) start container node


getStartOffset()
            Get offset of the start point.

            Syntax
            long getStartOffset() const;

            Returns
            (long) offset


insertNode()
            Inserts a node.

            Syntax
            void insertNode(
               NodeRef< Node>& newNode)
            throw (RangeException, DOMException);


            Parameter                Description
                                     inserted node
            newNode




                                                              3-65
                                                                Chapter 3
                                                          Range Interface




selectNodeContent()
           Selects node content by its reference.

           Syntax
           void selectNodeContent(
              NodeRef< Node>& refNode)
           throw (RangeException);


            Parameter             Description
                                  reference node
            refNode



selectNode()
           Selects a node.

           Syntax
           void selectNode(
              NodeRef< Node>& refNode)
           throw (RangeException);


            Parameter             Description
                                  reference node
            refNode



setEnd()
           Sets an end point.

           Syntax
           void setEnd(
              NodeRef< Node>& refNode,
              long offset)
           throw (RangeException, DOMException);


            Parameter             Description
                                  reference node
            refNode

                                  offset
            offset



setEndAfter()
           Sets the end pointer after a specified node.




                                                                   3-66
                                                                Chapter 3
                                                          Range Interface




             Syntax
             void setEndAfter(
                NodeRef< Node>& refNode)
             throw (RangeException);


             Parameter               Description
                                     reference node
             refNode



setEndBefore()
             Set the end before a specified node.

             Syntax
             void setEndBefore(
                NodeRef< Node>& refNode)
             throw (RangeException);


             Parameter               Description
                                     reference node
             refNode



setStart()
             Sets start point.

             Syntax
             void setStart(
                NodeRef< Node>& refNode,
                long offset)
             throw (RangeException, DOMException);


             Parameter               Description
                                     reference node
             refNode

                                     offset
             offset



setStartAfter()
             Sets start pointer after a specified node.

             Syntax
             void setStartAfter(
                NodeRef< Node>& refNode)
             throw (RangeException);




                                                                   3-67
                                                                                         Chapter 3
                                                                          RangeException Interface




             Parameter              Description
                                    reference node
             refNode



setStartBefore()
             Sets start pointer before a specified node.

             Syntax
             void setStartBefore(
                NodeRef< Node>& refNode)
             throw (RangeException);


             Parameter              Description
                                    reference node
             refNode



surroundContents()
             Makes a node into a child of the specified node.

             Syntax
             void surroundContents(
                NodeRef< Node>& newParent)
             throw (RangeException, DOMException);


             Parameter              Description
                                    parent node
             newParent



toString()
             Converts an item into a string.

             Syntax
             oratext* toString();

             Returns
             (oratext*) string representation of the range


RangeException Interface
             Table 3-25 summarizes the methods available through RangeException interface.




                                                                                             3-68
                                                                                              Chapter 3
                                                                               RangeException Interface




            Table 3-25     Summary of RangeException Methods; Dom Package

            Function                         Summary
            getCode()                        Get Oracle XML error code embedded in the exception.
            getMesLang()                     Get current language (encoding) of error messages.
            getMessage()                     Get Oracle XML error message.
            getRangeCode()                   Get Range exception code embedded in the exception.


getCode()
            Gets Oracle XML error code embedded in the exception. Virtual member function
            inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            Gets the current language encoding of error messages. Virtual member function
            inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages


getMessage()
            Get XML error message. Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMessage() const = 0;

            Returns
            (oratext *) Error message


getRangeCode()
            This is a virtual member function that defines a prototype for implementation defined
            member functions returning Range exception codes, defined in RangeExceptionCode,
            of the exceptional situations during execution.




                                                                                                  3-69
                                                                                                   Chapter 3
                                                                                           TextRef Interface




              Syntax
              virtual RangeExceptionCode getRangeCode() const = 0;

              Returns
              (RangeExceptionCode) exception code


TextRef Interface
              Table 3-26 summarizes the methods available through TextRef interface.

              Table 3-26    Summary of TextRef Methods; Dom Package

              Function                          Summary
              TextRef()                         Constructor.
              splitText()                       Split text node into two.
              ~TextRef()                        Public default destructor.


TextRef()
              Class constructor.


              Syntax                                    Description
                                                        Used to create references to a given text node
              TextRef(
                 const NodeRef< Node>& node_ref,        after a call to createtext.
                 Node* nptr);

                                                        Copy constructor.
              TextRef(
                 const TextRef< Node>& nref);




              Parameter              Description
                                     reference to provide the context
              node_ref

                                     referenced node
              nptr


              Returns
              (TextRef) Node reference object


splitText()
              Splits a single text node into two text nodes; the original data is split between them.
              The offset is zero-based, and is in characters, not bytes. The original node is retained,
              its data is just truncated. A new text node is created which contains the remainder of




                                                                                                      3-70
                                                                                                        Chapter 3
                                                                                             TreeWalker Interface


              the original data, and is inserted as the next sibling of the original. The new text node
              is returned.

              Syntax
              Node* splitText(
                 ub4 offset)
              throw (DOMException);


              Parameter               Description
                                      character offset where to split text
              offset


              Returns
              (Node*) new node


~TextRef()
              This is the default destructor.

              Syntax
              ~TextRef();


TreeWalker Interface
              Table 3-27 summarizes the methods available through TreeWalker interface.

              Table 3-27      Summary of TreeWalker Methods; Dom Package

              Function                            Summary
              adjustCtx()                         Attach this tree walker to another context.
              firstChild()                        Get the first child of the current node.
              lastChild()                         Get the last child of the current node.
              nextNode()                          Get the next node.
              nextSibling()                       Get the next sibling node.
              parentNode()                        Get the parent of the current node.
              previousNode()                      Get the previous node.
              previousSibling()                   Get the previous sibling node.


adjustCtx()
              Attaches this tree walker to the context associated with a given node reference

              Syntax
              void adjustCtx(
                 NodeRef< Node>& nref);




                                                                                                           3-71
                                                                                     Chapter 3
                                                                          TreeWalker Interface




               Parameter               Description
                                       reference to provide the context
               nref



firstChild()
               Get the first child of the current node.

               Syntax
               Node* firstChild();

               Returns
               (Node*) pointer to first child node


lastChild()
               Get the last child of the current node.

               Syntax
               Node* lastChild();

               Returns
               (Node*) pointer to last child node


nextNode()
               Get the next node.

               Syntax
               Node* nextNode();

               Returns
               (Node*) pointer to the next node


nextSibling()
               Get the next sibling node.

               Syntax
               Node* nextSibling();

               Returns
               (Node*) pointer to the next sibling node




                                                                                        3-72
                                                                      Chapter 3
                                                           TreeWalker Interface




parentNode()
            Get the parent of the current node.

            Syntax
            Node* parentNode();

            Returns
            (Node*) pointer to the parent node


previousNode()
            Get the previous node.

            Syntax
            Node* previousNode();

            Returns
            (Node*) pointer to previous node


previousSibling()
            Get the previous sibling node.

            Syntax
            Node* previousSibling();

            Returns
            (Node*) pointer to the previous sibling node




                                                                         3-73
4
Package IO APIs for C++
          The IO Package for C++ APIs describes the input/output IO datatypes and
          InputSource methods.



                 See Also:
                 Oracle XML Developer's Kit Programmer's Guide




IO Datatypes
          Table 4-1 summarizes the datatypes of the IO package.

          Table 4-1    Summary of Datatypes; IO Package

          Datatype                         Description
          InputSourceType                  Defines input source types.


InputSourceType
          Defines input source types.

          Definition
          typedef enum InputSourceType {
             ISRC_URI = 1,
             ISRC_FILE = 2,
             ISRC_BUFFER = 3,
             ISRC_DOM = 4,
             ISRC_CSTREAM = 5 }
          InputSourceType;


InputSource Interface
          Table 4-2 summarizes the methods available through the IO interface

          Table 4-2    Summary of IO Package Interfaces

          Function                         Summary
          getBaseURI()                     Get the base URI.
          getISrcType()                    Get the input source type.
          setBaseURI()                     Set the base URI.




                                                                                    4-1
                                                                                           Chapter 4
                                                                               InputSource Interface




getBaseURI()
           Gets the base URI. It is used by some input sources such as File and URI.

           Syntax
           oratext* getBaseURI() { return baseURI; }

           Returns
           (oratext*) base URI


getISrcType()
           Gets the input source type.

           Syntax
           InputSourceType getISrcType() const { return isrctype; }

           Returns
           (InputSourceType) input source type


setBaseURI()
           Sets the base URI. It is used by some input sources such as File and URI.

           Syntax
           void setBaseURI( oratext* base_URI) baseURI = base_URI; }




                                                                                               4-2
5
Package Parser APIs for C++
          The Parser interfaces include Parserdatatypes, DOMParsermethods, GParser methods,
          ParserException methods,SAXHandler methods, SAXParsermethods, and
          SchemaValidatormethods.



                 See Also:
                 Oracle XML Developer's Kit Programmer's Guide




Parser Datatypes
          Table 5-1 summarizes the datatypes of the Parser package.

          Table 5-1    Summary of Datatypes; Parser Package

          Datatype                             Description
          ParserExceptionCode                  Parser implementation of exceptions.
          DOMParserIdType                      Defines parser identifiers.
          SAXParserIdType                      Defines type of node.
          SchValidatorIdType                   Defines validator identifiers.


ParserExceptionCode
          Parser implementation of exceptions.

          Definition
          typedef enum ParserExceptionCode {
             PARSER_UNDEFINED_ERR = 0,
             PARSER_VALIDATION_ERR = 1,
             PARSER_VALIDATOR_ERR = 2,
             PARSER_BAD_ISOURCE_ERR = 3,
             PARSER_CONTEXT_ERR = 4,
             PARSER_PARAMETER_ERR = 5,
             PARSER_PARSE_ERR = 6,
             PARSER_SAXHANDLER_SET_ERR = 7,
             PARSER_VALIDATOR_SET_ERR = 8 }
          ParserExceptionCode;


DOMParserIdType
          Defines parser identifiers.




                                                                                       5-1
                                                                                                  Chapter 5
                                                                                       DOMParser Interface




           Definition
           typedef enum DOMParserIdType {       DOMParCXml             = 1       } DOMParserIdType;
           ypedef enum CompareHowCode {
              START_TO_START = 0,
              START_TO_END = 1,
              END_TO_END = 2,
              END_TO_START = 3 }
           CompareHowCode;


SAXParserIdType
           Defines parser identifiers.

           Definition
           typedef enum SAXParserIdType {
              SAXParCXml = 1 }
           SAXParserIdType;


SchValidatorIdType
           Defines validator identifiers.These identifiers are used as parameters to the XML tools
           factory when a particular validator object has to be created.

           Definition
           typedef enum SchValidatorIdType {
              SchValCXml         = 1
           } SchValidatorIdType;


DOMParser Interface
           Table 5-2 summarizes the methods available through the DOMParser interface.

           Table 5-2      Summary of DOMParser Methods; Parser Package

           Function                         Summary
           getContext()                     Returns parser's XML context (allocation and encodings).
           getParserId()                    Get parser id.
           parse()                          Parse the document.
           parseDTD()                       Parse DTD document.
           parseSchVal()                    Parse and validate the document.
           setValidator()                   Set the validator for this parser.


getContext()
           Each parser object is allocated and executed in a particular Oracle XML context. This
           member function returns a pointer to this context.




                                                                                                      5-2
                                                                                   Chapter 5
                                                                        DOMParser Interface




             Syntax
             virtual Context* getContext() const = 0;

             Returns
             (Context*) pointer to parser's context


getParserId()
             Syntax
             virtual DOMParserIdType getParserId() const = 0;

             Returns
             (DOMParserIdType) Parser Id


parse()
             Parses the document and returns the tree root node

             Syntax
             virtual DocumentRef< Node>* parse(
                InputSource* isrc_ptr,
                boolean DTDvalidate = FALSE,
                DocumentTypeRef< Node>* dtd_ptr = NULL,
                boolean no_mod = FALSE,
                DOMImplementation< Node>* impl_ptr = NULL)
             throw (ParserException) = 0;


             Parameter             Description
                                   input source
             isrc_ptr


             DTDvalidate           TRUE if validated by DTD

                                   DTD reference
             dtd_ptr


             no_mod                TRUE if no modifications allowed


             impl_ptr              optional DomImplementation pointer



             Returns
             (DocumentRef) document tree


parseDTD()
             Parse DTD document.




                                                                                       5-3
                                                                                             Chapter 5
                                                                                  DOMParser Interface




            Syntax
            virtual DocumentRef< Node>* parseDTD(
               InputSource* isrc_ptr,
               boolean no_mod = FALSE,
               DOMImplementation< Node>* impl_ptr = NULL)
            throw (ParserException) = 0;


            Parameter              Description
                                   input source
            isrc_ptr


            no_mod                 TRUE if no modifications allowed

                                   optional DomImplementation pointer
            impl_ptr


            Returns
            (DocumentRef) DTD document tree


parseSchVal()
            Parses and validates the document. Sets the validator if the corresponding parameter
            is not NULL.

            Syntax
            virtual DocumentRef< Node>* parseSchVal(
               InputSource* src_par,
               boolean no_mod = FALSE,
               DOMImplementation< Node>* impl_ptr = NULL,
               SchemaValidator< Node>* tor_ptr = NULL)
            throw (ParserException) = 0;


            Parameter              Description
                                   input source
            isrc_ptr


            no_mod                 TRUE if no modifications allowed

                                   optional DomImplementation pointer
            impl_ptr

                                   schema validator
            tor_ptr


            Returns
            (DocumentRef) document tree


setValidator()
            Sets the validator for all validations except when another one is given in parseSchVal



                                                                                                 5-4
                                                                                                        Chapter 5
                                                                                             GParser Interface




           Syntax
           virtual void setValidator(
           SchemaValidator< Node>* tor_ptr) = 0;


           Parameter              Description
                                  schema validator
           tor_ptr



GParser Interface
           Table 5-3 summarizes the methods available through the GParser interface.

           Table 5-3   Summary of GParser Methods; Parser Package

           Function                             Summary
           SetWarnDuplicateEntity()             Specifies if multiple entity declarations result in a
                                                warning.
           getBaseURI()                         Returns the base URI for the document.
           getDiscardWhitespaces()              Checks if whitespaces between elements are discarded.
           getExpandCharRefs()                  Checks if character references are expanded.
           getSchemaLocation()                  Get schema location for this document.
           getStopOnWarning()                   Get if document processing stops on warnings.
           getWarnDuplicateEntity()             Get if multiple entity declarations cause a warning.
           setBaseURI()                         Sets the base URI for the document.
           setDiscardWhitespaces()              Sets if formatting whitespaces should be discarded.
           setExpandCharRefs()                  Get if character references are expanded.
           setSchemaLocation()                  Set schema location for this document.
           setStopOnWarning()                   Sets if document processing stops on warnings.


SetWarnDuplicateEntity()
           Specifies if entities that are declared more than once will cause warnings to be issued.

           Syntax
           void setWarnDuplicateEntity(
              boolean par_bool);


           Parameter              Description

           par_bool               TRUE if multiple entity declarations cause a warning




                                                                                                            5-5
                                                                                            Chapter 5
                                                                                    GParser Interface




getBaseURI()
          Returns the base URI for the document. Usually only documents loaded from a URI
          will automatically have a base URI. Documents loaded from other sources (stdin,
          buffer, and so on) will not naturally have a base URI, but a base URI may have been
          set for them using setBaseURI, for the purposes of resolving relative URIs in inclusion.

          Syntax
          oratext* getBaseURI() const;

          Returns
          (oratext *) current document's base URI [or NULL]


getDiscardWhitespaces()
          Checks if formatting whitespaces between elements, such as newlines and indentation
          in input documents are discarded. By default, all input characters are preserved.

          Syntax
          boolean getDiscardWhitespaces() const;

          Returns
          (boolean) TRUE if whitespace between elements are discarded


getExpandCharRefs()
          Checks if character references are expanded in the DOM data. By default, character
          references are replaced by the character they represent. However, when a document
          is saved those characters entities do not reappear. To ensure they remain through
          load and save, they should not be expanded.

          Syntax
          boolean getExpandCharRefs() const;

          Returns
          (boolean) TRUE if character references are expanded


getSchemaLocation()
          Gets schema location for this document. It is used to figure out the optimal layout
          when loading documents into a database.

          Syntax
          oratext* getSchemaLocation() const;

          Returns
          (oratext*) schema location




                                                                                                5-6
                                                                                            Chapter 5
                                                                                    GParser Interface




getStopOnWarning()
           When TRUE is returned, warnings are treated the same as errors and cause parsing,
           validation, and so on, to stop immediately. By default, warnings are issued but the
           processing continues.

           Syntax
           boolean getStopOnWarning() const;

           Returns
           (boolean) TRUE if document processing stops on warnings


getWarnDuplicateEntity()
           Get if entities which are declared more than once will cause warnings to be issued.

           Syntax
           boolean getWarnDuplicateEntity() const;

           Returns
           (boolean) TRUE if multiple entity declarations cause a warning


setBaseURI()
           Sets the base URI for the document. Usually only documents that were loaded from a
           URI will automatically have a base URI. Documents loaded from other sources (stdin,
           buffer, and so on) will not naturally have a base URI, but a base URI may have been
           set for them using setBaseURI, for the purposes of resolving relative URIs in inclusion.

           Syntax
           void setBaseURI( oratext* par);


           Parameter              Description
                                  base URI
           par



setDiscardWhitespaces()
           Sets if formatting whitespaces between elements (newlines and indentation) in input
           documents are discarded. By default, ALL input characters are preserved.

           Syntax
           void setDiscardWhitespaces(
              boolean par_bool);




                                                                                                 5-7
                                                                                                 Chapter 5
                                                                                         GParser Interface




           Parameter               Description

           par_bool                TRUE if whitespaces should be discarded



setExpandCharRefs()
          Sets if character references should be expanded in the DOM data. Ordinarily,
          character references are replaced by the character they represent. However, when a
          document is saved those characters entities do not reappear. To ensure they remain
          through load and save is to not expand them.

          Syntax
          void setExpandCharRefs(
             boolean par_bool);


           Parameter               Description

           par_bool                TRUE if character references should be discarded



setSchemaLocation()
          Sets schema location for this document. It is used to figure out the optimal layout when
          loading documents into a database.

          Syntax
           void setSchemaLocation(
             oratext* par);


           Parameter               Description
                                   schema location
           par



setStopOnWarning()
          When TRUE is set, warnings are treated the same as errors and cause parsing,
          validation, and so on, to stop immediately. By default, warnings are issued but the
          processing continues.

          Syntax
          void setStopOnWarning(
             boolean par_bool);


           Parameter               Description

           par_bool                TRUE if document processing should stop on warnings




                                                                                                     5-8
                                                                                              Chapter 5
                                                                              ParserException Interface




ParserException Interface
            Table 5-4 summarizes the methods available through the ParserException interface.

            Table 5-4   Summary of ParserException Methods; Parser Package

            Function                        Summary
            getCode()                       Get Oracle XML error code embedded in the exception.
            getMesLang()                    Get current language (encoding) of error messages.
            getMessage()                    Get Oracle XML error message.
            getParserCode()                 Get parser exception code embedded in the exception.


getCode()
            Virtual member function inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages


getMessage()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMessage() const = 0;

            Returns
            (oratext *) Error message




                                                                                                   5-9
                                                                                                  Chapter 5
                                                                                      SAXHandler Interface




getParserCode()
          This is a virtual member function that defines a prototype for implementation defined
          member functions returning parser and validator exception codes, defined in
          ParserExceptionCode, of the exceptional situations during execution.

          Syntax
          virtual ParserExceptionCode getParserCode() const = 0;

          Returns
          (ParserExceptionCode) exception code


SAXHandler Interface
          Table 5-5 summarizes the methods available through the SAXHandler interface.

          Table 5-5       Summary of SAXHandler Methods; Parser Package

           Function                        Summary
           CDATA()                         Receive notification of CDATA.
           XMLDecl()                       Receive notification of an XML declaration.
           attributeDecl()                 Receive notification of attribute's declaration.
           characters()                    Receive notification of character data.
           comment()                       Receive notification of a comment.
           elementDecl()                   Receive notification of element's declaration.
           endDocument()                   Receive notification of the end of the document.
           endElement()                    Receive notification of element's end.
           notationDecl()                  Receive notification of a notation declaration.
           parsedEntityDecl()              Receive notification of a parsed entity declaration.
           processingInstruction()         Receive notification of a processing instruction.
           startDocument()                 Receive notification of the start of the document.
           startElement()                  Receive notification of element's start.
           startElementNS()                Receive namespace aware notification of element's start.
           unparsedEntityDecl()            Receive notification of an unparsed entity declaration.
           whitespace()                    Receive notification of whitespace characters.


CDATA()
          This event handles CDATA, as distinct from Text. The data will be in the data
          encoding, and the returned length is in characters, not bytes. This is an Oracle
          extension.




                                                                                                     5-10
                                                                                             Chapter 5
                                                                                  SAXHandler Interface




            Syntax
            virtual void CDATA(
               oratext* data,
               ub4 size) = 0;


             Parameter             Description
                                   pointer to CDATA
             data

                                   size of CDATA
             size



XMLDecl()
            This event marks an XML declaration (XMLDecl). The startDocument event is always
            first; this event will be the second event. The encoding flag says whether an encoding
            was specified. For the standalone flag, -1 will be returned if it was not specified,
            otherwise 0 for FALSE, 1 for TRUE. This member function is an Oracle extension.

            Syntax
            virtual void XMLDecl(
               oratext* version,
               boolean is_encoding,
               sword standalone) = 0;


             Parameter             Description
                                   version string from XMLDecl
             version

                                   whether encoding was specified
             is_encoding

                                   value of standalone value flag
             standalone



attributeDecl()
            This event marks an attribute declaration in the DTD. It is an Oracle extension; not in
            SAX standard

            Syntax
            virtual void attributeDecl(
               oratext* attr_name,
               oratext *name,
               oratext *content) = 0;


             Parameter             Description
                                   name of the attribute
             attr_name




                                                                                                5-11
                                                                                            Chapter 5
                                                                                 SAXHandler Interface




               Parameter             Description
                                     name of the declaration
               name

                                     body of attribute declaration
               content



characters()
            This event marks character data.

            Syntax
            virtual void characters(
               oratext* ch,
               ub4 size) = 0;


               Parameter             Description
                                     pointer to data
               ch

                                     length of data
               size



comment()
            This event marks a comment in the XML document. The comment's data will be in the
            data encoding. It is an Oracle extension, not in SAX standard.

            Syntax
            virtual void comment(
               oratext* data) = 0;


               Parameter             Description
                                     comment's data
               data



elementDecl()
            This event marks an element declaration in the DTD. It is an Oracle extension; not in
            SAX standard.

            Syntax
            virtual void elementDecl(
               oratext *name,
               oratext *content) = 0;




                                                                                               5-12
                                                                                          Chapter 5
                                                                               SAXHandler Interface




            Parameter            Description
                                 element's name
            name

                                 element's content
            content



endDocument()
           Receive notification of the end of the document.

           Syntax
           virtual void endDocument() = 0;


endElement()
           This event marks the end of an element. The name is the tagName of the element
           (which may be a qualified name for namespace-aware elements) and is in the data
           encoding.

           Syntax
           virtual void endElement( oratext* name) = 0;


notationDecl()
           The even marks the declaration of a notation in the DTD. The notation's name, public
           ID, and system ID will all be in the data encoding. Both IDs are optional and may be
           NULL.

           Syntax
           virtual void notationDecl(
              oratext* name,
              oratext* public_id,
              oratext* system_id) = 0;


            Parameter            Description
                                 notations's name
            name

                                 notation's public Id
            public_id

                                 notation's system Id
            sysem_id



parsedEntityDecl()
           Marks a parsed entity declaration in the DTD. The parsed entity's name, public ID,
           system ID, and notation name will all be in the data encoding. This is an Oracle
           extension.




                                                                                             5-13
                                                                                                 Chapter 5
                                                                                      SAXHandler Interface




            Syntax
            virtual void parsedEntityDecl(
               oratext* name,
               oratext* value,
               oratext* public_id,
               oratext* system_id,
               boolean general) = 0;


            Parameter              Description
                                   entity's name
            name

                                   entity's value if internal
            value

                                   entity's public Id
            public_id

                                   entity's system Id
            sysem_id


            general                whether a general entity (FALSE if parameter entity)




processingInstruction()
            This event marks a processing instruction. The PI's target and data will be in the data
            encoding. There is always a target, but the data may be NULL.

            Syntax
            virtual void processingInstruction(
               oratext* target,
               oratext* data) = 0;


            Parameter              Description
                                   PI's target
            target

                                   PI's data
            data



startDocument()
            Receive notification of the start of document.

            Syntax
            virtual void startDocument() = 0;


startElement()
            This event marks the start of an element.




                                                                                                    5-14
                                                                                         Chapter 5
                                                                              SAXHandler Interface




           Syntax
           virtual void startElement(
              oratext* name,
              NodeListRef< Node>* attrs_ptr) = 0;


           Parameter             Description
                                 element's name
           name

                                 list of element's attributes
           attrs_ptr



startElementNS()
           This event marks the start of an element. Note this is the new SAX 2 namespace-
           aware version. The element's qualified name, local name, and namespace URI will be
           in the data encoding, as are all the attribute parts.

           Syntax
           virtual void startElementNS(
              oratext* qname,
              oratext* local,
              oratext* ns_URI,
              NodeListRef< Node>* attrs_ptr) = 0;


           Parameter             Description
                                 element's qualified name
           qname

                                 element's namespace local name
           local

                                 element's namespace URI
           ns_URI


           attrs_ref             NodeList of element's attributes



unparsedEntityDecl()
           Marks an unparsed entity declaration in the DTD. The unparsed entity's name, public
           ID, system ID, and notation name will all be in the data encoding.

           Syntax
           virtual void unparsedEntityDecl(
              oratext* name,
              oratext* public_id,
              oratext* system_id,
              oratext* notation_name) = 0;
           };




                                                                                            5-15
                                                                                                Chapter 5
                                                                                     SAXParser Interface




           Parameter              Description
                                  entity's name
           name

                                  entity's public Id
           public_id

                                  entity's system Id
           sysem_id

                                  entity's notation name
           notation_name



whitespace()
           This event marks ignorable whitespace data such as newlines, and indentation
           between lines.

           Syntax
           virtual void whitespace(
              oratext* data,
              ub4 size) = 0;


           Parameter              Description
                                  pointer to data
           data

                                  length of data
           size



SAXParser Interface
           Table 5-6 summarizes the methods available through the SAXParser interface.

           Table 5-6      Summary of SAXParser Methods; Parser Package

           Function                           Summary
           getContext()                       Returns parser's XML context (allocation and encodings).
           getParserId()                      Returns parser Id.
           parse()                            Parse the document.
           parseDTD()                         Parse the DTD.
           setSAXHandler()                    Set SAX handler.


getContext()
           Each parser object is allocated and executed in a particular Oracle XML context. This
           member function returns a pointer to this context.




                                                                                                  5-16
                                                                            Chapter 5
                                                                  SAXParser Interface




             Syntax
             virtual Context* getContext() const = 0;

             Returns
             (Context*) pointer to parser's context


getParserId()
             Returns the parser id.

             Syntax
             virtual SAXParserIdType getParserId() const = 0;

             Returns
             (SAXParserIdType) Parser Id


parse()
             Parses a document.

             Syntax
             virtual void parse(
                InputSource* src_ptr,
                boolean DTDvalidate = FALSE,
                SAXHandlerRoot* hdlr_ptr = NULL)
             throw (ParserException) = 0;


             Parameter                Description
                                      input source
             src_ptr


             DTDValidate              TRUE if validate with DTD

                                      SAX handler pointer
             hdlr_ptr



parseDTD()
             Parses a DTD.

             Syntax
             virtual void parseDTD(
                InputSource* src_ptr,
                SAXHandlerRoot* hdlr_ptr = NULL)
             throw (ParserException) = 0;




                                                                               5-17
                                                                                              Chapter 5
                                                                              SchemaValidator Interface




           Parameter              Description
                                  input source
           src_ptr

                                  SAX handler pointer
           hdlr_ptr



setSAXHandler()
          Sets SAX handler for all parser invocations except when another SAX handler is
          specified in the parser call.

          Syntax
          virtual void setSAXHandler(
             SAXHandlerRoot* hdlr_ptr) = 0;


           Parameter              Description
                                  SAX handler pointer
           hdlr_ptr



SchemaValidator Interface
          Table 5-7 summarizes the methods available through the SchemaValidator interface.

          Table 5-7     Summary of SchemaValidator Methods; Parser Package

           Function                          Summary
           getSchemaList()                   Return the Schema list.
           getValidatorId()                  Get validator identifier.
           loadSchema()                      Load a schema document.
           unloadSchema()                    Unload a schema document.


getSchemaList()
          Return only the size of loaded schema list documents if "list" is NULL. If "list" is not
          NULL, a list of URL pointers is returned in the user-provided pointer buffer. Note that its
          user's responsibility to provide a buffer with big enough size.

          Syntax
          virtual ub4 getSchemaList(
             oratext **list) const = 0;


           Parameter              Description
                                  address of a pointer buffer
           list




                                                                                                 5-18
                                                                                               Chapter 5
                                                                               SchemaValidator Interface




            Returns
            (ub4) list size and list of loaded schemas (I/O parameter)


getValidatorId()
            Get the validator identifier corresponding to the implementation of this validator object.

            Syntax
            virtual SchValidatorIdType getValidatorId() const = 0;

            Returns
            (SchValidatorIdType) validator identifier


loadSchema()
            Load up a schema document to be used in the next validation session. Throws an
            exception in the case of an error.

            Syntax
            virtual void loadSchema(
               oratext* schema_URI)
            throw (ParserException) = 0;


            Parameter              Description
                                   URL of a schema document; compiler encoding
            schema_URI



unloadSchema()
            Unload a schema document and all its descendants (included or imported in a nested
            manner from the validator. All previously loaded schema documents will remain loaded
            until they are unloaded. To unload all loaded schema documents, set schema_URI to
            be NULL. Throws an exception in the case of an error.

            Syntax
            virtual void unloadSchema(
               oratext* schema_URI)
            throw (ParserException) = 0;


            Parameter              Description
                                   URL of a schema document; compiler encoding
            schema_URI




                                                                                                  5-19
6
Package SOAP APIs for C++
         According to the W3C definition, “SOAP is a lightweight protocol for exchange of
         information in a decentralized, distributed environment. It is an XML based protocol
         that consists of three parts: an envelope that defines a framework for describing what
         is in a message and how to process it, a set of encoding rules for expressing instances
         of application-defined datatypes, and a convention for representing remote procedure
         calls and responses."
         The structure of a SOAP message follows:
         [SOAP message (XML document)
            [SOAP envelope
               [SOAP header?
                     element*
               ]
               [SOAP body
                    (element* | Fault)?
               ]
            ]
         ]

         The Oracle C++ implementation of the SOAP interface includes SOAP datatypes,
         SoapException methods, ConnectRef methods, and MsgFactory methods.



                See Also:
                Oracle XML Developer's Kit Programmer's Guide




SOAP Datatypes
         Table 6-1 summarizes the datatypes of the SOAP package.

         Table 6-1      Summary of Datatypes; SOAP Package

          Datatype                          Description
          SoapExceptionCode                 Defines Soap-related exception codes.
          SoapBinding                       Defines binding for SOAP connections.
          SoapRole                          Defines roles for SOAP nodes.


SoapExceptionCode
         Defines Soap-related exception codes.




                                                                                            6-1
                                                                                             Chapter 6
                                                                               SoapException Interface


            typedef enum SoapExceptionCode {
               SOAP_UNDEFINED_ERR       = 0,
               SOAP_OTHER_ERR           = 1} SoapExceptionCode;


SoapBinding
            Defines binding for SOAP connections. HTTP is currently the only choice.
            typedef enum SoapBinding {
               BIND_NONE = 0, /* none */
               BIND_HTTP = 1 /* HTTP */ } SoapBinding;


SoapRole
            Defines roles for SOAP nodes.
            typedef enum SoapRole {
               ROLE_UNSET = 0, /* not specified */
               ROLE_NONE = 1, /* "none" */
               ROLE_NEXT = 2, /* "next" */
               ROLE_ULT = 3 /* "ultimateReceiver" */ } SoapRole;


SoapException Interface
            Table 6-2 summarizes the methods available through the SoapException Interface.

            Table 6-2   Summary of SoapException Interfaces

            Datatype                           Description
            getCode()                          Get Oracle XML error code embedded in the exception
            getMessage()                       Get Oracle XML error message.
            getMesLang()                       Get current language encoding of error messages.
            getSoapCode()                      Get Soap exception code embedded in the exception.


getCode()
            Get Oracle XML error code embedded in the exception. This is a virtual member
            function inherited from XMLException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMessage()
            Get Oracle XML error message. Virtual member function inherited from XMLException.




                                                                                                  6-2
                                                                                           Chapter 6
                                                                                ConnectRef Interface




          Syntax
          virtual oratext* getMessage() const = 0;

          Returns
          (oratext *) Error message


getMesLang()
          Get current language encoding of error messages. Virtual member function inherited
          from XMLException.

          Syntax
          virtual oratext* getMesLang() const = 0;

          Returns
          (oratext*) Current language (encoding) of error messages


getSoapCode()
          Get SOAP exception code embedded in the exception. This is a virtual member
          function that defines a prototype for implementing defined member functions that
          return SOAP API exception codes.

          Syntax
          virtual SoapExceptionCode getSoapCode() const = 0;

          Returns
          (SoapExceptionCode) exception code


ConnectRef Interface
          Table 6-3 summarizes the methods available ConnectRef Interface.

          Table 6-3   Summary of ConnectRef Interfaces

          Datatype                    Description
          ~ConnectRef()               Destroys a SOAP connection object
          call()                      Send a SOAP message then waits for a response.


~ConnectRef()
          Destructor. Destroys a SOAP connection object and frees any resources associated
          with it.

          Syntax
          ~ConnectRef() throw (SoapException);




                                                                                               6-3
                                                                                                  Chapter 6
                                                                                      MsgFactory Interface




call()
         Send a SOAP message then waits for a response.

         Syntax
         DocumentRef< Node>* call(
            DocumentRef< Node>& msg) throw (SoapException);


          Parameter              Description
                                 The SOAP message that is sent.
          msg


         Returns
         (DocumentRef) returned message


MsgFactory Interface
         Table 6-4 summarizes the methods available through the MsgFactory Interface.

         Table 6-4      Summary of MsgFactory Interfaces

          Datatype                         Description
          ~MsgFactory()                    Destroys the SOAP message factory instance.
          MsgFactory()                     Creates and returns a SOAP Message Factory instance.
          addBodyElement()                 Adds an element to a SOAP message body.
          addFaultReason()                 Add s an additional Reason to Fault
          addHeaderElement()               Adds an element to SOAP header.
          createConnection()               Creates a SOAP connection.
          createMessage()                  Creates and returns an empty SOAP message.
          destroyMessage()                 Destroyw a SOAP message.
          getBody()                        Returns a SOAP message's envelope body..
          getBodyElement()                 Gets an element from a SOAP body.
          getEnvelope()                    Returns a SOAP part's envelope.
          getFault()                       Returns Fault code, reason, and details.
          getHeader()                      Returns a SOAP message's envelope header..
          getHeaderElement()               Gets an element from a SOAP header.
          getMustUnderstand()              Gets mustUnderstand attribute from the SOAP header
                                           element.
          getReasonNum()                   Gets the number of reasons in Fault element.
          getReasonLang()                  Gets a language of a reason with a particular index.
          getRole()                        Gets role from SOAP header element.
          hasFault()                       Determines if a SOAP message contains a Fault object.
          setFault()                       Sets Fault in a SOAP message.




                                                                                                      6-4
                                                                                              Chapter 6
                                                                                   MsgFactory Interface




          Table 6-4    (Cont.) Summary of MsgFactory Interfaces

           Datatype                       Description
           setMustUnderstand()            Sets mustUnderstand attribute for the SOAP header
                                          element.
           setRole()                      Sets the role for SOAP header element.


~MsgFactory()
          Destructor. Destroys the SOAP message factory. All allocated memory is frieed and all
          connections are closed.

          Syntax
          ~MsgFactory() throw (SoapException);


MsgFactory()
          Creates and returns a SOAP Message Factory instance.

          Syntax
          MsgFactory(
             Context* ctx_ptr) throw (SoapException);


           Parameter             Description

           ctx_ptr               TContext object


          Returns
          (MsgFactory) object


addBodyElement()
          Adds an element to a SOAP message body.

          Syntax
          Node* addBodyElement( DocumentRef< Node>& msg,
             oratext *qname,
             oratext *uri) throw (SoapException);


           Parameter             Description
                                 SOAP message
           msg

                                 QName of element to add
           qname

                                 Namespace URI of element to add
           uri




                                                                                                  6-5
                                                                                          Chapter 6
                                                                               MsgFactory Interface




           Returns
           (Node*) pointer to the created element


addFaultReason()
           Adds an additional Reason to Fault. The same re son text may be provided in different
           languages. When the fault is created, the primary language and reasonare added at
           that time; use this function to add additional translations of the reason.

           Syntax
           void addFaultReason(
              DocumentRef< Node>& msg,
              oratext *reason,
              oratext *lang) throw (SoapException);


           Parameter             Description
                                 SOAP message
           msg

                                 Human-readable fault reason
           reason

                                 Language of reason
           lang



addHeaderElement()
           Adds an element to SOAP header.

           Syntax
           Node* addHeaderElement(
              DocumentRef< Node>& msg,
              oratext *qname, oratext *uri) throw (SoapException);


           Parameter             Description
                                 SOAP message
           msg

                                 QName of element to add
           qname

                                 Namespace URI of element to add
           uri


           Returns
           (Node*) pointer to the created element


createConnection()
           Creates a SOAP connection object. The connection reference object should explicitly
           deleted by the user.



                                                                                              6-6
                                                                                            Chapter 6
                                                                                 MsgFactory Interface




          Syntax
          ConnectRef< Node>* createConnection(
             SoapBinding bind,
             void *endp,
             oratext *buf,
             ubig_ora bufsiz,
             oratext *msgbuf,
             ubig_ora msgbufsiz) throw (SoapException);


          Parameter             Description
                                connection binding
          bind

                                connection endpoint
          endp


          buf                   data buffer (or NULL to have one allocated)


                                size of data buffer (or 0 for default size)
          bufsiz


          msgbuf                message buffer (or NULL to have one allocated)


                                size of message buffer (or 0 for default size)
          msgfubsiz


          Returns
          (ConnectRef) connect object


createMessage()
          Creates and returns an empty SOAP message. The reference object should be
          explicitly deleted by the user when no longer needed.

          Syntax
          DocumentRef< Node>* CreateMessage() throw (SoapException);

          Returns
          (DocumentRef*) SOAP message, or an exception


destroyMessage()
          Destroys a SOAP message.

          Syntax
          void destroyMessage(
             DocumentRef< Node>& msg) throw (SoapException);




                                                                                                6-7
                                                                                            Chapter 6
                                                                                 MsgFactory Interface




            Parameter             Description
                                  The SOAP message.
            msg



getBody()
            Returns a SOAP message's envelope body as a pointer to the body's element node.

            Syntax
            Node* getBody(
               DocumentRef<Node>& msg) throw (SoapException);


            Parameter             Description
                                  SOAP message
            msg


            Returns
            (Node*) pointer to the SOAP message's envelope body


getBodyElement()
            Gets an element from a SOAP body as a pointer to its element node.

            Syntax
            Node* getBodyElement(
               DocumentRef< Node>& msg,
               oratext *uri,
               oratext *local) throw (SoapException);


            Parameter             Description
                                  SOAP message
            msg

                                  Namespace URI of element to add
            uri

                                  Local name of element to get
            local


            Returns
            (Node*) pointer to the named element


getEnvelope()
            Returns a SOAP part's envelope as a pointer to envelope element node.




                                                                                                6-8
                                                                                                   Chapter 6
                                                                                        MsgFactory Interface




             Syntax
             Node* getEnvelope(
                DocumentRef<Node>& msg) throw (SoapException);


              Parameter               Description
                                      SOAP message
              msg


             Returns
             (Node*) pointer to the SOAP message's envelope


getFault()
             Returns Fault code, reason, and details through user variables. NULL may be supplied
             for any part that is not needed. For lang, if the pointed-to variable is NULL, it will be set
             to the default language, that of the first reason.

             Syntax
             Node* getFault(
                DocumentRef< Node>& msg,
                oratext **code,
                oratext **reason,
                oratext **lang,
                oratext **node,
                oratext **role) throw (SoapException);


              Parameter     Description
                            SOAP message
              msg

                            Fault code
              code

                            Human-readable fault reason
              reason


              lang          Desired reason language or NULL (default language, same as for the first
                            reason)
                            Fault node
              node

                            Role: next, none, or ulitmate receiver (not used in 1.1)
              role


             Returns
             (Node) pointer to the detail


getHeader()
             Returns a SOAP message's envelope header as a pointer to the header element
             node.



                                                                                                       6-9
                                                                                       Chapter 6
                                                                            MsgFactory Interface




          Syntax
          Node* getHeader(
             DocumentRef< Node>& msg) throw (SoapException);


           Parameter             Description
                                 SOAP message
           msg


          Returns
          (Node*) pointer to the SOAP message's envelope header


getHeaderElement()
          Gets an element from a SOAP header as a pointer to its element node.

          Syntax
          Node* getHeaderElement(
             DocumentRef< Node>& msg,
             oratext *uri,
             oratext *local) throw (SoapException);


           Parameter    Description
                        SOAP message
           msg

                        Namespace URI of element to get
           uri

                        Local name of element to get
           local


          Returns
          (Node*) pointer to the named element


getMustUnderstand()
          Gets mustUnderstand attribute from SOAP header element.

          Syntax
          boolean getMustUnderstand(
             ElementRef< Node>& elem) throw (SoapException);


           Parameter             Description
                                 SOAP header element
           elem




                                                                                          6-10
                                                                                            Chapter 6
                                                                               MsgFactory Interface




            Returns
            (boolean) value of the mustUnderstand attribute


getReasonNum()
            Determines the number of reasons in the Fault element. Returns 0 if no Fault.

            Syntax
            ub4 getReasonNum(
               DocumentRef< Node>& msg) throw (SoapException);


            Parameter               Description
                                    SOAP message
            msg


            Returns
            (up4) number of reasons in Fault element


getReasonLang()
            Returns the language of a reason with a particular index.

            Syntax
            oratext* getReasonLang(
               DocumentRef< Node>& msg,
               ub4 idx) throw (SoapException);


            Parameter               Description
                                    SOAP message
            msg

                                    index of a fault reason
            idx


            Returns
            (oratext *) value of property or NULL.


getRole()
            Gets role from SOAP header element.

            Syntax
            SoapRole getRole(
               ElementRef< Node>& elem) throw (SoapException);




                                                                                              6-11
                                                                                  Chapter 6
                                                                       MsgFactory Interface




             Parameter               Description
                                     Reference to the header element
             elem


             Returns
             (SoapRole) header element's role


hasFault()
             Determines if a SOAP message contains a Fault object.

             Syntax
             boolean hasFault(
                DocumentRef< Node>& msg) throw (SoapException);


             Parameter               Description
                                     SOAP message
             msg


             Returns
             (boolean) TRUE if there's a Fault, FALSE if not


setFault()
             Sets Fault in a SOAP message.

             Syntax
             void setFault(
                DocumentRef< Node>& msg,
                oratext *node,
                oratext *code,
                oratext *reason,
                oratext *lang,
                oratext *role,
               ElementRef< Node>& detail) throw (SoapException);


             Parameter               Description
                                     SOAP message
             msg

                                     URI of SOAP node which faulted
             node

                                     Fault code
             code

                                     Human-readable fault reason
             reason




                                                                                     6-12
                                                                                               Chapter 6
                                                                                    MsgFactory Interface




            Parameter             Description
                                  Language
            lang

                                  URI representing role, Role (1.2), unused (1.1)
            role

                                  User-defined elements
            detail



setMustUnderstand()
            Sets mustUnderstand attribute for the SOAP header element.

            Syntax
            void setMustUnderstand(
               ElementRef< Node>& elem,
               boolean mustUnderstand) throw (SoapException);


            Parameter             Description
                                  SOAP header element
            elem


            mustUnderstand        mustUnderstand value (TRUE or FALSE)



setRole()
            Sets the role for SOAP header element.

            Syntax
            void setRole(
               ElementRef< Node>& elem,
               SoapRole role) throw (SoapException);


            Parameter             Description
                                  reference to the header element
            elem

                                  role value
            role




                                                                                                  6-13
7
Package Tools APIs for C++
          The Tools package contains types and methods for creating and instantiating Oracle
          XML tools. It describes Tools datatypes, Factory methods, and FactoryException
          methods.


Tools Datatypes
          Table 7-1 summarizes the datatypes of the Tools package.

          Table 7-1    Summary of Datatypes; Tools Package

          Datatype                          Description
          FactoryExceptionCode              Tool Factory exceptions.


FactoryExceptionCode
          Tool Factory exceptions.

          Definition
          typedef enum FactoryExceptionCode {
             FACTORY_UNDEFINED_ERR = 0,
             FACTORY_OTHER_ERR = 1
          } FactoryExceptionCode;


Factory Interface
          Table 7-2 summarizes the methods available through the Factory interface.

          Table 7-2    Summary of Factory Methods; Tools Package

          Function                                     Summary
          Factory()                                    Constructor.
          createDOMParser()                            Create DOM Parser.
          createSAXParser()                            Create SAX Parser.
          createSchemaValidator()                      Create schema validator.
          createXPathCompProcessor()                   Create extended XPath processor.
          createXPathCompiler()                        Create XPath compiler.
          createXPathProcessor()                       Create XPath processor.
          createXPointerProcessor()                    Create XPointer processor.
          createXslCompiler()                          Create Xsl compiler.
          createXslExtendedTransformer()               Create XSL extended transformer.




                                                                                          7-1
                                                                                                     Chapter 7
                                                                                             Factory Interface




            Table 7-2      (Cont.) Summary of Factory Methods; Tools Package

            Function                                           Summary
            createXslTransformer()                             Create XSL transformer.
            getContext()                                       Get factory's context.
            ~Factory()                                         Default destructor.


Factory()
            Class constructor.


            Syntax                                       Description
                                                         Default constructor
            Factory()
            throw (FactoryException);

                                                         Creates factory object given a Context object.
            Factory(
               Context* ctx_ptr)
            throw (FactoryException);



            Parameter                Description
                                     pointer to a context object
            ctx_ptr


            Returns
            (Factory) object


createDOMParser()
            Creates DOM parser.

            Syntax
            DOMParser< Context, Node>* createDOMParser (
               DOMParserIdType id_type,
               Context* ctx_ptr = NULL)
            throw (FactoryException);


            Parameter                Description
                                     parser id type
            id_type

                                     pointer to a Context object
            ctx_ptr


            Returns
            (DOMParser*) pointer to the parser object




                                                                                                          7-2
                                                                                  Chapter 7
                                                                          Factory Interface




createSAXParser()
          Creates SAX parser.

          Syntax
          SAXParser< Context>* createSAXParser (
             SAXParserIdType id_type,
             Context* ctx_ptr = NULL)
          throw (FactoryException);


           Parameter            Description
                                parser id type
           id_type

                                pointer to a Context object
           ctx_ptr


          Returns
          (SAXParser*) pointer to the parser object


createSchemaValidator()
          Creates schema validator.

          Syntax
          SchemaValidator< Node>* createSchemaValidator (
             SchValidatorIdType id_type,
             Context* ctx_ptr = NULL)
          throw (FactoryException);


           Parameter            Description
                                validator id type
           id_type

                                pointer to a Context object
           ctx_ptr


          Returns
          (SchemaValidator*) pointer to the validator object


createXPathCompProcessor()
          Creates extended XPath processor; takes XvmPrCXml value only.

          Syntax
          CompProcessor< Context, Node>* createXPathCompProcessor (
             XPathPrIdType id_type,
             Context* ctx_ptr = NULL)
          throw (FactoryException);




                                                                                      7-3
                                                                             Chapter 7
                                                                     Factory Interface




           Parameter            Description
                                processor id type
           id_type

                                pointer to a Context object
           ctx_ptr


          Returns
          (CompProcessor*) pointer to the processor object


createXPathCompiler()
          Creates XPath compiler.

          Syntax
          XPath::Compiler< Context, Node>* createXPathCompiler (
             XPathCompIdType id_type,
             Context* ctx_ptr = NULL)
          throw (FactoryException);


           Parameter            Description
                                compiler id type
           id_type

                                pointer to a Context object
           ctx_ptr


          Returns
          (XPathCompiler*) pointer to the compiler object


createXPathProcessor()
          Creates XPath processor.

          Syntax
          XPath::Processor< Context, Node>* createXPathProcessor (
             XPathPrIdType id_type,
             Context* ctx_ptr = NULL)
          throw (FactoryException);


           Parameter            Description
                                processor id type
           id_type

                                pointer to a Context object
           ctx_ptr


          Returns
          (Processor*) pointer to the processor object



                                                                                 7-4
                                                                                     Chapter 7
                                                                             Factory Interface




createXPointerProcessor()
           Creates XPointer processor.

           Syntax
           XPointer::Processor< Context, Node>* createXPointerProcessor (
              XppPrIdType id_type,
              Context* ctx_ptr = NULL)
           throw (FactoryException);


           Parameter               Description
                                   processor id type
           id_type

                                   pointer to a Context object
           ctx_ptr


           Returns
           (Processor*) pointer to the processor object


createXslCompiler()
           Creates Xsl compiler.

           Syntax
           Xsl::Compiler< Context, Node>* createXslCompiler (
              XslCompIdType id_type,
              Context* ctx_ptr = NULL)
           throw (FactoryException);


           Parameter               Description
                                   compiler id type
           id_type

                                   pointer to a Context object
           ctx_ptr


           Returns
           (Compiler*) pointer to the compiler object


createXslExtendedTransformer()
           Creates XSL extended trnasformer; takes XvmTrCXml value only.

           Syntax
           CompTransformer< Context, Node>* createXslExtendedTransformer (
              XslTrIdType id_type,
              Context* ctx_ptr = NULL)
           throw (FactoryException);




                                                                                         7-5
                                                                           Chapter 7
                                                                   Factory Interface




             Parameter              Description
                                    transformer id type
             id_type

                                    pointer to a Context object
             ctx_ptr


             Returns
             (CompTrasformer*) pointer to the transformer object


createXslTransformer()
             Creates XSL trnasformer.

             Syntax
             Transformer< Context, Node>* createXslTransformer (
                XslTrIdType id_type,
                Context* ctx_ptr = NULL)
             throw (FactoryException);


             Parameter              Description
                                    transformer id type
             id_type

                                    pointer to a Context object
             ctx_ptr


             Returns
             (Trasformer*) pointer to the transformer object


getContext()
             Returns factory's context.

             Syntax
             Context* getContext() const;

             Returns
             (Context*) pointer to the context object


~Factory()
             Default destructor.

             Syntax
             ~Factory();




                                                                               7-6
                                                                                              Chapter 7
                                                                             FactoryException Interface




FactoryException Interface
            Table 7-3 summarizes the methods available through the FactoryException interface.

            Table 7-3   Summary of FactoryException Methods; Tools Package

            Function                        Summary
            getCode()                       Get Oracle XML error code embedded in the exception.
            getFactoryCode()                Get FactoryException code embedded in the exception.
            getMesLang()                    Get current language (encoding) of error messages.
            getMessage()                    Get Oracle XML error message.


getCode()
            Gets Oracle XML error code embedded in the exception. Virtual member function
            inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getFactoryCode()
            This is a virtual member function that defines a prototype for implementation defined
            member functions returning exception codes specific to the Tools namespace, defined
            in FactoryExceptionCode, of the exceptional situations during execution

            Syntax
            virtual FactoryExceptionCode getFactoryCode() const = 0;

            Returns
            (FactoryExceptionCode) exception code


getMesLang()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages




                                                                                                   7-7
                                                                                  Chapter 7
                                                                 FactoryException Interface




getMessage()
          Virtual member function inherited from XmlException.

          Syntax
          virtual oratext* getMessage() const = 0;

          Returns
          (oratext *) Error message




                                                                                      7-8
8
Package XPath APIs for C++
         The XPath package for C++ contains types and interfaces related to XPath processing,
         such as XPath datatypes, CompProcessor methods,Compiler methods, NodeSet
         methods, Processor methods, XPathException methods, and XPathObject methods.



                See Also:
                Oracle XML Developer's Kit Programmer's Guide




XPath Datatypes
         Table 8-1 summarizes the datatypes of the XPath package.

         Table 8-1    Summary of Datatypes; XPath Package

          Datatype                        Description
          XPathCompIdType                 Defines XPath compiler identifiers.
          XPathObjType                    Defines object types for XPath 1.0 based implementations.
          XPathExceptionCode              XPath related exception codes.
          XPathPrIdType                   Defines XPath processor identifiers.


XPathCompIdType
         Defines XPath compiler identifiers.

         Definition
         typedef enum XPathCompIdType {
            XvmXPathCompCXml = 1
         } XPathCompIdType;


XPathObjType
         Defines object types for XPath 1.0 based implementations.

         Definition
         typedef enum XPathObjType {
            XPOBJ_TYPE_UNKNOWN = 0,
            XPOBJ_TYPE_NDSET = 1,
            XPOBJ_TYPE_BOOL    = 2,
            XPOBJ_TYPE_NUM     = 3,
            XPOBJ_TYPE_STR     = 4




                                                                                                8-1
                                                                                               Chapter 8
                                                                                CompProcessor Interface


            } XPathObjType;



XPathExceptionCode
            XPath related exception codes.

            Definition
            typedef enum XPathExceptionCode {
               XPATH_UNDEFINED_ERR = 0,
               XPATH_OTHER_ERR = 1
            } XPathExceptionCode;


XPathPrIdType
            Defines XPath processor identifiers.

            Definition
            typedef enum XPathPrIdType {        XPathPrCXml           = 1,   XvmPrCXml             =
            2    } XPathPrIdType;


CompProcessor Interface
            Table 8-2 summarizes the methods available through the CompProcessor interface.

            Table 8-2    Summary of CompProcessor Methods; XPath Package

            Function                            Summary
            getProcessorId()                    Get processor's Id.
            process()                           Evaluate XPath expression against given document.
            processWithBinXPath()               Evaluate compiled XPath expression against given
                                                document.


getProcessorId()
            Get processor Id.

            Syntax
            virtual XPathPrIdType getProcessorId() const = 0;

            Returns
            (XPathPrIdType) Processor's Id


process()
            Inherited from Processor.




                                                                                                       8-2
                                                                                            Chapter 8
                                                                                   Compiler Interface




          Syntax
          virtual XPathObject< Node>* process (
             InputSource* isrc_ptr,
             oratext* xpath_exp)
          throw (XPathException) = 0;



           Parameter            Description
                                instance document to process
           isrc_ptr

                                XPATH expression
           xpath_exp


          Returns
          (XPathGenObject*) XPath object


processWithBinXPath()
          Evaluates compiled XPath expression against given document.

          Syntax
          virtual XPathObject< Node>* processWithBinXPath (
             InputSource* isrc_ptr,
             ub2* bin_xpath)
          throw (XPathException) = 0;


           Parameter            Description
                                instance document to process
           isrc_ptr

                                compiled XPATH expression
           bin_xpath


          Returns
          (XPathGenObject*) XPath object


Compiler Interface
          Table 8-3 summarizes the methods available through the Compiler interface.

          Table 8-3    Summary of Compiler Methods; XPath Package

           Function                       Summary
           compile()                      Compile XPath and return its compiled binary
                                          representation.
           getCompilerId()                Get the compiler's Id




                                                                                                8-3
                                                                                         Chapter 8
                                                                                 NodeSet Interface




compile()
            Compiles XPath and returns its compiled binary representation.

            Syntax
            virtual ub2* compile (
               oratext* xpath_exp)
            throw (XPathException) = 0;


            Parameter             Description
                                  XPATH expression
            xpath_exp


            Returns
            (ub2) XPath expression in compiled binary representation


getCompilerId()
            Get compiler's id.

            Syntax
            virtual XPathCompIdType getCompilerId() const = 0;

            Returns
            (XPathCompIdType) Compiler's Id


NodeSet Interface
            Table 8-4 summarizes the methods available through the NodeSet interface.

            Table 8-4   Summary of NodeSet Methods; XPath Package

            Function                           Summary
            getNode()                          Get node given its index.
            getSize()                          Get NodeSet size.


getNode()
            Returns a reference to the node.

            Syntax
            NodeRef< Node>* getNode(
               ub4 idx) const;




                                                                                             8-4
                                                                                               Chapter 8
                                                                                     Processor Interface




            Parameter              Description
                                   index of the node in the set
            idx


            Returns
            (NodeRef) reference to the node


getSize()
            The size of the node set.

            Syntax
            ub4 getSize() const;

            Returns
            (ub4) node set size


Processor Interface
            Table 8-5 summarizes the methods available through the Processor interface.

            Table 8-5   Summary of Processor Methods; XPath Package

            Function                          Summary
            getProcessorId()                  Get processor's Id.
            process()                         Evaluate XPath expression against given document.


getProcessorId()
            Get processor Id.

            Syntax
            virtual XPathPrIdType getProcessorId() const = 0;

            Returns
            (XPathPrIdType) Processor's Id


process()
            Evaluates XPath expression against given document and returns result XPath object.

            Syntax
            virtual XPathObject< Node>* process (
               InputSource* isrc_ptr,
               oratext* xpath_exp)
            throw (XPathException) = 0;




                                                                                                   8-5
                                                                                             Chapter 8
                                                                              XPathException Interface




            Parameter             Description
                                  instance document to process
            isrc_ptr

                                  XPath expression
            xpath_exp


            Returns
            (XPathGenObject*) XPath object


XPathException Interface
            Table 8-6 summarizes the methods available through the XPathException interface.

            Table 8-6   Summary of XPathException Methods; XPath Package

            Function                        Summary
            getCode()                       Get Oracle XML error code embedded in the exception.
            getMesLang()                    Get current language (encoding) of error messages.
            getMessage()                    Get Oracle XML error message.
            getXPathCode()                  Get XPath exception code embedded in the exception.


getCode()
            Virtual member function inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages


getMessage()
            Virtual member function inherited from XmlException.




                                                                                                   8-6
                                                                                         Chapter 8
                                                                             XPathObject Interface




          Syntax
          virtual oratext* getMessage() const = 0;

          Returns
          (oratext *) Error message


getXPathCode()
          This is a virtual member function that defines a prototype for implementation defined
          member functions returning XPath processor and compiler exception codes, defined in
          XPathExceptionCode, of the exceptional situations during execution.

          Syntax
          virtual XPathExceptionCode getXPathCode() const = 0;

          Returns
          (XPathExceptionCode) exception code


XPathObject Interface
          Table 8-7 summarizes the methods available through the XPathObject interface.

          Table 8-7    Summary of XPathObject Methods; XPath Package

           Function                        Summary
           XPathObject()                   Copy constructor.
           getNodeSet()                    Get the node set.
           getObjBoolean()                 Get boolean from object.
           getObjNumber()                  Get number from object.
           getObjString()                  Get string from object.
           getObjType()                    Get type from object.


XPathObject()
          Copy constructor.

          Syntax
          XPathObject(
             XPathObject< Node>& src);


           Parameter            Description
                                reference to the object to be copied
           src




                                                                                             8-7
                                                             Chapter 8
                                                 XPathObject Interface




           Returns
           (XPathObject) new object


getNodeSet()
           Get the node set.

           Syntax
           NodeSet< Node>* getNodeSet() const;


getObjBoolean()
           Get the boolean from the object.

           Syntax
           boolean getObjBoolean() const;


getObjNumber()
           Get the number from the object.

           Syntax
           double getObjNumber() const;


getObjString()
           Get the string from the object.

           Syntax
           oratext* getObjString() const;


getObjType()
           Get the type from the object.

           Syntax
           XPathObjType getObjType() const;




                                                                 8-8
9
Package XPointer APIs for C++
         The XPointer package for C++ contains types and methods related to XPointer
         processing, such as XPointer datatypes, Processor methods, XppException methods,
         XPPLocation methods, and XppLocSet methods.


XPointer Datatypes
         Table 9-1 summarizes the datatypes of the XPointer package.

         Table 9-1     Summary of Datatypes; XPointer Package

          Datatype                              Description
          XppExceptionCode                      Defines XPath compiler identifiers.
          XppPrIdType                           Defines XPointer processor identifiers.
          XppLocType                            Defines location types for XPointer.


XppExceptionCode
         XPointer related exception codes.

         Definition
         typedef enum XPathCompIdType {
            XvmXPathCompCXml = 1
         } XPathCompIdType;


XppPrIdType
         Defines XPointer processor identifiers.

         Definition
         typedef enum XppPrIdType {    XPtrPrCXml             = 1} XppPrIdType;



XppLocType
         Defines location types for XPointer.

         Definition
         typedef enum XppLocType {
               XPPLOC_TYPE_UNKNOWN = 0,
               XPPLOC_TYPE_NODE    = 1,
               XPPLOC_TYPE_POINT = 2,
               XPPLOC_TYPE_RANGE = 3,




                                                                                          9-1
                                                                                                Chapter 9
                                                                                      Processor Interface


                  XPPLOC_TYPE_BOOL      = 4,
                  XPPLOC_TYPE_NUM       = 5,
                  XPPLOC_TYPE_STR       = 6
                } XppLocType;


Processor Interface
            Table 9-2 summarizes the methods available through the Processor interface.

            Table 9-2   Summary of Processor Methods; XPointer Package

            Function                           Summary
            getProcessorId()                   Get processor's Id.
            process()                          Evaluate XPointer expression against given document.


getProcessorId()
            Get Processor Id.

            Syntax
            virtual XppPrIdType getProcessorId() const = 0;

            Returns
            (XppPrIdType) Processor's Id


process()
            Evaluates XPointer expression against given document and returns result XPointer
            location set object.

            Syntax
            virtual XppLocSet< Node>* process (
               InputSource* isrc_ptr,
               oratext* xpp_exp)
            throw (XppException) = 0;

            Table 9-3   Description of Process Method Parameters

            Parameter                Description
                                     instance document to process
            isrc_ptr

                                     XPointer expression
            xpp_exp


            Returns
            (XppLocSet*) XPath object




                                                                                                      9-2
                                                                                               Chapter 9
                                                                                 XppException Interface




XppException Interface
            Table 9-4 summarizes the methods available through the XPPException interface.

            Table 9-4   Summary of XppException Methods; Package XPointer

            Function                      Summary
            getCode()                     Get Oracle XML error code embedded in the exception.
            getMesLang()                  Get current language (encoding) of error messages.
            getMesLang()                  Get Oracle XML error message.
            getXppCode()                  Get XPointer exception code embedded in the exception.


getCode()
            Virtual member function inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages


getMessage()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMessage() const = 0;

            Returns
            (oratext *) Error message




                                                                                                   9-3
                                                                                            Chapter 9
                                                                                XppLocation Interface




getXppCode()
             This is a virtual member function that defines a prototype for implementation defined
             member functions returning XPointer processor and compiler exception codes, defined
             in XppExceptionCode, of the exceptional situations during execution.

             Syntax
             virtual XppExceptionCode getXppCode() const = 0;

             Returns
             (XppExceptionCode) exception code


XppLocation Interface
             Table 9-5 summarizes the methods available through the XppLocation interface.

             Table 9-5    Summary of XppLocation Methods; XPointer Package

             Function                           Summary
             getLocType()                       Get the location type.
             getNode()                          Get the node.
             getRange()                         Get range.


getLocType()
             Get the location type.

             Syntax
              XppLocType getLocType() const;


getNode()
             Get the node.

             Syntax
              Node* getNode() const;


getRange()
             Get range.

             Syntax
              Range< Node>* getRange() const;




                                                                                                9-4
                                                                                          Chapter 9
                                                                               XppLocSet Interface




XppLocSet Interface
            Table 9-6 summarizes the methods available through the XppLocSet interface.

            Table 9-6   Summary of XppLocSet Methods; XPointer Package

            Function                           Summary
            getItem()                          Get item given its index.
            getSize()                          Get location set size.


getItem()
            Returns a reference to the item.

            Syntax
            XppLocation< Node>* getItem(
               ub4 index) const;

            Table 9-7   Summary of getItem Method; XPointer Package

            Parameter              Description
                                   index of an item
            index


            Returns
            (XppLocation*) reference to the item


getSize()
            The size of the node set.

            Syntax
            ub4 getSize() const;

            Returns
            (ub4) node set size




                                                                                              9-5
10
Package Xsl APIs for C++
          The Xsl package for C++ contains types and methods related to XSL transformation.
          They include Xsl datatypes, Compiler methods, CompTransformer methods,
          Transformer methods, and XSLException methods.



                 See Also:
                 Oracle XML Developer's Kit Programmer's Guide




Xsl Datatypes
          Table 10-1 summarizes the datatypes of the Xsl package.

          Table 10-1    Summary of Datatypes; Xsl Package

          Datatype                            Description
          XslCompIdType                       Defines XSL compiler identifiers.
          XslExceptionCode                    Defines XSLT related exceptions.
          XslTrIdType                         Defines XSL transformer identifiers.


XslCompIdType
          Defines XSL compiler identifiers.

          Definition
          typedef enum XslCompIdType {
             XvmCompCXml = 1
          } XslCompIdType;


XslExceptionCode
          Defines XSLT related exceptions.

          Definition
          typedef typedef enum XslExceptionCode {
             XSL_UNDEFINED_ERR = 0,
             XSL_OTHER_ERR = 1
          } XslExceptionCode;




                                                                                        10-1
                                                                                               Chapter 10
                                                                                       Compiler Interface




XslTrIdType
            Defines XSL transformer identifiers.

            Definition
            typedef enum XslTrIdType {
               XslTrCXml         = 1,
               XvmTrCXml         = 2
            } XslTrIdType;


Compiler Interface
            Table 10-2 summarizes the methods available through the Compiler interface.

            Table 10-2      Summary of Compiler Methods; Xsl Package

              Function                       Summary
              compile()                      Compile Xsl and return its compiled binary representation.
              getCompilerId()                Get compiler's Id.
              getLength()                    Get length of compiled XSL document.


compile()
            Compiles Xsl and returns its compiled binary representation.

            Syntax
            virtual ub2* compile(
               InputSource* isrc_ptr)
            throw (XslException) = 0;


              Parameter            Description
                                   Xsl document
              isrc_ptr


            Returns
            (InputSource) Xsl document in compiled binary representation


getCompilerId()
            Get the compiler Id.

            Syntax
            virtual XslCompIdType getCompilerId() const = 0;

            Returns
            (XslCompIdType) Compiler's Id




                                                                                                   10-2
                                                                                                Chapter 10
                                                                                 CompTransformer Interface




getLength()
              Returns length of compiled XSL document

              Syntax
              virtual ub4 getLength(
                 ub2* binxsl_ptr)
              throw (XslException) = 0;


              Parameter               Description
                                      compiled Xsl document
              binxsl_ptr


              Returns
              (ub4) length of the document


CompTransformer Interface
              Table 10-3 summarizes the methods available through the CompTransformer interface.

              Table 10-3    Summary of CompTransformer Methods; Xsl Package

              Function                          Summary
              getTransformerId()                Get transformer's Id.
              setBinXsl()                       Set compiled Xsl.
              setSAXHandler()                   Set SAX handler.
              setXSL()                          Set XSLT document for this transformer.
              transform()                       Transform the document.


getTransformerId()
              Get transformer's id.

              Syntax
              virtual XslTrIdType getTransformerId() const = 0;

              Returns
              (XslTrIdType) Transformer's Id


setBinXsl()
              Sets compiled Xsl.




                                                                                                    10-3
                                                                                              Chapter 10
                                                                             CompTransformer Interface




              Syntax
              virtual void setBinXsl (
                 ub2* binxsl_ptr)
              throw (XslException) = 0;


              Parameter             Description
                                    compiled Xsl document
              binxsl_ptr



setSAXHandler()
              Inherited from Transformer.

              Syntax
              virtual void setSAXHandler(
                 SAXHandlerRoot* hdlr_ptr) = 0;


              Parameter             Description
                                    SAX handler pointer
              hdlr_ptr



setXSL()
              Set XSLT document for this transformer. Should be called before the transform
              member function is called. It is inherited from Transform.

              Syntax
              virtual void setXSL (
                 InputSource* isrc_ptr)
              throw (XslException) = 0;


              Parameter             Description
                                    instance document to process
              isrc_ptr



transform()
              Transforms the document. Throws an exception if an XSLT document is not set by a
              previous call to setXSL. Inherited from Transform.


              Syntax                                 Description
                                                     Transform the document and return DOM.
              virtual NodeRef< Node>* transform(
                 nputSource* isrc_ptr)
              throw (XslException) = 0;




                                                                                                 10-4
                                                                                               Chapter 10
                                                                                    Transformer Interface




           Syntax                                    Description
                                                     Transform the document and return SAX events.
           virtual void transform(
              InputSource* isrc_ptr,
              SAXHandlerRoot* hdlr_ptr)
           throw (XslException) = 0;



           Parameter                Description
                                    instance document to process
           isrc_ptr

                                    SAX handler pointer
           hdlr_ptr


           Returns
           (DocumentRef) document tree of new document


Transformer Interface
           Table 10-4 summarizes the methods available through the Transformer interface.

           Table 10-4    Summary of Transformer Methods; Xsl Package

           Function                           Summary
           getTransformerId()                 Get transformer's Id.
           setSAXHandler()                    Set SAX handler.
           setXSL()                           Set XSLT document for this transformer.
           transform()                        Transform the document and return SAX events.


getTransformerId()
           Gets transformer's id.

           Syntax
           virtual XslTrIdType getTransformerId() const = 0;

           Returns
           (XslTrIdType) Transformer's Id


setSAXHandler()
           Set SAX handler.

           Syntax
           virtual void setSAXHandler(
              SAXHandlerRoot* hdlr_ptr) = 0;




                                                                                                   10-5
                                                                                              Chapter 10
                                                                                 XSLException Interface




              Parameter             Description
                                    SAX handler pointer
              hdlr_ptr



setXSL()
              Set XSLT document for this transformer. Should be called before the transform
              member function is called.

              Syntax
              virtual void setXSL (
                 InputSource* isrc_ptr)
              throw (XslException) = 0;


              Parameter             Description
                                    instance document to process
              isrc_ptr



transform()
              Transforms the document. Throws an exception if an XSLT document is not set by a
              previous call to setXSL.


              Syntax                                 Description
                                                     Transform the document and return DOM.
              virtual NodeRef< Node>* transform(
                 nputSource* isrc_ptr)
              throw (XslException) = 0;

                                                     Transform the document and return SAX events.
              virtual void transform(
                 InputSource* isrc_ptr,
                 SAXHandlerRoot* hdlr_ptr)
              throw (XslException) = 0;



              Parameter             Description
                                    instance document to process
              isrc_ptr

                                    SAX handler pointer
              hdlr_ptr


              Returns
              (DocumentRef) document tree of new document


XSLException Interface
              Table 10-5 summarizes the methods available through the XSLException interface.



                                                                                                 10-6
                                                                                             Chapter 10
                                                                                 XSLException Interface




            Table 10-5     Summary of XSLException Methods; Xsl Package

            Function                        Summary
            getCode()                       Get Oracle XML error code embedded in the exception.
            getMesLang()                    Get current language (encoding) of error messages.
            getMessage()                    Get Oracle XML error message.
            getXslCode()                    Defines a prototype for implementation.


getCode()
            Gets Oracle XML error code embedded in the exception. Virtual member function
            inherited from XmlException.

            Syntax
            virtual unsigned getCode() const = 0;

            Returns
            (unsigned) numeric error code (0 on success)


getMesLang()
            Virtual member function inherited from XmlException.

            Syntax
            virtual oratext* getMesLang() const = 0;

            Returns
            (oratext*) Current language (encoding) of error messages


getMessage()
            Virtual member function inherited from XmlException

            Syntax
            virtual oratext* getMessage() const = 0;

            Returns
            (oratext *) Error message


getXslCode()
            This is a virtual member function that defines a prototype for implementation defined
            member functions returning XSL transformer and compiler exception codes, defined in
            XslExceptionCode, of the exceptional situations during execution.




                                                                                                 10-7
                                                               Chapter 10
                                                   XSLException Interface




Syntax
virtual XslExceptionCode getXslCode() const = 0;

Returns
(XslExceptionCode) exception code




                                                                   10-8
Index
Symbols                                      AttrRef Interface (continued)
                                                 setValue(), 3-5
~AttrRef(), 3-6                              AttrRef(), 3-4
~CDATASectionRef(), 3-7
~CommentRef(), 3-11
~ConnectRef(), 6-3
                                             C
~DocumentFragmentRef(), 3-18                 C++ packages
~DocumentRange(), 3-19                            Ctx, 2-1
~DocumentRef(), 3-28                              Dom, 3-1
~DocumentTypeRef(), 3-32                          IO, 4-1
~DOMImplementation(), 3-17                        OracleXml, 1-1
~DOMImplRef(), 3-16                               Parser, 5-1
~ElementRef(), 3-38                               SOAP, 6-1
~EntityRef(), 3-40                                Tools, 7-1
~EntityReferenceRef(), 3-41                       XPath, 8-1
~Factory(), 7-6                                   XPointer, 9-1
~MemAllocator(), 2-2                              Xsl, 10-1
~MsgFactory(), 6-5                           call(), 6-4
~NamedNodeMapRef(), 3-45                     CDATA(), 5-10
~NodeListRef(), 3-48                         CDATASectionRef Interface
~NodeRef(), 3-58                                  ~CDATASectionRef(), 3-7
~NotationRef(), 3-60                              CDATASectionRef(), 3-6
~ProcessingInstructionRef(), 3-62                 Dom package, 3-6
~TCtx(), 2-5                                 CDATASectionRef(), 3-6
~TextRef(), 3-71                             CharacterDataRef Interface
                                                  appendData(), 3-7
A                                                 deleteData(), 3-7
                                                  Dom package, 3-7
acceptNode(), 3-45                                freeString(), 3-8
AcceptNodeCodes datatype, DOM package, 3-2        getData(), 3-8
addBodyElement(), 6-5                             getLength(), 3-8
addFaultReason(), 6-6                             insertData(), 3-9
addHeaderElement(), 6-6                           replaceData(), 3-9
adjustCtx(), 3-46, 3-71                           setData(), 3-9
alloc(), 2-2                                      substringData(), 3-10
appendChild(), 3-50                          characters(), 5-12
appendData(), 3-7                            cloneContent(), 3-63
attributeDecl(), 5-11                        cloneNode(), 3-50
AttrRef Interface                            cloneRange(), 3-63
     ~AttrRef(), 3-6                         comment(), 5-12
     AttrRef(), 3-4                          CommentRef Interface
     Dom package, 3-4                             ~CommentRef(), 3-11
     getName(), 3-4                               CommentRef(), 3-10
     getSpecified(), 3-5                          Dom package, 3-10
     getValue(), 3-5                         CommentRef(), 3-10



                                                                             Index-1
                                                                                         Index


CompareBoundaryPoints(), 3-63               Ctx Datatypes (continued)
CompareHowCode datatype, DOM package, 3-2       encodings, 2-1
compile(), 8-4, 10-2                        Ctx package for C++, 2-1
Compiler interface
    Xsl package, 10-2
Compiler Interface
                                            D
    compile(), 8-4, 10-2                    dealloc(), 2-2
    getCompilerId(), 8-4, 10-2              deleteContents(), 3-63
    getLength(), 10-3                       deleteData(), 3-7
    getTransformerId(), 10-3                destroyMessage(), 6-7
    setBinXsl(), 10-3                       destroyRange(), 3-19
    setSAXHandler(), 10-4                   detach(), 3-46, 3-64
    setXSL(), 10-4                          DocumentFragmentRef Interface
    transform(), 10-4                           ~DocumentFragmentRef(), 3-18
    XPath package, 8-3                          DocumentFragmentRef(), 3-17
CompProcessor Interface                         Dom package, 3-17
    getProcessorId(), 8-2                   DocumentFragmentRef(), 3-17
    process(), 8-2                          DocumentRange Interface
    processWithBinXPath(), 8-3                  ~DocumentRange(), 3-19
    XPath package, 8-2                          createRange(), 3-18
CompTransformer Interface                       destroyRange(), 3-19
    Xsl package, 10-3                           DocumentRange(), 3-18
ConnectRef Interface                            Dom package, 3-18
    ~ConnectRef(), 6-3                      DocumentRange(), 3-18
    call(), 6-4                             DocumentRef Interface
    SOAP package, 6-3                           ~DocumentRef(), 3-28
createAttribute(), 3-20                         createAttribute(), 3-20
createAttributeNS(), 3-21                       createAttributeNS(), 3-21
createCDATASection(), 3-21                      createCDATASection(), 3-21
createComment(), 3-22                           createComment(), 3-22
createConnection(), 6-6                         createDocumentFragment(), 3-22
createDocument(), 3-13                          createElement(), 3-22
createDocumentFragment(), 3-22                  createElementNS(), 3-23
createDocumentType(), 3-14                      createEntityReference(), 3-23
createDOMParser(), 7-2                          createProcessingInstruction(), 3-24
createElement(), 3-22                           createTextNode(), 3-24
createElementNS(), 3-23                         DocumentRef(), 3-20
createEntityReference(), 3-23                   Dom package, 3-19
createMessage(), 6-7                            getDoctype(), 3-25
createNodeIterator(), 3-28                      getDocumentElement(), 3-25
createProcessingInstruction(), 3-24             getElementById(), 3-25
createRange(), 3-18                             getElementsByTagNameNS(), 3-26
createSAXParser(), 7-3                          getImplementation(), 3-27
createSchemaValidator(), 7-3                    importNode(), 3-27
createTextNode(), 3-24                      DocumentRef(), 3-20
createTreeWalker(), 3-29                    DocumentTraversal Interface
createXPathCompiler(), 7-4                      ~DocumentTraversal(), 3-30
createXPathCompProcessor(), 7-3                 createNodeIterator(), 3-28
createXPathProcessor(), 7-4                     createTreeWalker(), 3-29
createXPointerProcessor(), 7-5                  destroyNodeIterator(), 3-29
createXslCompiler(), 7-5                        destroyTreeWalker(), 3-30
createXslExtendedTransformer(), 7-5             DocumentTraversal(), 3-28
createXslTransformer(), 7-6                     Dom package, 3-28
Ctx Datatypes, 2-1                          DocumentTraversal(), 3-28
    encoding, 2-1



                                                                                      Index-2
                                                                                      Index


DocumentTypeRef Interface                 DOMParser Interface
   ~DocumentTypeRef(), 3-32                 Parser package, 5-2
   DocumentTypeRef(), 3-30                DOMParserIdType datatype, Parser package,
   Dom package, 3-30                           5-1
   getEntities(), 3-31
   getInternalSubset(), 3-31
   getName(), 3-32
                                          E
   getNotations(), 3-32                   elementDecl(), 5-12
   getPublicId(), 3-32                    ElementRef Interface
   getSystemId(), 3-32                        ~ElementRef(), 3-38
DocumentTypeRef(), 3-30                       Dom package, 3-33
Dom Datatypes                                 ElementRef(), 3-33
   AcceptNodeCodes, 3-2                       getAttributeNode(), 3-34
   CompareHowCode, 3-2                        getAttributeNS(), 3-34
   DOMExceptionCode, 3-3                      getElementsByTagName(), 3-35
   DOMNodeType, 3-2                           getTagName(), 3-35
   RangeExceptionCode, 3-3                    hasAttribute(), 3-35
   WhatToShowCode, 3-3                        hasAttributeNS(), 3-36
DOM package                                   removeAttribute(), 3-36
   using, 3-1                                 removeAttributeNode(), 3-37
DOM package for C++, 3-1                      removeAttributeNS(), 3-36
DOMException Interface                        setAttribute(), 3-37
   Dom package, 3-11                          setAttributeNode(), 3-38
   getDOMCode(), 3-11                         setAttributeNS(), 3-38
   getMesLang(), 3-12                     ElementRef(), 3-33
   getMessage(), 3-12                     encoding datatype, Ctx package, 2-1
DOMExceptionCode datatype, DOM package,   encodings datatype, Ctx package, 2-1
       3-3                                endDocument(), 5-13
DOMImplementation Interface               endElement(), 5-13
   ~DOMImplementation(), 3-17             EntityRef Interface
   Dom package, 3-16                          ~EntityRef(), 3-40
   DOMImplementation(), 3-16                  Dom package, 3-39
   getNoMod(), 3-17                           EntityRef(), 3-39
DOMImplementation(), 3-16                     getNotationName(), 3-39
DOMImplRef Interface                          getPublicId(), 3-40
   ~DOMImplRef(), 3-16                        getSystemId(), 3-40
   createDocument(), 3-13                     getType(), 3-40
   createDocumentType(), 3-14             EntityRef(), 3-39
   Dom package, 3-12                      EntityReferenceRef Interface
   DOMImplRef(), 3-12                         ~EntityReferenceRef(), 3-41
   formDocument(), 3-14                       Dom package, 3-40
   getImplementation(), 3-14                  EntityReferenceRef(), 3-41
   getNoMod(), 3-15                       EntityReferenceRef(), 3-41
   hasFeature(), 3-15                     extractContent(), 3-64
   setContext(), 3-15
DOMImplRef(), 3-12
DOMNodeType datatype, DOM package, 3-2    F
DomParser Interface                       Factory Interface
   getContext(), 5-2                         ~Factory(), 7-6
   getParserId(), 5-3                        createDOMParser(), 7-2
   parse(), 5-3                              createSAXParser(), 7-3
   parseDTD(), 5-3                           createSchemaValidator(), 7-3
   parseSchVal(), 5-4                        createXPathCompiler(), 7-4
   setValidator(), 5-4                       createXPathCompProcessor(), 7-3
                                             createXPathProcessor(), 7-4



                                                                                         3
                                                                                                     Index


Factory Interface (continued)                         getHeaderElement(), 6-10
     createXPointerProcessor(), 7-5                   getImplementation(), 3-14, 3-27
     createXslCompiler(), 7-5                         getInternalSubset(), 3-31
     createXslExtendedTransformer(), 7-5              getISrcType(), 4-2
     createXslTransformer(), 7-6                      getItem(), 9-5
     Factory(), 7-2                                   getLastChild(), 3-52
     getContext(), 7-6                                getLength(), 3-8, 3-42, 3-48, 10-3
     Tools package, 7-1                               getLocalName(), 3-52
Factory(), 7-2                                        getLocType(), 9-4
FactoryException Interface                            getMemAllocator(), 2-4
     getCode(), 7-7                                   getMesLang(), 1-2, 3-12, 3-69, 5-9, 6-3, 7-7, 8-6,
     getFactoryCode(), 7-7                                    9-3, 10-7
     getMesLang(), 7-7                                getMessage(), 1-2, 3-12, 3-69, 5-9, 7-8, 8-6, 9-3,
     getMessage(), 7-8                                        10-7
     Tools package, 7-7                               getMustUnderstand(), 6-10
FactoryExceptionCode datatype, Tools package,         getName(), 3-4, 3-32
         7-1                                          getNamedItem(), 3-43
firstChild(), 3-72                                    getNamedItemNS(), 3-43
formDocument(), 3-14                                  getNamespaceURI(), 3-52
freeString(), 3-8                                     getNextSibling(), 3-52
                                                      getNode(), 8-4, 9-4
                                                      getNodeName(), 3-53
G                                                     getNodeSet(), 8-8
getAttribute(), 3-34                                  getNodeType(), 3-53
getAttributeNode(), 3-34                              getNodeValue(), 3-53
getAttributeNS(), 3-34                                getNoMod(), 3-15, 3-17, 3-53
getAttributes(), 3-51                                 getNotationName(), 3-39
getBaseURI(), 4-2, 5-6                                getNotations(), 3-32
getBody(), 6-8                                        getObjBoolean(), 8-8
getBodyElement(), 6-8                                 getObjNumber(), 8-8
getChildNodes(), 3-51                                 getObjString(), 8-8
getCode(), 1-2, 3-69, 5-9, 6-2, 7-7, 8-6, 9-3, 10-7   getObjType(), 8-8
getCollapsed(), 3-64                                  getOwnerDocument(), 3-54
getCommonAncestorContainer(), 3-64                    getOwnerElement(), 3-5
getCompilerId(), 8-4, 10-2                            getParentNode(), 3-54
getContext(), 5-2, 5-16, 7-6                          getParserCode(), 5-10
getData(), 3-8, 3-61                                  getParserId(), 5-3, 5-17
getDiscardWhitespaces(), 5-6                          getPrefix(), 3-54
getDoctype(), 3-25                                    getPreviousSibling(), 3-54
getDocumentElement(), 3-25                            getProcessorId(), 8-2, 8-5, 9-2
getDOMCode(), 3-11                                    getPublicId(), 3-32, 3-40, 3-59
getElementById(), 3-25                                getRange(), 9-4
getElementsByTagName(), 3-26, 3-35                    getRangeCode(), 3-69
getElementsByTagNameNS(), 3-26                        getReasonLang(), 6-11
getEncoding(), 2-4                                    getReasonNum(), 6-11
getEndContainer(), 3-64                               getRole(), 6-11
getEndOffset(), 3-65                                  getSchemaList(), 5-18
getEntities(), 3-31                                   getSchemaLocation(), 5-6
getEnvelope(), 6-8                                    getSize(), 8-5, 9-5
getErrHandler(), 2-4                                  getSoapCode(), 6-3
getExpandCharRefs(), 5-6                              getSpecified(), 3-5
getFactoryCode(), 7-7                                 getStartContainer(), 3-65
getFault(), 6-9                                       getStartOffset(), 3-65
getFirstChild(), 3-51                                 getStopOnWarning(), 5-7
getHeader(), 6-9                                      getSystemId(), 3-32, 3-40, 3-60



                                                                                                 Index-4
                                                                            Index


getTagName(), 3-35                          L
getTarget(), 3-61
getTransformerId(), 10-3, 10-5              lastChild(), 3-72
getType(), 3-40                             loadSchema(), 5-19
getValidatorId(), 5-19
getValue(), 3-5
getWarnDuplicateEntity(), 5-7
                                            M
getXPathCode(), 8-7                         markToDelete(), 3-56
getXppCode(), 9-4                           MemAllocator Interface
getXslCode(), 10-7                             ~MemAllocator(), 2-2
GParser Interface                              alloc(), 2-2
    getBaseURI(), 5-6                          Ctx package, 2-1
    getDiscardWhitespaces(), 5-6               dealloc(), 2-2
    getExpandCharRefs(), 5-6                MsgFactory Interface
    getSchemaLocation(), 5-6                   ~MsgFactory(), 6-5
    getStopOnWarning(), 5-7                    addBodyElement(), 6-5
    getWarnDuplicateEntity(), 5-7              addFaultReason(), 6-6
    Parser package, 5-5                        addHeaderElement(), 6-6
    setBaseURI(), 5-7                          createConnection(), 6-6
    setDiscardWhitespaces(), 5-7               createMessage(), 6-7
    setExpandCharRefs(), 5-8                   destroyMessage(), 6-7
    setSchemaLocation(), 5-8                   getBody(), 6-8
    setStopOnWarning(), 5-8                    getBodyElement(), 6-8
    SetWarnDuplicateEntity(), 5-5              getEnvelope(), 6-8
                                               getFault(), 6-9
H                                              getHeader(), 6-9
                                               getHeaderElement(), 6-10
hasAttribute(), 3-35                           getMustUnderstand(), 6-10
hasAttributeNS(), 3-36                         getReasonLang(), 6-11
hasAttributes(), 3-55                          getReasonNum(), 6-11
hasChildNodes(), 3-55                          getRole(), 6-11
hasFault(), 6-12                               hasFault(), 6-12
hasFeature(), 3-15                             MsgFactory(), 6-5
                                               setFault(), 6-12
                                               setMustUnderstand(), 6-13
I                                              setRole(), 6-13
importNode(), 3-27                             SOAP package, 6-4
InputSource Interface                       MsgFactory(), 6-5
    getBaseURI(), 4-2
    getISrcType(), 4-2                      N
    IO package, 4-1
    setBaseURI(), 4-2                       NamedNodeMapRef Interface
InputSourceType datatype, IO package, 4-1       ~NamedNodeMapRef(), 3-45
insertBefore(), 3-55                            Dom package, 3-41
insertData(), 3-9                               getLength(), 3-42
insertNode(), 3-65                              getNamedItem(), 3-43
IO Datatypes, 4-1                               getNamedItemNS(), 3-43
    InputSourceType, 4-1                        item(), 3-43
IO package for C++, 4-1                         NamedNodeMapRef(), 3-42
isSimple(), 2-4                                 removeNamedItem(), 3-44
isSupported(), 3-56                             removeNamedItemNS(), 3-44
isUnicode(), 2-5                                setNamedItem(), 3-44
item(), 3-43, 3-48                              setNamedItemNS(), 3-45
                                            NamedNodeMapRef(), 3-42
                                            nextNode(), 3-46, 3-72



                                                                               5
                                                                           Index


nextSibling(), 3-72              NotationRef Interface
NodeFilter Interface                ~NotationRef(), 3-60
    acceptNode(), 3-45              Dom package, 3-59
    Dom package, 3-45               getPublicId(), 3-59
NodeIterator Interface              getSystemId(), 3-60
    adjustCtx(), 3-46               NotationRef(), 3-59
    detach(), 3-46               NotationRef(), 3-59
    Dom package, 3-46
    nextNode(), 3-46
    previousNode(), 3-47
                                 O
NodeListRef Interface            OracleXml package for C++, 1-1
    ~NodeListRef(), 3-48
    Dom package, 3-47
    getLength(), 3-48            P
    item(), 3-48                 packages
    NodeListRef(), 3-47              Ctx for C++, 2-1
NodeListRef(), 3-47                  Dom for C++, 3-1
NodeRef Interface                    IO for C++, 4-1
    ~NodeRef(), 3-58                 OracleXml for C++, 1-1
    appendChild(), 3-50              Parser for C++, 5-1
    cloneNode(), 3-50                SOAP for C++, 6-1
    Dom package, 3-48                Tools for C++, 7-1
    getAttributes(), 3-51            XPath for C++, 8-1
    getChildNodes(), 3-51            XPointer for C++, 9-1
    getFirstChild(), 3-51            Xsl for C++, 10-1
    getLastChild(), 3-52         parentNode(), 3-73
    getNamespaceURI(), 3-52      parse(), 5-3, 5-17
    getNextSibling(), 3-52       parsedEntityDecl(), 5-13
    getNodeName(), 3-53          parseDTD(), 5-3, 5-17
    getNodeType(), 3-53          Parser Datatypes, 5-1
    getNodeValue(), 3-53             DOMParserIdType, 5-1
    getNoMod(), 3-53                 ParserExceptionCode, 5-1
    getOwnerDocument(), 3-54         SAXParserIdType, 5-2
    getParentNode(), 3-54            SchValidatorIdType, 5-2
    getPrefix(), 3-54            Parser package for C++, 5-1
    getPreviousSibling(), 3-54   ParserException Interface
    hasAttributes(), 3-55            getCode(), 5-9
    hasChildNodes(), 3-55            getMesLang(), 5-9
    insertBefore(), 3-55             getMessage(), 5-9
    isSupported(), 3-56              getParserCode(), 5-10
    markToDelete(), 3-56             Parser package, 5-9
    NodeRef(), 3-49              ParserExceptionCode datatype, Parser package,
    normalize(), 3-56                     5-1
    removeChild(), 3-56          parseSchVal(), 5-4
    replaceChild(), 3-57         previousNode(), 3-47, 3-73
    resetNode(), 3-57            previousSibling(), 3-73
    setNodeValue(), 3-57         process(), 8-2, 8-5, 9-2
    setPrefix(), 3-58            processingInstruction(), 5-14
NodeRef(), 3-49                  ProcessingInstructionRef Interface
NodeSet Interface                    ~ProcessingInstructionRef(), 3-62
    getNode(), 8-4                   Dom package, 3-60
    getSize(), 8-5                   getData(), 3-61
    XPath package, 8-4               getTarget(), 3-61
normalize(), 3-56                    ProcessingInstructionRef(), 3-60
notationDecl(), 5-13                 setData(), 3-61



                                                                       Index-6
                                                                                      Index


ProcessingInstructionRef(), 3-60            S
Processor Interface
    getProcessorId(), 8-5, 9-2              SAXHandler Interface
    process(), 8-5, 9-2                         attributeDecl(), 5-11
    XPath package, 8-5                          CDATA(), 5-10
    XPointer package, 9-2                       characters(), 5-12
processWithBinXPath(), 8-3                      comment(), 5-12
                                                elementDecl(), 5-12
                                                endDocument(), 5-13
R                                               endElement(), 5-13
Range Interface                                 notationDecl(), 5-13
    cloneContent(), 3-63                        parsedEntityDecl(), 5-13
    cloneRange(), 3-63                          Parser package, 5-10
    CompareBoundaryPoints(), 3-63               processingInstruction(), 5-14
    deleteContents(), 3-63                      startDocument(), 5-14
    detach(), 3-64                              startElement(), 5-14
    Dom package, 3-62                           startElementNS(), 5-15
    extractContent(), 3-64                      unparsedEntityDecl(), 5-15
    getCollapsed(), 3-64                        whitespace(), 5-16
    getCommonAncestorContainer(), 3-64          XMLDecl(), 5-11
    getEndContainer(), 3-64                 SAXParser Interface
    getEndOffset(), 3-65                        getContext(), 5-16
    getStartContainer(), 3-65                   getParserId(), 5-17
    getStartOffset(), 3-65                      parse(), 5-17
    insertNode(), 3-65                          parseDTD(), 5-17
    selectNode(), 3-66                          Parser package, 5-16
    selectNodeContent(), 3-66                   setSAXHandler(), 5-18
    setEnd(), 3-66                          SAXParserIdType datatype, Parser package, 5-2
    setEndAfter(), 3-66                     SchemaValidator Interface
    setEndBefore(), 3-67                        getSchemaList(), 5-18
    setStart(), 3-67                            getValidatorId(), 5-19
    setStartAfter(), 3-67                       loadSchema(), 5-19
    setStartBefore(), 3-68                      Parser package, 5-18
    surroundContents(), 3-68                    unloadSchema(), 5-19
    toString(), 3-68                        SchValidatorIdType datatype, Parser package,
RangeException Interface                             5-2
    Dom package, 3-68                       selectNode(), 3-66
    getCode(), 3-69                         selectNodeContent(), 3-66
    getMesLang(), 3-69                      setAttribute(), 3-37
    getMessage(), 3-69                      setAttributeNode(), 3-38
    getRangeCode(), 3-69                    setAttributeNS(), 3-38
RangeExceptionCode datatype, DOM package,   setBaseURI(), 4-2, 5-7
        3-3                                 setBinXsl(), 10-3
removeAttribute(), 3-36                     setContext(), 3-15
removeAttributeNode(), 3-37                 setData(), 3-9, 3-61
removeAttributeNS(), 3-36                   setDiscardWhitespaces(), 5-7
removeChild(), 3-56                         setEnd(), 3-66
removeNamedItem(), 3-44                     setEndAfter(), 3-66
removeNamedItemNS(), 3-44                   setEndBefore(), 3-67
replaceChild(), 3-57                        setExpandCharRefs(), 5-8
replaceData(), 3-9                          setFault(), 6-12
resetNode(), 3-57                           setMustUnderstand(), 6-13
                                            setNamedItem(), 3-44
                                            setNamedItemNS(), 3-45
                                            setNodeValue(), 3-57




                                                                                            7
                                                                                     Index


setPrefix(), 3-58                           toString(), 3-68
setRole(), 6-13                             transform(), 10-4, 10-6
setSAXHandler(), 5-18, 10-4, 10-5           Transformer Interface
setSchemaLocation(), 5-8                        getTransformerId(), 10-5
setStart(), 3-67                                setSAXHandler(), 10-5
setStartAfter(), 3-67                           setXSL(), 10-6
setStartBefore(), 3-68                          transform(), 10-6
setStopOnWarning(), 5-8                         XSL package, 10-5
setValidator(), 5-4                         TreeWalker Interface
setValue(), 3-5                                 adjustCtx(), 3-71
SetWarnDuplicateEntity(), 5-5                   Dom package, 3-71
setXSL(), 10-4, 10-6                            firstChild(), 3-72
SOAP Datatypes, 6-1                             lastChild(), 3-72
     SoapBinding, 6-2                           nextNode(), 3-72
     SoapExceptionCode, 6-1                     nextSibling(), 3-72
     SoapRole, 6-2                              parentNode(), 3-73
SOAP package for C++, 6-1                       previousNode(), 3-73
SoapBinding datatype, SOAP package, 6-2         previousSibling(), 3-73
SoapException Interface
     getCode(), 6-2
     getMesLang(), 6-3
                                            U
     getMessage(), 6-2                      unloadSchema(), 5-19
     getSoapCode(), 6-3                     unparsedEntityDecl(), 5-15
     SOAP package, 6-2
SoapExceptionCode datatype, SOAP package,
         6-1                                W
SoapRole datatype, SOAP package, 6-2        WhatToShowCode datatype, DOM package, 3-3
splitText(), 3-70                           whitespace(), 5-16
startDocument(), 5-14
startElement(), 5-14
startElementNS(), 5-15                      X
substringData(), 3-10
                                            XMLDecl(), 5-11
surroundContents(), 3-68
                                            XmlException Interface
                                               getCode(), 1-2
T                                              getMesLang(), 1-2
                                               getMessage(), 1-2
TCtx Interface                                 OracleXml package, 1-1
   ~TCtx(), 2-5                             XPath Datatypes, 8-1
   Ctx package, 2-2                            XPathCompIdType, 8-1
   getEncoding(), 2-4                          XPathExceptionCode, 8-2
   getErrHandler(), 2-4                        XPathObjType, 8-1
   getMemAllocator(), 2-4                      XPathPrIdType, 8-2
   isSimple(), 2-4                          XPath package for C++, 8-1
   isUnicode(), 2-5                         XPathCompIdType datatype, XPath package, 8-1
   TCtx(), 2-3                              XPathException Interface
TCtx(), 2-3                                    getCode(), 8-6
TextRef Interface                              getMesLang(), 8-6
   ~TextRef(), 3-71                            getMessage(), 8-6
   Dom package, 3-70                           getXPathCode(), 8-7
   splitText(), 3-70                           XPath package, 8-6
   TextRef(), 3-70                          XPathExceptionCode datatype, XPath package,
TextRef(), 3-70                                    8-2
Tools Datatypes, 7-1                        XPathObject Interface
   FactoryExceptionCode, 7-1                   getNodeSet(), 8-8
Tools package for C++, 7-1



                                                                                 Index-8
                                                                                          Index


XPathObject Interface (continued)              XppLocation Interface
   getObjBoolean(), 8-8                            getLocType(), 9-4
   getObjNumber(), 8-8                             getNode(), 9-4
   getObjString(), 8-8                             getRange(), 9-4
   getObjType(), 8-8                               XPointer package, 9-4
   XPath package, 8-7                          XppLocSet Interface
   XPathObject(), 8-7                              getItem(), 9-5
XPathObject(), 8-7                                 getSize(), 9-5
XPathObjType datatype, XPath package, 8-1          XPointer package, 9-5
XPathPrIdType datatype, XPath package, 8-2     XppLocType datatype, XPointer package, 9-1
XPointer Datatypes, 9-1                        XppPrIdType datatype, XPointer package, 9-1
   XppExceptionCode, 9-1                       Xsl Datatypes, 10-1
   XppLocType, 9-1                                 XslCompIdType, 10-1
   XppPrIdType, 9-1                                XslTrIdType, 10-2
XPointer package for C++, 9-1                  Xsl package for C++, 10-1
XppException Interface                         XslCompIdType datatype, Xsl package, 10-1
   getCode(), 9-3                              XSLException Interface
   getMesLang(), 9-3                               Xsl package, 10-6
   getMessage(), 9-3                           XslExceptionCode datatype, Xsl package, 10-1
   getXppCode(), 9-4                           XslTrIdType datatype, Xsl package, 10-2
   XPointer package, 9-3
XppExceptionCode datatype, XPointer package,
       9-1




                                                                                              9

