=begin
  Iniciar Sesión
  Cerrar Sesión
  Crear cuenta de usuario
  Página secreta
=end
def create_usser(u_name,u_email,u_password)
  Usser.create!(name: u_name,email: u_email,password: u_password)
end

get '/' do
  # La siguiente linea hace render de la vista
  # que esta en app/views/index.erb
  erb :index
end

post '/home' do
  # entradas del formulario
  u_name = params[:user_name]
  u_email = params[:user_email]
  u_password = params[:user_password]

  user = create_usser(u_name,u_email,u_password)

  if user.save
    # redirect to("/welcome/#{user.name}")
    erb :log_in
  else
    erb :home
  end


end

get '/welcome/:user' do
  puts "-" * 50
 p params[:user]

end
