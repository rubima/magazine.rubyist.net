#!/usr/local/bin/ruby
#  encoding: utf-8
#  d_index.rb
#
#  Created by midori on 2006-09-24.
#  Copyright (c) 2006. All rights reserved.
#  You can distribute/modify this program under the terms of the Ruby License.
#  Last change: 2006-10-27.
#  2006-10-25 view_archives changed
#______________________________________________________________ NewINDEX
class NewIndex
  include MakeXML
  include ReadWrite
  def initialize(myhash)
    @path_index_file = myhash["path_index_file"]
    @path_xml_dir = myhash["dir_xml"]
    @path_admin_dir = myhash["dir_admin"]
    @path_archive_dir = myhash["dir_xhtml"]
    @path_url = myhash["url_archives_dir"]
    
    @path_index_xsl = myhash["f_xsl_index"]
    @path_indexhtml = myhash["f_indexhtml"]
    @entryview = myhash["entryview"]
    
    @path_log_xml = myhash["f_log_xml"]
    @path_archives_xsl = myhash["f_xsl_archives"]
    @path_archivehtml = myhash["f_archivehtml"]
    @path_xsl = myhash["f_xsl_post"]
    
    @path_admin_xsl = myhash["f_xsl_admin"]
    @path_adminhtml = myhash["f_adminhtml"]
    
    @list_element = ["entry/meta/itemcount", "entry/meta/uri", "/entry/meta/metadate/t_i/", 
    "entry/item/telop","entry/item/subject", "entry/item/date", "entry/item/name", "entry/item/comment/p"]
  end
  def view_all
    view_index
    view_archives
    view_admin
  end
  
  def view_index
    list_targetxml = m_common_count_xmlfiles(@path_log_xml)
    unless list_targetxml.empty?
      list_targetxml = list_targetxml[0..@entryview]
      new_index_xml = p_index_xml_make(list_targetxml)
      new_index_xhtml = m_apply_xsl_path(new_index_xml, @path_index_xsl)
      p_common_xhtml_save( @path_indexhtml, new_index_xhtml )
      return "done"
    end
  end
  def view_archives
    archives_list_targetxml = m_common_count_xmlfiles(@path_log_xml)
    unless archives_list_targetxml.empty?
      return p_archives_xml_make(archives_list_targetxml)
    end
  end
  def view_admin
    archives_list_targetxml = m_common_count_xmlfiles(@path_log_xml)
    unless archives_list_targetxml.empty?
      str_xml = p_admin_xml_make(archives_list_targetxml)
      str_xhtml = m_apply_xsl_path(str_xml, @path_admin_xsl)
      p_common_xhtml_save( @path_adminhtml, str_xhtml )
    end
  end
  
  private
  def p_common_xhtml_save(path_html, str_xhtml)
    if FileTest.exist?(path_html)
      cash_trash_file = File.join(@path_admin_dir , "daybook_trash", "cash.txt")
      File.rename(path_html, cash_trash_file)
    end
    m_write_file(path_html, str_xhtml)
  end
  def p_index_xml_make(list_targetxml)
    indexdoc = m_make_new_xml("daybookindex")
    
    docroot = indexdoc.root; docroot.add_text("\n")
    meta = docroot.add_element("metadate")
    meta.add_text(Time.now.to_s); docroot.add_text("\n")
    items = docroot.add_element("items")
    #---------- Add Every Entry of XML FILE
    list_targetxml.each{|f| 
      onefiledoc = Document.new(File.new( f ))
      items.add_text("\n")
      item = items.add_element("item")
      @list_element.each{|e| item.add_element(onefiledoc.elements[e]) unless onefiledoc.elements[e].nil?}
    }
    #---------- Add Every Comment of XML FILE
    ele_comments = p_makexml_comment
    docroot.add_element(ele_comments)
    #----------
    items.add_text("\n")
    docroot.add_text("\n")
    return indexdoc.to_s
  end
  def p_makexml_comment
    #----------Temp Hash
    h = Hash.new
    list_sort = m_common_count_xmlfiles(@path_log_xml)
    list_sort.each{|f|
      onefiledoc = Document.new(File.new( f ))
      # 20060923
      urii =  onefiledoc.elements["entry/meta/uri"].deep_clone
      ssubject =  onefiledoc.elements["entry/item/subject"].deep_clone
      a = onefiledoc.get_elements("entry/item_comment")
       unless a.nil?
         a.each{|e|
           h[e.elements["date"].text] = [urii, ssubject, 
           e.elements["date"], e.elements["name"],e.elements["comment/p"]]
           }
       end
    }
    #---------- Comments Element
    comments = REXML::Element.new( "comments" )
    h_sort = h.sort.reverse[0..4]#Recent Comment 1 to 5
    h_sort.each{|aray|
      
      item_comment = REXML::Element.new( "item_comment" )
      v = aray[1]
      v.each{|i| i_name = item_comment.add_element(i.name); i_name.add_text(i.text) }
      comments.add_element(item_comment)
      }
    #----------
    return comments
  end
  def p_admin_xml_make(archives_list_targetxml)
    h = Hash.new{|h, key| h[key] = []}
    archivesdoc = m_make_new_xml("archives")
    docroot = archivesdoc.root
    meta = docroot.add_element("metadate")
    meta.add_text(Time.now.to_s)
    docroot.add_text("\n")
    items = docroot.add_element("items")
    #----------
    archives_list_targetxml.each{|f| 
     onefiledoc = Document.new(File.new( f ))
     entry = REXML::Element.new( "entry" )
     @list_element.each{|e| entry.add_element(onefiledoc.elements[e]) unless onefiledoc.elements[e].nil? }
     
     onefiledoc.root.get_elements('item_comment').each{|com|
       comments = REXML::Element.new( "comments" )
       comments.add_element(com.elements["date"])
       comments.add_element(com.elements["postno"])
       comments.add_element(com.elements["name"])
       entry.add_element(comments)
       }
     
     y = onefiledoc.root.elements['meta/metadate/d_y'].text
     m = onefiledoc.root.elements['meta/metadate/d_m'].text
     metadate = [y,"/",m].to_s
     h["#{metadate}"] << entry
    }
    
    h_sort = h.sort.reverse
    h_sort.each{|ary|
      item = items.add_element("item")
      year = item.add_element("year")
      year.add_text(ary[0].to_s)
      ary[1].each{|i| item.add_text(i) }      
      }
    items.add_text("\n")
    docroot.add_text("\n")
    return archivesdoc.to_s
  end
  def p_archives_xml_make(archives_list_targetxml)
    # 2006-10-25 Make new archives_index.html
    entry_hash = Hash.new{|h, key| h[key] = []}
    archives_list_targetxml.each{|f| 
      onefiledoc = Document.new(File.new( f )); entry = REXML::Element.new( "entry" )
      @list_element.each{|e| entry.add_element(onefiledoc.elements[e]) unless onefiledoc.elements[e].nil? }
     y = onefiledoc.root.elements['meta/metadate/d_y'].text
     m = onefiledoc.root.elements['meta/metadate/d_m'].text
     metadate = [y,"/",m].to_s
     entry_hash["#{metadate}"] << entry
    }
    #entry_hash = {"2006/09"=>[EntryElement, EntryElement], "2006/10"=>[EntryElement, EntryElement]}
    
    xml_archive = m_make_new_xml("archives")
    a_items = m_add_my_element(xml_archive.root, "items", "")
    # sort.reverse?
    entry_hash.sort.reverse.each{|k, v| 
      #a_item = m_add_my_element(a_items, "item", "")
      a_item = a_items.add_element("item")
      m_add_my_element(a_item, "year", k)
      #/daybook/daybook_archives/2006/09/a_index.html
      path_year_html = File.join(@path_url, k, "a_index.html")
      m_add_my_element(a_item, "year_uri", path_year_html)
      # year html
      xml_year = m_make_new_xml("archives")
      items = xml_year.root.add_element("items"); item = items.add_element("item")
      year = m_add_my_element(item, "year", k)
    
      v.each{|x| item.add_element(x)}
      xhtml_year = m_apply_xsl_path(xml_year.to_s, @path_archives_xsl)
      require "fileutils"
      path_dir_year = File.join(@path_archive_dir, k)
      FileUtils.mkdir_p(path_dir_year)
      path_year_html = File.join(path_dir_year, "a_index.html")
      p_common_xhtml_save(path_year_html, xhtml_year)
      }
      str_arc_index_xhtml = m_apply_xsl_path(xml_archive.to_s, @path_archives_xsl)
      p_common_xhtml_save(@path_archivehtml, str_arc_index_xhtml)
      return xml_archive
    
  end

end