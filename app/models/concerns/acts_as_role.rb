# frozen_string_literal: true
module ActsAsRole
  def acts_as_role(class_name, as: :role)
    extend ActiveHash::Associations::ActiveRecordExtensions

    class_name = class_name.to_s.camelize
    belongs_to_active_hash as, class_name: class_name

    validates as, presence: true

    class_name.constantize.all.each do |common_role|
      define_method "#{common_role.name}?" do
        public_send(as).try(:id).to_i >= common_role.id
      end
    end
  end
end
