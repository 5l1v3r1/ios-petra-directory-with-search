//
//  ViewController.swift
//  PetraDirectory
//
//  Created by Justinus Andjarwirawan on 10/1/15.
//  Copyright © 2015 Petra Christian University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userName:[String] = []
    var realName:[String] = []
    var otherInfo: [String] = []

    @IBOutlet weak var waiting: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var selectSegment: UISegmentedControl!
    @IBAction func searchButton(_ sender: AnyObject) {
        //need to check searchField for funny characters that cause freeze
        var teks = String(describing: searchField.text)
        let customAllowedSet =  CharacterSet(charactersIn:" +.=\"#%/<>?@\\^`{|}&!`~*").inverted
        teks = (searchField.text?.addingPercentEncoding(withAllowedCharacters: customAllowedSet))!
        print(teks)
//        if let a = searchField.text {
//            print(a)
//            if String(UTF8String: a) == nil {
//                alertMe()
//            }
//        }
        self.waiting.isHidden = false
        self.waiting.startAnimating()
        DismissKeyboard()
        var myURL: NSURL
        if selectSegment.selectedSegmentIndex == 0 {
            myURL = NSURL(string: "http://peter.petra.ac.id/~justin/finger.php?s=\(teks)")!
        } else {
            myURL = NSURL(string: "http://john.petra.ac.id/~justin/finger.php?s=\(teks)")!
        }
        let sharedSession = URLSession.shared
        let downloadTask: URLSessionDownloadTask = sharedSession.downloadTask(with: myURL as URL) {
            (location, response, error) -> Void in
                let dataObject = try? Data(contentsOf: location!)
                var myDictionary: NSDictionary!
                do {
                    myDictionary = try JSONSerialization.jsonObject(with: dataObject!, options: []) as! NSDictionary
                } catch {
                    print("ada error Dictionary")
                    myDictionary = ["hasil":""] //kosongkan biar tdk error
                }
                //print(myDictionary)
                let currentDictionary = myDictionary as NSDictionary
                DispatchQueue.main.async(execute: {
                    //key value of root JSON (key is "hasil", ignored)
                    for (_,isian) in currentDictionary {
                        //check if isian is empty!
                        if let _ = isian as? NSArray {
                            //print("ok")
                        } else {
                            //print("not ok")
                            self.waiting.stopAnimating()
                            self.waiting.isHidden = true
                            self.alertMe()
                            break
                        } //end of check
                        self.userName = []
                        self.realName = []
                        self.otherInfo = []
                        for value in isian as! NSArray {
                            let a = (value as AnyObject)["login"] as! String
                            let b = (value as AnyObject)["nama"] as! String
                            let c = (value as AnyObject)["unit"] as! String
                            self.userName += ["\(a)"]
                            self.realName += ["\(b)"]
                            self.otherInfo += ["\(c)"]
                        }
                        self.waiting.stopAnimating()
                        self.waiting.isHidden = true
                        self.performSegue(withIdentifier: "toTableView", sender: self)
                    }
                }) //end of dispatch
        } //end of (location: NSURL
        downloadTask.resume()
    } //end of func searchButton
    override func viewDidLoad() {
        super.viewDidLoad()
        self.waiting.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }
    
    func alertMe() {
        let alertKu = UIAlertController(title: "Not Found", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertKu.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        present(alertKu, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let thisView = segue.destination as? TableViewController {
            if segue.identifier == "toTableView" {
                for isi in 0..<userName.count {
                    thisView.userName += ["\(userName[isi])"]
                    thisView.realName += ["\(realName[isi])"]
                    thisView.otherInfo += ["\(otherInfo[isi])"]
                }
            }
        }
    }
}

