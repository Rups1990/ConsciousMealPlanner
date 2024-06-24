//
//  ViewController.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 23/06/24.
//

import UIKit

final class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func didChangeSegment(_ sender: Any) {
    }
    
    @IBAction func didClickAddButton(_ sender: Any) {
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
