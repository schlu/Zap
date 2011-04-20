#
#  rb_main.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright (c) 2011 Chalk. All rights reserved.
#

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'

require 'jalist'

# Loading all the Ruby project files.
main = File.basename(__FILE__, File.extname(__FILE__))
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.glob(File.join(dir_path, '*.{rb,rbo}')).map { |x| File.basename(x, File.extname(x)) }.uniq.each do |path|
  if path != main
    require(path)
  end
end

Dir.glob(File.join(dir_path, '*.bridgesupport')).uniq.each do |path|
    load_bridge_support_file path
end

# Starting the Cocoa main loop.
NSApplicationMain(0, nil)
