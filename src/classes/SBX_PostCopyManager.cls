/**
*	@description The sf-sandbox-post-copy framework is an open source project managed in Github (https://github.com/GSA/sf-sandbox-post-copy)
*
*	@author Derek Benner, Manikanta Ramineni, Christian Coleman
* @group Sandbox Post Copy
*	@date 4/12/2016
*/
public with sharing class SBX_PostCopyManager implements SandboxPostCopy{

	/**
	* @description
	* @param SandboxContext context
	* @return void
	* @example
	*/
	public void runApexClass(SandboxContext context){
		List<SBX_PostCopyWorker> workerList = SBX_PostCopyWorkerFactory.getWorkers();
		for(SBX_PostCopyWorker worker : workerList){
			worker.process(context);
		}
	}

}
