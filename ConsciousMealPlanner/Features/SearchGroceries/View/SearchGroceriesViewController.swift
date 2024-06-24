//
//  AddProductsViewController.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 23/06/24.
//

import UIKit
import Combine

final class SearchGroceriesViewController: UIViewController {
        
    @IBOutlet private weak var searchResultsTableView: UITableView!
    private let searchController = UISearchController()

    private let subject = PassthroughSubject<String, Never>()
    private var cancellable: [AnyCancellable] = []
    
    let viewModel = SearchGroceriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        viewModel.searchResultUpdater = self
        
        //configure navigation bar title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        // configure searchcontroller
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.textColor = UIColor.white
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        //configure tableview
        searchResultsTableView.register(ProductDetailCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension SearchGroceriesViewController: SearchGroceriesResultUpdater {
    
    func updateView(with model: [Product]) {
        DispatchQueue.main.async { [weak self] in
            self?.searchResultsTableView.dataSource = self
            self?.searchResultsTableView.delegate = self
        }
    }
    
    func updateView(with error: ServiceError) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Search Result", message: "No result found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension SearchGroceriesViewController: UISearchResultsUpdating,
                                         UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, 
                !searchText.isEmpty else { return }
        subject
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .print()
            .sink { [weak self] searchText in
                self?.viewModel.fetchMatchingGroceryItem(for: searchText)
            }
            .store(in: &cancellable)
        subject.send(searchText)
    }
    
}

extension SearchGroceriesViewController: UITableViewDelegate,
                                         UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductDetailCell
        cell.updateView(with: viewModel.products[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.products.count }
}
