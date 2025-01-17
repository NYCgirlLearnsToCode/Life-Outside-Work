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
        selectedCategories = CategoryPersistenceHelper.manager.loadData()?.elements ?? [Category]()
        
        // the expected categories are here
        print(selectedCategories)

        self.selectedCategoriesView.tableView.dataSource = self
        self.selectedCategoriesView.tableView.delegate = self
        
        self.view.backgroundColor = UIColor.green
        setupSelectedCategoriesView()
    }

    private func setupSelectedCategoriesView() {
        self.view.addSubview(selectedCategoriesView)
        selectedCategoriesView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            selectedCategoriesView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            selectedCategoriesView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            selectedCategoriesView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            selectedCategoriesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // need to constrain tableview - not self sizing, cells are self sizing
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedCategories.count)
        return selectedCategories.count
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
