//
//  utils.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-28.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class DebugUtils:NSObject {
    func printWithDate(info:AnyObject){
        let date = NSDate()
        print(date)
        print(" ---- ")
        print(info)
        println("")
    }
}


class VersionCheck:NSObject {
    var alert:UIAlertController!
    
    func checkVersion(versionInfo:NSDictionary, view:UIViewController, mustNotice:Bool){
        let version = versionInfo["version"] as String
        let index = versionInfo["index"] as Int
        let des = versionInfo["des"] as String
        
        if(index > VERSIONINDEX){
            alert = UIAlertController(title: "有新版本啦(\(version))", message: des, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "以后再说", style: UIAlertActionStyle.Cancel, handler:nil))
            alert.addAction(UIAlertAction(title: "欢乐升级", style: UIAlertActionStyle.Default, handler:okButtonClick))
            view.presentViewController(alert, animated: true, completion: nil)
        }
        else if(mustNotice){
            alert = UIAlertController(title: "", message: "已经是最新版本:\(VERSION)", preferredStyle: UIAlertControllerStyle.Alert)
            view.presentViewController(alert, animated: true, completion: nil)
            
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("performDismiss:"), userInfo: nil, repeats: false)
        }
    }
    
    func performDismiss(timer:NSTimer){
        alert.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func okButtonClick(alertView: UIAlertAction!)
    {
        goToAppStore()
    }
}

func goToAppStore(){
//    UIApplication.sharedApplication().openURL(NSURL(string: "http://www.baidu.com")!)
    UIApplication.sharedApplication().openURL(NSURL(string: "itms://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4")!)
}






