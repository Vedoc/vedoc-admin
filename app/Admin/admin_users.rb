# app/admin/admin_users.rb
ActiveAdmin.register AdminUser do
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # Create a default admin user if none exists
  controller do
    before_action :ensure_admin_user

    def ensure_admin_user
      return if AdminUser.exists?

      AdminUser.create!(
        email: ENV['ADMIN_EMAIL'],
        password: ENV['ADMIN_PASSWORD'],
        password_confirmation: ENV['ADMIN_PASSWORD']
      )
    end
  end
end
