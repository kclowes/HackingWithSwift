//
//  MasterViewController.swift
//  Project5
//
//  Created by Keri Clowes on 3/23/16.
//  Copyright © 2016 Keri Clowes. All rights reserved.
//

import UIKit
import GameKit

class MasterViewController: UITableViewController {
  var objects = [String]()
  var allWords = [String]()


  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
    if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
      if let startWords = try? String(contentsOfFile: startWordsPath, usedEncoding: nil) {
        allWords = startWords.componentsSeparatedByString("\n")
      }
    } else {
      allWords = ["silkworm"]
    }
    startGame()
  }

  func promptForAnswer() {
    let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
    ac.addTextFieldWithConfigurationHandler(nil)

    let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] _ in
      let answer = ac.textFields![0]
      self.submitAnswer(answer.text!)
    }

    ac.addAction(submitAction)
    presentViewController(ac, animated: true, completion: nil)
  }

  func submitAnswer(answer: String) {
    let lowerAnswer = answer.lowercaseString

    let errorTitle: String
    let errorMessage: String

    if wordIsLongerThanThreeChars(lowerAnswer) {
      if wordIsPossible(lowerAnswer) {
        if wordIsOriginal(lowerAnswer) {
          if wordIsReal(lowerAnswer) {
            objects.insert(answer, atIndex: 0)
              let indexPath = NSIndexPath(forRow: 0, inSection: 0)
              tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

              return
          } else {
            errorTitle = "Word Not Recognized"
            errorMessage = "You can't just make them up, you know!"
            displayError(errorTitle, errorMessage: errorMessage)
          }
        } else {
          errorTitle = "Duplicate"
          errorMessage = "You already used that one!"
          displayError(errorTitle, errorMessage: errorMessage)
        }
      } else {
        errorTitle = "Word Not Possible"
        errorMessage = "You can't spell that word from '\(title!.lowercaseString)'!"
        displayError(errorTitle, errorMessage: errorMessage)
      }
    } else {
      errorTitle = "Word Too Short"
      errorMessage = "Your word needs to be at least 3 characters!"
      displayError(errorTitle, errorMessage: errorMessage)
    }
  }

  func wordIsLongerThanThreeChars(answer: String) -> Bool {
    return answer.characters.count > 2
  }

  func displayError(errorTitle: String, errorMessage: String) {
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    presentViewController(ac, animated: true, completion: nil)
  }

  func wordIsPossible(answer: String) -> Bool {
    var tempWord = title!.lowercaseString

    for letter in answer.characters {
      if let pos = tempWord.rangeOfString(String(letter)) {
        tempWord.removeAtIndex(pos.startIndex)
      } else {
        return false
      }
    }

    return true
  }

  func wordIsOriginal(answer: String) -> Bool {
    return !objects.contains(answer)
  }

  func wordIsReal(answer: String) -> Bool {
    let checker = UITextChecker()
    let range = NSMakeRange(0, answer.characters.count)
    let misspelledRange = checker.rangeOfMisspelledWordInString(answer, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    let object = objects[indexPath.row]
    cell.textLabel!.text = object
    return cell
  }

  func startGame() {
    allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
    title = allWords[0]
    objects.removeAll(keepCapacity: true)
    tableView.reloadData()

  }

}

