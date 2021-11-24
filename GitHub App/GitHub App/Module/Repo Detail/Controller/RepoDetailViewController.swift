//
//  RepoDetailViewController.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var profileimageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDecLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var repoInfo:RepoInfo?
    var repoDetailViewModel = RepoDetailViewModel()
    var dataSource = [[Any]]()
    var loadingIndicator = LoadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        setupLoadingIndicator()
        bindRepoDetailViewModel()
        setupUI()
        configureTableView()
        addTableViewCell()
        makeApiRequest()
    }
}

extension RepoDetailViewController{
    
    private func setupProfile(){
        
        if let name = repoInfo?.name{
            repoNameLabel.text = name
        }
        
        if let des = repoInfo?.repoDescription{
            repoDecLabel.text = des
        }
        if let owner = repoInfo?.owner,let url = owner.avatar_url{
            
            downloadImage(imageUrl: url)
        }
        
    }
    
    private func setupUI(){
        
        profileimageView.makeRoundCorner(radius:profileimageView.bounds.height/2)
    }
    
    private func addTableViewCell(){
        
        tableView.register(UINib(nibName:"RepoDetailTableViewCell", bundle:nil), forCellReuseIdentifier:RepoDetailTableViewCell.identifier)
    }
    
    private func configureTableView(){
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupLoadingIndicator(){
        
        loadingIndicator = loadingIndicator.initWithView(view:self.view)
        self.view.addSubview(loadingIndicator)
    }
}

extension RepoDetailViewController{
    
    private func downloadImage(imageUrl:String){
        
        if let owner = repoInfo?.owner,let url = owner.avatar_url{
            
            profileimageView.sd_setImage(with:URL(string: url)) { [weak self](image,error,type,url) in
                
                guard let img = image else{
                    
                    return
                }
                
                self?.profileimageView.image = img
            }
        }
        
    }
}

extension RepoDetailViewController{
    
    
    private func makeApiRequest(){
        
        guard let path = repoInfo?.path else{
            return
        }
        repoDetailViewModel.makeApiRequest(for:path)
    }
    
}

extension RepoDetailViewController{
    
    private func bindRepoDetailViewModel(){
        
        repoDetailViewModel.contributorList.bind { [weak self](contributors) in
            
            guard let arr = contributors else{
                return
            }
            
            if arr.count>0{
                self?.dataSource.append(arr)
            }
            
        }
        
        repoDetailViewModel.issueList.bind { [weak self](issues) in
            
            guard let arr = issues else{
                
                return
            }
            
            if arr.count > 0{
                
                self?.dataSource.append(arr)
            }
        }
        
        repoDetailViewModel.commentsList.bind { [weak self](comments) in
            
            guard let arr = comments else{
                return
            }
            
            if arr.count>0{
                
                self?.dataSource.append(arr)
            }
        }
        
        
        repoDetailViewModel.contributorServiveFailure.bind { (msg) in
            
            guard let message = msg else{
                return
            }
            print(message)
        }
        
        repoDetailViewModel.issueServiveFailure.bind {(msg) in
            
            guard let message = msg else{
                return
            }
            print(message)
        }
        
        repoDetailViewModel.commentsServiveFailure.bind { (msg) in
            
            guard let message = msg else{
                return
            }
            
            print(message)
        }
        
        repoDetailViewModel.apiLoadingStatus.bind { [weak self](status) in
            
            if status == false{
                self?.loadingIndicator.startAnimation()
            }else{
                self?.loadingIndicator.stopAnimation()
            }
        }
        
        repoDetailViewModel.reloadStatus.bind { [weak self](status) in
            
            if status == true{
                self?.tableView.reloadData()
            }
        }
    }
}

extension RepoDetailViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier:RepoDetailTableViewCell.identifier, for:indexPath) as! RepoDetailTableViewCell
        
        let arr = dataSource[indexPath.section]
        let obj = arr[indexPath.row]
        if let wrapObj = obj as? ContributorInfo {
            detailCell.setupContributorView(contributor:wrapObj)
        }else if let wrapObj = obj as? IssueInfo {
            detailCell.setupIssueView(issue:wrapObj)
        }else if let wrapObj = obj as? CommentInfo {
            detailCell.setupCommentView(comment:wrapObj)
        }
        return detailCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let _ = dataSource[section] as? [ContributorInfo] {
            
            return "Contributors"
            
        }else if let _ = dataSource[section] as? [IssueInfo]{
            
            return "Issue List"
        }else{
            return "Comments"
        }
    }
    
}

extension RepoDetailTableViewCell:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
}
