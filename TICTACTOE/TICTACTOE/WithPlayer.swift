//
//  WithPlayer.swift
//  TICTACTOE
//
//  Created by student on 2021-02-25.
//

import UIKit

class WithPlayer: UIViewController {
    
    var activePlayer = 1//Cross
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winningcombination = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8],[2,4,6]]
    var gameIsActive = true
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func Action(_ sender: Any) {
        
        if(gameState[(sender as AnyObject).tag-1]==0){
            
            gameState[(sender as AnyObject).tag-1] = activePlayer
            
            if (activePlayer == 1)
            {
                (sender as AnyObject).setBackgroundImage( UIImage(named: "x"), for:UIControl.State())
                activePlayer = 2
            }else{
                (sender as AnyObject).setBackgroundImage( UIImage(named: "o"), for:UIControl.State())
                activePlayer = 1
            }
        }
        for combination in winningcombination{
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                gameIsActive = false
                if gameState[combination[0]] == 1 {
                    print("Cross")
                    label.text = "Cross has won"
                }else{
                    print("nought")
                    label.text = "Naught has won"
                }
                playAgainButton.isHidden = false
                label.isHidden = false
            }
        }
        gameIsActive = false
        for i  in gameState{
            if  i == 0{
                gameIsActive = true
                break
            }
        }
        if gameIsActive == false{
            label.text =   "It was a draw"
            label.isHidden = false
            playAgainButton.isHidden = false
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        gameState = [0,0,0,0,0,0,0,0,0]
        gameIsActive = true
        activePlayer = 1
        playAgainButton.isHidden = true
        label.isHidden = true
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setBackgroundImage( nil, for:UIControl.State())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
