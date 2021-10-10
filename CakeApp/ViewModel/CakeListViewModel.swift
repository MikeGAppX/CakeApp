//
//  CakeListViewModel.swift
//  CakeApp
//
//  Created by Mikael Galliot on 10/10/2021.
//

import Foundation

protocol CakeListViewModelType {
    var itemCount: Int {get}
    func fetchCakes()
    func getCakes(for row:Int)-> CakeDetails
    
}

struct CakeDetails {
    let title: String
    let desc: String
    let image: String
}

class CakeListViewModel: CakeListViewModelType {
    
    weak private var delegate:CakeListViewType!
    let service:Service!
    
    private var cakes:[Cake]?
    
    var itemCount: Int {
        return cakes?.count ?? 0
    }
    
    init(delegate:CakeListViewType,
         service:Service = ServiceImpl()) {
        self.delegate = delegate
        self.service = service
    }
    
    /*
     this method connect calls rest API to get data
     */
    func fetchCakes() {
        let client = ServiceClient(baseUrl:EndPoints.baseUrl.rawValue, path:Path.cakeList.rawValue, params:"", method:"get")
        
        service.fetchData(client:client, type:Cake.self) { [weak self] (result)  in
            switch result {
            case .success(let result):
                self?.cakes = result
                DispatchQueue.main.async {
                    self?.delegate?.updateUI()
                }
            case .failure(_):
                self?.cakes = nil
                DispatchQueue.main.async {
                    self?.delegate?.showError()
                }
            }
        }
    }
    
    
    func getCakes(for row: Int) -> CakeDetails {
        guard let _cakes = cakes,  _cakes.count >= row , row >= 0 else {
            return CakeDetails(title:"", desc:"", image: "")
        }
        let cake = _cakes[row]
        return CakeDetails(title: cake.title, desc: cake.desc, image: cake.image)
    }
}
