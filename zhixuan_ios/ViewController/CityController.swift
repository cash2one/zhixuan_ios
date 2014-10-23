//
//  CityController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14/10/22.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//


import UIKit

class CityController: UITableViewController {
    
    var citys = [] as Array
    var httpRequest = HttpRequest()
    
    override func viewDidLoad() {
        println("go to city select")
        super.viewDidLoad()
        
        self.navigationItem.title = "选择城市"
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.citys.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("cityCell") as? UITableViewCell
        
        
        if(cell == nil) { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cityCell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.textLabel?.text = self.citys[indexPath.row]["name"] as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var fv = FirstViewController()
//        fv.cityId = citys[indexPath.row]["id"] as String
//        self.navigationController?.popToRootViewControllerAnimated(true)
//        self.navigationController?.popToViewController(ProvinceController(), animated: false)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //跳转到选择城市页面
        println("get this")
    }
    
}
