# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

	
# Users
print("Adding survey answers...\n")
		expert = User.find_by_email("expert@expert.com")
		
    chandan = User.find_by_email("chandan@virtueinfo.com")
    chandan.experts << expert
    chandan.save!
    
    juha = User.find_by_email("juha@vendep.com")
    juha.experts << expert
    juha.save!
    
    nitin = User.find_by_email("nitin@vendep.com")
    nitin.experts << expert
    juha.save!
    
    
    

    

