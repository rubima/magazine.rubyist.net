#!/usr/local/bin/ruby
#  encoding: utf-8
#  daybook_viewindex.rb

#  Created by midori on 2006-08-26.
#  Copyright (c) 2006. All rights reserved.
#  You can distribute/modify this program under the terms of the Ruby License.
#  Last change: 2006-10-25.
#________________________________________ 
require "daybook"
base = MainBase.load('base/daybook_base')
h_base =  base.make_base_hash
#________________________________________
require "index/d_index"
#________________________________________ 

begin
  SAFE = 3
  newindex = NewIndex.new(h_base)
  newindex.view_index
  newindex.view_archives
  newindex.view_admin
  DaybookPrint.new.custom_print("Success!")
rescue
  DaybookPrint.new.error_out
end
#________________________________________
#DaybookPrint.new.custom_print(ans)
