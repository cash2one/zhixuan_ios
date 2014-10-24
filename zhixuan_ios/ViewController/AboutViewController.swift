//
//  ThirdViewController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-25.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var aboutTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let menuList = ["关于我们", "联系我们", "检查新版本", "亲，请评价，支持我们做得更好！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.aboutTableView.tableFooterView = UIView(frame: CGRectZero)
        versionLabel.text = "当前版本:\(VERSION)"
        println("start3")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goToZhixuan(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://zhixuan.com")!)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("aboutCell") as UITableViewCell
        cell.textLabel.text = menuList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(indexPath.row == 0){
            self.navigationController?.pushViewController(AboutUsViewController(), animated: true)
        }
    }
    
   
}




