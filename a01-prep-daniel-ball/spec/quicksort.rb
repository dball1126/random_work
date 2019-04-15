class Array
    def my_zip(*args)

        zip_arr = [] 

        self.each do |el| 
            arr = [el]
            el.each do |i|

                arr << i.shift 
            end
            zip_arr << arr
        end
        
            zip_arr

    end
end