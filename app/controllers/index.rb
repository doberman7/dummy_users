#A session is a way for a web application to set a cookie that persists an identifier across multiple HTTP requests, and then relate these requests to each other
enable :sessions
#-----------------------------------------------------
#Evitar que un error de validacion se vea directamente..
# require 'sinatra'
# set :show_exceptions, false
# #The exception object can be obtained from the sinatra.error Rack variable:
# error do#.. en lugar de eso se lanza esta opcion
#   @fuck = "something's FUCK'T UP...some where"
#   # erb :sign_up
# end
#-----------------------------------------------------
before '/' do

  if session[:user_datails] != ""
    p "BEFORE /" + "=" * 100
    p session[:user_datails]= "SESION TERMINADA"
    session[:user_datails].clear
    session[:goodbye] = "vuelve pronto"
  else    
    p session[:goodbye].clear
  end
end
#peticion GET a pagina de inicio
get '/' do
  erb :index
end
# Crear cuenta de usuario
before '/sign' do
  session[:goodbye].clear
end
get '/sign' do
  session[:goodbye].clear
  erb :sign_up
end
# Logearse como usuario existente

before '/log' do
  session[:goodbye].clear
end

get '/log' do
  session[:goodbye].clear
  erb :log_in
end

#accion si se escoge el boton de "sign"
post '/signUP' do
  # Asignar a @user entradas del formulario en los PARAMS name, email y password
  user = Usser.new(name: params[:user_name],email: params[:user_email],password: params[:user_password])
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
    # Para el sinatra error Stack
    # else
    #   error
    #   p user
  end

end#fin de post '/signUP'

# peticion si el login es exitoso
post '/log_page' do
  #Autenticar objeto con metodo ".authenticate" creado en MODELO con lo inputs del formulario
  p "AUTETICACION y creacion de SESSION" + "-"*100
  p session[:user_datails] =  Usser.authenticate(params[:email], params[:password])
  redirect to '/secret/:user'
end#FIN de post '/log_page'

before '/secret/:user' do
  p "BEFORE SECRETE USER" + "<" * 100
  p user = session[:user_datails].class == Usser
  case user
  when true
    p "session[:user_datails] NO ES NIL" + "<"*100
     @name = session[:user_datails].name
     @id = session[:user_datails].id
     session[:rong_log_in].clear
  when false
    #CONVERTIT en SESIONSS
    p session[:rong_log_in] = "Email o password incorrectos "
    #renderear log_in nuevamente
    redirect to'/log'
  end

end

get '/secret/:user'do
  session[:rong_log_in].clear
  erb :secret_page#=>GET
end

after '/secret/:user' do
  p 'after /secret/:user' + "."*100
  p session[:time] = Time.now
end
