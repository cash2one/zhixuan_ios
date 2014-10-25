//
//  ThirdViewController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-25.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactTableView: UITableView!
    
    let contactList = [["邮箱", "jz@zhxiuan.com"], ["QQ", "2659790310 "], ["官方网站", ""], ["新浪微博", ""]]
    
    override func viewDidLoad() {
        //        self.view.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
        self.contactTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("contactUsCell") as UITableViewCell
        cell.textLabel.text = contactList[indexPath.row][0]
        cell.detailTextLabel?.text = contactList[indexPath.row][1]
        
        if(indexPath.row < 2)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(indexPath.row == 2){
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.zhixuan.com")!)
        }
        if(indexPath.row == 3){
            UIApplication.sharedApplication().openURL(NSURL(string: "http://weibo.com/zhixuancom")!)
        }
    }

    
    
}