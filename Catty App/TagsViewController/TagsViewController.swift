//
//  TagsViewController.swift
//  Catty App
//
//  Created by Vladimir Alyoshkin on 17.11.21.
//

import UIKit

class TagsViewController: UIViewController {
    
    private var tags: [String] = []

    @IBOutlet weak var tableView: UITableView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
    
         load()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TagsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TagsTableViewCellIdentifier")
        
        self.navigationItem.title = "Tags"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func load() {
        guard let url = URL(string: "https://cataas.com/api/tags") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    
                let decoder = JSONDecoder()
                let object = try decoder.decode([String].self, from: data)
                    
                DispatchQueue.main.async {
                    self.tags = object.filter({ tag in
                        return tag.isEmpty == false
                    })
                    self.tableView.reloadData()
//                    tableView.reloadData()
                    }
                 } catch {
//                    fatalError()
                DispatchQueue.main.async {
//                   self.textView.text = "Can't decose data..."
                }
                    
             }
            } else {
                
//                print("Somthing went wrong...")
                DispatchQueue.main.async {
//                   self.textView.text = "Somthing went wrong..."
              }
            }
          }.resume()
        }
      }

    extension TagsViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tags.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tag = tags[indexPath.row]
        
//        let cell = UITableViewCell()
//        let label = UILabel(frame: .zero)

       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCellIdentifier", for: indexPath) as! TagsTableViewCell
        
        cell.configure(tag:tag)
        cell.configure(tag: tag)
        color(cell: cell, for: tag)
        
        return cell
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let tag = tags[indexPath.row]
            
            loadCatBy(tag: tag)
            save(tag: tag)

            let cell = self.tableView(tableView, cellForRowAt: indexPath)
            color(cell: cell, for: tag)
        }
        
        private func color(cell: UITableViewCell, for tag: String) {
            if let value = get(),value == tag {
                cell.contentView.layer.borderColor = UIColor.red.cgColor
                cell.contentView.layer.borderWidth = 2
            } else {
                cell.contentView.layer.borderColor = nil
                cell.contentView.layer.borderWidth = 0
            }
        }
        
        private func save(tag: String) {
            UserDefaults.standard.setValue(tag, forKey: "user_default_favorite_key")
        }
        
        private func get() -> String?{
            return UserDefaults.standard.value(forKey: "user_default_favorite_key") as? String
        }
        
        private func loadCatBy(tag:String) {
            guard let url = URL(string: "https://cataas.com/cat/\(tag)") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        let vc = CatDetailsViewController(nibName: nil, bundle: nil)

                        vc.configure(image: image)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    print("Please procces error!")
                }
              }.resume()
            
        }
    }

