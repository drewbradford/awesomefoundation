class Notifier < ActionMailer::Base
  def submission_notification(submission)
    recipients submission.email
    from       "contact@awesomefoundation.org"
    subject    "Your Awesome Foundation Application!"
    body       :submission => submission
  end
end
