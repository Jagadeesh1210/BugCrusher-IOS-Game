//
//  ViewController.m
//  Animation
//
//  Created by ios on 11/09/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
bool bugDead;
NSInteger BCount;
}
@end

@implementation ViewController
@synthesize basketBottom,basketTop,napkinBottom,napkinTop,bug,img,lbl;


- (void)viewDidAppear:(BOOL)animated
{
    lbl.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bug Crusher" message:@"Start Now!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    sleep(7);
    
	// Do any additional setup after loading the view, typically from a nib.
    //[basketTop setImage:[UIImage imageNamed:@"door_top.png"]];
    
    CGRect basketTopFrame = self.basketTop.frame;
    basketTopFrame.origin.y = -basketTopFrame.size.height;
    // basketTopFrame.size.height=0;
    //basketTopFrame.size.width=1;
    NSLog(@"Top Height %f",basketTopFrame.size.height);
    
    CGRect basketBottomFrame = self.basketBottom.frame;
    basketBottomFrame.origin.y = self.view.bounds.size.height;
    //basketBottomFrame.size.height=0;
    NSLog(@"Bottom Height %f",self.view.bounds.size.height);
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         basketTop.frame = basketTopFrame;
                         basketBottom.frame = basketBottomFrame;
                         //[basketTop setCenter:CGPointMake(0, 0)];
                         //[basketTop setAlpha:0.0f];
                         //[basketBottom setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    
    
    // At bottom of viewDidAppear
    
    CGRect napkinTopFrame = self.napkinTop.frame;
    //napkinTopFrame.origin.y = -napkinTopFrame.size.height;
    napkinTopFrame.size.height=0;
    CGRect napkinBottomFrame = self.napkinBottom.frame;
    napkinBottomFrame.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:1
                          delay:1.5
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.napkinTop.frame = napkinTopFrame;
                         self.napkinBottom.frame = napkinBottomFrame;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    //  [UIView commitAnimations];
    //[self moveToLeft:nil finished:nil context:nil];
    
    //GStyle
    
    NSArray *imageNames = @[@"win_1.png", @"win_2.png", @"win_3.png", @"win_4.png",
                            @"win_5.png", @"win_6.png", @"win_7.png", @"win_8.png",
                            @"win_9.png", @"win_10.png", @"win_11.png", @"win_12.png",
                            @"win_13.png", @"win_14.png", @"win_15.png", @"win_16.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    //UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 95, 86, 193)];
    img.animationImages = images;
    img.animationDuration = 0.5;
    
    [self.view addSubview:img];
    [img startAnimating];

    }



- (void)viewDidLoad
{	
    [super viewDidLoad];
    BCount=0;
    timer =[NSTimer scheduledTimerWithTimeInterval:0.5
                                            target:self
                                          selector:@selector(BugGen:)
                                          userInfo:nil
                                           repeats:YES];
    

}



-(void)BugGen:(NSTimer *)timer 
{
    //BugCreation
    
    
    int xCoordinate = arc4random() % 320;
    int yCoordinate = arc4random() % 460;
    if(BCount < 0)
    {
        
    starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, 35, 27)];
    //create ImageView
    starImgView.userInteractionEnabled=YES;
    starImgView.image = [UIImage imageNamed:@"bug.png"];
        BCount=BCount+1;
        starImgView.tag=0;
    [self.view addSubview: starImgView];
                
    }
    else if(BCount < 60){
        NSLog(@"In Image Array%i",BCount);
            b[BCount]=[[UIImageView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, 35, 27)];
            b[BCount].image = [UIImage imageNamed:@"bug.png"];
            b[BCount].userInteractionEnabled=YES;
            b[BCount].tag=BCount;
            [self.view addSubview: b[BCount]];
           [self moveToLeft:nil finished:nil context:nil];
            BCount=BCount+1;
         }
    else{
        NSLog(@"TimerCompleted");
        [timer invalidate];
        NSInteger Score=0;
        for(int i=0;i<60;i++)
        {
            NSLog(@" Value %@",b[i].hidden ? @"T":@"F");
           //b[i].hidden ? Score++ : Score=Score ;
            if(b[i].hidden == YES)
            {
                Score=Score+1;
                
            }else { b[i].hidden=YES;  }
        }
        NSString *status;
        if(Score < 15){ status=@"Poor";  } else if(Score >=15 && Score < 30) { status=@"Learner"; }
        else if(Score >=30 && Score <40){
            status=@"Good";
        } else if(Score >=40 && Score <50){ status=@"Skilled";  }
        else if(Score >=50) {  status=@"Master";     }
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bug Crusher" message:[[NSString alloc] initWithFormat:@"You Have Crushed %i Bugs in 30 Secends. Grade::%@",Score,status] delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Retry", nil];
        [alert show];
        
        //[super reloadInputViews];
        }

    //[self moveToLeft:nil finished:nil context:nil];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog(@"In Alert View Delegate");
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        exit(0);
    }
    lbl.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bug Crusher" message:@"Start Now!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    //sleep(5);
    
	// Do any additional setup after loading the view, typically from a nib.
    //[basketTop setImage:[UIImage imageNamed:@"door_top.png"]];
    
    CGRect basketTopFrame = self.basketTop.frame;
    basketTopFrame.origin.y = -basketTopFrame.size.height;
    // basketTopFrame.size.height=0;
    //basketTopFrame.size.width=1;
    NSLog(@"Top Height %f",basketTopFrame.size.height);
    
    CGRect basketBottomFrame = self.basketBottom.frame;
    basketBottomFrame.origin.y = self.view.bounds.size.height;
    //basketBottomFrame.size.height=0;
    NSLog(@"Bottom Height %f",self.view.bounds.size.height);
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         basketTop.frame = basketTopFrame;
                         basketBottom.frame = basketBottomFrame;
                         //[basketTop setCenter:CGPointMake(0, 0)];
                         //[basketTop setAlpha:0.0f];
                         //[basketBottom setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    
    
    // At bottom of viewDidAppear
    
    CGRect napkinTopFrame = self.napkinTop.frame;
    //napkinTopFrame.origin.y = -napkinTopFrame.size.height;
    napkinTopFrame.size.height=0;
    CGRect napkinBottomFrame = self.napkinBottom.frame;
    napkinBottomFrame.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:1
                          delay:1.5
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.napkinTop.frame = napkinTopFrame;
                         self.napkinBottom.frame = napkinBottomFrame;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    //  [UIView commitAnimations];
    //[self moveToLeft:nil finished:nil context:nil];
    
    //GStyle
    
    NSArray *imageNames = @[@"win_1.png", @"win_2.png", @"win_3.png", @"win_4.png",
                            @"win_5.png", @"win_6.png", @"win_7.png", @"win_8.png",
                            @"win_9.png", @"win_10.png", @"win_11.png", @"win_12.png",
                            @"win_13.png", @"win_14.png", @"win_15.png", @"win_16.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    //UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 95, 86, 193)];
    img.animationImages = images;
    img.animationDuration = 0.5;
    
    [self.view addSubview:img];
    [img startAnimating];
    
    BCount=0;
    timer =[NSTimer scheduledTimerWithTimeInterval:0.5
                                            target:self
                                          selector:@selector(BugGen:)
                                          userInfo:nil
                                           repeats:YES];
    

 
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    NSSet *allTouches=[event allTouches];
    
    switch ([allTouches count])
    {
        case 1:
        {
            UITouch *touch1=[[allTouches allObjects] objectAtIndex:0];
            CGPoint t1=[touch1 locationInView:self.view];
            [UIView animateWithDuration:0.5f animations:^{
                //Move the image view to 100, 100 over 10 seconds.
               // [self.view bringSubviewToFront: self];
                 UITouch *tou = [touches anyObject];
                NSLog(@"TagValues %i",[tou view].tag);
                NSInteger val=[tou view].tag;
               
                
//                
//                if (CGRectIntersectsRect(img.frame, b[val].frame)) {
//                    b[val].hidden=YES;
//
//                }
                
                img.frame = CGRectMake(t1.x, t1.y, img.frame.size.width, img.frame.size.height);
                float imgxp=b[val].center.x + 17.5;
                float imgxm=b[val].center.x - 17.5;
                float imgyp=b[val].center.y + 13.5;
                float imgym=b[val].center.y - 13.5;
                if((img.frame.origin.x < imgxp) && (img.frame.origin.x > imgxm)  )
                {
                    
                    if((img.frame.origin.y < imgyp) && (img.frame.origin.y > imgym) )
                    {
                        //sleep(5);
                        b[val].hidden=YES;
                    }
                }
            }];

           // NSLog(@"GManCoordinated %fX%f and Bug Coordinates %fX%f   :::%f",img.center.x,img.center.y,starImgView.center.x,starImgView.center.y,imgyp);
            
            //starImgView.frame.origin.x
            
            break;
            }
            
        default:
            NSLog(@"In Default condition");
            break;
    }
    
        UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];

    CGRect bugEvent = [[[starImgView layer] presentationLayer] frame];
    if (CGRectContainsPoint(bugEvent, touchLocation))
    {
        NSLog(@"i got you");
    }
    
   // CGRect bugRect = [self.bug frame];
    CGRect bugRect = [[[self.bug layer] presentationLayer] frame];
    CGRect imgRect = [self.img frame];
    if (CGRectContainsPoint(bugRect, touchLocation)) {
        NSLog(@"Bug tapped!");
       // [self moveToLeft:nil finished:nil context:nil];
       // [self moveToRight:nil finished:nil context:nil];
        bugDead=YES;
       // UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bug" message:@"Dead" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
        bug.hidden=YES;
    } else if(CGRectContainsPoint(imgRect, touchLocation))
    {
       //UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"GangamStyle"  message:@"Don't Disturb Me!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       // [alt show];
    }
    
    else
    {
        
        bugDead=NO;
        //[self moveToLeft:nil finished:nil context:nil];

        NSLog(@"Bug not tapped.");
        return;
    }
    

    
}

