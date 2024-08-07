# frozen_string_literal: true

class UnencryptedBook < ActiveRecord::Base
  self.table_name = "encrypted_books"
end

class EncryptedBook < ActiveRecord::Base
  self.table_name = "encrypted_books"

  encrypts :name, deterministic: true
end

class EncryptedBookWithUniquenessValidation < ActiveRecord::Base
  self.table_name = "encrypted_books"

  validates :name, uniqueness: true
  encrypts :name, deterministic: true
end

class EncryptedBookWithDowncaseName < ActiveRecord::Base
  self.table_name = "encrypted_books"

  validates :name, uniqueness: true
  encrypts :name, deterministic: true, downcase: true
end

class EncryptedBookThatIgnoresCase < ActiveRecord::Base
  self.table_name = "encrypted_books"

  encrypts :name, deterministic: true, ignore_case: true
end

class EncryptedBookWithUnencryptedDataOptedOut < ActiveRecord::Base
  self.table_name = "encrypted_books"

  validates :name, uniqueness: true
  encrypts :name, deterministic: true, support_unencrypted_data: false
end

class EncryptedBookWithUnencryptedDataOptedIn < ActiveRecord::Base
  self.table_name = "encrypted_books"

  validates :name, uniqueness: true
  encrypts :name, deterministic: true, support_unencrypted_data: true
end

class EncryptedBookWithBinary < ActiveRecord::Base
  self.table_name = "encrypted_books"

  encrypts :logo
end

class EncryptedBookWithSerializedBinary < ActiveRecord::Base
  self.table_name = "encrypted_books"

  serialize :logo, coder: JSON
  encrypts :logo
end

class EncryptedBookWithCustomCompressor < ActiveRecord::Base
  module CustomCompressor
    def self.deflate(value)
      "[compressed] #{value}"
    end

    def self.inflate(value)
      value
    end
  end

  self.table_name = "encrypted_books"

  encrypts :name, compressor: CustomCompressor
end
