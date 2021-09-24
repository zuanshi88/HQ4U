

   case @selection[:type] 
        when /\Asingle/ 
            single_topic(@selection[:topic])
        when /\Amultiple/ 
             multiple_topic(@selection[:topic])
        else
            exit
        end 