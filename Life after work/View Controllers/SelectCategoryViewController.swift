//
//  ViewController.swift
//  Life after work
//
//  Created by Lisa J on 10/3/24.
//

import UIKit
import AVFoundation

class SelectCategoryViewController: UIViewController, SaveCategoryDelegate {

    @IBOutlet var selectCategoryView: SelectCategoryView!
    
    var categoriesViewModel = CategoriesViewModel()
    var selectedCategories = [Category]()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - temporary for testing, remove
        CategoryPersistenceHelper.manager.deleteItems()
        print("loading data \(CategoryPersistenceHelper.manager.loadData())")
        selectCategoryView.selectCategoryTableview.delegate = self
        selectCategoryView.selectCategoryTableview.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        selectCategoryView.delegate = self
        selectCategoryView.selectCategoryTableview.dataSource = self
        selectCategoryView.setupView()
    }
    
    func saveSelectedCategories() {
        for row in 0..<selectCategoryView.selectCategoryTableview.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            
            if let cell = selectCategoryView.selectCategoryTableview.cellForRow(at: indexPath) {
                if cell.accessoryType == .checkmark {
                    let category = categoriesViewModel.categories[indexPath.row]
                    selectedCategories.append(category)
                }
            }
        }
        
        if selectedCategories.isEmpty {
            let alert = UIAlertController(title: "No categories selected", message: "Please select some categories :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let saveData = SaveData(elements: selectedCategories, lastSavedDate: Date.now)
        CategoryPersistenceHelper.manager.saveJson(saveData:saveData, completion: {
            // TODO: navigate to vc with selected categories or refresh the tableview with the selected categories
            // once successfully saved, navigate to viewcontroller displaying the list of selected categories
            // dismiss select category vc
            let selectedCategoriesVC = SelectedCategoriesViewController()
            if let navController = self.navigationController {
                navController.pushViewController(selectedCategoriesVC, animated: true)
                playSound(name: "twinkle")
                print("done pushing")
            } else {
                print("this vc is not embedded in a nav controller")
            }
        }, onFailure: {
            print("couldn't save")
        })
    }
    
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        // Toggle the selection state in the data model
        categoriesViewModel.categories[indexPath.row].isSelected.toggle()

        if categoriesViewModel.categories[indexPath.row].isSelected {
            cell.accessoryType = .checkmark
            // add audio
            playSound(name: "sparkle")
        } else {
            cell.accessoryType = .none
        }
    }
}

extension SelectCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categoriesViewModel.categories[indexPath.row]
        cell.categoryLabel.text = category.name
        cell.iconImageView.image = UIImage(systemName: category.icon)

        return cell
    }
}

