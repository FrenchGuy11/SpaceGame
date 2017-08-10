import SpriteKit



class GameScene: SKScene, SKPhysicsContactDelegate
    
{
    let bluebase = SKSpriteNode(imageNamed:"bluebase")
    let blueball = SKSpriteNode(imageNamed:"blueball")
    let bluespaceship = SKSpriteNode(imageNamed:"bluespaceship")
    
    let redbase = SKSpriteNode(imageNamed:"redbase")
    let redball = SKSpriteNode(imageNamed:"redball")
    let redspaceship = SKSpriteNode(imageNamed:"redspaceship")
    
    let bshoot = SKSpriteNode(imageNamed:"shoot")
    let rshoot = SKSpriteNode(imageNamed:"shoot")
    
    let bluelaser = SKSpriteNode(imageNamed:"bluelaser")
    let redlaser = SKSpriteNode(imageNamed:"redlaser")
    
    let background = SKSpriteNode(imageNamed: "background")
    
    let explosion = SKSpriteNode(imageNamed: "explosion")
    
    let wall = SKSpriteNode(imageNamed: "wall")
    
    var redstickActive : Bool = false
    var bluestickActive : Bool = false
    var shouldMoveRed : Bool = false
    var shouldMoveBlue : Bool = false
    var redshouldshoot : Bool = false
    var blueshouldshoot : Bool = false
    var bshootGrow : Bool = false
    var rshootGrow : Bool = false
    
    var fingerRed : Int? = nil
    var fingerBlue : Int? = nil
    
    var bshootAnim : Double? = 0
    var rshootAnim : Double? = 0
    var transparent : Double? = 1
    
    var fingers = [String?](repeating: nil, count:4)
    
    var redlasers:[SKSpriteNode] = [];
    var bluelasers:[SKSpriteNode] = [];
    var explosions:[SKSpriteNode] = [];
    var explosionTimers:[Int] = [];
    
    var redspaceshipHealth :Int = 1;
    var bluespaceshipHealth :Int = 1;
    
    func restart()
    {
        redspaceship.position = CGPoint(x: 0, y: 200)
        redspaceship.zRotation = 3.1415927
        bluespaceship.position = CGPoint(x: 0, y: -200)
        bluespaceship.zRotation = 0
        redspaceshipHealth = 1
        bluespaceshipHealth = 1
        transparent = 1
    }
    
    
    
