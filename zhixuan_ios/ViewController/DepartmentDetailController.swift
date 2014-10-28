//
//  DepartmentDetailController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-10-9.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class DepartmentDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpRequestProtocol {
    @IBOutlet weak var labelDepartmentName: UILabel!
    @IBOutlet weak var imageViewDepartment: UIImageView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelTel: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var textDes: UITextView!
    @IBOutlet weak var cmOfDepartmentTable: UITableView!
    @IBOutlet weak var cmSrollView: UIScrollView!
    
    var img:UIImage!
    var departmentObj:NSDictionary?
    var httpRequest = HttpRequest()
    var cmObjs = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDepartmentName.text = departmentObj!["short_name"] as? String
        imageViewDepartment.image = img
        labelCompanyName.text = departmentObj!["company_name"] as? String
        labelTel.text = departmentObj!["tel"] as? String
        labelAddr.text = departmentObj!["addr"] as? String
        
        //转换html后再textview中显示
        var desWithoutFormat = departmentObj!["des"] as? String
        let des = NSAttributedString(data:desWithoutFormat!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!,
                                     options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
                                     documentAttributes: nil, error: nil)
        
        textDes.attributedText = des

        var navButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: NSSelectorFromString("backToDepartmentList:"))
        self.navigationItem.setLeftBarButtonItem(navButtonItem, animated: true)
        
        self.cmOfDepartmentTable.tableFooterView = UIView(frame: CGRectZero)
        
        let department_id = departmentObj!["id"] as Int
        self.httpRequest.delegate = self
        self.httpRequest.getResultsWithJson("\(MAINDOMAIN)/kaihu/api_get_custom_manager_list_of_department?department_id=\(department_id)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func backToDepartmentList(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cmObjs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("customManagerOfDepartment") as CustomManagerOfDepartmentCell
        let rowData:NSDictionary = self.cmObjs[indexPath.row] as NSDictionary
        
        cell.nameLabel?.text = rowData["nick"] as? String
        cell.telLabel?.text = rowData["mobile"] as? String
        cell.qqLabel?.text = rowData["qq"] as? String
        cell.vipInfoLabel?.text = rowData["vip_info"] as? String
        
        let img = httpRequest.getImage(rowData["img"] as String)
        cell.cmImageView?.image = img
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    
    func didRecieveResults(results:NSDictionary){
        self.cmObjs = results["custom_managers"] as NSMutableArray
        if(self.cmObjs.count == 0){
//            self.cmOfDepartmentTable.hidden = true
        }else{
//            self.cmOfDepartmentTable.hidden = false
        }
        
        
        println(self.cmOfDepartmentTable.frame)
        let height = CGFloat(65 * self.cmObjs.count)
//        self.cmOfDepartmentTable.frame = CGRectMake(16, 385, 350, 600)
//        println(self.cmOfDepartmentTable.frame)
        
        self.cmSrollView.contentSize = CGSize(width: 320, height: 1600)
        
        self.cmOfDepartmentTable.reloadData()
        println(self.cmOfDepartmentTable.contentSize)
        
        println(self.cmOfDepartmentTable)
        self.cmOfDepartmentTable.frame = CGRectMake(16, 331, 288, height)
        println(self.cmOfDepartmentTable)
        
    }
    
    
}