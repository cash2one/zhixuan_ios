//
//  ThirdViewController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-25.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    override func viewDidLoad() {
        println("test")
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func goToZhixuan(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://zhixuan.com")!)
    }
}


class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var departmentObjs = []
    @IBOutlet weak var testTable: UITableView!
    
    override func viewDidLoad() {
        println("start4")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //注册动画
        setupRefresh()
        
        let delayInSeconds:Int64 = 1000000000 * 2
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.departmentObjs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            self.testTable.reloadData()
            
        })
        
        
    }
    
    
    func setupRefresh(){
        self.testTable.addFooterWithCallback({
            //            self.departmentObjs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            self.testTable.footerEndRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.departmentObjs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("test") as UITableViewCell
        
        cell.textLabel.text = "11111"
        return cell
    }
    
    //    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!){
    //        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
    //        UIView.animateWithDuration(0.25, animations: {
    //            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
    //        })
    //    }
    
}






