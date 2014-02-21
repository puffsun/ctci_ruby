module OnlineReading

  class ReadingSystem
    def initialize(lib, user_manager)
      @lib = lib
      @user_manager = user_manager
    end
  end

  class Library
    def add_book(type, title)
    end
  end

  class BookShelf

    def initialize(group)
      @shelves = []
      @grp = group
    end

    def add_book(grp, title)
    end
  end

  class Book
    attr_accessor :title, :type
  end

  class UserManager
    def initialize
      @users = []
    end

    def add_user(user)
    end
  end

  class User
    def initialize(account)
      @account = account
    end
  end

  class Account
    def initialize
      @active_book = nil
    end
  end
end
