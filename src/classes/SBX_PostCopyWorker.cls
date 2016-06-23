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
*	SBX_PostCopyWorker
*
*	@author Derek Benner
*	@author Manikanta Ramineni
*	@author Christian Coleman
*	@date 4/12/2016
*/
public with sharing abstract class SBX_PostCopyWorker {

	/**
	* One of the two methods that are required to be implemented by a SBX_PostCopyWorker.
	* Class extensions will implement this method and include any post copy logic they want to run.
	* Generic exception handling is provided by the wrapper method process() below which is directly
	* 	called by the SBX_PostCopyManager
	*/
	protected abstract void run(SandboxContext context);

	/**
	* In order to identify the offending class that has caused an exception developers will 
	* 	need to implement this getClassName() method so that a Post Copy Log is created with the 
	* 	appropriate class name.
	*/
	public abstract String getClassName();

	/**
	* This is the publicly available method called by the SBX_PostCopyManager. Class extensions
	* 	are required to implement the run method above which is then wrapped by this process() method.
	* 	It attempts to provide generic exception handling. If you are catching your own exceptions then
	* 	be sure to look at the SBX_PostCopyUtil to see the way they are generated.
	*/
	public void process(SandboxContext context){
		try {
			run(context);
			SBX_PostCopyUtil.createLogObj(getClassName(), null);
		} catch (Exception e){
			SBX_PostCopyUtil.createLogObj(getClassName(), e);
		}
	}

}