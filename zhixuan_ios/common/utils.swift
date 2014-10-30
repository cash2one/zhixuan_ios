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
        if(!DEBUG){
            return
        }
        let date = NSDate()
        print(date)
        print(" ---- ")
        print(info)
        println("")
    }
}

class DateUtil:NSObject {
    func changeCurrentDateAsString(format:String?)->NSString{
        //获取当前日期字符串
        
        return changeDateAsString(NSDate(), format: format)
    }
    
    func changeDateAsString(date:NSDate, format:String?)->NSString{
        //获取日期字符串
        
        let timeFormatter = NSDateFormatter()
        var dateFormat = format
        
        if(format == "" || format == nil){
            dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        timeFormatter.dateFormat = dateFormat
        
        return timeFormatter.stringFromDate(NSDate())
    }
    
    func getDateFromString(dateString:String, format:String?)->NSDate{
        //将字符串转换为日期格式
        
        let mydateFormatter = NSDateFormatter()
        var dateFormat = format
        if(format == "" || format == nil){
            dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        mydateFormatter.dateFormat = dateFormat
        let date = mydateFormatter.dateFromString(dateString)
        return date!
    }
}


class VersionCheck:NSObject {
    var alert:UIAlertController!
    
    func checkVersion(versionInfo:NSDictionary, view:UIViewController, mustNotice:Bool){
        let version = versionInfo["version"] as String
        let index = versionInfo["index"] as Int
        let des = versionInfo["des"] as String
        let cityInfoIndex = versionInfo["city_info_index"] as Int
        
        // 判断是否需要更新城市信息
        let defaults = NSUserDefaults()
        var needUpdateCityInfo = false
        
        let cityIndexFromDefaults:AnyObject? = defaults.valueForKey("cityInfoIndex")
        if(cityIndexFromDefaults == nil){
            needUpdateCityInfo = true
        }else{
            let cityIndexFromDefaultsInt = cityIndexFromDefaults as Int
            if(cityIndexFromDefaultsInt < cityInfoIndex){
                needUpdateCityInfo = true
            }
        }
        defaults.setValue(needUpdateCityInfo, forKey: "needUpdateCityInfo")
        defaults.setValue(cityInfoIndex, forKey: "cityInfoIndex")
        defaults.synchronize()
        
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

func getDeviceId()->String{
    return UIDevice.currentDevice().identifierForVendor.UUIDString
    
//    let cls: AnyClass! = NSClassFromString("UMANUtil")
//    let deviceIDSelector = Selector("openUDIDString:")
//    var deviceId = ""
//    if(cls != nil){
//        cls.respondsToSelector(deviceIDSelector)
//        let cls1 = cls as NMANUtil
//        deviceId = cls.performSelector(deviceIDSelector)
//    }
//    return deviceId
}






