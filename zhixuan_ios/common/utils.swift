//
//  utils.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-28.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import Foundation


class DebugUtils:NSObject {
    func printWithDate(info:AnyObject){
        let date = NSDate()
        print(date)
        print(" ---- ")
        print(info)
        println("")
    }
}


