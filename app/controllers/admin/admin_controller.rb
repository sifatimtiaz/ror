# Routes consumer website traffic
class Admin::AdminController < ActionController::Base
  layout "admin"
  
  # method for uploading files
  def uploadfile(fileobj,dbobj,param,directory,thumb,resize,med)
     if(fileobj && fileobj != "")
      if( fileobj.original_filename != "" )
        if(thumb == false && med == false)
         filename = "#{RAILS_ROOT}/public/images/"+directory+"/"+fileobj.original_filename
         dbobj[param] = fileobj.original_filename
        else if(thumb == true)
         filename = "#{RAILS_ROOT}/public/images/"+directory+"/"+fileobj.original_filename.sub(".","_thumb.")
         dbobj[param] = fileobj.original_filename.sub(".","_thumb.")
       else
         filename = "#{RAILS_ROOT}/public/images/"+directory+"/"+fileobj.original_filename.sub(".","_med.")
         dbobj[param] = fileobj.original_filename.sub(".","_med.")
       end
       end
       
       File.open(filename,"wb") { |f| f.write(fileobj.read) }
       fileobj.rewind
         if(resize == true)
           # thumb == true ? resize(filename,80) : resize(filename,200)
           thumb == true ? resize(filename,true) : resize(filename,false)
            med == true ? resizeMed(filename,true) : resize(filename,false)
          
         end
      end
    end   
  end
  
  # method for resizing images
  # http://www.tutorialized.com/tutorial/rmagick/11954
  # http://www.simplesystems.org/RMagick/doc/index.html
  def resize(filename,thumb)
    pic = Magick::Image.read(filename).first
    if(pic != nil)      
      # default sizes
      tmbw = 80
      minw = 80
      #minw = 200
      maxw = width = 400
      
      #image sizes
      picw = pic.columns
      pich = pic.rows 
      
      if(thumb == true)
        width = tmbw
      else
        if( picw >= maxw )
          width = maxw
        else
          width = minw
        end
      end     

      height = (pich.to_f / picw.to_f) * width
      pic.crop_resized!(width,height)
      pic.write(filename)
      
    end    
  end
  
  def resizeMed(filename,med)
    pic = Magick::Image.read(filename).first
    if(pic != nil)      
      # default sizes
      tmbw = 136
      minw = 250
      maxw = width = 400
      
      #image sizes
      picw = pic.columns
      pich = pic.rows 
      
      if(med == true)
        width = tmbw
      else
        if( picw >= maxw )
          width = maxw
        else
          width = minw
        end
      end     

      height = (pich.to_f / picw.to_f) * width
      pic.crop_resized!(width,height)
      pic.write(filename)
      
    end    
  end

end
