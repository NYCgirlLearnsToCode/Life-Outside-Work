//
//  SelectCategoryView.swift
//  Life after work
//
//  Created by Lisa J on 10/3/24.
//

import UIKit

protocol SaveCategoryDelegate: AnyObject {
    func saveSelectedCategories()
}

class SelectCategoryView: UIView {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectCategoryTableview: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: SaveCategoryDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        // Custom setup code, e.g. setting background color
        self.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1.0)
        
        //tableview set up
        selectCategoryTableview.estimatedRowHeight = 44
        selectCategoryTableview.rowHeight = UITableView.automaticDimension
    }
    @IBAction func saveSelectedCategories(_ sender: UIButton) {
        self.delegate?.saveSelectedCategories()
    }
}
