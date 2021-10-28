//
//  PopupView.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//

import UIKit

protocol PopupViewProtocol:class {
    
    func didSelectSortType(popupView:PopupView,type:SortType)
}

class PopupView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popupView: UIView!
    private var dataSource = [SortType]()
    private var selectedIndexPath:IndexPath?
    weak var delegate:PopupViewProtocol?
    
    func initWithView(view:UIView)->PopupView{
        
        let popup = Bundle.main.loadNibNamed("PopupView", owner:self, options:nil)?.first as! PopupView
        popup.center = view.center
        popup.frame = view.frame
        popup.setupUI()
        popup.setupTableView()
        popup.hide()
        return popup
    }
    
    private func setupTableView(){
        
        registerTableViewCell()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    private func setupUI(){
        
        popupView.makeRoundCorner(radius:10.0)
    }
    
    private func registerTableViewCell(){
        
        tableView.register(UINib(nibName:"SuggestionTableViewCell", bundle:nil), forCellReuseIdentifier:SUGGESTION_CELL)
    }
    
    func setupDataSource(datasoure:[SortType]){
        
        dataSource = datasoure
    }
    
    
    func show(){
        self.isHidden = false
    }
    
    func hide(){
        self.isHidden = true
    }
    
}

extension PopupView:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SuggestionTableViewCell = tableView.dequeueReusableCell(withIdentifier:SUGGESTION_CELL, for:indexPath) as! SuggestionTableViewCell
        
        let data = dataSource[indexPath.row]
        if  data.isSelected == true {
            
            cell.accessoryType = .checkmark
            cell.tintColor = .green
            selectedIndexPath = indexPath
        }else{
            cell.accessoryType = .none
        }
        cell.setupView(str:data.name ?? "")
        return cell
    }
    
    
}

extension PopupView:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = selectedIndexPath {
            resetSelectedSortType(indexPath:indexPath)
        }
        
        setSelectSortType(indexPath: indexPath)
        hide()
        self.delegate?.didSelectSortType(popupView:self, type:dataSource[indexPath.row])
    }
}

extension PopupView{
    
    private func setSelectSortType(indexPath:IndexPath){
        
        dataSource[indexPath.row].isSelected = true
        tableView.reloadRows(at:[indexPath], with:.none)
    }
    
    private func resetSelectedSortType(indexPath:IndexPath){
        
        dataSource[indexPath.row].isSelected = false
        tableView.reloadRows(at:[indexPath], with:.none)
    }
}

