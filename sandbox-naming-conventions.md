# Sandbox Naming Conventions

## The Problem

Salesforce teams at GSA have adopted a sandbox naming convention to help inform us what org a sandbox is associated to and what type of data is present. The below convention fits within Salesforce's 11 character maximum for sandbox names. When refreshing sandboxes, include either the point of contact name or ticket number so that folks may identify the purpose and use of the sandbox.


|Max Characters|Nomenclature|Values|Description|
|---|---|---|---|
|3|Org|{org-based character codes}|Three character code for your org - if only a single org exists, this isn’t necessary|
|2|Type|dv, pr, pa, fl|Denotes the type of sandbox being used<br><br>**dv-** developer <br>**pr-** developer Pro <br>**pa-** partial copy <br>**fl-** full copy |
|2|Sequence|1, 2, 3, etc|denotes the numeric sequence for the type of box|
|3|Use|dv, qa, int, uat, stg, trg|denotes what the sandbox will be used for <br> **dv-** development<br>**qa-** QA<br>**int-** Integration<br>**uat-** User Acceptance Testing<br>**stg-** Staging<br>**trg-** Triage|
|1|Data|p, n|denotes the type of data allowed/ existing on the sandbox<br><br>**p-** production data exists<br>**n-** no production data exists|

## Sandbox Name Examples
The table below represents one of our Salesforce orgs and the type of information present on the Sandbox administrator page.

|Action|Name|Type|Status|Location|Current Org Id|Completed On|Description|
|------|----|----|------|--------|--------------|------------|-----------|
|Login|EEODevSD2|Developer|Completed​|CS##|**masked**|10/20/2015 1:31 PM|Case 00021418|
|Login|EEOdV10DVn|Developer|Completed​|CS##|**masked**|11/18/2015 10:41 AM|Case 00022017|
|Login|EEOdV12DVn|Developer|Completed​|CS##|**masked**|2/17/2016 5:04 PM|Case: 23927 Team: IAS Dev|
|Login|EEOdV13DVn|Developer|Completed​|CS##|**masked**|2/10/2016 11:29 AM|Case: 23674/23807 Team: IAS Dev|
|Login|EEOfL3DVp|Full|Completed​|CS##|**masked**|3/11/2016 1:52 PM|Full sandbox used for Lightning|
|Login|EEOpR1UATn|Developer Pro|Completed​|CS##|**masked**|3/24/2016 4:31 PM|Case# 00024601|
