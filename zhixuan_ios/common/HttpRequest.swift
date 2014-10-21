//
//  HttpRequest.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-25.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

protocol HttpRequestProtocol{
    func didRecieveResults(results:NSDictionary)
}


class HttpRequest:NSObject{
    var delegate:HttpRequestProtocol?
    var debug = DebugUtils()
    
    func getResultsWithJson(url:String){
        var nsUrl:NSURL = NSURL(string:url)
        var request:NSURLRequest = NSURLRequest(URL: nsUrl)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {
                (response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                self.debug.printWithDate("get http response ok")
                
                let httpResponse = response as NSHTTPURLResponse
                if(httpResponse.statusCode != 200){
                    println("http request status is \(httpResponse.statusCode)")
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    let alert = UIAlertView(title: "http请求错误：\(httpResponse.statusCode)", message: nil, delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
                else{
                    var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers,
                        error: nil) as NSDictionary
                    
                    var errorCode = jsonResult["errcode"] as Int
                    if (errorCode != 0){
                        let alert = UIAlertView(title: jsonResult["errmsg"] as? String, message: nil, delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }
                    
                    self.delegate?.didRecieveResults(jsonResult)
                }
            }
        )
    }
    
    func getImage(url:String) -> UIImage{
        let imgURL:NSURL = NSURL(string:url)
        let request:NSURLRequest = NSURLRequest(URL:imgURL)
        var img:UIImage!
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        img = UIImage(data: data!)
        return img
    }
}

