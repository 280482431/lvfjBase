//
//  HQBaseSegmentViewController.m
//  TiKu
//
//  Created by lvfeijun on 2021/5/28.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import "lvfjBaseSegmentViewController.h"
#import "Masonry.h"
#import "GlobalMacro.h"
#import "HQGlobalMacro.h"
#import "UIColor+Architecture.h"
#import "LogSetting.h"
#import "UIImage+bundle.h"
#import "NSArray+Architecture.h"
//#import "HQSubjectTagEditController.h"
//#import "HQGetCategoryQBoxDataService.h"

@interface lvfjBaseSegmentViewController ()

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) UIButton *categoryBtn;

@property (nonatomic, strong) NSArray<NSString *> *segmentTitles;

@property (nonatomic, assign) BOOL isRebuild;

@end

@implementation lvfjBaseSegmentViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isRebuild = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isRebuild = YES;
}

#pragma mark set api

- (void)setCategoryViewBackgroundColor:(nullable UIColor *)backgroundColor titleColor:(nullable UIColor *)titleColor titleSelectedColor:(nullable UIColor *)titleSelectedColor titleFont:(nullable UIFont *)titleFont titleSelectedFont:(UIFont *)titleSelectedFont
{
    if ([backgroundColor isKindOfClass:[UIColor class]]) {
        self.categoryView.backgroundColor = backgroundColor;
    }
    if ([titleColor isKindOfClass:[UIColor class]]) {
        self.categoryView.titleColor = titleColor;
    }
    if ([titleSelectedColor isKindOfClass:[UIColor class]]) {
        self.categoryView.titleSelectedColor = titleSelectedColor;
    }
    if ([titleSelectedFont isKindOfClass:[UIFont class]]) {
        self.categoryView.titleSelectedFont = titleSelectedFont;
    }
    if ([titleFont isKindOfClass:[UIFont class]]) {
        self.categoryView.titleFont = titleFont;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSegment];
    [self initDatas];
}

#pragma mark setviews

- (void)initSegment
{
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    
    UIButton *categoryBtn = [[UIButton alloc] init];
    UIImage *img = [UIImage hq_getImageWithBundleName:@"ArchitectureBase" ImageName:@"segment_more"];
    [categoryBtn setImage:img forState:UIControlStateNormal];
    [categoryBtn setBackgroundColor:UIColor.whiteColor];
    [categoryBtn addTarget:self action:@selector(moreTagClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn];
    self.categoryBtn = categoryBtn;
    [categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(32);
    }];
}

- (void)moreTagClick
{
//    if (self.navigationController) {
//        HQSubjectTagEditController *controller = [[UIStoryboard storyboardWithName:@"SubjectTag" bundle:nil] instantiateViewControllerWithIdentifier:@"TagEditCon"];
//        controller.selectedSecondCategoryID = kGVUserDefaults.hq_selectSecondCategoryID;
//
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//        self.navigationItem.backBarButtonItem = backItem;
//        [self.navigationController pushViewController:controller animated:YES];
//    }
}

// 需要在 viewDidLayoutSubviews 设置 listContainerView 的frame，否则可能引起布局错误
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view layoutIfNeeded];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.categoryViewTop);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(48);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark setdatas
- (void)setSegmentTitles:(NSArray<NSString *> *)segmentTitles
{
    _segmentTitles = segmentTitles;

    NSMutableArray *aliasList = [NSMutableArray array];
    [aliasList addObjectsFromArray:_segmentTitles];
    
    self.categoryView.titles = aliasList.copy;
    [self.categoryView reloadData];
}

#pragma mark setter &getter

// 列表容器视图
- (JXCategoryListContainerView *)listContainerView
{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}
- (JXCategoryTitleView *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] init];
        _categoryView.delegate = self;
        _categoryView.titleSelectedFont = HQ_Font_Medium(17);
        _categoryView.titleFont = HQ_Font_Regular(16);
        _categoryView.titleLabelStrokeWidthEnabled = YES;
        _categoryView.selectedAnimationEnabled = YES;
        _categoryView.cellWidthZoomEnabled = YES;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleLabelZoomEnabled = YES;
//        _categoryView.titleLabelZoomScale = 1.5;
        _categoryView.cellWidthZoomScale = 1.5;
        _categoryView.averageCellSpacingEnabled = NO;
        _categoryView.titleLabelZoomScrollGradientEnabled = YES;
        _categoryView.cellSpacing = 25;
        _categoryView.contentEdgeInsetLeft = 10;
        _categoryView.titleColor = UIColor.ArColor_555555;
        _categoryView.titleSelectedColor = UIColor.ArColor_111111;
        _categoryView.backgroundColor = [UIColor whiteColor];
//        _categoryView.backgroundColor = [UIColor redColor];

        JXCategoryIndicatorLineView *indicatorView = [[JXCategoryIndicatorLineView alloc] initWithFrame:CGRectMake(0, 0, 25, 3)];
        indicatorView.indicatorWidth = 12;
        indicatorView.indicatorHeight = 3;
        indicatorView.indicatorCornerRadius = 1.5;
        indicatorView.verticalMargin = 3;
        indicatorView.indicatorColor = UIColor.Ar_themeColor;
        _categoryView.indicators = @[indicatorView];
        
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    [self setCurrentCourseInitialWithIndex:index];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    [self setCurrentCourseInitialWithIndex:index];
}
- (void)setCurrentCourseInitialWithIndex:(NSInteger)index
{
    if (index<self.datas.count) {
        self.selectIndex = index;
        self.selectData = self.datas[index];
    } else {
        DDLogDebug(@"数组越界🙅‍♂️");
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView
{
    return self.datas.count;
}
- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    [self reloadDatas];
}
- (void)reloadDatas
{
    
    if (self.selectData) {
        self.selectIndex = [self.datas indexOfObject:self.selectData];
    } else {
        self.selectIndex = 0;
    }
    
    [self doReloadView:self.datas];
}
- (void)doReloadView:(NSArray <NSString *> *)titles
{
    self.categoryView.defaultSelectedIndex = self.selectIndex;
    if (_isRebuild||([NSArray hq_isEmptyArray:self.categoryView.titles]!=[NSArray hq_isEmptyArray:titles])) {
        [self setSegmentTitles:titles];
    }
}
- (void)initDatas
{
//    self.datas = @[@"1",@"2",@"3",@"4",@"5",@"6"];
}
#pragma mark - datas
//
//- (void)initDatas
//{
//    // 获取选择的所有科目
//    self.subjectArray = [HQGetCategoryQBoxDataService getSelectCourseArray];
//
//    // 添加 RAC 监听
//    [self addRACObserve];
//}
//- (void)addRACObserve
//{
//    @weakify(self);
//    [RACObserve([GVUserDefaults standardUserDefaults], hq_boxId) subscribeNext:^(NSNumber *boxId) {
//        @strongify(self)
//         if ([boxId integerValue] == 0) {
//            return;
//        }
//
//        self.subjectArray = [HQGetCategoryQBoxDataService getSelectCourseArray];
//        self.currentCourseInitial = [HQCourseInitialModel objectInRealm:[RLMRealm defaultRealm] forPrimaryKey:@(kGVUserDefaults.hq_boxId)];
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
