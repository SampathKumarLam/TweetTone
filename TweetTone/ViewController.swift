//
//  ViewController.swift
//  TweetTone
//
//  Created by Sampath Kumar Lam on 17/11/24.
//

import UIKit
import Twift
import IQKeyboardManagerSwift
import CoreML

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var emojiView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputTextField: UITextField!
    
    
    let clientId = "<twitter_developer_id>"
    let clientSecret = "<twitter_developer_secret_key>"
    let callBackUri = "<twitter_callback_uri>"
    let searchEndPoint = "https://api.twitter.com/2/tweets/search/recent?query="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        // Do any additional setup after loading the view.
    }
    
    func loginUser(username: String) async {
        do {
            var oauthUser = createUser()
            oauthUser = try await Twift.Authentication().authenticateUser(clientId: clientId, redirectUri: URL(string: callBackUri)!, scope: Set(OAuth2Scope.allCases))
            let client = Twift(oauth2User: oauthUser)
            print(searchEndPoint+username)
            let results:TwitterAPIDataIncludesAndMeta =  try await client.searchRecentTweets(query: username, maxResults: 100)
            var tweets = [TweetTonerInput]()
            for i in 0..<results.data.count {
                print(tweets[i].text)
                let tweetInput = TweetTonerInput(text: results.data[i].text)
                tweets.append(tweetInput)
            }
//            guard let mlModel = try? (for: TweetToner().model) else {
            //                fatalError("Error in initiating Core ML model")
            //            }
            let toner = TweetToner()
            let tonerOutput = try toner.predictions(inputs: tweets)
            updateEmoji(impression: tonerOutput[0].label)
        }catch {
            print(error)
        }
    }
    
    func updateEmoji(impression: String) {
        switch impression {
        case "Positive":
            emojiView.image = .happyFace
            break
        case "Negative":
            emojiView.image = .sadFace
            break
        case "Neutral":
            emojiView.image = .neutralFace
        default:
            fatalError("Invalid Impression \(impression)")
        }
    }
    
    func createUser() -> OAuth2User{
        return OAuth2User(accessToken: clientSecret, scope: Set(OAuth2Scope.allCases))
    }

    @IBAction func userNameEntered(_ sender: UITextField) {
        Task { @MainActor in
            let username = sender.text ?? "@Apple"
            await loginUser(username: username)
        }
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }
    
}

