//
//  DepartmentDetailController.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-10-9.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit

class DepartmentDetailController: UIViewController {
    @IBOutlet weak var labelDepartmentName: UILabel!
    @IBOutlet weak var imageViewDepartment: UIImageView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelTel: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var textDes: UITextView!
    
    
    var img:UIImage!
    var departmentObj:NSDictionary?
    var httpRequest = HttpRequest()
    
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
        
//        NSAttributedString *normal = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        
        textDes.attributedText = des

        var navButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: NSSelectorFromString("backToDepartmentList:"))
        self.navigationItem.setLeftBarButtonItem(navButtonItem, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func backToDepartmentList(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
}