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
*	SBX_PostCopyWorkerFactory
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*/
public with sharing class SBX_PostCopyWorkerFactory {

	private static final String CLASS_NAME = 'SBX_PostCopyWorkerFactory';

	public static List<SBX_PostCopyWorker> getWorkers() {
		// arbitrary limit to fetch 100 post copy tasks to satisfy Checkmarx code scans
		List<Post_Copy_Task__mdt> postCopyTasks = [
			SELECT Id, DeveloperName
			FROM Post_Copy_Task__mdt
			LIMIT 100
		];
		return getWorkerListFromCustomMetaDataTypes(postCopyTasks);
	}

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