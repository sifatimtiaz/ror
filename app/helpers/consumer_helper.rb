module ConsumerHelper
  #def paginate(query,page,perpage,count)  
  # try and make more modular
  def paginate(url,page,perpage,count)
    f = Float(count)/Float(perpage)
    numpages = f.ceil    
    if(numpages > 1)
      contain = Builder::XmlMarkup.new
      contain.div("class"=>"pagination") {
  
        for i in (0..numpages)

            pg = i.to_i + 1
            if( pg <= numpages )
              if( i.to_i != page.to_i )
                #contain.a("href"=>"/search/index/?pg="+i.to_s+"&amp;query="+query, "class"=>"paginateon") {
                contain.a("href"=>url+"pg="+i.to_s, "class"=>"paginateon") {
                  contain.text! pg.to_s
                }
              else
                #contain.a("href"=>"/search/index/?pg="+i.to_s+"&amp;query="+query, "class"=>"paginateoff") {
                contain.a("href"=>url+"pg="+i.to_s, "class"=>"paginateoff") {
                  contain.text! pg.to_s
                }
              end            
            end
        end # end for
        
      }
    end # end if > 0
  end

  def paginate2(url,page,perpage,count)
    f = Float(count)/Float(perpage)
    numpages = f.ceil    
    if(numpages > 1)
      contain = Builder::XmlMarkup.new
      contain.ul("class"=>"pagination") {
  
        for i in (0..numpages)

            pg = i.to_i + 1
            if( pg <= numpages )
              if( i.to_i != page.to_i )
                contain.li {
  			contain.a("href"=>url+"pg="+i.to_s, "class"=>"paginateon") {
        	          contain.text! pg.to_s
                	}
		} 
              else
                contain.li {
			contain.a("href"=>url+"pg="+i.to_s, "class"=>"paginateoff") {
                  		contain.text! pg.to_s
                	}
		}
              end            
            end
        end # end for
        
      }
    end # end if > 0
  end
  
end
