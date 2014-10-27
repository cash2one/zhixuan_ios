//
//  ProvinceController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14/10/22.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//


import UIKit

class ProvinceController: UITableViewController, HttpRequestProtocol {
    
    var provinces = Array([])
    var httpRequest = HttpRequest()
    var provinceDatas:NSArray!
    var fc:FirstViewController!
    let defaults = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择省份"
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.httpRequest.delegate = self
        getCityInfo()
    }
    
    func getCityInfo(){
        let cityInfo: AnyObject? = self.defaults.valueForKey("cityInfo")
        var needUpdateCityInfo: AnyObject? = self.defaults.valueForKey("needUpdateCityInfo")
        if(needUpdateCityInfo == nil){
            needUpdateCityInfo = false
        }
        
        if(cityInfo != nil && needUpdateCityInfo as Bool == false){
            self.provinceDatas = cityInfo as NSArray
            reloadTable()
        }else{
            self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_province_and_city")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.provinces.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("provinceCell") as? UITableViewCell
        
        
        if(cell == nil) { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "provinceCell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.textLabel.text = self.provinces[indexPath.row] as? String

        return cell!
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cc = CityController()
        let cityDict = provinceDatas[indexPath.row] as NSDictionary
        cc.citys = cityDict["cities"] as NSArray
        cc.delegate = self.fc
        self.navigationController?.pushViewController(cc, animated: true)
    }
    
    func didRecieveResults(results:NSDictionary){
        self.provinceDatas = results["data"] as NSArray
        
        self.defaults.setValue(provinceDatas, forKey: "cityInfo")
        self.defaults.setValue(false, forKey: "needUpdateCityInfo")
        self.defaults.synchronize()
        
        reloadTable()
    }
    
    func reloadTable(){
        for provinceData in provinceDatas{
            self.provinces.append(provinceData["name"] as String)
        }
        self.tableView.reloadData()
    }
}


