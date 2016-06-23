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
*	SBX_PostCopyUtil
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*/
public with sharing class SBX_PostCopyUtil {

	private static final String PICKLIST_STATUS_SUCCESS = 'Success';
	private static final String PICKLIST_STATUS_FAILURE = 'Error';
	private static final String DELIMITER = '|||';

	/**
	* Consider making this util less generic by extracting the log object creation aspect into its own class.
	*/
	public static void createLogObj(String className, Exception e){
		if(e != null){
			Post_Copy_Log__c errorLog = new Post_Copy_Log__c();
			errorLog.Status__c = PICKLIST_STATUS_FAILURE;
			errorLog.Apex_Class__c = className;
			errorLog.Error_Message__c = getErrorMessage(e);
			insert errorLog;
		} else {
			Post_Copy_Log__c successLog = new Post_Copy_Log__c();
			successLog.Status__c = PICKLIST_STATUS_SUCCESS;
			successLog.Apex_Class__c = className;
			insert successLog;
		}
	}

	/**
	* Required to perform the testRun_UnknownExceptionOccursViaChildClass_VerifyLogObjectCreated method
	* 	in SBX_AdminEmailWorkerTest.
	*/
	public class ForcedException extends Exception{

	}

	private static String getErrorMessage(Exception e){
		return 	  e.getLineNumber() + DELIMITER
				+ e.getMessage() + DELIMITER
				+ e.getStackTraceString();

	}

}