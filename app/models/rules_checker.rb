class RulesChecker

  def initialize gmail_account
    @gmail_account = gmail_account
    @rules = @gmail_account.user.rules.to_a
  end

  def check email
    results = false

    @message = email.message

    @rules.each do |rule|
      return true if check_rule(rule)
    end

    results
  end

  def check_rule rule
    SingleRuleChecker.new(rule, @message).check
  end

end