/**
*	The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
*
*	SBX_PostCopyManagerTest
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*/
@isTest
public with sharing class SBX_PostCopyManagerTest {

	static testMethod void testRunApexClass_InitiateSandboxRefresh_VerifyPostCopyLogsWereCreated(){
		SBX_PostCopyManager manager = new SBX_PostCopyManager();
		/**
		* The following sandboxpostcopy test takes these params: apex class name, org Id, sandbox Id, and sandboxName.
		* The org Id and sandbox Id can be any valid object Id... As of 4/27/16 I've seen example of passing Account Ids
		* 	into these two parameters and the test working as expected
		*/
		Test.testSandboxPostCopyScript(manager, UserInfo.getOrganizationId(), UserInfo.getOrganizationId(), 'sandboxName');
		List<Post_Copy_Log__c> logList = [SELECT Id FROM Post_Copy_Log__c LIMIT 2];
		System.assertNotEquals(0, logList.size());
	}

}