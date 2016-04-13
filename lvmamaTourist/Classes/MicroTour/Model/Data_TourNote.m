//
//  Data_TourNote.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Data_TourNote.h"

@implementation Data_TourNote

/**
 *  初始化六条加载数据
 */
+(NSArray *)getTourData
{
    
    NSArray *array = @[
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=c609d0035b27694f267a27e76d801a5a&postkey=1C27C1A3070A12501E147A2800A7F78F",
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=791cf4ca3881e55c729404d3be64543a&postkey=0F006BF332BB22E3FA294C430F7E223B",
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=7914ea3ddcb482d26317fdbabe2a17f3&postkey=0E55BD09213C643CC36DC95CEF3E8D63",
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=bb1a65c16a2ffac0a3be8b44e69100e4&postkey=E4F69C73756BB3DB8ED75C50396B471F",
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=986e043b26799edc48ce6859253befdd&postkey=8F4857FF127557596331200C20ACB01B",
            @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116677&globalLongitude=112.503633&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=dbba57dc10dc5370e0e449bd3402edd0&postkey=DD745391C514D53A5498EF7B4B5CD08F"
            ];
    
    return array;
}


@end
