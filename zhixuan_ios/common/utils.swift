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


class VersionAlertView: UIViewController, UIAlertViewDelegate{
    override func viewDidLoad() {
        println(1111)
        super.viewDidLoad()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        println(12221)
        println(buttonIndex)
    }
}

func checkVersion(versionInfo:NSDictionary, view:UIViewController){
    let version = versionInfo["version"] as String
    let index = versionInfo["index"] as Int
    let des = versionInfo["des"] as String
    
    if(index > VERSIONINDEX){
        var alert = UIAlertController(title: "有新版本啦(\(version))", message: des, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "以后再说", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "欢乐升级", style: UIAlertActionStyle.Default, handler:goToAppStore))
        view.presentViewController(alert, animated: true, completion: nil)
        
        //    let alert = UIAlertView(title: "有新版本啦(\(version))", message: des, delegate: VersionAlertView(), cancelButtonTitle: "以后再说", otherButtonTitles: "欢乐升级")
        //    alert.show()
    }
    
}


func goToAppStore(alertView: UIAlertAction!)
{
//    UIApplication.sharedApplication().openURL(NSURL(string: "http://www.baidu.com")!)
    UIApplication.sharedApplication().openURL(NSURL(string: "itms://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4")!)
}



