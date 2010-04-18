unless GameStatus.exists?(['description = ?', 'Send Update'])
  GameStatus.create(:description => 'Send Update')
end
