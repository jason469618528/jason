//
//  FavoriteHomeViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-10.
//  Copyright (c) 2014年 Panli. All rights reserved.
//
#define FAVORITE_PRODUCT        LocalizedString(@"FavoriteHomeViewController_FAVORITE_PRODUCT", @"商品")
#define FAVORITE_SHOP           LocalizedString(@"FavoriteHomeViewController_FAVORITE_SHOP", @"店铺")
#define COUNT @"10"
#define PAGE_COUNT 10
#define DISPLAY_VIEW_HEIGHT

#import "FavoriteHomeViewController.h"
#import "FavoriteProductsCell.h"
#import "FavoriteShopCell.h"
#import "FavoriteProducts.h"
#import "FavoriteShops.h"
#import "UIImageView+WebCache.h"
#import "UserInfo.h"


@interface FavoriteHomeViewController ()

@end

@implementation FavoriteHomeViewController
@synthesize displayFavoriteInfoTable = _displayFavoriteInfoTable;
@synthesize favoriteCategoryArray = _favoriteCategoryArray;
@synthesize productsDetailedArray = _productsDetailedArray;
@synthesize shopsDetailedArray = _shopsDetailedArray;
@synthesize currentIndex = _currentIndex;
@synthesize productsRepeater = _productsRepeater;
@synthesize shopsRepeater = _shopsRepeater;
@synthesize info_ExceptionView = _info_ExceptionView;
@synthesize pageIndexProduct = _pageIndexProduct;
@synthesize pageIndexShop = _pageIndexShop;
@synthesize isRequestAll = _isRequestAll;
@synthesize isPullDownProduct = _isPullDownProduct;
@synthesize isPullDownShop = _isPullDownShop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear=-=-=-=");
    [self checkLoginWithBlock:^{
        //刷新tableview
        switch (viewType)
        {
            case view_Products:
            {
                [_displayFavoriteInfoTable requestData:YES];
                break;
            }
            case view_Shops:
            {
                [_displayFavoriteInfoTable requestData:YES];
                break;
            }
            default:
                break;
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad-=-=-=-=-");
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = LocalizedString(@"FavoriteHomeViewController_Title", @"收藏夹");
    
    self.favoriteCategoryTable.scrollEnabled = NO;
    
    _displayFavoriteInfoTable = [[CustomTableViewController alloc] init];
    _displayFavoriteInfoTable.tableStyle = UITableViewStylePlain;
    _displayFavoriteInfoTable.loadingStyle = head_none;
    _displayFavoriteInfoTable.customTableViewDelegate = self;
    _displayFavoriteInfoTable.view.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    _displayFavoriteInfoTable.view.frame = CGRectMake(self.favoriteCategoryTable.frame.size.width, 44.0f, MainScreenFrame_Width-self.favoriteCategoryTable.frame.size.width, self.favoriteCategoryTable.frame.size.height);
    _displayFavoriteInfoTable.tableView.frame = CGRectMake(0.0, 0.0f, MainScreenFrame_Width-self.favoriteCategoryTable.frame.size.width, self.favoriteCategoryTable.frame.size.height);
    [PanliHelper setExtraCellLineHidden:_displayFavoriteInfoTable.tableView];
    [self.view addSubview:_displayFavoriteInfoTable.view];
    
    _currentIndex = 0;
    
    self.favoriteCategoryArray = [NSArray arrayWithObjects:FAVORITE_PRODUCT,FAVORITE_SHOP, nil];
    self.favoriteCategoryTable.backgroundColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
    
    self.favoriteCategoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //异常view
    _info_ExceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_displayFavoriteInfoTable.view.frame.size.width, _displayFavoriteInfoTable.view.frame.size.height)];
    [_info_ExceptionView setHidden:YES];
    [self.view insertSubview:_info_ExceptionView belowSubview:_displayFavoriteInfoTable.view];
    
    _pageIndexProduct = 1;
    _pageIndexShop = 1;
    _isRequestAll = YES;
    _isPullDownProduct = YES;
    _isPullDownShop = YES;
}

