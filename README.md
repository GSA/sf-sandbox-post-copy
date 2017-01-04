# Salesforce Sandbox Post Copy
A framework for managing automation tasks that are fired upon sandbox refresh in Salesforce orgs.

## Background

Preparing sandboxes for use by development teams or other users has traditionally required manual action.  

With the Salesforce Spring '16 release, the platform provides a capability to automate data manipulation or business logic tasks.  

More specifically, the platform defines the SandboxPostCopy interface and allows an administrator at the time of a sandbox create or refresh action to select an Apex class implementing this interface.  The Apex class then executes within the sandbox as it is prepared for use.

This repository contains an extensible framework for organizing sandbox post copy automation tasks within your org.

## Framework Overview

### Apex Classes
For more details regarding classes, see the project ApexDoc's, http://gsa.github.io/sf-sandbox-post-copy/

* SBX_PostCopyManager
  * Implements the Salesforce SandboxPostCopy interface.  Delegates to SBX_PostCopyWorkerFactory to obtain a collection of classes containing automation logic then invokes each class's processing.

* SBX_PostCopyManagerTest
  * Test class for SBX_PostCopyManager.

* SBX_PostCopyUtil
	* Utility functions used by the framework.

* SBX_PostCopyWorker
  * An abstract class defining behavior common to all automation tasks and defining an abstract method which subclasses override.

* SBX_PostCopyWorkerFactory
  * Factory class responsible for creating all subclasses of SBX_PostCopyWorker for the organization.  Uses the Post Copy Task custom metadata type and the Type class to instantiate each required class.  

* SBX_PostCopyWorkerFactoryTest
  * Test class for SBX_PostCopyWorkerFactory.

### Custom Objects

* Post Copy Log
  * Records the success or failure of an automation task

### Tabs

* Post Copy Log

### Page Layouts

* Post Copy Log Layout
* Post Copy Task Layout

### Custom Metadata Type

* Post Copy Task
  * Each record identifies an Apex class which performs an automation task during the creation or refresh of a sandbox.

## Installation

Use the Force.com Migration Tool to deploy the framework using the code, configuration and package.xml from this repository.

### Requirements
* Ant 1.9 or later
* ant-salesforce.jar

### Instructions
````
git clone
cd sf-sandbox-post-copy
````
Create a build.properties file in the base of the project and update accordingly. Copy and past the entire line into you terminal.
````
echo -e "# enter the full username typically yourname@domain.com.sandboxname\nsf.username=\n# password and security token\nsf.password=\n# fully qualified URL https://mydomain.my.salesforce.com\nsf.serverurl=\nsf.maxPoll=300\n" > build.properties
````
Deploy to your environment
````
ant deployCode
````


## Extending and Using the Framework

1. Implement each of your automation tasks in the run() method of an Apex class extending SBX_PostCopyWorker.
1. Create a corresponding record in the Post Copy Task custom metadata type for each Apex class.
1. Deploy your Apex class(es) and the custom metadata type record(s) to production.
1. Initiate a sandbox create or refresh action.  When prompted, specify SBX_PostCopyManager as the Apex class.
1. Once the sandbox is accessible, review record(s) in the Post Copy Log custom object to view the status of each task.


## Runtime Considerations

The subclasses of SBX_PostCopyWorker will execute in a single transaction and in aggregate are subject to the Per Transaction Apex limits.

The synchronous limit of 100 SOQL queries in a transaction could be reached as the number of subclasses grows.  Should this limit be reached, move the processing of the SBX_PostCopyWorker subclass to another class that implements the Queueable interface.  In the run method of the SBX_PostCopyWorker subclass, call the Queueable class using System.enqueueJob.  

## Contributing
We are actively enhancing this framework and would love submissions! See [CONTRIBUTING](CONTRIBUTING.md).
