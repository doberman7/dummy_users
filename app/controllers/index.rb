#permitir sesiones donde se
enable :sessions
#-----------------------------------------------------
#Evitar que un error de validacion se vea directamente..
require 'sinatra'
set :show_exceptions, false
#The exception object can be obtained from the sinatra.error Rack variable:
error do#.. en lugar de eso se lanza esta opcion
  @fuck = "something's FUCK'T UP...some where"
  # erb :sign_up
end
#-----------------------------------------------------
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
  user = Usser.new(name: params[:user_name],email: params[:user_email],password: params[:user_password])


=begin
  OPCIONES PARA VALIDAR EL OBJETO
  No usar create! ya que inserta en la BD inmediatamente, impidiendo posteriores mensajes, etc.

  @user.valid?#=> true ior false

  @user.validate!#=> boolean, pero en false detiene las demas accciones

  @user.save!#=> true o ActiveRecord::RecordInvalid, detiene las demas acciones

   @user.errors.any?#=>true

  @user.errors.full_messages#=>[array of errors]

=end
  case user.valid?
    when true
      @user = user
      @user.save!
      #se ve en consola y en layout:
      p "*" * 100
      p session[:saved_message] = "Successfully stored the name: "#en layout se establecio que se visualize el @user.name si este no es nil
      #renderear pagina de lof in
      p "*"*100
      erb :log_in
    when false
       @error = user.errors.full_messages.each do |e|
         p e
      end
      erb :sign_up
    else
      error
      p user
  end

end#fin de post '/signUP'

# peticion si el login es exitoso
post '/log_page' do

  #Autenticar objeto con metodo ".authenticate" creado en MODELO con lo inputs del formulario
  @autentication =  Usser.authenticate(params[:email], params[:password])
  #mostrar inputs en consola

  puts "AUTENTICATION" + "-" * 100
  p @autentication
  puts "-" * 100
  #SI la autenticacion no es nil
  if @autentication !=nil
    #ir a pagina secreta

    p "sesion user_datails" + "-"*100
    p session[:user_datails] = @autentication    
    p "-"*100
    erb :secret_page
  #SINO crear @advert
  else
    #@advert esta enmbebido en log_in.erb
    @advert = true
    #renderear log_in nuevamente
    erb :log_in
  end
end
