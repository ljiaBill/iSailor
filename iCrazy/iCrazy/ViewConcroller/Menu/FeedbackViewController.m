//
//  FeedbackViewController.m
//  iLazy
//
//  Created by Administrator on 15/10/13.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//背景
@property (strong, nonatomic) UIImageView *background;

//输入框
@property (strong, nonatomic) UITextView * ideaText;

@property (strong, nonatomic) UIButton * button;

//添加图片
@property (strong, nonatomic) UIButton * appendBut;

//图片
@property (strong, nonatomic) UIImageView * imgView1;
@property (strong, nonatomic) UIImageView * imgView2;
@property (strong, nonatomic) UIImage * image1;
@property (strong, nonatomic) UIImage * image2;
@property (strong, nonatomic) UILabel * numLable;
//提交按钮
@property (strong, nonatomic) UIButton * putInBut;

//图片个数
@property (assign, nonatomic) int num;

//手势
@property (strong, nonatomic) UITapGestureRecognizer * tapOne;
@property (strong, nonatomic) UITapGestureRecognizer * tapTwo;

@property (strong, nonatomic) NSString * imageOne;
@property (strong, nonatomic) NSString * imageTwo;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.num = 0;
    
    self.image1 = nil;
    self.image2 = nil;
    
    self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.background.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.background];
    
    //改变状态栏
    [self statusBar];
    
    //自定义navigation
    [self mynavigation];
    
    //界面设计
    [self interfaceDesign];
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar
{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= COLORNAVIGATION;
    
    [self.view addSubview:statusBarView];
    
}
//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 自定义navigation
- (void)mynavigation
{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"意见反馈"];
    
    [myBar.leftBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBar];
}

#pragma mark - 界面设计
- (void)interfaceDesign
{
    //发表意见
    self.ideaText = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, 100)];
    [self.ideaText.layer setCornerRadius:5];
    [self.view addSubview:self.ideaText];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, 100)];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button setTitle:@"留下您的宝贵意见吧!" forState:UIControlStateNormal];
    [self.button setTitleColor:COLORMAMP(193,192,200,1) forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.button addTarget:self action:@selector(proButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    //添加图片
    self.appendBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 74+self.ideaText.bounds.size.height+15, self.ideaText.bounds.size.height/2, self.ideaText.bounds.size.height/2)];
    self.appendBut.backgroundColor = [UIColor whiteColor];
    [self.appendBut setImage:[UIImage imageNamed:@"zhaopian"] forState:UIControlStateNormal];
    self.appendBut.layer.borderColor = COLORNAVIGATION.CGColor;
    [self.appendBut.layer setCornerRadius:5];
    self.appendBut.layer.borderWidth = 0.6;
    self.appendBut.tag = 1;
    [self.appendBut addTarget:self action:@selector(putInButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.appendBut];
    
    self.imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10+self.ideaText.bounds.size.height/2+10, 74+self.ideaText.bounds.size.height+15, self.ideaText.bounds.size.height/2, self.ideaText.bounds.size.height/2)];
    [self.imgView1.layer setCornerRadius:5];
    [self.view addSubview:self.imgView1];
    
    self.imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10+self.ideaText.bounds.size.height+10+10, 74+self.ideaText.bounds.size.height+15, self.ideaText.bounds.size.height/2, self.ideaText.bounds.size.height/2)];
    [self.imgView2.layer setCornerRadius:5];
    [self.view addSubview:self.imgView2];
    
    self.imgView1.alpha = 0;
    self.imgView2.alpha = 0;
    
    self.numLable = [[UILabel alloc]initWithFrame:CGRectMake(10+self.ideaText.bounds.size.height*3/2+10+10+10, 74+self.ideaText.bounds.size.height+15, UISCREEN_WIDTH-(10+self.ideaText.bounds.size.height*3/2+10+10+10)-10, self.ideaText.bounds.size.height/2)];
    self.numLable.textAlignment = NSTextAlignmentCenter;
    self.numLable.text = @"您可以选择2张图片";
    self.numLable.textColor = COLORMAMP(193,192,200,1);
    self.numLable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.numLable];
    
    //提交按钮
    self.putInBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 74+self.ideaText.bounds.size.height+15+self.ideaText.bounds.size.height/2+15, UISCREEN_WIDTH-20, 42)];
    self.putInBut.backgroundColor = COLORNAVIGATION;
    self.putInBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.putInBut setTitle:@"提交" forState:UIControlStateNormal];
    [self.putInBut.layer setCornerRadius:6];
    [self.putInBut setShowsTouchWhenHighlighted:YES];               //点击高亮
    self.putInBut.tag = 2;
    [self.view addSubview:self.putInBut];
    [self.putInBut addTarget:self action:@selector(putInButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgView1.userInteractionEnabled = YES;
    self.imgView2.userInteractionEnabled = YES;
    self.tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test:)];
    self.tapTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test:)];
    [self.imgView1 addGestureRecognizer:self.tapOne];
    [self.imgView2 addGestureRecognizer:self.tapTwo];
}

