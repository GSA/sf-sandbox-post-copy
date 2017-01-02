/**
*	@description The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
*
*	@author Derek Benner, Manikanta Ramineni, Christian Coleman
*	@date 4/12/2016
* @group Sandbox Post Copy
*/
public with sharing class SBX_PostCopyWorkerFactory {

	private static final String CLASS_NAME = 'SBX_PostCopyWorkerFactory';

	/**
	* @description
	* @return List containing Id's, and API Names of Post Copy Tasks
	*/
	public static List<SBX_PostCopyWorker> getWorkers() {
		List<Post_Copy_Task__mdt> postCopyTasks = [
			SELECT Id, DeveloperName, Active__c, Order_Number__c
			FROM Post_Copy_Task__mdt
			WHERE Active__c = true
			ORDER BY Order_Number__c ASC
		];
		return getWorkerListFromCustomMetaDataTypes(postCopyTasks);
	}

	/**
	* @description
	* @param List<Post_Copy_Task__mdt> taskList
	* @return
	*/
	private static List<SBX_PostCopyWorker> getWorkerListFromCustomMetaDataTypes(List<Post_Copy_Task__mdt> taskList){
		List<SBX_PostCopyWorker> workerList = new List<SBX_PostCopyWorker>();
		for(Post_Copy_Task__mdt task : taskList){
			String workerName = task.DeveloperName;
			SBX_PostCopyWorker worker = createWorkerObjectFromString(workerName);
			if(worker == null) {
				// a log obj was created in createWorkerObjectFromString() above; it also retuned a null obj so we're not going to add it
				continue;
			}
			workerList.add(worker);
		}
		return workerList;
	}

	/**
	* @description
	* @param String workerName
	* @return SBX_PostCopyWorker
	*/
	private static SBX_PostCopyWorker createWorkerObjectFromString(String workerName){
		SBX_PostCopyWorker worker = null;
		try {
			Type t = Type.forName(workerName);
			worker = (SBX_PostCopyWorker) t.newInstance();
		} catch (Exception e){
			SBX_PostCopyUtil.createLogObj(CLASS_NAME, e);
		}
		return worker;
	}
}
