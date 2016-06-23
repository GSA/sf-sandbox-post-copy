/**
*	MIT License
*
*	Copyright (c) [year] [fullname]
*
*	Permission is hereby granted, free of charge, to any person obtaining a copy
*	of this software and associated documentation files (the "Software"), to deal
*	in the Software without restriction, including without limitation the rights
*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*	copies of the Software, and to permit persons to whom the Software is
*	furnished to do so, subject to the following conditions:
*
*	The above copyright notice and this permission notice shall be included in all
*	copies or substantial portions of the Software.
*
*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*	SOFTWARE.
*
*
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