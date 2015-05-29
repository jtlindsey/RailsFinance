class Transfer < Transaction
  #should have access to withdrawal and deposit class
  #so it can perform two simutanious actions?
  #or remove it completely, change transaction history to transaction, 
  #and in transaction model, make a method that does both?
end