//
//  Downloader.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class Downloader: NSObject, URLSessionDownloadDelegate
{
	var url : URL?
	var obj1 : NSObject?


	init(_ obj1 : NSObject)
	{
		self.obj1 = obj1
	}
	

	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
	{	//is called once the download is complete
		//copy downloaded data to your documents directory with same names as source file
		let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
		let destinationUrl = documentsUrl!.appendingPathComponent(url!.lastPathComponent)
		let dataFromURL = NSData(contentsOf: location)
		dataFromURL?.write(to: destinationUrl, atomically: true)
		
		//now it is time to do what is needed to be done after the download
		//obj1!.callWhatIsNeeded()
	}
	

	private func URLSession(session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
	{	//this is to track progress
	}
	

	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
	{	// if there is an error during download this will be called
		if(error != nil)
		{
			print("Download completed with error: \(error!.localizedDescription)");
		}
	}
	
	
	func download(url: URL)
	{	//method to be called to download
		self.url = url
		
		//download identifier can be customized. I used the "ulr.absoluteString"
		let sessionConfig = URLSessionConfiguration.background(withIdentifier: url.absoluteString)
		let session = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
		let task = session.downloadTask(with: url)
		task.resume()
	}

}
