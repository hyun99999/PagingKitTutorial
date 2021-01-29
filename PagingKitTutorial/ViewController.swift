//
//  ViewController.swift
//  PagingKitTutorial
//
//  Created by kimhyungyu on 2021/01/29.
//

import UIKit
import PagingKit

class ViewController: UIViewController {
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? PagingMenuViewController {
               menuViewController = vc
           } else if let vc = segue.destination as? PagingContentViewController {
               contentViewController = vc
           }
       }

}