// Add four new methods for the bug animation
- (void)moveToLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
   
    {
    [UIView animateWithDuration:2.0
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceRight:finished:context:)];
                         //self.bug.center = CGPointMake(75, 200);
                         //starImgView.center = CGPointMake(75, 200);
                         b[BCount].center=CGPointMake(b[BCount].center.x,b[BCount].center.y);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Move to left done");
                     }];
    }
    
}

- (void)faceRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
     
     {
    
    [UIView animateWithDuration:2.0
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(moveToRight:finished:context:)];
                         
                         self.bug.transform = CGAffineTransformMakeRotation(M_PI);
                         b[BCount].transform=CGAffineTransformMakeRotation(M_PI);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Face right done");
                     }];
     }
}

- (void)moveToRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
     {
    [UIView animateWithDuration:2.0
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceLeft:finished:context:)];
                         self.bug.center = CGPointMake(230, 250);
                          b[BCount].center=CGPointMake(b[BCount].center.x,b[BCount].center.y);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSLog(@"Move to right done");
                     }];
     }
}

- (void)faceLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
     {
    
    [UIView animateWithDuration:2.0
                          delay:1.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         
                         [UIView setAnimationDidStopSelector:@selector(moveToLeft:finished:context:)];
                         self.bug.transform = CGAffineTransformMakeRotation(0);
                         b[BCount].transform= CGAffineTransformMakeRotation(0);
                         
                         
                     }completion:^(BOOL finished){
                         NSLog(@"Face left done");
                         
                     }];
     }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
