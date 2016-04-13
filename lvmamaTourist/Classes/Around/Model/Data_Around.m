//
//  Data_Around.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Data_Around.h"

@implementation Data_Around

/**
 *  获取肇庆:酒店的刷新url
 */
+ (NSMutableArray *)getLocationOneData
{
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116684&globalLongitude=112.503625&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=a42a4b3752ddc493551ac0397f6864e4&postkey=B6A313011AFE93864D4948AD84C3201F",
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116684&globalLongitude=112.503625&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=083c8c5226acb66b2d0f58f918eb607d&postkey=21070569DD5C478627BAC4CBF0EEB48D",
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116684&globalLongitude=112.503625&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=5137304316fa937c4aeabc935283723a&postkey=6D5BA58A03D6F12AE2A93A6A2C925565",
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116684&globalLongitude=112.503625&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=3b0f5994fcfdf88f0a1c996a133150ed&postkey=AAE95F599C5DBCD158EE5AD18FB8AFA5",
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116684&globalLongitude=112.503625&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=76ce93e712a5c943d49e136f291289cf&postkey=7615ECD6FC7EB8F10E43EB84683AF6C7",
                      nil];
    
/*参数
 pageSize=20&version=2.0.0&windage=100&pageNum=1&latitude=23.116684&longitude=112.503625

 */
    
    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.search.searchHotel&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116655&globalLongitude=112.503603&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=b7271c50dea023a948bed0a408296169&postkey=8B02D0D44584019E81348D4BB8A16653",
            @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.search.searchHotel&osVersion=4.4.4&lvversion=7.3.2&lvsessionid=4c5dda06-1245-467b-af01-edc5a3e795a3&globalLatitude=23.116655&globalLongitude=112.503603&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=2d3ba23a8f612b2cf025bcd6e5a47478&postkey=4A0D7467DF450F57501B2E91DE4D0450",
                       nil];
    
/*参数
distance=10&departureDate=2015-12-12&arrivalDate=2015-12-11&longitude=112.503603&hotelStar=104%2C105%2C102%2C103%2C100%2C101&latitude=23.116655&version=2.0.0&pageIndex=1
 */
    
    return (NSMutableArray *)@[array1,array2];
}



@end
