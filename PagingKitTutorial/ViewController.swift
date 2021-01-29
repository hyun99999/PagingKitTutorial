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
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
          let vc = UIViewController()
           vc.view.backgroundColor = color
           return vc
       }
       
       var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //nib 파일로 menucell 을 만듦.
//        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        //nib 파일말고도 코드로 만들 수 있다. 이미 만들어둔 titleLabelMenuViewCell 을 사용.
        menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier:"titleLabelMenuCell")
        
//        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        menuViewController.registerFocusView(view: UnderlineFocusView())
        
        menuViewController.cellAlignment = .center
        
        menuViewController.reloadData()
        contentViewController.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? PagingMenuViewController {
               menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
           } else if let vc = segue.destination as? PagingContentViewController {
               contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
           }
    }
}
//메뉴 데이터 소스
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
//        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "titleLabelMenuCell", for: index) as! TitleLabelMenuViewCell
        
        cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }
}

extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

//컨텐트 데이터 소스
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
}
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
