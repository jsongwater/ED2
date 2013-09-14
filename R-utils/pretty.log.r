#==========================================================================================#
#==========================================================================================#
#     Function that creates a pretty scale in log co-ordinates.                            #
#------------------------------------------------------------------------------------------#
pretty.log = function(x,base=10,n=10){
   log.neat  = pretty(x=log(x,base=base),n=n)
   dlog.neat = median(diff(log.neat))
   neat      = base^log.neat
   nact      = length(neat)



   #---------------------------------------------------------------------------------------#
   #     In case it is a base 10, make it even prettier.                                   #
   #---------------------------------------------------------------------------------------#
   if (base == 10 && dlog.neat %wr% c(0.1,0.5)){
      sel  = abs(log.neat - as.integer(log.neat)) < 0.5 * dlog.neat
      tens = sort(c(neat[sel],base^(c(floor(min(log.neat)),ceiling(max(log.neat))))))

      #------------------------------------------------------------------------------------#
      #      Fix scale so it looks nicer if dtens is 2 or 3.                               #
      #------------------------------------------------------------------------------------#
      if (dlog.neat < 0.15){
         mult    = c(1,2,3,5,7)
      }else if (dlog.neat < 0.35){
         mult    = c(1,2,5)
      }else{
         mult    = c(1,3)
      }#end if
      vlevels = sort(unique(c(mult %o% tens)))
      aa      = min(which(vlevels > min(neat)))-1
      zz      = max(which(vlevels < max(neat)))+1
      vlevels = vlevels[aa:zz]
      #------------------------------------------------------------------------------------#
   }else{
      vlevels = neat
   }#end if
   #---------------------------------------------------------------------------------------#



   power.base  = base^(floor(log(x=vlevels,base=base)))
   npow        = length(unique(power.base))
   ndigits     = ceiling(log(nact/npow,base=base))
   vlevels     = round(vlevels / power.base,digits=ndigits) * power.base

   return(vlevels)
}#end function
#==========================================================================================#
#==========================================================================================#
