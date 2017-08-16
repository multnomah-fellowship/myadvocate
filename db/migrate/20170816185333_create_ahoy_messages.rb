class CreateAhoyMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :ahoy_messages do |t|
      t.string :token

      # user
      t.text :to
      t.integer :user_id
      t.string :user_type

      t.string :mailer
      t.text :subject

      # optional
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      # timestamps
      t.timestamp :sent_at
      t.timestamp :opened_at
      t.timestamp :clicked_at
    end

    add_index :ahoy_messages, [:token]
    add_index :ahoy_messages, [:user_id, :user_type]
  end
end