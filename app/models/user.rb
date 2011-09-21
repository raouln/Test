require 'digest/sha2'

class User < ActiveRecord::Base
    
    # Create two virtual (in memory only) attributes to hold the password and its confirmation.
    attr_accessor :new_password, :new_password_confirmation
    # We need to validate that the user has typed the same password twice
    # but we only want to do the validation if they've opted to change their password.
    validates_confirmation_of :new_password, :if=>:password_changed?
    
    before_save :hash_new_password, :if=>:password_changed?
    
    # By default the form_helpers will set new_password to "",
    # we don't want to go saving this as a password
    def password_changed?
      !@new_password.blank?
    end
    
    private
    # This is where the real work is done
    def hash_new_password
      # First reset the salt to a new random string.  You could choose a
      # longer string here but for a salt, 8 bytes of randomness is probably
      # fine.  Note this uses SecureRandom which will use your platform's secure
      # random number generator.
      self.salt = ActiveSupport::SecureRandom.base64(8)
      # Now calculate the hash of the password, with the salt prepended, store
      # store that in the database
      self.hashed_password = Digest::SHA2.hexdigest(self.salt + @new_password)
    end

    # As is the 'standard' with rails apps we'll return the user record if the
    # password is correct and nil if it isn't.
    def self.authenticate(email, password)
      # Because we salt the passwords we can't do this query in one part, first
      # we need to fetch the potential user
      if user = find_by_email(email)
        # Then compare the provided password against the hashed one in the db.
        if user.hashed_password == Digest::SHA2.hexdigest(user.salt + password)
          # If they match we return the user 
          return user
        end
      end
      # If we get here it means either there's no user with that email, or the wrong
      # password was provided.  But we don't want to let an attacker know which. 
      return nil
    end
  end