/**
*	The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
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