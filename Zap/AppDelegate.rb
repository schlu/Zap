#
#  AppDelegate.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class AppDelegate
    attr_accessor :window
    
    def applicationDidFinishLaunching(a_notification)
        @main_view_controller = MainViewController.new
        @main_view_controller.view.frame = window.contentView.frame
        window.contentView.addSubview @main_view_controller.view
    end
    
    def reload_application
        @main_view_controller.setup_links
    end
end

