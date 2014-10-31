//
//  DepartmentDetailController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-10-9.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class DepartmentDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetResultsWithJsonAsynctProtocol, getImageAsyncAsynctProtocol {
    @IBOutlet weak var labelDepartmentName: UILabel!
    @IBOutlet weak var imageViewDepartment: UIImageView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelTel: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var textDes: UITextView!
    @IBOutlet weak var cmOfDepartmentTable: UITableView!
    @IBOutlet weak var cmSrollView: UIScrollView!
    
    @IBOutlet weak var labelDesTtile: UILabel!
    @IBOutlet weak var labelCmTitle: UILabel!
    
    
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
        self.httpRequest.delegateImage = self
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
        let tel = rowData["mobile"] as String
        cell.telLabel?.text = "\(tel)"
        let qq = rowData["qq"] as String
        cell.qqLabel?.text = "\(qq)"
        cell.vipInfoLabel?.text = rowData["vip_info"] as? String
        
//        let img = httpRequest.getImageSync(rowData["img"] as String)
//        cell.cmImageView?.image = img
        
        let imageTag = indexPath.row + 1
        cell.cmImageView.tag = imageTag
        httpRequest.getImageAsync(rowData["img"] as String, tag: imageTag)
        
        
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
        self.cmOfDepartmentTable.reloadData()
        
        let frameUtilsObj = FrameUtils()
        let tableInitHeight = CGFloat(90)
        let desTextInitHeight = CGFloat(85)
        
        let frameHeight = self.view.frame.height
        let frameWidth = self.view.frame.width
        let tableHeight = self.cmOfDepartmentTable.contentSize.height
        let tableWidth = self.cmOfDepartmentTable.contentSize.width
        
        var cmTitleAndTableHeight = 0
        if(self.cmObjs.count == 0){
            self.labelCmTitle.hidden = true
            self.cmOfDepartmentTable.hidden = true
            cmTitleAndTableHeight = 140
            frameUtilsObj.setFrameY(self.labelDesTtile, offsetY: self.labelDesTtile.frame.origin.y - CGFloat(cmTitleAndTableHeight))
            frameUtilsObj.setFrameY(self.textDes, offsetY: self.textDes.frame.origin.y - CGFloat(cmTitleAndTableHeight))
        }else{
            self.cmOfDepartmentTable.hidden = false
            self.labelCmTitle.hidden = false
            frameUtilsObj.setFrameY(self.labelDesTtile, offsetY: self.labelDesTtile.frame.origin.y + tableHeight - tableInitHeight - CGFloat(cmTitleAndTableHeight))
            frameUtilsObj.setFrameY(self.textDes, offsetY: self.textDes.frame.origin.y + tableHeight - tableInitHeight - CGFloat(cmTitleAndTableHeight))
        }
        
        var scrollHeight = frameHeight + tableHeight - tableInitHeight + self.textDes.contentSize.height - desTextInitHeight
        self.cmSrollView.contentSize = CGSize(width: frameWidth, height: scrollHeight)
        
        frameUtilsObj.setFrameSize(self.cmOfDepartmentTable, width: tableWidth, height: tableHeight)
        frameUtilsObj.setFrameSize(self.textDes, width: self.textDes.contentSize.width, height: self.textDes.contentSize.height)
        
//        println(tableHeight)
//        println(self.labelDesTtile)
//        println(self.textDes)
    }
    
    func showImage(img:UIImage, tag:Int){
        let imageView = self.view.viewWithTag(tag) as UIImageView
        imageView.image = img
    }
    
}