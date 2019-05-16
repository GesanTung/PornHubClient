//
//  HomeViewController.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gt.colorWith(hex: 0x111111)
        self.navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }


}
