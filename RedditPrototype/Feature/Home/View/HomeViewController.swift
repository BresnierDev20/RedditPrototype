//
//  HomeViewController.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        settingTableView()
        settingsNavBar()
        loadInitialData()
    }
        
     func configSearch() {
        if let text = searchTextField?.text?.lowercased() {
            viewModel.redditDt.removeAll()
            CustomLoader.shared.showLoader()
         
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.getReddit(query: text)
            }
        }
    }
    
    func settingTableView() {
        homeTableView.register(UINib(nibName: viewModel.cellNibName, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.estimatedRowHeight = 100
    }
  
    func loadInitialData() {
        CustomLoader.shared.showLoader()
        
        if !Helper.getUserToken().isEmpty {
            getReddit(query: "venezuela")
        }else {
            getAccessToken()
        }
    }
    
    func getReddit(query: String) {
        viewModel.getRedditTop(query: query)
            .sink(receiveCompletion: { [weak self] completion in
              guard let self = self else { return }
               
              switch completion {
              case .finished:
                break
              case .failure(let error):
                  CustomLoader.shared.hideLoader()
                  self.viewModel.redditDt.removeAll()
                 
                  handleMyOrdersError(error: error)
                 
              }
            },receiveValue: { [weak self] result in
              guard let self = self else { return }
                self.viewModel.redditDt = result.data.children
                CustomLoader.shared.hideLoader()
                
                self.homeTableView.reloadData()
    
            }).store(in: &viewModel.disposables)
    }
    
    func getAccessToken() {
        viewModel.accessToken()
            .sink(receiveCompletion: { [weak self] completion in
              guard let self = self else { return }
               
              switch completion {
              case .finished:
                  break
              case .failure(let error):
                  handleMyOrdersError(error: error)
              }
            },receiveValue: { [weak self] result in
              guard let self = self else { return }
                Helper.setUserToken(result.access_token)
    
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.getReddit(query: "venezuela")
                }
            }).store(in: &viewModel.disposables)
    }
    
    func handleMyOrdersError(error: RemoteError) {
      switch error {
      case .apiError(let statusCode, _):
        if statusCode == 401 {
            getAccessToken()
        }else {
            mostrarAlerta(messages: "Problema en la busquedad")
        }
      case .decodingError(let decodingError):
          mostrarAlerta(messages: "Problema en el servicio")
        
      case .networkError(let error):
          mostrarAlerta(messages: "Problema en el Internet")
         
      }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.redditDt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as? HomeTableViewCell else { fatalError() }
        let homeDt = viewModel.redditDt[indexPath.row]
        
        cell.configUI(response: homeDt)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = DetailViewController()
        viewCtrl.detailDt = viewModel.redditDt[indexPath.row]
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        configSearch()
        view.endEditing(true)
        return false
    }
}
