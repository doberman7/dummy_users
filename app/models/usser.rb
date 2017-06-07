class Usser < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true



	# http://api.rubyonrails.org/classes/ActiveRecord/Base.html
	def self.authenticate(email, password)
		#regresar DONDE hay concordancia del input en el formulario(email y password) SI existe un email igual al input en la BD
		# The exists? method also takes multiple values, but the catch is that it will return true if any one of those records exists.
		where(email:email , password:password).first if self.exists?(email: email)
	end
end
