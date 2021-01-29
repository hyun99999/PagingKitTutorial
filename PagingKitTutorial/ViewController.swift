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
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? PagingMenuViewController {
               menuViewController = vc
           } else if let vc = segue.destination as? PagingContentViewController {
               contentViewController = vc
           }
       }

}

