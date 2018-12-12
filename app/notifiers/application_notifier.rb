class ApplicationNotifier
  def notify!
    d = data
    t = type
    payload = {
      type: t,
      data: d,
    }
    create = notified_users.map do |user|
      {user: user, payload: payload}
    end
    Notification.create(create)
    act = email_action
    notified_users.to_a.select{|u| should_email? u}
      .each do |user|
      NotifierMailer.with(user: user, data: data).public_send(act)
        .deliver_later
    end
  end
end
