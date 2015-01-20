//
//  MessageTopicCell.h
//  PanliApp
//
//  Created by jason on 13-4-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>


/**************************************************
 * 内容描述: 短信Cell
 * 创 建 人: jason
 * 创建日期: 2013-4-18
 **********************************修改记录1********
 * 修改日期: 2013-06-17
 * 修 改 人: 刘彬
 * 修改内容: 代码优化，view修改
 **************************************************/
@interface MessageTopicCell : UITableViewCell

{
    //是否已读
    UIImageView *img_isRead;
    
    //图标
    UIImageView *img_icon;
    
    //标题、类型
    UILabel *lab_title;
    
    //时间
    UILabel *lab_date;
    
    //内容
    UILabel *lab_content;
    
    //箭头
    UIImageView *img_arrow;
    
    //虚线
    UIImageView *img_line;
    
    //数据
    id dataSource;
    
    int indexRow;
    
}

-(void)SetData:(id)object type:(int)type indexRow:(int)row;


@end
