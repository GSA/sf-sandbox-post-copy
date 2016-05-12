/** 
*	SBX_PostCopyManager
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*/
public with sharing class SBX_PostCopyManager implements SandboxPostCopy{

	public void runApexClass(SandboxContext context){
		List<SBX_PostCopyWorker> workerList = SBX_PostCopyWorkerFactory.getWorkers();
		for(SBX_PostCopyWorker worker : workerList){
			worker.process(context);
		}
	}

}