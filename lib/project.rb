class Project

  def testFunction
    mockFunction
    return stubFunction
  end

  def mockFunction
    return -1;
  end

  def stubFunction
    return 1
  end

  def exceptionFunction
    raise Error.new('Exception Catch');
  end

end
