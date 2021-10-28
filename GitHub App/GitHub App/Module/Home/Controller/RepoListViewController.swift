//
//  ViewController.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 26/10/21.
//

import UIKit

class RepoListViewController: UIViewController {
    
    
    private let repoDetailsSegue = "RepoDetailsScreenSegue"
    private let CELL_INSET:CGFloat = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchController:UISearchController!
    private var popup = PopupView()
    private var loadingIndicator = LoadingIndicator()
    
    private var repoListViewModel = RepoListViewModel()
    private var selectedLanguage = "swift"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        bindViewModel()
        setupSearchView()
        setupPopup()
        fetchRepoList(language:selectedLanguage)
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        popup.show()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? RepoDetailViewController, let repoInfo = sender as? RepoInfo{
            
            controller.repoInfo = repoInfo
        }
    }
}


extension RepoListViewController{
    
    private func setupSearchView(){
        
        searchController = UISearchController(searchResultsController:nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter programing language"
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    private func setupPopup(){
        
        popup =  popup.initWithView(view:self.view)
        let arr = [SortType(name:"Stars", isSelected:true),SortType(name:"Forks"),SortType(name:"Updated_At")];
        popup.setupDataSource(datasoure:arr)
        popup.delegate = self
        self.view.addSubview(popup)
    }
    
    private func setupLoadingIndicator(){
        
        loadingIndicator = loadingIndicator.initWithView(view:self.view)
        self.view.addSubview(loadingIndicator)
    }
    
    private func dismissSarchBar(){
        self.searchController.dismiss(animated:true, completion:nil)
        self.view.layoutIfNeeded()
    }
}

extension RepoListViewController{
    
    private func bindViewModel(){
        
        repoListViewModel.repoList.bind { [weak self] (repoList) in
            
            
            self?.collectionView.reloadData()
        }
        
        repoListViewModel.failure.bind {[weak self] (msg) in
            
            guard let message = msg else{
                return
            }
            
            self?.showAlert(message:message)
            
        }
        
        repoListViewModel.apiLoadingStatus.bind { [weak self](status) in
            
            if status == true{
                self?.loadingIndicator.startAnimation()
            }else{
                self?.loadingIndicator.stopAnimation()
            }
        }
        
    }
}

extension RepoListViewController{
    
    private func fetchRepoList(language:String,sortType:String = "stars"){
        repoListViewModel.query(for:language, sortType:sortType)
    }
}

extension RepoListViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.repoListViewModel.repoList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let repoListCell = collectionView.dequeueReusableCell(withReuseIdentifier:RepoListCollectionViewCell.identifier, for:indexPath) as! RepoListCollectionViewCell
        repoListCell.setupView(repo:self.repoListViewModel.repoList.value[indexPath.row])
        return repoListCell
        
    }
    
}

extension RepoListViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let repo = self.repoListViewModel.repoList.value[indexPath.row]
        self.performSegue(withIdentifier:repoDetailsSegue, sender:repo)
    }
}

extension RepoListViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * CELL_INSET))/2, height:280)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return CELL_INSET
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        let sectionInset = UIEdgeInsets(top: CELL_INSET, left: CELL_INSET, bottom: CELL_INSET, right: CELL_INSET)
        return sectionInset
    }
}


extension RepoListViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else{
            return
        }
        let  strippedString = text.trimmingCharacters(in:.whitespacesAndNewlines)
        dismissSarchBar()
        if strippedString.count > 0{
            selectedLanguage = text.lowercased()
            fetchRepoList(language:selectedLanguage)
        }
    }
}

extension RepoListViewController:PopupViewProtocol{
    
    func didSelectSortType(popupView: PopupView, type: SortType) {
        
        guard let sortStr = type.name else{
            return
        }
        fetchRepoList(language:selectedLanguage,sortType:sortStr.lowercased())
    }
}

extension RepoListViewController{
    
    private func showAlert(message:String){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"", message:message, preferredStyle:.alert)
            let okayAction = UIAlertAction(title:"OK", style:.default) { (action) in
                alertController.dismiss(animated:true, completion: nil)
            }
            alertController.addAction(okayAction)
            self.present(alertController, animated:true, completion: nil)
        }
        
        
    }
}
