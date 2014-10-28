//
//  FirstViewController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-9-24.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpRequestProtocol, SelectCityProtocol, UIAlertViewDelegate {
    
    @IBOutlet weak var cmTableView: UITableView!
    @IBOutlet weak var cmNav: UINavigationItem!
    
    let defaults = NSUserDefaults()
    var httpRequest = HttpRequest()
    var cmObjs = NSMutableArray()
    var cmAddObjs = NSArray()
    var cmCount = 0
    var pageCount = 1
    let pageMaxCount = 10
    var pullView:UIView!
    var cityId:Int = 0
    var cityIdReSelect:Int = 0
    var cityName = "选择城市"
    var rightBarButtonItem = UIBarButtonItem()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("start1")
        self.cmTableView.tableFooterView = UIView(frame: CGRectZero)
        
        // 给城市id和name赋值
        let cityIdFromDefualt: AnyObject? = self.defaults.valueForKey("cityId")
        let cityNameFromDefualt: AnyObject? = self.defaults.valueForKey("cityName")
        if(cityIdFromDefualt != nil){
            self.cityId = cityIdFromDefualt as Int
        }
        if(cityNameFromDefualt != nil){
            self.cityName = cityNameFromDefualt as String
        }
        
        
        self.httpRequest.delegate = self
        self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list?page=\(self.pageCount)&city_id=\(self.cityId)")
        
        setupRefresh()  //注册动画
        setNav()    //设置右侧按钮
        checkVersion()  //版本检测
        
    }
    
    func setNav(){
        rightBarButtonItem = UIBarButtonItem(title: cityName, style: UIBarButtonItemStyle.Plain, target: self, action: NSSelectorFromString("goToSelectProvince:"))
        self.cmNav.setRightBarButtonItem(rightBarButtonItem, animated: true)
    }
    
    func goToSelectProvince(sender: UIBarButtonItem){
        let pc = ProvinceController()
        pc.fc = self
        self.navigationController?.pushViewController(pc, animated: false)
    }
    
    func checkVersion(){
        let lastCheckVersionDate = self.defaults.stringForKey("lastCheckVersionDate")
        let currentDate = DateUtil().changeCurrentDateAsString("yyyy-MM-dd")
        //版本一天检测一次
        if(lastCheckVersionDate < currentDate){
            self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/static/app/ios.json")
        }
    }
    
    func setupRefresh(){
        self.cmTableView.addFooterWithCallback({
            self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list?page=\(self.pageCount)&city_id=\(self.cityId)")
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
        
//        cmNav.title = "客户经理(共\(self.cmCount)位)"
        return cell
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    
    func didRecieveResults(results:NSDictionary){
        if(results["version"] != nil){
            let lastCheckVersionDate = DateUtil().changeCurrentDateAsString("yyyy-MM-dd")
            self.defaults.setValue(lastCheckVersionDate, forKey: "lastCheckVersionDate")    //设置时间戳，每天检测一次升级
            self.defaults.synchronize()
            
            VersionCheck().checkVersion(results, view: self, mustNotice: false)
            return
        }
        cmAddObjs = results["custom_managers"] as NSArray
        self.cmCount = results["custom_managers_count"] as Int
        
        if(self.cityId != self.cityIdReSelect){
            // 更换了城市重新加载数据
            self.cmTableView.reloadData()
            self.cityId = self.cityIdReSelect
        }
        
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
            
            var indexPaths = Array([])
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
    
    func selectCity(cityId: Int, cityName: String) {
        //数据持久化
        self.defaults.setValue(cityId, forKey: "cityId")
        self.defaults.setValue(cityName, forKey: "cityName")
        self.defaults.synchronize()
        
        self.cityId = cityId
        self.cityName = cityName
        
        self.cityIdReSelect = cityId
        self.rightBarButtonItem.title = cityName
        self.pageCount = 1
        self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list?page=\(self.pageCount)&city_id=\(self.cityId)")
    }


}