#pragma mark - Request list of favorite Products ,Categories ,Shops
//发送 获取收藏的商品 网络请求
- (void)requestFavoriteProducts
{
    [self.view setUserInteractionEnabled:NO];
    favorite_Products_Request = favorite_Products_Request ? favorite_Products_Request : [[FavoriteProductsOrShopsRequest alloc] init];
    //设置参数
    NSMutableDictionary *paramsProducts = [[NSMutableDictionary alloc] init];
    [paramsProducts setValue:@"F" forKey:RQ_GETCOLLECT_PARM_TYPE];
    if (_isPullDownProduct)
    {
        _pageIndexProduct = 1;
        
    }
    [paramsProducts setValue:[NSString stringWithFormat:@"%d",_pageIndexProduct] forKey:RQ_GETCOLLECT_PARM_PAGEINDEX];
    [paramsProducts setValue:COUNT forKey:RQ_GETCOLLECT_PARM_PAGECOUNT];
    
    repeater_Favorite_Products = repeater_Favorite_Products ? repeater_Favorite_Products : [[DataRepeater alloc] initWithName:RQNAME_LIST_FAVORITES_ORDERS];
    repeater_Favorite_Products.requestParameters = paramsProducts;
    __weak FavoriteHomeViewController *favoriteHomeVC_Products = self;
    repeater_Favorite_Products.compleBlock  = ^(id repeater)
    {
        [favoriteHomeVC_Products getFavoriteProducts:repeater];
    };
    repeater_Favorite_Products.requestModal = PullData;
    repeater_Favorite_Products.networkRequest = favorite_Products_Request;
    [[DataRequestManager sharedInstance] sendRequest:repeater_Favorite_Products];
    
}
- (void)requestFavoriteShops
{
    NSLog(@"请求收藏的店铺数据");
    [self.view setUserInteractionEnabled:NO];
    favorite_Shops_Request = favorite_Shops_Request ? favorite_Shops_Request :[[FavoriteProductsOrShopsRequest alloc] init];
    //配置请求参数
    NSMutableDictionary *paramsShops = [[NSMutableDictionary alloc] init];
    [paramsShops setValue:@"S" forKey:RQ_GETCOLLECT_PARM_TYPE];
    if (_isPullDownShop)
    {
        _pageIndexShop = 1;
        
    }
    [paramsShops setValue:[NSString stringWithFormat:@"%d",_pageIndexShop] forKey:RQ_GETCOLLECT_PARM_PAGEINDEX];
    [paramsShops setValue:COUNT forKey:RQ_GETCOLLECT_PARM_PAGECOUNT];
    repeater_Favorite_Shops = repeater_Favorite_Shops ? repeater_Favorite_Shops : [[DataRepeater alloc] initWithName:RQNAME_FAVORITESSHOPS_LIST];
    repeater_Favorite_Shops.requestParameters = paramsShops;
    __weak FavoriteHomeViewController *favoriteHomeVC_Shops = self;
    repeater_Favorite_Shops.compleBlock = ^(id repeater)
    {
        [favoriteHomeVC_Shops getFavoriteShops:repeater];
    };
    repeater_Favorite_Shops.requestModal = PullData;
    repeater_Favorite_Shops.networkRequest = favorite_Shops_Request;
    
    [[DataRequestManager sharedInstance] sendRequest:repeater_Favorite_Shops];
}
//- (void)requestFavoriteCategories
//{
//    NSLog(@"请求收藏的 专辑(分类)");
//    [self.view setUserInteractionEnabled:NO];
//    favorite_Categories_Request = favorite_Categories_Request ? favorite_Categories_Request : [[FavoriteCategoryRequest alloc] init];
//    NSMutableDictionary *paramsCategory = [[NSMutableDictionary alloc] init];
//    [paramsCategory setValue:@"0" forKey:RQ_GETCATEGORYORTAGFAVORITELIST_PARM_TYPE];
//    if (_isPullDownCategory)
//    {
//        _pageIndexCategory = 1;
//        
//    }
//    [paramsCategory setValue:[NSString stringWithFormat:@"%d",_pageIndexCategory] forKey:RQ_GETCOLLECT_PARM_PAGEINDEX];
//    [paramsCategory setValue:COUNT forKey:RQ_GETCATEGORYORTAGFAVORITELIST_PARM_PAGESIZE];
//    repeater_Favorite_Categories = repeater_Favorite_Categories ? repeater_Favorite_Categories : [[DataRepeater alloc] initWithName:RQNAME_FAVORITE_GETCATEGORY_LIST];
//    repeater_Favorite_Categories.requestParameters = paramsCategory;
//  __weak FavoriteHomeViewController *favoriteHomeVC_Categoris = self;
//favorite_Categories_Request. = ^(id repeater)
//{
//    [favoriteHomeVC_Categoris getFavoriteCategories:repeater];
//};
//    repeater_Favorite_Categories.requestModal = PullData;
//    repeater_Favorite_Categories.networkRequest = favorite_Categories_Request;
//    
//    [[DataRequestManager sharedInstance] sendRequest:repeater_Favorite_Categories];
//    
//}

