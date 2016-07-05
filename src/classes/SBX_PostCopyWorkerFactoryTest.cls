/**
*	The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
*
*	SBX_PostCopyWorkerFactoryTest
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*
*	WARNING: Custom Metadata Types cannot be created in a test class, so we need to depend on having existing metadata available.
*	The Custom Metadata Type we're using is called a Post Copy Task (PCT). This is used to identify the names of classes that should be
*	executed after a refresh. The named classes implement a custom type called SBX_PostCopyWorker (Post Copy Worker or PWC). These tests
*	need to verify the following:
*		1. We have at least one PCT
*		2. At least one PCT can create a valid PCW
*		3. At least one PCT needs to be invalid and could not create a PCW (the name of the PCT does not match an existing class name)
*/
@isTest
public with sharing class SBX_PostCopyWorkerFactoryTest {

	/**
	*	See warning at top
	*/
	static testMethod void testGetWorkers_GetPostCopyWorkers_VerifySomeExist(){
		List<SBX_PostCopyWorker> workerList = SBX_PostCopyWorkerFactory.getWorkers();
		System.assertNotEquals(0, workerList.size());
	}

	/**
	*	See warning at top
	*/
	static testMethod void testGetWorkers_GetPCWsAndPCTs_VerifyCountDoesntMatch(){
		List<Post_Copy_Task__mdt> pctList = [SELECT Id FROM Post_Copy_Task__mdt];
		List<SBX_PostCopyWorker> workerList = SBX_PostCopyWorkerFactory.getWorkers();
		System.assertNotEquals(pctList.size(), workerList.size());
	}

}