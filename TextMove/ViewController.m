//
//  ViewController.m
//  TextMove
//
//  Created by 卓森 on 2018/2/24.
//  Copyright © 2018年 卓森. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#define ScreenHeight   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define CellMarginX 10
#define TableViewWidth 300
#define CELLWIDTH (ScreenWidth - 5*CellMarginX - TableViewWidth)*0.2

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    //正在拖拽的indexpath
    NSIndexPath *_dragingIndexPath;
    //目标位置
    NSIndexPath *_targetIndexPath;
    //移动的cell
    UIView *_dragingView;
    
    //滚动的距离
    CGFloat _scrollY;
    //横向滚动的距离
    CGFloat _scrollX;
}

/** 左边collectionView */
@property (nonatomic, strong) UICollectionView  *collectionView;
/** 右边的tableView */
@property (nonatomic, strong) UITableView  *tableView;

/** collectionView数据源 */
@property (nonatomic, strong) NSMutableArray  *collectMulArr;
/** tableView数据源 */
@property (nonatomic, strong) NSMutableArray  *tableViewArr;


@end

@implementation ViewController
// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView reloadData];
    
    self.tableViewArr = [[NSMutableArray alloc] init];
}


#pragma mark ------------ UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"tableView";
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.tableViewArr[indexPath.row];
    
    return cell;
}


#pragma mark ------------ UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectMulArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        
        return footerView;
    }
    
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}




#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){CELLWIDTH,CELLWIDTH};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMarginX, CellMarginX, CellMarginX, CellMarginX);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){ScreenWidth,44};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){ScreenWidth,22};
}




#pragma mark ---- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




#pragma mark ----- 利用UIGestureRecognizer在工作时的三种状态：开始、移动、停止这三种状态来分别实现三个主要功能,为了代码明了，分别创建三个方法，实现三个不同工能：
-(void)longPressMethod:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:gesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:gesture];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd:gesture];
            break;
        default:
            break;
    }
}

-(void)dragBegin:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:_collectionView];
    _dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!_dragingIndexPath) {return;}
    NSLog(@"拖拽开始 indexPath = %@",_dragingIndexPath);
    [_collectionView bringSubviewToFront:_dragingView];
    //更新被拖拽的cell
    _dragingView.frame = [_collectionView cellForItemAtIndexPath:_dragingIndexPath].frame;
    
    //collectionView被滚动跟新cell在试图中的位置
    CGRect frame = _dragingView.frame;
    frame.origin.y = frame.origin.y - _scrollY;
    _dragingView.frame = frame;
    
    _dragingView.hidden = false;
    [UIView animateWithDuration:0.3 animations:^{
        [_dragingView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    }];
}

-(void)dragChanged:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:_collectionView];
    
    NSLog(@"拖拽中。。。。。。。%f",point.x);
    _scrollX = point.x;
    //获取目标位置
    _targetIndexPath = [self getTargetIndexPathWithPoint:point];
    //collectionView被滚动跟新cell在试图中的位置
    point.y = point.y - _scrollY;
    _dragingView.center = point;
    
//    if (_targetIndexPath && _dragingIndexPath) {
//        [_collectionView moveItemAtIndexPath:_dragingIndexPath toIndexPath:_targetIndexPath];
//        _dragingIndexPath = _targetIndexPath;
//    }
}

-(void)dragEnd:(UILongPressGestureRecognizer*)gesture{
    NSLog(@"拖拽结束--------- %@",_dragingIndexPath);
    if (!_dragingIndexPath) {return;}
    CGRect endFrame = [_collectionView cellForItemAtIndexPath:_dragingIndexPath].frame;
    //collectionView被滚动跟新cell在试图中的位置
    endFrame.origin.y = endFrame.origin.y - _scrollY;
    
    if (!_targetIndexPath) {
        //判断移动的cell是否在当前collectionView中
        if (_scrollX > ScreenWidth - TableViewWidth) {
            
            //添加到tableView中
            [self.tableViewArr addObject:self.collectMulArr[_dragingIndexPath.row]];
            [self.tableView reloadData];
            
            //隐藏View
            [_dragingView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            _dragingView.frame = endFrame;
            _dragingView.hidden = true;
            
        }else{//在collection中动画方式返回初始位置
            
            [UIView animateWithDuration:0.3 animations:^{
                [_dragingView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                _dragingView.frame = endFrame;
            }completion:^(BOOL finished) {
                _dragingView.hidden = true;
            }];
        }
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            [_dragingView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            _dragingView.frame = endFrame;
        }completion:^(BOOL finished) {
            _dragingView.hidden = true;
        }];
    }
    
}

//获取被拖动IndexPath的方法
-(NSIndexPath*)getDragingIndexPathWithPoint:(CGPoint)point
{
    NSIndexPath* dragingIndexPath = nil;
    //遍历所有屏幕上的cell
    for (NSIndexPath *indexPath in [_collectionView indexPathsForVisibleItems]) {
        //判断cell是否包含这个点
        if (CGRectContainsPoint([_collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            dragingIndexPath = indexPath;
            break;
        }
    }
    return dragingIndexPath;
}

//获取目标IndexPath的方法
-(NSIndexPath*)getTargetIndexPathWithPoint:(CGPoint)point
{
    NSIndexPath *targetIndexPath = nil;
    //遍历所有屏幕上的cell
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        //避免和当前拖拽的cell重复
        if ([indexPath isEqual:_dragingIndexPath]) {continue;}
        //判断是否包含这个点
        if (CGRectContainsPoint([_collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            targetIndexPath = indexPath;
        }
    }
    return targetIndexPath;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _scrollY = scrollView.contentOffset.y;
}


#pragma mark ------- 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellWidth = CELLWIDTH;
        flowLayout.itemSize = CGSizeMake(CELLWIDTH,CELLWIDTH);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, CellMarginX, CellMarginX, CellMarginX);
        flowLayout.minimumLineSpacing = CellMarginX;
        flowLayout.minimumInteritemSpacing = CellMarginX;
        flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        // 注册cell、sectionHeader、sectionFooter
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.tableView.mas_left);
        }];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
        longPress.minimumPressDuration = 0.3f;
        [_collectionView addGestureRecognizer:longPress];
        
        _dragingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellWidth/2.0f)];
        _dragingView.backgroundColor = [UIColor redColor];
        _dragingView.hidden = true;
        [self.view addSubview:_dragingView];
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];//设置背景颜色
        _tableView.tableFooterView = [UIView new];//去除多余的分割线
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(TableViewWidth);
            make.top.bottom.right.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)collectMulArr
{
    if (!_collectMulArr) {
        
        _collectMulArr = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 39; i ++ ) {
            
            [_collectMulArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    return _collectMulArr;
}
@end