#pragma mark - Get list of favorite Products ,Categories ,Shops
- (void)getFavoriteProducts:(DataRepeater *)repeater
{
    NSLog(@"得到收藏的商品数据");
    if (favorite_Products_Request != nil)
    {
        NSString *type = [repeater.requestParameters objectForKey:@"type"];
        if ([type isEqualToString:@"F"])
        {
            if (repeater.isResponseSuccess)
            {
                if (self.isPullDownProduct)
                {
                    if (self.productsDetailedArray)
                    {
                        [self.productsDetailedArray removeAllObjects];
                        self.productsDetailedArray = nil;
                    }
                    self.productsDetailedArray = [NSMutableArray new];
                    [self.productsDetailedArray addObjectsFromArray:repeater.responseValue];
                    //得到 数据后 重新加载 Table, 隐藏 刷新视图
                    [self.displayFavoriteInfoTable hideLoadingView];
                    [self.displayFavoriteInfoTable.tableView reloadData];
                    //如果无商品显示无商品View
                    if (self.productsDetailedArray == nil || self.productsDetailedArray.count == 0)
                    {
                        self.info_ExceptionView.image = [UIImage imageNamed:@"bg_FatNoProduct"];
                        self.info_ExceptionView.title = LocalizedString(@"FavoriteHomeViewController_infoExceptionView1", @"还没有关注过商品");
                        self.info_ExceptionView.detail = @"";
                        [self.info_ExceptionView setNeedsDisplay];
                        [self.info_ExceptionView setHidden:NO];
                        //                        [favoriteHomeVC_Products.view bringSubviewToFront:favoriteHomeVC_Products.info_ExceptionView];
                    }
                }
                //如果是上拉加载
                else
                {
                    [self.productsDetailedArray addObjectsFromArray:repeater.responseValue];
                    //得到 数据后 重新加载 Table, 隐藏 刷新视图
                    [self.displayFavoriteInfoTable hideLoadingView];
                    [self.displayFavoriteInfoTable.tableView reloadData];
                }
                
                self.pageIndexProduct++;
                //判断是否可以获取更多
                BOOL haveMore = repeater!=nil && ((NSArray *)repeater.responseValue).count>0 && (self.productsDetailedArray.count%PAGE_COUNT == 0) && self.productsDetailedArray.count>0;
                [self.displayFavoriteInfoTable doAfterRequestSuccess:self.isPullDownProduct AndHavaMore:haveMore];
            }
            //加载失败
            else
            {
                if (self.isPullDownProduct)
                {
                    [self.displayFavoriteInfoTable hideLoadingView];
                }
                [self.displayFavoriteInfoTable doAfterRequsetFailure:self.isPullDownProduct errorInfo:repeater.errorInfo];
            }
            [self.view setUserInteractionEnabled:YES];
        }
    }
    if (_productsDetailedArray.count == 0)
    {
        [_displayFavoriteInfoTable hideLoadingView];
    }
}
- (void)getFavoriteShops:(DataRepeater *)repeater
{
    NSLog(@"得到 收藏的店铺 的信息");
    if (favorite_Shops_Request != nil)
    {
        NSString *type = [repeater.requestParameters objectForKey:@"type"];
        if ([type isEqualToString:@"S"])
        {
            if (repeater.isResponseSuccess)
            {
                if (self.isPullDownShop)
                {
                    if (self.shopsDetailedArray)
                    {
                        [self.shopsDetailedArray removeAllObjects];
                        self.shopsDetailedArray = nil;
                    }
                    self.shopsDetailedArray = [NSMutableArray new];
                    [self.shopsDetailedArray addObjectsFromArray:repeater.responseValue];
                    //得到数据后 重新加载 table
                    [self.displayFavoriteInfoTable hideLoadingView];
                    [self.displayFavoriteInfoTable.tableView reloadData];
                    
                    if (self.shopsDetailedArray == nil || self.shopsDetailedArray.count == 0)
                    {
                        self.info_ExceptionView.image = [UIImage imageNamed:@"bg_FatNoShop"];
                        self.info_ExceptionView.title = LocalizedString(@"FavoriteHomeViewController_infoExceptionView2", @"还没有关注过店铺");
                        self.info_ExceptionView.detail = @"";
                        [self.info_ExceptionView setNeedsDisplay];
                        [self.info_ExceptionView setHidden:NO];
                    }
                }
                //如果是上拉加载
                else
                {
                    [self.shopsDetailedArray addObjectsFromArray:repeater.responseValue];
                    //得到数据后 重新加载 table
                    [self.displayFavoriteInfoTable hideLoadingView];
                    [self.displayFavoriteInfoTable.tableView reloadData];
                }
                self.pageIndexShop ++;
                //判断是否可以加载更多
                BOOL haveMore = repeater!=nil && ((NSArray *)repeater.responseValue).count>0 && (self.shopsDetailedArray.count%PAGE_COUNT == 0) && self.shopsDetailedArray.count>0;
                [self.displayFavoriteInfoTable doAfterRequestSuccess:self.isPullDownShop AndHavaMore:haveMore];
            }
            //加载失败
            else
            {
                if (self.isPullDownShop)
                {
                    [self.displayFavoriteInfoTable hideLoadingView];
                }
                [self.displayFavoriteInfoTable doAfterRequsetFailure:self.isPullDownShop errorInfo:repeater.errorInfo];
            }
            [self.view setUserInteractionEnabled:YES];
        }
    }
    if (_shopsDetailedArray.count == 0)
    {
        [_displayFavoriteInfoTable hideLoadingView];
    }
}
//- (void)getFavoriteCategories
//{
//    NSLog(@"得到 收藏的分类 数据");
//    if (favorite_Categories_Request != nil)
//    {
//        __weak FavoriteHomeViewController *favoriteHomeVC_Category = self;
//        favorite_Categories_Request.getFavoriteCategoriesData = ^(DataRepeater *repeater)
//        {
//            favoriteHomeVC_Category.categoriesRepeater = repeater;
//            PageData *mPageData = favoriteHomeVC_Category.categoriesRepeater.responseValue;
//            if (favoriteHomeVC_Category.categoriesRepeater.isResponseSuccess)
//            {
//                if (favoriteHomeVC_Category.isPullDownCategory)
//                {
//                    if (favoriteHomeVC_Category.categoriesDetailedArray)
//                    {
//                        [favoriteHomeVC_Category.categoriesDetailedArray removeAllObjects];
//                        favoriteHomeVC_Category.categoriesDetailedArray = nil;
//                    }
//                    favoriteHomeVC_Category.categoriesDetailedArray = [NSMutableArray new];
//                    [favoriteHomeVC_Category.categoriesDetailedArray addObjectsFromArray:mPageData.list];
//                    //重新加载 table
//                    [favoriteHomeVC_Category.displayFavoriteInfoTable hideLoadingView];
//                    [favoriteHomeVC_Category.displayFavoriteInfoTable.tableView reloadData];
//                    
//                    if (favoriteHomeVC_Category.categoriesDetailedArray == nil || favoriteHomeVC_Category.categoriesDetailedArray.count == 0)
//                    {
//                        favoriteHomeVC_Category.info_ExceptionView.image = [UIImage imageNamed:@"bg_FatNoCategory"];
//                        favoriteHomeVC_Category.info_ExceptionView.title = @"还没有关注过专辑";
//                        favoriteHomeVC_Category.info_ExceptionView.detail = @"";
//                        [favoriteHomeVC_Category.info_ExceptionView setNeedsDisplay];
//                        [favoriteHomeVC_Category.info_ExceptionView setHidden:NO];
//                    }
//                }
//                //如果是上拉加载
//                else
//                {
//                    [favoriteHomeVC_Category.categoriesDetailedArray addObjectsFromArray:mPageData.list];
//                    //重新加载 table
//                    [favoriteHomeVC_Category.displayFavoriteInfoTable hideLoadingView];
//                    [favoriteHomeVC_Category.displayFavoriteInfoTable.tableView reloadData];
//                }
//                favoriteHomeVC_Category.pageIndexCategory++;
//                //判断是否可以加载更多
//                [favoriteHomeVC_Category.displayFavoriteInfoTable doAfterRequestSuccess:favoriteHomeVC_Category.isPullDownCategory AndHavaMore:mPageData.hasNext];
//            }
//            //加载失败
//            else
//            {
//                if (favoriteHomeVC_Category.isPullDownCategory)
//                {
//                    [favoriteHomeVC_Category.displayFavoriteInfoTable hideLoadingView];
//                }
//                [favoriteHomeVC_Category.displayFavoriteInfoTable doAfterRequsetFailure:favoriteHomeVC_Category.isPullDownCategory errorInfo:favoriteHomeVC_Category.categoriesRepeater.errorInfo];
//            }
//            [favoriteHomeVC_Category.view setUserInteractionEnabled:YES];
//        };
//    }
//    if (_categoriesDetailedArray.count == 0)
//    {
//        [_displayFavoriteInfoTable hideLoadingView];
//    }
//}

