//
//  SelectedCategoriesViewController.swift
//  Life after work
//
//  Created by Lisa J on 11/26/24.
//

import UIKit

class SelectedCategoriesViewController: UIViewController {
    
    let selectedCategoriesView = SelectedCategoriesView()
    var selectedCategories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCategories = CategoryPersistenceHelper.manager.getItems() ?? [Category]()

        self.selectedCategoriesView.tableView.dataSource = self
        self.selectedCategoriesView.tableView.delegate = self

        setupSelectedCategoriesView()
    }

    private func setupSelectedCategoriesView() {
        self.view.addSubview(selectedCategoriesView)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SelectedCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = selectedCategories[indexPath.row]
        // TODO: Selected category enums are saved but the string counterparts are not, revisit this as currently the indexpath is used to reference the category
        //debug here incorrect categories shown
        cell.categoryLabel.text = category.name
        cell.iconImageView.image = UIImage(systemName: category.icon)

        return cell
    }
}

extension SelectedCategoriesViewController: UITableViewDelegate {
    
}
