function link=Tlink(args)%ro, l , d, alpha
  
  link=rotz(args(1))*trans(args(2),0,args(3))*rotx(args(4))
  
end