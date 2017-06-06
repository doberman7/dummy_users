class Usser < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true


	#ej.User.authenticate('fernando@codea.mx', 'qwerty')
	def self.authenticate(email, password)
		# si el email y el password corresponden a un usuario valido, regresa el usuario
		# de otra manera regresa nil
	end
end
