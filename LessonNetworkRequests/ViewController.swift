//
//  ViewController.swift
//  LessonNetworkRequests
//
//  Created by Ян Таше on 10.04.2022.
//

import UIKit

enum URLExamples: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
}

enum UserActions: String, CaseIterable {
    case downloadImage = "Download image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
}

let userActions = UserActions.allCases

class ViewController: UICollectionViewController {
    
    @IBOutlet var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
            
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let userAction = userActions[indexPath.item]
        cell.titleLabel.text = userAction.rawValue
        cell.layer.cornerRadius = 10
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "toImageView", sender: nil)
        case .exampleOne: exampleOneButtonPressed()
        case .exampleTwo: exampleTwoButtonPressed()
        case .exampleThree: exampleThreeButtonPressed()
        case .exampleFour: exampleFourButtonPressed()
        case .ourCourses: performSegue(withIdentifier: "toTableView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTableView" {
            let tableVC = segue.destination as! ResultsViewController
        }
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "Success", message: "You may see the results at the Dubug area", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func failedAlert() {
        let alert = UIAlertController(title: "Failed", message: "You may see errors at the Dubug area", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 150)
    }
}

extension ViewController {
    private func exampleOneButtonPressed() {
        guard let url = URL(string: URLExamples.exampleOne.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleTwoButtonPressed() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            do {
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleThreeButtonPressed() {
        guard let url = URL(string: URLExamples.exampleThree.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            do {
                let course = try JSONDecoder().decode(Courses.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleFourButtonPressed() {
        guard let url = URL(string: URLExamples.exampleFour.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            do {
                let course = try JSONDecoder().decode(Courses.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
}

