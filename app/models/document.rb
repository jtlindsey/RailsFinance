class Document < ActiveRecord::Base
  mount_uploader :efile, EfileUploader
  # "You tried to define an association named transaction on the model Category, 
  # but this will conflict with a method transaction already defined by Active Record. 
  # Please choose a different association name."
  # This is caused by ActiveRecord already using a method named "transactions".
  # alternative
  belongs_to :owner, foreign_key: "id", class_name: "Transaction"
end
