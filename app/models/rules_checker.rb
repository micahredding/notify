class RulesChecker

  def initialize gmail_account
    @gmail_account = gmail_account
    @rules = @gmail_account.user.rules.to_a
  end

  def check email
    matched_email = nil

    @email = email

    @rules.each do |rule|
      matched_email = check_rule(rule)
      break if matched_email
    end

    matched_email
  end

  def check_rule rule
    SingleRuleChecker.new(rule, @email, @gmail_account.id).check
  end

end