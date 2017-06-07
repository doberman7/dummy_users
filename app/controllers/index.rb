
get '/' do
  erb :index
end
# Crear cuenta de usuario
get '/sign' do
  erb :sign_up
end
#logearse
get '/log' do
  erb :log_in
end

#accion si se escoge el boton de "sign"
post '/signUP' do
  # entradas del formulario
  u_name = params[:user_name]
  u_email = params[:user_email]
  u_password = params[:user_password]

  user = Usser.create!(name: u_name,email: u_email,password: u_password)
  #si se logra salvar el usser
  if user.save!
    # Iniciar Sesión
    erb :log_in
  # en caso de bo salvarse usario ir al index
  #NO FUNCIONA, las validaaciones en el modelo lo impiden
  else
    erb :index
  end

end

# Página secreta
post '/user_page' do
  puts "-" * 100
  em = params[:email]
  pass = params[:password]

  @autentication =  Usser.authenticate(em,pass)
  p @autentication.itself

  if @autentication !=nil
     erb :secret_page
  else
     erb :log_in
  end




end
