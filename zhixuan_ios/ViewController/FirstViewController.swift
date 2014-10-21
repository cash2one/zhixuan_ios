//
//  FirstViewController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-24.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpRequestProtocol {
    
    @IBOutlet weak var cmTableView: UITableView!
    
    var httpRequest = HttpRequest()
    var cmObjs = NSMutableArray()
    var cmAddObjs = NSArray()
    var cmCount = 0
    var pageCount = 1
    let pageMaxCount = 10
    var pullView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("start1")
        self.cmTableView.tableFooterView = UIView(frame: CGRectZero)
//            [[[UIView alloc] initWithFrame:CGRectZero] autorelease]
        
        self.httpRequest.delegate = self
        self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list?page=\(self.pageCount)")
        
        //注册动画
        setupRefresh()
    }
    
    func setupRefresh(){
        self.cmTableView.addFooterWithCallback({
            self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list?page=\(self.pageCount)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cmObjs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let rowData:NSDictionary = self.cmObjs[indexPath.row] as NSDictionary        
        let cell = tableView.dequeueReusableCellWithIdentifier("customManager") as CustomManagerCell
        
        cell.nameLabel?.text = rowData["nick"] as? String
        cell.telLabel?.text = rowData["mobile"] as? String
        cell.qqLabel?.text = rowData["qq"] as? String
        cell.vipInfoLabel?.text = rowData["vip_info"] as? String
        cell.companyLabel?.text = rowData["company_name"] as? String
        
        let img = httpRequest.getImage(rowData["img"] as String)
        cell.cmImageView?.image = img
        
//        cmNavItem.title = "客户经理(共\(self.cmCount)位)"
        return cell
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func didRecieveResults(results:NSDictionary){
        cmAddObjs = results["custom_managers"] as NSArray
        self.cmCount = results["custom_managers_count"] as Int
        
        if(self.pageCount == 1)
        {
            self.cmObjs = cmAddObjs as NSMutableArray
            self.cmTableView.reloadData()
        }
        else if(cmAddObjs.count > 0) {
            let originCount = cmObjs.count
            let newCount = cmAddObjs.count - 1
            for i in 0...newCount {
                self.cmObjs.insertObject(self.cmAddObjs[i], atIndex: self.cmObjs.count)
            }
            
            var indexPaths:Array = []
            for i in 0...newCount {
                indexPaths.append(NSIndexPath(forRow: originCount + i, inSection: 0))
            }
            self.cmTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Left)
        }
        
        self.cmTableView.footerEndRefreshing()
        // 最后一页隐藏
        if(cmAddObjs.count < self.pageMaxCount){
            self.cmTableView.setFooterHidden(true)
        }
        self.pageCount += 1
    }

}

