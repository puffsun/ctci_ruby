
require 'singleton'

module CallCenter

  # Singleton pattern, get an instance of CallHandler with CallHandler.instance
  class CallHandler
    include Singleton

    def initialize
      @employees = {}
      fill_in_employees
    end

    def fill_in_employees
      @employees[:Respondent] = [] << Respondent.new << Respondent.new << Respondent.new << Respondent.new
      @employees[:Manager] = [] << Manager.new << Manager.new
      @employees[:Director] = [] << Director.new
    end

    def dispatch_call(call)
      handler = get_handler_for_call(call)
      if handler.nil?
        "waiting..."
      else
        handler.receive_call(call)
        call.callee = handler
      end
    end

    # get the first available employee to handle the call
    # maybe escalate to employee with higher title later
    def get_handler_for_call(call)
    end
  end

  class Call

    attr_accessor :visitor, :callee_title

    def initialize(callee_title, visitor)
      @callee_title = callee_title
      @visitor = visitor
    end

    def callee=(callee)
      @callee = callee
    end

    def disconnect
    end
  end

  class Employee
    attr_accessor :title

    def initialize
      @cur_call = nil
    end

    def receive_call(call)
      # handle incoming call or escalate the call to higher rank employee
    end

    def escalate_call(call)
    end

    def free?
      @cur_call.nil?
    end
  end

  class Respondent < Employee
    def initialize
      @title = :Respondent
    end
  end

  class Manager < Employee
    def initialize
      @title = :Employee
    end
  end

  class Director < Employee
    def initialize
      @title = :Director
    end
  end
end
