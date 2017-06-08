#permitir sesiones donde se
enable :sessions
#-----------
#Evitar que un error de validacion se vea directamente..
require 'sinatra'
set :show_exceptions, false
#The exception object can be obtained from the sinatra.error Rack variable:
error do#.. en lugar de eso se lanza esta opcion
  @error = "something's FUCK IT UP"
  erb :sign_up
end
#-----------
#peticion GET a pagina de inicio
get '/' do
  erb :index
end
# Crear cuenta de usuario
get '/sign' do
  erb :sign_up
end
# Logearse como usuario existente
get '/log' do
  erb :log_in
end

#accion si se escoge el boton de "sign"
post '/signUP' do
  # Asignar a @user entradas del formulario en los PARAMS name, email y password
  @user = Usser.new(name: params[:user_name],email: params[:user_email],password: params[:user_password])
  puts "-"*50

  if @user.errors.any?
    rong = @user.errors.full_messages
    p rong
    p "ssssss"
  end
  puts "-"*50
  #si se logra salvar el modelo usser
  if @user.save
    #se ve en consola y en layout:
    p session[:saved_message] = "Successfully stored the name: "#en layout se establecio que se visualize el @user.name si este no es nil
    #renderear pagina de log_in
    erb :log_in
  else
    @user = @user
    erb :sign_up
  end
end

# peticion si el login es exitoso
post '/log_page' do
  puts "-" * 100
  #Autenticar objeto con metodo ".authenticate" creado en MODELO con lo inputs del formulario
  @autentication =  Usser.authenticate(params[:email], params[:password])
  #mostrar inputs en consola
  p @autentication.itself
  #SI la autenticacion no es nil
  if @autentication !=nil
    #ir a pagina secreta
     erb :secret_page
  #SINO crear @advert
  else
    #@advert esta enmbebido en log_in.erb
    @advert = true
    #renderear log_in nuevamente
    erb :log_in
  end
end
