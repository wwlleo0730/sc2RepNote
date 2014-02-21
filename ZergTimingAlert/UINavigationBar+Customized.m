#import "UINavigationBar+Customized.h"
@implementation UINavigationBar (Customized)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"navibar_1.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end


@implementation UIToolbar (Customized1)
- (void)drawRect:(CGRect)rect {
    if (self.tag == 111) {
        UIImage *image = [UIImage imageNamed:@"navibar_1.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}
@end