#pragma mark - CustomTableViewControllerDelegate
- (void)customTableView:(CustomTableViewController*)customTableView sendRequset:(BOOL)isFirst
{
    UserInfo *userInfo = nil;
    userInfo = [GlobalObj getUserInfo];
    if (userInfo != nil)
    {
        if (_isRequestAll)
        {
            [self requestFavoriteProducts];
            [self requestFavoriteShops];
            _isRequestAll = NO;
        }
        else
        {
            switch (_currentIndex)
            {
                case 0:
                {
                    _isPullDownProduct = isFirst;
                    [self requestFavoriteProducts];
                }
                case 1:
                {
                    _isPullDownShop = isFirst;
                    [self requestFavoriteShops];
                    break;
                }
                default:
                    break;
            }
        }
    }
    else
    {
        [_displayFavoriteInfoTable hideLoadingView];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.favoriteCategoryTable == tableView)
    {
        return [_favoriteCategoryArray count];
    }
    else
    {
        switch (_currentIndex)
        {
            case 0:
                return [_productsDetailedArray count];
                break;
            case 1:
                return [_shopsDetailedArray count];
                break;
            default:
                return 0;
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.favoriteCategoryTable == tableView)
    {
        DLOG(@"tabel");
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
            cell.textLabel.text = [_favoriteCategoryArray objectAtIndex:indexPath.row];
            cell.textLabel.font = DEFAULT_FONT(17.0f);
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.textColor = [PanliHelper colorWithHexString:@"#848484"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell右侧线条
            UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-1.5f, 0, 1.5, 80)];
            rightLine.tag = 100;
            rightLine.backgroundColor = [PanliHelper colorWithHexString:@"#d8d8d8"];
            [cell addSubview:rightLine];
            //cell下的线条
            UIView *bottonLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80-1.5, tableView.frame.size.width, 1.5f)];
            bottonLine.tag = 101;
            bottonLine.backgroundColor = [PanliHelper colorWithHexString:@"#d8d8d8"];
            [cell addSubview:bottonLine];
        }

        UIView *bottonLine = (UIView *)[cell viewWithTag:101];
        UIView *rightLine = (UIView *)[cell viewWithTag:100];
        if (_currentIndex == indexPath.row)
        {
            cell.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
            rightLine.hidden = YES;
            bottonLine.hidden = NO;
        }
        else
        {
            cell.backgroundColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
            rightLine.hidden = NO;
            bottonLine.hidden = YES;
        }
        
        return cell;
    }
    if (_displayFavoriteInfoTable.tableView == tableView)
    {
        NSLog(@"-=-=列表_displayFavoriteInfoTable-=-=-=-=-=-=-");
        //根据当前收藏的是 哪种类型，展示相应的 tableCell
        switch (_currentIndex)
        {
            case 0:
            {
                FavoriteProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoriteProduct"];
                if (!cell)
                {
                    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"FavoriteProductsCell" owner:nil options:nil];
                    for (id obj in nibs)
                    {
                        if ([obj isKindOfClass:[FavoriteProductsCell class]])
                        {
                            cell = (FavoriteProductsCell *)obj;
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            break;
                        }
                    }
                }
                FavoriteProducts *favoritePro = (FavoriteProducts *)[self.productsDetailedArray objectAtIndex:indexPath.row];
                [cell.productImageView setImageWithURL:[NSURL URLWithString:favoritePro.thumbnail] placeholderImage:[UIImage imageNamed:@"icon_product"]];
                cell.productNameLabel.font = DEFAULT_FONT(17);
                cell.productNameLabel.text = favoritePro.productName;
                cell.productPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",favoritePro.price];
                
                return cell;
                break;
            }
            case 1:
            {
                FavoriteShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoriteShop"];
                if (!cell)
                {
                    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"FavoriteShopCell" owner:nil options:nil];
                    for (id obj in nibs)
                    {
                        if ([obj isKindOfClass:[FavoriteShopCell class]])
                        {
                            cell = (FavoriteShopCell *)obj;
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            break;
                        }
                    }
                }
                FavoriteShops *favoriteShop = (FavoriteShops *)[self.shopsDetailedArray objectAtIndex:indexPath.row];
                [cell.shopImage setImageWithURL:[NSURL URLWithString:favoriteShop.logo] placeholderImage:[UIImage imageNamed:@"icon_product"]];
                cell.shopImage.layer.masksToBounds = YES;
                [cell.shopImage.layer setCornerRadius:53.5f];
                cell.shopNameLabel.text = ![NSString isEmpty:favoriteShop.keeperName]? favoriteShop.keeperName : favoriteShop.shopName;
                cell.shopNameLabel.font = DEFAULT_FONT(17);
                //店铺来源
                NSString *str_Image = [self getSourceImage:favoriteShop.siteName];
                cell.shopOriginImage.image = [UIImage imageNamed:str_Image];
                
                return cell;
                break;
            }
            default:
                break;
        }
    }
    return nil;
}
- (NSString*)getSourceImage:(NSString*)strImage
{
    if([NSString isEmpty:strImage])
    {
        return nil;
    }
    if([strImage isEqualToString:@"淘宝"])
    {
        return @"icon_FatProduct_Taobao";
    }
    else if([strImage isEqualToString:@"天猫"])
    {
        return @"icon_FatProduct_Tmall";
    }
    else
    {
        return nil;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.favoriteCategoryTable == tableView)
    {
        return 80.0f;
    }
    else if(_displayFavoriteInfoTable.tableView == tableView)
    {
        float cellHeight =[self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
        return cellHeight;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
    [self checkLoginWithBlock:^{
        if (self.favoriteCategoryTable == tableView)
        {
            if (_currentIndex != indexPath.row)
            {
                _currentIndex = (int)indexPath.row;
                
                [_displayFavoriteInfoTable.tableView reloadData];
                [tableView reloadData];
                
            }
        }
        else
        {
            switch (_currentIndex)
            {
                case 0:
                {
                    
                    break;
                }
                case 1:
                {
                    
                    break;
                }
                    
                default:
                    break;
            }
        }
    }];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_displayFavoriteInfoTable.tableView == tableView)
    {
        return YES;
    }
    else
        return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_displayFavoriteInfoTable.tableView == tableView)
    {
        if (UITableViewCellEditingStyleDelete == editingStyle)
        {
            switch (_currentIndex)
            {
                case 0:
                {
                    NSLog(@"commitEditing点击取消关注");
                    FavoriteProducts *product = [_productsDetailedArray objectAtIndex:indexPath.row];
                    NSString *productID = [NSString stringWithFormat:@"%d",product.favoriteID];
                    [_productsDetailedArray removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    [_displayFavoriteInfoTable.tableView reloadData];
                    [self deleteRequest:1 ids:productID];
                    
                    break;
                }
                case 1:
                {
                    FavoriteShops *shop = [_shopsDetailedArray objectAtIndex:indexPath.row];
                    NSString *shopID = [NSString stringWithFormat:@"%d",shop.isFavorite];
                    [_shopsDetailedArray removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [_displayFavoriteInfoTable.tableView reloadData];
                    [self deleteRequest:0 ids:shopID];
                    
                    break;
                }
                default:
                    break;
            }
        }
        
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LocalizedString(@"FavoriteHomeViewController_titleForDeleteConfirmationButton", @"取消关注");
}

#pragma mark - DelegateFavoriteRequest
//注册 删除收藏的信息
- (void)deleteRequest:(int)type ids:(NSString*)iIds
{
    //type 0 为店铺 1为商品 2为专辑
    req_DeleteFavoriteOnly = [[DeleteFavoriteOrShopRequest alloc] init];
    data_DeleteFavoriteOnly = [[DataRepeater alloc] initWithName:RQNAME_DELETEFAVORITES_FaList];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%d",type] forKey:RQ_DELETEFAVORITE_PARM_TYPE];
    [params setValue:iIds forKey:RQ_DELETEFAVORITE_PARM_IDS];
    
    data_DeleteFavoriteOnly.requestParameters = params;
    data_DeleteFavoriteOnly.notificationName = RQNAME_DELETEFAVORITES_FaList;
    __weak FavoriteHomeViewController *favoriteVC_Delete = self;
    data_DeleteFavoriteOnly.compleBlock = ^(id repeater)
    {
        [favoriteVC_Delete DeleteResponse:repeater];
    };
    data_DeleteFavoriteOnly.requestModal = PushData;
    data_DeleteFavoriteOnly.networkRequest = req_DeleteFavoriteOnly;
    NSArray *arr_Ids = [iIds split:@","];
    data_DeleteFavoriteOnly.updateDataSouce = arr_Ids;
    [[DataRequestManager sharedInstance] sendRequest:data_DeleteFavoriteOnly];
}

- (void)DeleteResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        int type = [[repeater.requestParameters objectForKey:RQ_DELETEFAVORITE_PARM_TYPE] intValue];
        switch (type)
        {
            case 0:
            {
                //店铺
                if(_shopsDetailedArray == nil ||  _shopsDetailedArray.count <= 0)
                {
                    _info_ExceptionView.image = [UIImage imageNamed:@"bg_FatNoShop"];
                    _info_ExceptionView.title = LocalizedString(@"FavoriteHomeViewController_infoExceptionView2", @"还没有关注过店铺");
                    _info_ExceptionView.detail = @"";
                    [_info_ExceptionView setNeedsDisplay];
                    [_info_ExceptionView setHidden:NO];
                }
                break;
            }
            case 1:
            {
                //商品
                if(_productsDetailedArray == nil || _productsDetailedArray.count <= 0)
                {
                    _info_ExceptionView.image = [UIImage imageNamed:@"bg_FatNoProduct"];
                    _info_ExceptionView.title = LocalizedString(@"FavoriteHomeViewController_infoExceptionView1", @"还没有关注过商品");
                    _info_ExceptionView.detail = @"";
                    [_info_ExceptionView setNeedsDisplay];
                    [_info_ExceptionView setHidden:NO];
                }
                break;
            }
            default:
                break;
        }
    }
    else
    {
        ErrorInfo *errorInfo = repeater.errorInfo;
        [self showHUDErrorMessage:errorInfo.message];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
