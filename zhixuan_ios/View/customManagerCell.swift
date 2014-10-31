//
//  customManagerCell.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14/10/21.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit


class CustomManagerCell: UITableViewCell {
    //客户经理表格自定义
    @IBOutlet weak var cmImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telButton: UIButton!
//    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var qqLabel: UILabel!
    @IBOutlet weak var vipInfoLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
}


class CustomManagerOfDepartmentCell: UITableViewCell {
    //营业部客户经理表格自定义
    @IBOutlet weak var cmImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var telButton: UIButton!
    @IBOutlet weak var qqLabel: UILabel!
    @IBOutlet weak var vipInfoLabel: UILabel!
    
}
