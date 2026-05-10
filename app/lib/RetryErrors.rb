class RetryErrors
  # Initialize with a list of errors to retry on.
  # You can pass multiple error classes as arguments.
  #
  # Example:
  # RetryErrors.new(ZeroDivisionError, NameError)
  #
  # This will retry the block if it raises either ZeroDivisionError or NameError.
  #
  # @param errors [Array<Class>] List of error classes to retry on.
  # @return [RetryErrors] An instance of RetryErrors.

  attr_reader :errors

  def initialize(*errors)
    @errors = errors
  end

  # Retry the block if it raises one of the specified errors.
  def try(times:)
    yield
  rescue *errors
    raise unless times > 0
    times -= 1
    retry
  end
end
