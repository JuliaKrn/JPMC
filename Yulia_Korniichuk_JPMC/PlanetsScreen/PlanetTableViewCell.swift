//
//  PlanetTableViewCell.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
import UIKit

final class PlanetTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let smallPadding: CGFloat = 4.0
    static let standardSmallPadding: CGFloat = 8.0
    static let standardLargePadding: CGFloat = 20.0
  }
  
  // MARK: Properties
  static let reuseIdentifier = "PlanetTableViewCell"
  
  private var infoView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10.0
    view.layer.borderColor = UIColor.systemYellow.cgColor
    view.layer.borderWidth = 2
    view.backgroundColor = .systemYellow.withAlphaComponent(0.2)
    return view
  }()
  
  private var nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .systemYellow
    label.font = .boldSystemFont(ofSize: 20.0)
    return label
  }()
  
  private var populationLable: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 15.0)
    return label
  }()
  
  private var terrainLable: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .left
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 15.0)
    return label
  }()
  
  // MARK: Public Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func prepareForReuse() {
    nameLabel.text = ""
    populationLable.text = ""
  }
  
  func configure(name: String, population: String, terrain: String) {
    nameLabel.text = name
    populationLable.text = String(
      format: NSLocalizedString("planet_population_label", comment: ""),
      population)
    terrainLable.text = String(
      format: NSLocalizedString("planet_terrain_label", comment: ""),
      terrain)
  }
  
  // MARK: Private Methods
  private func setupLayout() {
    backgroundColor = .clear
    contentView.clipsToBounds = true
    selectionStyle = .none
    
    setupInfoView()
  }
  
  private func setupInfoView() {
    [infoView, nameLabel, populationLable, terrainLable].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    contentView.addSubview(infoView)
    infoView.addSubview(nameLabel)
    infoView.addSubview(populationLable)
    infoView.addSubview(terrainLable)
    
    NSLayoutConstraint.activate([
      infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallPadding),
      infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallPadding),
      infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: Constants.standardLargePadding),
      nameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -Constants.standardLargePadding),
      nameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: Constants.standardLargePadding),
      
      populationLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.standardSmallPadding),
      populationLable.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -Constants.standardLargePadding),
      populationLable.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: Constants.standardLargePadding),
      
      terrainLable.topAnchor.constraint(equalTo: populationLable.bottomAnchor, constant: Constants.standardSmallPadding),
      terrainLable.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -Constants.standardLargePadding),
      terrainLable.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -Constants.standardLargePadding),
      terrainLable.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: Constants.standardLargePadding)
    ])
  }
}


import SwiftUI

struct PlanetTableViewCell_Previews: PreviewProvider {

  static var previews: some View {
    VStack {
      DebugPreviewView {
        let cell = PlanetTableViewCell()
        cell.configure(
          name: "Tatooine",
          population: "10000",
          terrain: "desert")
        return cell
      }
      .frame(width: 300, height: 124)

      DebugPreviewView {
        let cell = PlanetTableViewCell()
        cell.configure(
          name: "Alderaan",
          population: "2000000000",
          terrain: "grasslands, mountains")
        return cell
      }
      .frame(width: 300, height: 124)

      Spacer()
      .frame(width: 450)
    }
    .background(Color.black)
  }
}

struct DebugPreviewView<T: UIView>: UIViewRepresentable {
  let view: UIView

  init(_ builder: @escaping () -> T) {
    view = builder()
  }

  // MARK: - UIViewRepresentable
  func makeUIView(context: Context) -> UIView {
    return view
  }

  func updateUIView(_ view: UIView, context: Context) {
    // To fit the view to the smallest possible size
    view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
}
