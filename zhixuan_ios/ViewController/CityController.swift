//
//  CityController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14/10/22.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//


import UIKit

protocol SelectCityProtocol{
    func selectCity(cityId:Int, cityName:String)
}

class CityController: UITableViewController {
    
    var citys = []
    var httpRequest = HttpRequest()
    var delegate:SelectCityProtocol?
    
    override func viewDidLoad() {
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
        cell?.textLabel.text = self.citys[indexPath.row]["name"] as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cityId = citys[indexPath.row]["id"] as Int
        let cityName = citys[indexPath.row]["name"] as String
        self.delegate?.selectCity(cityId, cityName: cityName)
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    
    
}