    override func didMove(to view: SKView)
    {
        
        background.setScale(0.8)
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.addChild(redbase)
        redbase.position = CGPoint(x: 400, y: 300)
        redbase.setScale(0.16)
        redbase.zPosition = 4
        
        self.addChild(redball)
        redball.position = redbase.position
        redball.setScale(0.095)
        redball.zPosition = 5
        
        self.addChild(redspaceship)
        redspaceship.position = CGPoint(x: 0, y: 200)
        redspaceship.setScale(0.15)
        redspaceship.zPosition = 3
        redspaceship.zRotation = 3.1415927
        
        self.addChild(bluebase)
        bluebase.position = CGPoint(x: -400, y: -300)
        bluebase.setScale(0.04)
        bluebase.zPosition = 4
        
        self.addChild(blueball)
        blueball.position = bluebase.position
        blueball.setScale(0.1)
        blueball.zPosition = 5
        
        self.addChild(bluespaceship)
        bluespaceship.position = CGPoint(x: 0, y: -200)
        bluespaceship.setScale(0.06)
        bluespaceship.zPosition = 3
        
        self.addChild(bshoot)
        bshoot.position = CGPoint(x: -400, y: 0)
        bshoot.setScale(0.2)
        bshoot.zPosition = 3
        
        self.addChild(rshoot)
        rshoot.position = CGPoint(x: 400, y: 0)
        rshoot.setScale(0.2)
        rshoot.zPosition = 3
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        
    {
        
        super.touchesBegan(touches, with: event)
        
        
        
        for touch in touches
            
        {
            
            let point = touch.location(in: self)
            
            
            
            for (index,finger)  in fingers.enumerated()
                
            {
                
                if finger == nil
                    
                {
                    
                    if (bluebase.frame.contains(point) && fingerBlue == nil)
                        
                    {
                        
                        fingerBlue = index
                        
                        bluestickActive = true
                        
                    }
                        
                    else
                        
                    {
                        
                        if (fingerBlue == nil)
                            
                        {
                            
                            bluestickActive = false
                            
                        }
                        
                    }
                    
                    
                    
                    if (redbase.frame.contains(point) && fingerRed == nil)
                        
                    {
                        
                        fingerRed = index
                        
                        redstickActive = true
                        
                    }
                        
                    else
                        
                    {
                        
                        if (fingerRed == nil)
                            
                        {
                            
                            redstickActive = false
                            
                        }
                        
                    }
                    
                    
                    
                    
                    
                    if (rshoot.frame.contains(point) && index != fingerBlue && index != fingerRed)
                        
                    {
                        
                        redshouldshoot = true
                        
                        rshoot.setScale(0.15)
                        
                        rshootGrow = true
                        
                    }
                        
                    else
                        
                    {
                        
                        redshouldshoot = false
                        
                    }
                    
                    
                    
                    if (bshoot.frame.contains(point) && index != fingerBlue && index != fingerRed)
                        
                    {
                        
                        blueshouldshoot = true
                        
                        bshoot.setScale(0.15)
                        
                        bshootGrow = true
                        
                    }
                        
                    else
                        
                    {
                        
                        blueshouldshoot = false
                        
                    }
                    
                    
                    
                    fingers[index] = String(format: "%p", touch)
                    
                    print("Finger begin \(index+1): x=\(point.x) , y=\(point.y)")
                    
                    break
                    
                }
                
            }
            
        }
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
        
    {
        
        super.touchesMoved(touches, with: event)
        
        
        
        for touch in touches
            
        {
            
            let point = touch.location(in: self)
            
            
            
            for (index,finger) in fingers.enumerated()
                
            {
                
                if let finger = finger, finger == String(format: "%p", touch)
                    
                {
                    
                    if (bluestickActive)
                        
                    {
                        
                        if (index == fingerBlue)
                            
                        {
                            
                            if (sqrt(pow((point.x - bluebase.position.x), 2) + pow((point.y - bluebase.position.y), 2)) >= 250)
                                
                            {
                                
                                touchesCancelled(touches, with: event)
                                
                                break
                                
                            }
                            
                            
                            
                            let bv = CGVector(dx: point.x - bluebase.position.x, dy: point.y - bluebase.position.y)
                            
                            let bangle = atan2(bv.dy, bv.dx)
                            
                            let blength : CGFloat = bluebase.frame.size.height / 2
                            
                            let bxDist:CGFloat = sin(bangle - 1.57079633) * blength
                            
                            let byDist:CGFloat = cos(bangle - 1.57079633) * blength
                            
                            
                            
                            shouldMoveBlue = true
                            
                            
                            
                            if (bluebase.frame.contains(point))
                                
                            {
                                
                                blueball.position = point
                                
                            }
                                
                            else
                                
                            {
                                
                                blueball.position = CGPoint(x: bluebase.position.x - bxDist, y: bluebase.position.y + byDist)
                                
                                
                                
                            }
                            
                            
                            
                            bluespaceship.zRotation = bangle - 1.57079633
                            
                        }
                        
                    }
                    
                    
                    
                    if (redstickActive)
                        
                    {
                        
                        if (index == fingerRed)
                            
                        {
                            
                            if (sqrt(pow((point.x - redbase.position.x), 2) + pow((point.y - redbase.position.y), 2)) >= 250)
                                
                            {
                                
                                touchesCancelled(touches, with: event)
                                
                                break
                                
                            }
                            
                            
                            
                            let rv = CGVector(dx: point.x - redbase.position.x, dy: point.y - redbase.position.y)
                            
                            let rangle = atan2(rv.dy, rv.dx)
                            
                            let rlength : CGFloat = redbase.frame.size.height / 2
                            
                            let rxDist:CGFloat = sin(rangle - 1.57079633) * rlength
                            
                            let ryDist:CGFloat = cos(rangle - 1.57079633) * rlength
                            
                            
                            
                            shouldMoveRed = true
                            
                            
                            
                            if (redbase.frame.contains(point))
                                
                            {
                                
                                redball.position = point
                                
                            }
                                
                            else
                                
                            {
                                
                                redball.position = CGPoint(x: redbase.position.x - rxDist, y: redbase.position.y + ryDist)
                                
                            }
                            
                            
                            
                            redspaceship.zRotation = rangle - 1.57079633
                            
                        }
                        
                    }
                    
                    
                    
                    print("Finger move \(index+1): x=\(point.x) , y=\(point.y)")
                    
                    break
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
        
    {
        
        super.touchesEnded(touches, with: event)
        
        
        
        for touch in touches
            
        {
            
            for (index,finger) in fingers.enumerated()
                
            {
                
                if let finger = finger, finger == String(format: "%p", touch)
                    
                {
                    
                    if (index == fingerBlue)
                        
                    {
                        
                        let bmove = SKAction.move(to: bluebase.position, duration: 0.1)
                        
                        bmove.timingMode = .easeOut
                        
                        blueball.run(bmove)
                        
                        fingerBlue = nil
                        
                        shouldMoveBlue = false
                        
                    }
                        
                    else if (index == fingerRed)
                        
                    {
                        
                        let rmove = SKAction.move(to: redbase.position, duration: 0.1)
                        
                        rmove.timingMode = .easeOut
                        
                        redball.run(rmove)
                        
                        fingerRed = nil
                        
                        shouldMoveRed = false
                        
                    }
                    
                    
                    
                    fingers[index] = nil
                    
                    break
                    
                }
                
            }
            
        }
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?)
        
    {
        
        super.touchesCancelled(touches!, with: event)
        
        
        
        guard let touches = touches else
            
        {
            
            return
            
        }
        
        
        
        touchesEnded(touches, with: event)
        
    }
    

    
    var currentBlueLaser :SKSpriteNode? = nil
    
    var currentRedLaser :SKSpriteNode? = nil
    
    var winTimer :Float = 0
    
    var blueWinText :SKLabelNode? = nil
    
    var redWinText :SKLabelNode? = nil
    
    
    
    override func update(_ currentTime: TimeInterval)
        
    {
        
        super.update(currentTime)
        
        
        
        if (bluespaceshipHealth == 0)
            
        {
            
            
            
            if (winTimer == 0)
                
            {
                
                blueWinText = SKLabelNode(fontNamed: "Arial")
                
                blueWinText?.text = "Red Wins!"
                
                blueWinText?.fontSize = 65
                
                blueWinText?.fontColor = SKColor.red
                
                blueWinText?.position = CGPoint(x: 0, y:0)
                
                self.addChild(blueWinText!)
                
                winTimer = 1
                
            }
                
            else
                
            {
                
                winTimer = winTimer + 1
                
                
                
                if (winTimer / 60.0 >= 3.0)
                    
                {
                    
                    blueWinText?.removeFromParent()
                    
                    blueWinText = nil
                    
                    restart();
                    
                    winTimer = 0;
                    
                }
                
            }
            
        }
            
        else if (redspaceshipHealth == 0)
            
        {
            
            
            
            
            
            if (winTimer == 0)
                
            {
                
                redWinText = SKLabelNode(fontNamed: "Arial")
                
                redWinText?.text = "Blue Wins!"
                
                redWinText?.fontSize = 65
                
                redWinText?.fontColor = SKColor.blue
                
                redWinText?.position = CGPoint(x: 0, y:0)
                
                self.addChild(redWinText!)
                
                winTimer = 1
                
            }
                
            else
                
            {
                
                winTimer = winTimer + 1
                
                
                
                if (winTimer / 60.0 >= 3.0)
                    
                {
                    
                    redWinText?.removeFromParent()
                    
                    redWinText = nil
                    
                    restart();
                    
                    winTimer = 0;
                    
                }
                
            }
            
        }
        
        
        
        if (shouldMoveRed)
            
        {
            
            redspaceship.position = CGPoint(x:redspaceship.position.x + cos(redspaceship.zRotation + 1.57079637) * 3,y:redspaceship.position.y + sin(redspaceship.zRotation + 1.57079637) * 3)
            
        }
        
        
        
        if (shouldMoveBlue)
            
        {
            
            bluespaceship.position = CGPoint(x:bluespaceship.position.x + cos(bluespaceship.zRotation + 1.57079637) * 3,y:bluespaceship.position.y + sin(bluespaceship.zRotation + 1.57079637) * 3)
            
        }
        if (bluespaceship.position.x > 490) {bluespaceship.position.x = 490 }
        if (bluespaceship.position.x < -490) {bluespaceship.position.x = -490 }
        if (bluespaceship.position.y > 360) {bluespaceship.position.y = 360 }
        if (bluespaceship.position.y < -360) {bluespaceship.position.y = -360 }
        
        if (redspaceship.position.x > 490) {redspaceship.position.x = 490 }
        if (redspaceship.position.x < -490) {redspaceship.position.x = -490 }
        if (redspaceship.position.y > 360) {redspaceship.position.y = 360 }
        if (redspaceship.position.y < -360) {redspaceship.position.y = -360 }
        
        if (bshootGrow)
            
        {
            
            bshootAnim = bshootAnim! + 1
            
            
            
            if (bshootAnim! / 60.0 >= 0.15)
                
            {
                
                bshoot.setScale(0.2)
                
                bshootAnim = 0
                
                bshootGrow = false
                
            }
            
        }
        
        
        
        if (rshootGrow)
            
        {
            
            rshootAnim = rshootAnim! + 1
            
            
            
            if (rshootAnim! / 60.0 >= 0.15)
                
            {
                
                rshoot.setScale(0.2)
                
                rshootAnim = 0
                
                rshootGrow = false
                
            }
            
        }
        
        
        
        
        
        if (redshouldshoot && redspaceshipHealth > 0 && bluespaceshipHealth > 0)
        {
            currentBlueLaser = SKSpriteNode(imageNamed:"bluelaser")
            bluelasers.append(currentBlueLaser!)
            
            self.addChild(currentBlueLaser!)
            currentBlueLaser?.position = redspaceship.position
            currentBlueLaser?.setScale(0.1)
            currentBlueLaser?.zPosition = 2
            currentBlueLaser?.zRotation = redspaceship.zRotation
            
            redshouldshoot = false
        }
        
        
        
        
        
        if (blueshouldshoot && bluespaceshipHealth > 0 && redspaceshipHealth > 0)
        {
            currentRedLaser = SKSpriteNode(imageNamed:"redlaser")
            redlasers.append(currentRedLaser!)
            
            self.addChild(currentRedLaser!)
            currentRedLaser?.position = bluespaceship.position
            currentRedLaser?.setScale(0.1)
            currentRedLaser?.zPosition = 2
            currentRedLaser?.zRotation = bluespaceship.zRotation
            
            blueshouldshoot = false
        }
        
        var redLaserIndex :Int = 0;
        
        for thisRedLaser in redlasers
        {
            
            thisRedLaser.position = CGPoint(x:(thisRedLaser.position.x) + cos((thisRedLaser.zRotation) + 1.57079637) * 10 , y: (thisRedLaser.position.y) + sin((thisRedLaser.zRotation) + 1.57079637) * 10)
            
            if (redspaceship.frame.contains(thisRedLaser.position))
            {
                let explosion = SKSpriteNode(imageNamed: "explosion")
                explosion.zPosition = 6
                explosion.setScale(1)
                explosion.position = redspaceship.position
                
                redspaceshipHealth = 0
                
                explosions.append(explosion)
                explosionTimers.append(120)
                self.addChild(explosion)
                
                redlasers.remove(at: redLaserIndex)
                thisRedLaser.removeFromParent()
                
                continue
                
            }
            
            
            
            if (thisRedLaser.position.x < -600 || thisRedLaser.position.x > 600 || thisRedLaser.position.y < -400 || thisRedLaser.position.y > 400)
                
            {
                
                
    
                redlasers.remove(at: redLaserIndex)
                
                thisRedLaser.removeFromParent()
                
                continue
                
                
                
            }
            
            
            
            redLaserIndex = redLaserIndex + 1
            
        }
        
        
        var blueLaserIndex :Int = 0;
        
        
        
        for thisBlueLaser in bluelasers
            
        {
            
            thisBlueLaser.position = CGPoint(x:(thisBlueLaser.position.x) + cos((thisBlueLaser.zRotation) + 1.57079637) * 10,y:(thisBlueLaser.position.y) + sin((thisBlueLaser.zRotation) + 1.57079637) * 10)
            
            
            
            if (bluespaceship.frame.contains(thisBlueLaser.position))
                
            {
                
                let explosion = SKSpriteNode(imageNamed: "explosion")
                
                explosion.setScale(1);
                
                explosion.zPosition = 6
                
                explosion.position = bluespaceship.position;
                
                
                
                explosions.append(explosion)
                
                explosionTimers.append(120)
                
                self.addChild(explosion)
                
                
                
                bluespaceshipHealth = 0
                
                
                
                bluelasers.remove(at: blueLaserIndex)
                
                thisBlueLaser.removeFromParent()
                
                continue
                
            }
            
            
            
            if (thisBlueLaser.position.x < -600 || thisBlueLaser.position.x > 600 || thisBlueLaser.position.y < -400 || thisBlueLaser.position.y > 400)
                
            {
                
                bluelasers.remove(at: blueLaserIndex)
                
                thisBlueLaser.removeFromParent()
                
                continue
                
            }
            
            
            
            blueLaserIndex = blueLaserIndex + 1
            
        }
        
        
        
        var explosionIndex :Int = 0;
        
        
        
        for explosion in explosions
            
        {
            
            if (explosionTimers[explosionIndex] > 0)
                
            {
                
                explosionTimers[explosionIndex] = explosionTimers[explosionIndex] - 1
                
                transparent = transparent! - 0.06
                
                explosion.alpha = CGFloat(transparent!)
                
            }
                
            else
            {
                explosions.remove(at: explosionIndex)
                explosionTimers.remove(at: explosionIndex)
                explosion.removeFromParent()
                continue
            }
            explosionIndex = explosionIndex + 1
        }
    }
}