//提交按钮事件
#pragma mark - 提交按钮的点击事件
- (void)putInButClick:(UIButton * )sendr
{
    if(sendr.tag == 2)
    {
        if([self.ideaText.text isEqualToString:@""])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有填写信息哦!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            dataRequest * data = [[dataRequest alloc]init];
            
            if(!self.image1 && !self.image2)
            {
                self.imageOne = @"";
                self.imageTwo = @"";
                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      self.ideaText.text,    @"info",
                                      self.imageOne,         @"imgone",
                                      self.imageTwo,         @"imgtwo",
                                      nil];
                [data insertIdeaInfo:dic and:^(NSDictionary *dataDic) {
                    
                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                    {
                        NSLog(@"提交成功!");
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功！" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    else
                    {
                        NSLog(@"提交失败!");
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败，请稍后再试！" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }
                }];
            }
            else if(self.image1 && self.image2)
            {
                [data insertFeedbackImage:self.image1 and:^(NSDictionary *dataDic) {
                    
                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                    {
                        self.imageOne = [[[dataDic objectForKey:@"message"] objectForKey:@"upload"] objectForKey:@"savename"];
                        
                        [data insertFeedbackImage:self.image2 and:^(NSDictionary *dataDic) {
                            
                            if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                            {
                                self.imageTwo = [[[dataDic objectForKey:@"message"] objectForKey:@"upload"] objectForKey:@"savename"];
                                
                                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      self.ideaText.text,    @"info",
                                                      self.imageOne,         @"imgone",
                                                      self.imageTwo,         @"imgtwo",
                                                      nil];
                                
                                
                                [data insertIdeaInfo:dic and:^(NSDictionary *dataDic) {
                                    
                                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                                    {
                                        NSLog(@"提交成功!");
                                        
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功！" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                            
                                            [self.navigationController popViewControllerAnimated:YES];
                                            
                                        }];
                                        [alert addAction:okAction];
                                        [self presentViewController:alert animated:YES completion:nil];
                                    }
                                    else
                                    {
                                        NSLog(@"提交失败!");
                                        
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败，请稍后再试！" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                        [alert addAction:okAction];
                                        [self presentViewController:alert animated:YES completion:nil];
                                        
                                    }
                                }];
                                
                            }
                            
                        }];
                    }
                }];
            }
            else
            {
                [data insertFeedbackImage:self.image1 and:^(NSDictionary *dataDic) {
                    
                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                    {
                        self.imageOne = [[[dataDic objectForKey:@"message"] objectForKey:@"upload"] objectForKey:@"savename"];
                        
                        self.imageTwo = @"";
                        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                              self.ideaText.text,    @"info",
                                              self.imageOne,         @"imgone",
                                              self.imageTwo,         @"imgtwo",
                                              nil];
                        
                        
                        [data insertIdeaInfo:dic and:^(NSDictionary *dataDic) {
                            
                            if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                            {
                                NSLog(@"提交成功!");
                                
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功！" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                }];
                                [alert addAction:okAction];
                                [self presentViewController:alert animated:YES completion:nil];
                            }
                            else
                            {
                                NSLog(@"提交失败!");
                                
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败，请稍后再试！" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                [alert addAction:okAction];
                                [self presentViewController:alert animated:YES completion:nil];
                                
                            }
                        }];
                    }
                }];
            }
        }
    }
    else if (sendr.tag == 1)
    {
        if(self.num < 2)
        {
            //打开相册
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                pickerImage.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                pickerImage.allowsEditing = YES;
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [self presentViewController:pickerImage animated:YES completion:^{
                
            }];
        }
        else
        {
            NSLog(@"图片个数已满!");
        }
    }
}

#pragma mark - 相片点击事件
- (void)test:(UITapGestureRecognizer *)sender
{
    if(sender == self.tapOne)                //第一个图片view
    {
        self.appendBut.userInteractionEnabled = YES;
        self.image1 = self.image2;
        self.imgView1.image = self.image1;
        if(self.image2 == nil)
        {
            self.imgView2.image = self.image2;
            self.num = 0;
            self.imgView2.alpha = 0;
            
            self.numLable.text = [NSString stringWithFormat:@"您还可以选择%d张图片",2-self.num];
        }
        else
        {
            self.image2 = nil;
            self.imgView2.image = self.image2;
            self.num = 1;
            self.imgView2.alpha = 0;
            
            self.numLable.text = [NSString stringWithFormat:@"您还可以选择%d张图片",2-self.num];
        }
        
    }
    else if(sender == self.tapTwo)               //第二个图片view
    {
        self.appendBut.userInteractionEnabled = YES;
        self.image2 = nil;
        self.imgView2.image = self.image2;
        self.num = 1;
        
        self.numLable.text = [NSString stringWithFormat:@"您还可以选择%d张图片",2-self.num];
    }
}

#pragma mark - 选取图片的代理方法
#pragma mark - 选取图片执行方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //设置图片的尺寸
    CGSize imagesize = image.size;
    imagesize.height = 224;
    imagesize.width = 224;
    //对图片进行压缩
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.00001);
    
    UIImage * imageNew = [UIImage imageWithData:imageData];
    
    if(self.num == 0)
    {
        self.imgView1.alpha = 1;
        self.image1 = imageNew;
        self.imgView1.image = self.image1;
        self.num++;
        self.numLable.text = [NSString stringWithFormat:@"您还可以选择%d张图片",2-self.num];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else if (self.num == 1)
    {
        self.imgView2.alpha = 1;
        self.image2 = imageNew;
        self.imgView2.image = self.image2;
        self.num--;
        self.numLable.text = [NSString stringWithFormat:@"您还可以选择%d张图片",0];
        [self dismissViewControllerAnimated:YES completion:^{
            
            self.appendBut.userInteractionEnabled = NO;
        }];
    }
}

#pragma mark - 对图片尺寸进行压缩返回新图片(newImage)
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 取消图片选取执行的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回成功!");
    }];
}

#pragma mark - 提示水印的点击事件
- (void)proButClick
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.button.alpha = 0;
        [self.ideaText becomeFirstResponder];               //获得焦点
        
    }];
}

#pragma mark - 收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    if([self.ideaText.text isEqualToString:@""])
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.button.alpha = 1;
            
        }];
    }
}

#pragma  mark - 返回上一页
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
