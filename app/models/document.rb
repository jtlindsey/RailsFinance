require 'file_size_validator' 

class Document < ActiveRecord::Base
  # "You tried to define an association named transaction on the model Category, 
  # but this will conflict with a method transaction already defined by Active Record. 
  # Please choose a different association name."
  # This is caused by ActiveRecord already using a method named "transactions".
  # alternative is: belongs_to :owner, foreign_key: "id", class_name: "Transaction"
  belongs_to :owner, foreign_key: "id", class_name: "Transaction"
  
  mount_uploader :efile, EfileUploader
  validates_presence_of :efile
  validates :efile,  
    :file_size => { 
    :maximum => 5.0.megabytes.to_i 
  }
  validate :max_uploads_per_transaction

  def max_uploads_per_transaction
    max_uploads = 3
    number_of_documents = Transaction.find_by(id: self.transaction_id).documents.count

    if number_of_documents >= max_uploads
      errors.add(:efile, "You have reached the #{max_uploads} uploads per transaction limit.")
    end
  end

end
