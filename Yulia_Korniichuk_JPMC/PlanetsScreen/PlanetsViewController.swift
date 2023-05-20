//
//  PlanetsViewController.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
import UIKit

final class PlanetsViewController: UIViewController {
  
  var viewModel: PlanetsViewModelProtocol
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorColor = .clear
    tableView.backgroundColor = .clear
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(PlanetTableViewCell.self, forCellReuseIdentifier: PlanetTableViewCell.reuseIdentifier)
    return tableView
  }()
  
  private lazy var activityIndicator = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .systemYellow
    return activityIndicator
  }()
  
  // MARK: - Init
  
  required init(viewModel: PlanetsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
    navigationItem.title = NSLocalizedString("planets_screen_title", comment: "")
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator.startAnimating()
    viewModel.loadPlanets()
    
    viewModel.updatePlanets = { [weak self] in
      DispatchQueue.main.async {
        self?.activityIndicator.stopAnimating()
        self?.tableView.reloadData()
      }
    }
    
    viewModel.errorLoadingPlanets = { [weak self] in
      DispatchQueue.main.async {
        self?.activityIndicator.stopAnimating()
        self?.showErrorAlert()
      }
    }
  }
    
  private func showErrorAlert() {
    let alert = UIAlertController(
      title: NSLocalizedString("alert_title", comment: ""),
      message: NSLocalizedString("alert_message", comment: ""),
      preferredStyle: .alert)
    alert.addAction(UIAlertAction(
      title: NSLocalizedString("alert_button", comment: ""),
      style: .default))
    present(alert, animated: true)
  }
  
  private func setupLayout() {
    let bgImageView = UIImageView(image: UIImage(named: "dark_sky"))
    
    [bgImageView, tableView, activityIndicator].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
      bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.planets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: PlanetTableViewCell.reuseIdentifier,
      for: indexPath) as? PlanetTableViewCell else {
      return UITableViewCell()
    }
    
    let planet = viewModel.planets[indexPath.row]
    cell.configure(name: planet.name, population: planet.population, terrain: planet.terrain)
    return cell
  }
  
}


