require './app/models/model_helper.rb'

    class Weblink < ActiveRecord::Base 
        belongs_to :project
        belongs_to :book
        belongs_to :note 
        belongs_to :addendum 
        
        extend ModelHelper
       

     def self.index_content
            #   t.integer "project_id"
            #     t.string "title"
            #     t.string "url"
            #     t.string "description"

         
            content_hash = {}
            self.all.each do |link|
                    unless link.title == nil || link.title == ""
                        link.title.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(link)
                        end 
                    end 
                    unless link.description == nil || link.description == ""
                        link.description.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(link)
                        end 
                    end 
                end 
            content_hash
        end





end 