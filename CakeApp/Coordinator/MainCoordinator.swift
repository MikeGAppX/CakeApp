//
//  MainCoordinator.swift
//  CakeApp
//
//  Created by Mikael Galliot on 10/10/2021.
//

import UIKit

protocol Coordinator:AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    
}


class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard  let vc =  UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier:"CakeListViewController") as? CakeListViewController else {
            return
        }
        vc.coordinator = self
        vc.viewModel = CakeListViewModel(delegate:vc as! CakeListViewType)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    
}
