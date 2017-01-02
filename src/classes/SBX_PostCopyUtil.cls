/**
*	@description The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
*	@author Derek Benner, Manikanta Ramineni, Christian Coleman
*	@date 4/12/2016
* @group Sandbox Post Copy
*/
public with sharing class SBX_PostCopyUtil {

	private static final String PICKLIST_STATUS_SUCCESS = 'Success';
	private static final String PICKLIST_STATUS_FAILURE = 'Error';
	private static final String DELIMITER = '|||';

	/**
	* @description Consider making this util less generic by extracting the log object creation aspect into its own class.
	* @param String className - The name of the class
	* @param Exception e
	* @return void
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
  * @description Required to perform the testRun_UnknownExceptionOccursViaChildClass_VerifyLogObjectCreated method
	* @return Id - Returns the Salesforce ID of the Admin Profile as designated above
	* @example
	*/
	public static Id getProfileId(){
		try {
			return [
				SELECT Id
				FROM Profile
				WHERE Name = :ADMIN_PROFILE].Id;
		} catch (QueryException e){

			return null;
		}
	}

	/**
	* @description Required to perform the testRun_UnknownExceptionOccursViaChildClass_VerifyLogObjectCreated method in SBX_AdminEmailWorkerTest.
	*/
	public class ForcedException extends Exception{

	}

	/**
	* @description returns a condensed error message containing the line number of the error, message, and stack trace for a given exception
	* @param Exception e
	* @return String error message
	*/
	private static String getErrorMessage(Exception e){
		return 	  e.getLineNumber() + DELIMITER
				+ e.getMessage() + DELIMITER
				+ e.getStackTraceString();

	}
}
