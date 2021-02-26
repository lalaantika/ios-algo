//
//  WithComputerController.swift
//  TICTACTOE
//
//  Created by student on 2021-02-25.
//

import UIKit

class WithComputerController: UIViewController {
    
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    @IBOutlet var userMessage: UILabel!
    @IBOutlet var resetBtn: UIButton!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func UIButtonClicked(_ sender: UIButton) {
        userMessage.isHidden = true
        if (plays[sender.tag] == nil) && !aiDeciding && !done{
            setImageForSpot(spot: sender.tag, player:1)
        }
        checkForWin()
        aiTurn()
    }
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        done = false
        resetBtn.isHidden = true
        userMessage.isHidden = true
        reset()
    }
    
    func setImageForSpot(spot:Int, player:Int){
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacBtn1.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 2:
            ticTacBtn2.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 3:
            ticTacBtn3.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 4:
            ticTacBtn4.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 5:
            ticTacBtn5.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 6:
            ticTacBtn6.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 7:
            ticTacBtn7.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 8:
            ticTacBtn8.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        case 9:
            ticTacBtn9.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        default:
            ticTacBtn5.setBackgroundImage( UIImage(named: playerMark), for: UIControl.State.normal)
        }
    }
    
    func checkForWin(){
        let whoWon = ["I":0, "you":1]
        for(key,value) in whoWon{
            if ((plays[7] == value && plays[8] == value && plays[9] == value ) ||  //across the bottom
                    (plays[4] == value && plays[5] == value && plays[6] == value ) || //across the middle
                    (plays[1] == value && plays[2] == value && plays[3] == value ) || //across the top
                    (plays[1] == value && plays[4] == value && plays[7] == value ) || //down to left
                    (plays[2] == value && plays[5] == value && plays[8] == value ) || //down to middle
                    (plays[9] == value && plays[6] == value && plays[3] == value ) || //down to right
                    (plays[1] == value && plays[5] == value && plays[9] == value ) || //diag left right
                    (plays[3] == value && plays[5] == value && plays[7] == value )) //diag right to left
            {
                userMessage.isHidden = false
                userMessage.text = "Looks like \(key) won!"
                resetBtn.isHidden = false
                done = true
            }
        }
    }
    
    func checkBottom(value:Int)-> (location:String,pattern:String){
        return ("bottom",checkFor(value: value, inList:[7,8,9]))
    }
    
    func checkTop(value:Int)-> (location:String,pattern:String){
        return ("top",checkFor(value: value, inList:[1,2,3]))
    }
    
    func checkMiddleAcross(value:Int)-> (location:String,pattern:String){
        return ("middleHorz",checkFor(value: value, inList:[4,5,6]))
    }
    
    func checkLeft(value:Int)-> (location:String,pattern:String){
        return ("left",checkFor(value: value, inList:[1,4,7]))
    }
    
    func checkRight(value:Int)-> (location:String,pattern:String){
        return ("right",checkFor(value: value, inList:[9,6,3]))
    }
    
    func checkMiddleDown(value:Int)-> (location:String,pattern:String){
        return ("middleVert",checkFor(value: value, inList:[2,5,8]))
    }
    
    func checkDiagLeftRight(value:Int)-> (location:String,pattern:String){
        return ("diagLeftRight",checkFor(value: value, inList:[1,5,9]))
    }
    
    func checkDiagRightLeft(value:Int)-> (location:String,pattern:String){
        return ("diagRightLeft",checkFor(value: value, inList:[3,5,7]))
    }
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in  inList {
            if plays[cell] == value{
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(value:Int)->(location:String,pattern:String)?{
        let acceptableFinds = ["011", "110", "101"]
        let findFuncs = [checkTop, checkBottom ,checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs{
            let algorithmResults = algorithm(value)
            if acceptableFinds.contains(algorithmResults.pattern){
                return algorithmResults
            }
        }
        return nil
    }
    
    
    func isOccupied(spot:Int) -> Bool{
        if plays[spot] == nil{
            return false
        }
        else{
            return true
        }
    }
    
    func aiTurn(){
        if done{
            return
        }
        aiDeciding = true
        if let result = rowCheck(value:0){
            let whereToPlayResult = whereToPlay(location: result.location, pattern: result.pattern)
            if !isOccupied(spot: whereToPlayResult){
                setImageForSpot(spot: whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        if let result = rowCheck(value:1){
            let whereToPlayResult = whereToPlay(location: result.location, pattern: result.pattern)
            if !isOccupied(spot: whereToPlayResult){
                setImageForSpot(spot: whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        if !isOccupied(spot: 5){
            setImageForSpot(spot: 5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        func firstAvailable(isCorner:Bool)-> Int? {
            let spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot: spot){
                    return spot
                }
            }
            return nil
        }
        if let cornerAvailable = firstAvailable(isCorner: true){
            setImageForSpot(spot: cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        if let sideAvailable = firstAvailable(isCorner: false){
            setImageForSpot(spot: sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        userMessage.isHidden = false
        userMessage.text = "Looks Like its a Draw"
        reset()
        aiDeciding = false
    }
    
    func reset(){
        plays = [:]
        ticTacBtn1.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn2.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn3.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn4.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn5.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn6.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn7.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn8.setBackgroundImage(nil, for: UIControl.State())
        ticTacBtn9.setBackgroundImage(nil, for: UIControl.State())
    }
    
    func whereToPlay(location:String, pattern: String)-> Int {
        let leftPattern = "011"
        let rightPattern = "110"
        _ = "101"
        switch location {
        case "top":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 3
            }else {
                return 2
            }
        case "bottom":
            if pattern == leftPattern{
                return 7
            }else if pattern == rightPattern{
                return 9
            }else {
                return 8
            }
            
        case "left":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 7
            }else {
                return 4
            }
        case "right":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 9
            }else {
                return 6
            }
        case "middleVert":
            if pattern == leftPattern{
                return 2
            }else if pattern == rightPattern{
                return 8
            }else {
                return 5
            }
        case "middleHorz":
            if pattern == leftPattern{
                return 4
            }else if pattern == rightPattern{
                return 6
            }else {
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 7
            }else {
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 9
            }else {
                return 5
            }
        default: return 4
        }
    }
}
