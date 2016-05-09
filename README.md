# sf-sandbox-post-copy
A framework for managing automation tasks that are fired upon sandbox refresh in Salesforce orgs. 

BACKGROUND

Preparing sandboxes for use by development teams or other users has traditionally required manual action.  

With the Salesforce Spring '16 release, the platform provides a capability to automate data manipulation or business logic tasks.  

More specifically, the platform defines the SandboxPostCopy interface and allows an administrator at the time of a sandbox create or refresh action to select an Apex class implementing this interface.  The Apex class then executes within the sandbox as it is prepared for use.

This repository contains an extensible framework for organizing sandbox post copy automation tasks within your org.

FRAMEWORK OVERVIEW

Apex Classes

	SBX_PostCopyManager - Implements the Salesforce SandboxPostCopy interface.  Delegates to SBX_PostCopyWorkerFactory to obtain a collection of classes containing automation logic then invokes each class's processing.

	SBX_PostCopyManagerTest - Test class for SBX_PostCopyManager.

	SBX_PostCopyWorker - An abstract class defining behavior common to all automation tasks and defining an abstract method which subclasses override.
	
	SBX_PostCopyWorkerFactory - Factory class responsible for creating all subclasses of SBX_PostCopyWorker for the organization.  Uses the Post Copy Task custom metadata type and the Type class to instantiate each required class.  

	SBX_PostCopyWorkerFactoryTest - Test class for SBX_PostCopyWorkerFactory.


Custom Objects
	Post Copy Log - Records the success or failure of an automation task

Tabs
	Post Copy Log
	
Page Layout
	Post Copy Log Layout
	
Custom Metadata Type
  Post Copy Task - Each record identifies an Apex class which performs an automation task during the creation or refresh of a sandbox. 

INSTALLATION

Use the Force.com Migration Tool to deploy the framework using the code, configuration and package.xml from this repository. 


EXTENDING & USING THE FRAMEWORK

1. Implement each of your automation tasks in the run() method of an Apex class extending SBX_PostCopyWorker.

2. Create a corresponding record in the Post Copy Task custom metadata type for each Apex class.

3. Deploy your Apex class(es) and the custom metadata type record(s) to production.

4. Initiate a sandbox create or refresh action.  When prompted, specify SBX_PostCopyManager as the Apex class.

5. Once the sandbox is accessible, review record(s) in the Post Copy Log custom object to view the status of each task.
 

RUNTIME CONSIDERATIONS
 
The subclasses of SBX_PostCopyWorker will execute in a single transaction and in aggregate are subject to the Per Transaction Apex limits.
 
The synchronous limit of 100 SOQL queries in a transaction could be reached as the number of subclasses grows.  Should this limit be reached, move the processing of the SBX_PostCopyWorker subclass to another class that implements the Queueable interface.  In the run method of the SBX_PostCopyWorker subclass, call the Queueable class using System.enqueueJob.  
